# 05 — Resilience and Disaster Recovery

## Lab profile limitations

The current runnable lab is deliberately non-resilient:
- One EC2 instance.
- One Single-AZ RDS instance.
- No cross-AZ application failover.
- No cross-Region replication or recovery environment.
- One small S3 bucket with versioning and a short noncurrent-version lifecycle policy.
- Terraform state is stored separately in a versioned S3 backend bucket, but state-bucket disaster recovery is not automated.

Use the recovery model below as the full-platform target design only. The lab's actual recovery procedure is to retain source / state appropriately, destroy and recreate disposable infrastructure, then re-bootstrap synthetic data. Do not quote the source document's RTO / RPO values as tested outcomes for the lab.

## 1. Objective

Define the failure domains, backup dependencies and recovery approach for Escanor. The source design proposes warm recovery for important state and cold rebuild for most compute. That strategy is retained as a starting point, not as proof of a tested disaster recovery capability.

## 2. Resilience principles

- Use Availability Zones within a Region for high availability of production services.
- Treat Region recovery as a separate design from Availability Zone recovery.
- Keep infrastructure and deployment configuration in version control.
- Protect Terraform state, database records, evidence archives and GitOps configuration.
- Keep the alerting path independent of the agent runtime.
- Test restoration and rebuild, not just backup job completion.
- Record achieved RTO / RPO from exercises; do not present targets as measured results.

## 3. Recovery scope

| Component | Proposed protection / recovery approach | Verification required |
|---|---|---|
| Terraform state | S3 backend with versioning, encryption, restricted role access and recovery copy | Restore a prior state version in a disposable test |
| Git and GitOps | Protected source repository, immutable release references and Argo CD configuration | Rebuild cluster and reconcile from a known commit |
| EKS configuration | Terraform-based cold rebuild; production profile uses supported managed cluster configuration | Recreate cluster, add-ons, IAM and workload state |
| RDS PostgreSQL | Automated backups, point-in-time recovery and Multi-AZ for production profile | Restore to a new target and verify Escanor metadata |
| S3 evidence / billing | Versioning and lifecycle; cross-Region replication where required | Restore / read a replicated object and validate integrity |
| Prometheus | Snapshots or selected managed-service retention | Restore recent metrics or document acceptable metric loss |
| Grafana / Alertmanager | Configuration as code and externalised alert routing | Rebuild dashboards, rules and receivers |
| AgentCore configuration | Configuration / agent definitions and tools as code where supported | Recreate runtime, gateway and identity configuration |
| Streamlit console | Rebuild from image and deployment manifest | Redeploy and validate authentication / data access |
| AWS audit logs | Central organization logging to Log Archive with retention controls | Retrieve sample events across accounts and Regions |

## 4. Proposed regional model

The design proposes:
- Primary Region: `ap-south-1`.
- Recovery Region: `us-east-1`.

Use a **warm-state / cold-compute** approach:
- Replicate or otherwise protect Terraform state, application artifacts, selected RDS backup / recovery points and S3 evidence according to data criticality.
- Recreate EKS compute and stateless collectors from Terraform and GitOps.
- Restore operational metadata before re-enabling agent tools.
- Reconcile live AWS inventory before resuming remediation recommendations.

Cross-region replication and recovery create ongoing costs and data-transfer implications. They are not part of the lab unless explicitly enabled.

## 5. RTO / RPO status

The source design includes a regional recovery target of approximately 2–4 hours and an EKS rebuild target of approximately 15–30 minutes. These are **provisional design targets**, not measured results.

| Scenario | Provisional target from source design | Current status |
|---|---:|---|
| Regional recovery | 2–4 hours | Not tested; dependency and data restore sequence must be proven |
| EKS compute rebuild | 15–30 minutes | Not tested; depends on account bootstrap, quotas, image pull and add-on readiness |
| RDS restore | TBD | RPO / restore time must be established by engine, backup mode and test |
| S3 evidence recovery | TBD | Depends on versioning, replication, retention and object volume |
| Alerting during AgentCore outage | Independent path | Must be tested with agent intentionally disabled |

The source architecture also references a 99.95% availability objective. That objective cannot be claimed alongside a 2–4 hour regional recovery window without explicitly defining the measurement scope, error budget and whether regional failure is excluded from the SLO. Reconcile these statements before publishing a production SLO.

Define RPO for each stateful component. Do not infer it from backup frequency without restoring and measuring.

## 6. Recovery runbook outline

1. Declare the incident and choose the recovery Region.
2. Confirm the recovery account, IAM roles, quotas and required service availability.
3. Restore Terraform backend access and select the approved state / source revision.
4. Deploy network prerequisites and private endpoints.
5. Rebuild EKS, node groups and approved add-ons.
6. Restore RDS from the selected recovery point.
7. Restore or validate S3 evidence and billing archive access.
8. Deploy Argo CD and reconcile workloads from the approved Git commit.
9. Recreate AgentCore runtime, gateway, identity and tool configuration.
10. Validate CloudWatch, Prometheus, Alertmanager and independent notification paths.
11. Run read-only checks first; keep remediation tools disabled.
12. Verify evidence freshness, resource inventory and cost pipeline completeness.
13. Obtain an explicit operational decision before resuming T2 tools.
14. Record actual RTO / RPO, gaps and corrective actions.

## 7. Recovery testing

### Monthly
- Restore selected Terraform state version to an isolated test.
- Restore a representative RDS backup to a test target.
- Verify access to a selected S3 evidence object / replica.
- Confirm alert routing independent of AgentCore.

### Quarterly
- Rebuild EKS in a disposable account or recovery environment.
- Reconcile the cluster from GitOps.
- Recreate the agent and console path.
- Execute a regional recovery tabletop / game day.
- Record achieved recovery time and data loss.

### Before production
- Demonstrate regional recovery from a clean account / Region.
- Demonstrate recovery from accidental Terraform state corruption.
- Demonstrate a failed agent tool call cannot bypass approval or IAM restrictions.
- Verify backup encryption keys, grants and access paths.
- Obtain architecture and operational approval for measured RTO / RPO.

## 8. Recovery acceptance checklist

- [ ] Each stateful component has an owner, retention policy, RPO and restore process.
- [ ] Terraform state version restore is tested.
- [ ] RDS restore is tested and application data reconciled.
- [ ] S3 evidence / billing archive recovery is tested.
- [ ] EKS rebuild from code and GitOps is timed.
- [ ] Independent alerting works during agent outage.
- [ ] Cross-region service and model availability is confirmed.
- [ ] Actual RTO / RPO results are captured.
- [ ] SLO and regional recovery objectives are reconciled.
