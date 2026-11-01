# 01 — Vision, Scope and Requirements

## Implementation profile boundary

This document describes the full Escanor target capability. The runnable repository profile is intentionally smaller and currently demonstrates:
- A single Amazon Linux EC2 application host.
- Private Single-AZ PostgreSQL on Amazon RDS.
- Private S3 object storage with versioning.
- S3 Gateway Endpoint and Systems Manager interface endpoints.
- IAM instance role, RDS IAM DB authentication, Session Manager and a Python Flask learning app.

EKS, Argo CD, the four drift collectors, Prometheus / Grafana, CUR 2.0 analytics and AgentCore remain roadmap items. Do not mark those requirements implemented based only on this LLD.

## 1. Vision

Build Escanor as an AWS-native AIOps and cloud-economics control plane that detects four classes of drift, presents source-backed evidence, and helps operators make safer decisions.

Escanor is not intended to replace Terraform, Argo CD, Kubernetes controllers, AWS Config, CloudWatch or a human change process. It correlates signals from those systems and provides an evidence-oriented operational interface.

## 2. Business outcomes

- Detect divergence between declared infrastructure and AWS resources.
- Detect GitOps desired-state divergence and application runtime divergence.
- Detect economic waste using AWS billing exports and historical utilisation.
- Normalise findings into a common evidence contract.
- Correlate findings and explain likely impact with traceable citations / source identifiers.
- Recommend reversible remediation while preserving human authority for risky changes.
- Distinguish potential savings from approved and actually realised savings.
- Demonstrate a secure AWS multi-account workload with an optional Azure-to-AWS federated read-only view.

## 3. Scope

### 3.1 In scope — initial AWS learning profile

- Dedicated AWS member account under an AWS Organizations / Control Tower foundation.
- Amazon EKS cluster, managed node groups and Argo CD.
- Terraform infrastructure source and state-management pattern.
- Prometheus, Grafana, Alertmanager and Fluent Bit, plus AWS-native telemetry.
- Drift detection for infrastructure, GitOps, runtime and economics.
- Lambda-based retrieval / action tools with least-privilege execution roles.
- Amazon Bedrock AgentCore for new-build agent runtime, gateway, identity and observability capabilities as selected.
- Amazon RDS for PostgreSQL and Amazon S3 for operational state / evidence.
- CUR 2.0, Glue and Athena for cost and utilisation analysis.
- Streamlit operator console with an explicit authentication and ingress design.
- Human approval gates for changes that can affect availability, data or spend.
- Optional Entra ID OIDC federation to AWS STS for cross-cloud read-only publication.

### 3.2 Out of scope for the initial lab

- Creating the enterprise AWS Organization and all Control Tower accounts automatically.
- Production customer workloads or sensitive business data.
- Automatic deletion of AWS resources or autonomous destructive remediation.
- A claim of 99.95% end-to-end availability before service measurement and failure testing.
- A fully active-active multi-region EKS platform.
- Automatic approval of infrastructure or cost changes by an AI model.
- Comprehensive SIEM / SOC service replacement.
- A production multi-tenant SaaS control plane.
- A guaranteed monthly cost cap; AWS Budgets notify but do not stop all spend.

## 4. Four drift planes

| Plane | Expected state | Observed state | Example signal |
|---|---|---|---|
| Infrastructure | Terraform configuration and state | AWS resource configuration and inventory | Unmanaged resource, changed attribute, missing resource |
| GitOps | Git commit and Argo CD desired state | Argo CD application sync / health state | Out-of-sync application or failed reconciliation |
| Runtime | Kubernetes workload specification | Live pods, deployments, nodes and rollout state | Replica mismatch, crash loop, failed rollout |
| Economic | Approved capacity and cost policy | CUR 2.0 charges plus historical utilisation | Idle, unattached or oversized resource |

A drift finding must be attributable to a specific resource or workload and must preserve the source and observation time. Findings must not be emitted as unqualified AI conclusions.

## 5. Users and personas

| Persona | Need |
|---|---|
| Platform engineer | Understand infrastructure and cluster drift |
| SRE / operations engineer | Prioritise incidents, dependencies and recovery |
| FinOps practitioner | Identify waste and validate savings |
| Security engineer | Review identities, configuration findings and agent authority |
| Engineering manager | Understand service health, risk, ownership and cost |
| Change approver | Approve or reject consequential actions based on evidence |

