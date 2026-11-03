# 79. Recovery Plans, Failover & DR Testing

[← Category 12](../README.md) · [← Master catalogue](../../README.md)

> **Purpose:** Turn recovery architecture into an executable, tested procedure. This guide owns recovery sequencing, test failovers, failback rehearsals and evidence—not the business decisions that set RTO/RPO or the service configuration that protects data.

## 1. What a recovery plan must contain

A recovery plan translates a workload dependency map into a controlled runbook. For virtual-machine scenarios using Azure Site Recovery, recovery plans can group machines, sequence groups, include scripts and add manual actions. Recovery plans are not a substitute for application-level testing.

Document:
- Disaster declaration conditions and decision authority.
- Workload inventory, dependency groups and startup order.
- Recovery-point choice and data consistency expectations.
- Target-region capacity, network mapping, DNS, identity and secrets.
- Manual approvals, communications, vendor contacts and business validation.
- Failover, commit, reprotect, failback and rollback criteria.
- Success evidence and ownership for unresolved gaps.

## 2. Multi-tier sequencing pattern

~~~mermaid
flowchart TB
  Declare[Declare disaster / approve activation] --> Data[Group 1: data services]
  Data --> Middleware[Group 2: integration and middleware]
  Middleware --> App[Group 3: application services]
  App --> Edge[Group 4: ingress, DNS and user access]
  Edge --> Validate[Business transaction and security validation]
  Validate --> Restore[Declare service restored]
~~~

This sequence is illustrative. Build the actual order from application dependencies; independent resources can recover in parallel where safe.

## 3. Site Recovery recovery plans

Where supported by the selected ASR scenario:
- Group protected machines by application or dependency tier.
- Define startup order between groups and parallel execution within a group when appropriate.
- Add scripts, Azure Automation tasks or manual pause/approval steps for required configuration changes.
- Include network mapping and post-start tasks such as DNS, application configuration or access validation.
- Keep recovery plans aligned with the current architecture; stale plans are a recovery risk.

Microsoft documents recovery-plan grouping, sequencing, task automation and test failover in the [recovery plan overview](https://learn.microsoft.com/en-us/azure/site-recovery/recovery-plan-overview).

## 4. Test failover without affecting production

A controlled test should:
1. Obtain workload owner approval and announce scope.
2. Verify replication/backup health and select the intended recovery point.
3. Use an isolated test network or restore target to prevent collision with production.
4. Execute the recovery steps and required automation/manual tasks.
5. Validate DNS, identity, routing, firewall rules, secrets and external dependencies.
6. Run business transactions and data integrity checks.
7. Record start time, service-ready time, recovery point timestamp, data loss and issues.
8. Clean up the test environment and verify that production protection remains healthy.

Repeat the test after major changes to network, identity, app tiers, data stores, recovery configuration or service support. Establish a periodic exercise cadence; critical workloads generally need more frequent evidence than low-impact workloads.

## 5. Failover, commit, reprotect and failback

- **Failover:** Start recovery in the target environment using the selected recovery point.
- **Validation:** Confirm the service and data are correct before committing the selected recovery point.
- **Commit:** Finalize the chosen recovery point according to the supported workflow.
- **Reprotect:** Resume replication in the intended direction when the source/target state is ready.
- **Failback:** Return service to the designated primary environment using an approved plan.
- **Closeout:** Reconcile data, restore normal routing, confirm monitoring and record residual risks.

Never fail back solely because the original site is reachable. Validate application state, dependency readiness, data consistency, recovery ownership and rollback criteria.

## 6. Measure what matters

| Measure | Evidence |
|---|---|
| Achieved RTO | Time from declared activation to successful business transaction |
| Achieved RPO | Difference between incident point and recovered data timestamp/transaction |
| Application completeness | Dependency, integration and user-journey tests |
| Security | Identity, privilege, network and data-protection checks in recovery state |
| Operational readiness | Runbook execution, escalation, approvals and communications |
| Residual risk | Failed steps, manual workarounds, unavailable dependencies and remediation owners |

## 7. DR exercise checklist

- [ ] Scope and business owner approved
- [ ] Recovery-point and replication/backup health verified
- [ ] Recovery target capacity and network checked
- [ ] Test environment isolated from production
- [ ] Identity, DNS, routes, secrets and integrations validated
- [ ] Business transaction and data integrity passed
- [ ] Actual RTO/RPO recorded and compared with targets
- [ ] Failback/reprotect actions rehearsed where applicable
- [ ] Test resources cleaned up and source protection rechecked
- [ ] Findings assigned owners and due dates

## 8. Common mistakes

- Declaring success when VMs start but application transactions fail.
- Testing only one component and ignoring multi-tier startup order.
- Running a test failover on a network that can collide with production.
- Not testing identity, DNS, certificates, secrets and external dependencies.
- Never testing failback or not knowing when to commit a recovery point.
- Failing to update recovery plans after architecture changes.
- Reporting planned RTO/RPO rather than measured results.

## Official references

- [About recovery plans in Azure Site Recovery](https://learn.microsoft.com/en-us/azure/site-recovery/recovery-plan-overview)
- [About Site Recovery](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview)
- [Failover and failback — modernized scenarios](https://learn.microsoft.com/en-us/azure/site-recovery/failover-failback-overview-modernized)
- [Azure Well-Architected disaster recovery strategies](https://learn.microsoft.com/en-us/azure/well-architected/reliability/disaster-recovery)