## 6. Functional requirements

| ID | Requirement | Acceptance evidence |
|---|---|---|
| FR-01 | Collect infrastructure inventory and drift signals | Finding contains resource ARN / ID, account, Region, expected and observed values |
| FR-02 | Collect GitOps state | Argo CD application, commit and sync status are traceable |
| FR-03 | Collect Kubernetes runtime state | Finding includes cluster, namespace, workload and observation timestamp |
| FR-04 | Ingest cost data | CUR 2.0 data is queryable through the documented Glue / Athena pipeline |
| FR-05 | Archive historical utilisation | Time-series history is available with defined retention and provenance |
| FR-06 | Normalise drift | All planes emit a versioned, validated finding contract |
| FR-07 | Present findings | Console shows severity, owner, evidence, confidence and next action |
| FR-08 | Reason over evidence | Agent answers cite the finding / metric / query evidence used |
| FR-09 | Enforce safe authority | Agent tools are IAM-constrained; read-only is the default |
| FR-10 | Gate consequential changes | Approval identity, ticket, action, target and result are recorded |
| FR-11 | Measure savings honestly | Identified, approved and realised savings are separate |
| FR-12 | Continue alerting without AI | Monitoring and alert delivery do not depend on AgentCore availability |

## 7. Non-functional requirements

| ID | Pillar | Requirement |
|---|---|---|
| NFR-01 | Security | No static AWS access keys in workload, CI/CD or cross-cloud integration |
| NFR-02 | Security | Agent authority is enforced by IAM and tool schemas, not only by system prompts |
| NFR-03 | Reliability | Telemetry and alerting continue if the agent runtime is unavailable |
| NFR-04 | Reliability | State, evidence and recovery dependencies have documented backup / restore procedures |
| NFR-05 | Operational Excellence | Findings are traceable, versioned, deduplicated and have clear ownership |
| NFR-06 | Performance Efficiency | Exporter cardinality, query cost and agent response latency are measured |
| NFR-07 | Cost Optimization | Cost claims distinguish incurred charges, forecasts and realised reductions |
| NFR-08 | Sustainability | Idle capacity and overprovisioning are surfaced as optimisation candidates |
| NFR-09 | Maintainability | Infrastructure, agent tools, prompt/configuration and console are version-controlled |
| NFR-10 | Auditability | Access, recommendations, approvals and executed actions are retained |

## 8. Assumptions and constraints

1. Primary Region is proposed as `ap-south-1`; recovery Region as `us-east-1`.
2. The workload account is already governed by an approved landing zone.
3. AWS service quotas, EKS instance capacity, Bedrock model access and AgentCore feature availability are confirmed before build.
4. EKS minor version will be selected from standard-supported versions at implementation time. EKS 1.31 in the source document is not accepted as the new-build default.
5. Amazon Bedrock Agents Classic is not accepted for a new account / new implementation; use AgentCore.
6. Cost and performance values in the source PDF are estimates and must be recalculated.
7. Production RTO / RPO and availability commitments remain provisional until test evidence exists.
8. The lab uses synthetic infrastructure and non-sensitive data only.

## 9. AWS Well-Architected review

Every design review must record trade-offs across all six pillars:
- Operational Excellence
- Security
- Reliability
- Performance Efficiency
- Cost Optimization
- Sustainability

A trade-off log is required when the lab deliberately reduces resilience or security controls to reduce cost. Security and operational ownership must not be silently removed to meet a budget target.

## 10. Acceptance criteria

- [ ] Every drift plane has a source, collection path and test fixture.
- [ ] Finding schema includes account, Region, resource identity, timestamps and evidence references.
- [ ] Alerting works with AgentCore disabled.
- [ ] Agent read-only policy is verified by IAM simulation and negative tests.
- [ ] An unapproved destructive action is denied by the tool and AWS API.
- [ ] Savings are not marked realised until subsequent billing data confirms the cost reduction.
- [ ] All cost estimates are recalculated using the selected Region and account profile.
- [ ] Teardown and residual-resource checks are documented and tested.
