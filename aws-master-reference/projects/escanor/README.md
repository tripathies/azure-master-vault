# Escanor — AWS AIOps and Cloud Economics Control Plane

**Document status:** AWS design baseline adapted from the supplied Escanor LLD  
**Version:** 0.1  
**Implementation status:** Design documentation only; executable infrastructure and workload code are not yet included  
**Environment:** AWS non-production learning lab first; production profile is a separate future deployment

## 1. Project intent

Escanor is an autonomous AIOps and cloud-economics control plane. It observes infrastructure, GitOps, runtime and financial drift, normalises findings into evidence, and uses an AI agent to explain issues and recommend safe actions.

The implementation is intended to demonstrate:
- Four-plane drift detection: infrastructure, GitOps, runtime and economic.
- Evidence-backed AIOps reasoning rather than free-form AI guesswork.
- Read-only retrieval as the default agent authority.
- Human approval for reversible and destructive infrastructure actions.
- FinOps grounded in billing exports and observed utilisation.
- A controlled multi-account AWS deployment with an optional cross-cloud Azure executive view.

## 2. Prerequisite foundation

Escanor is a workload, not a landing zone. Deploy it into a dedicated AWS member account created under the [AWS landing-zone reference](../../landing-zone/README.md).

Recommended account split:
- `Escanor-NonProd`: lab build, planted waste and validation.
- `Escanor-Prod`: future production profile, only after security, reliability, cost and operational gates are satisfied.

Do not deploy Escanor into the Organizations management account, Log Archive account or Audit / Security Tooling account.

## 3. AWS-native architecture

| Capability | AWS design choice |
|---|---|
| Kubernetes workload platform | Amazon EKS, private API in production profile |
| Infrastructure as code | Terraform with AWS provider and controlled remote state |
| GitOps | Argo CD |
| Container registry | Amazon ECR |
| Telemetry | Prometheus, Grafana, Alertmanager, Fluent Bit; CloudWatch for AWS service and platform telemetry |
| Infrastructure drift | Terraform state/plan comparison and AWS Config findings |
| GitOps drift | Argo CD application health and sync state |
| Runtime drift | Kubernetes API / workload state compared with desired state |
| Economic drift | CUR 2.0, Athena, Glue, utilisation history and resource inventory |
| Agent runtime / orchestration | Amazon Bedrock AgentCore; do not build new accounts on Bedrock Agents Classic |
| Tool integration | AgentCore Gateway and narrowly scoped Lambda / API tools |
| Operational state | Amazon RDS for PostgreSQL |
| Evidence and archive | Amazon S3 |
| Events and scheduling | Amazon EventBridge |
| Identity and access | IAM roles, EKS Pod Identity or IRSA, STS, IAM Identity Center |
| Executive console | Streamlit container behind an approved AWS application ingress and authentication pattern |

The exact managed-versus-self-managed telemetry choices, compute sizing and console hosting option must be closed in the design review before Terraform implementation.

## 4. Region baseline

The source design uses:
- Primary: `ap-south-1` (Mumbai).
- Proposed recovery: `us-east-1` (N. Virginia).

Amazon Bedrock AgentCore lists Mumbai among supported Regions, but check the individual AgentCore capability, model, inference profile, AZ and VPC connectivity requirements for the chosen design. Do not infer feature parity from regional control-plane availability.

## 5. Important modernisation from the source PDF

| Source design item | Implementation decision |
|---|---|
| Amazon EKS 1.31 | Do not carry forward as the default. Select an EKS minor version in standard support when the cluster is provisioned; validate add-on and node compatibility. |
| Amazon Bedrock Agents | Replace new-build orchestration with Amazon Bedrock AgentCore. Agents Classic is no longer open to new customers as of 30 July 2026. |
| Four drift planes | Preserve as the core Escanor differentiator. |
| Read-only retrieval and approval tiers | Preserve and enforce with IAM policies and tool contracts, not prompts alone. |
| Cross-cloud Azure executive view | Keep as an optional extension using Entra OIDC federation to AWS STS; no static AWS credentials. |
| Cost and availability figures | Treat as estimates / design targets until recalculated and tested in the target account and Region. |

## 6. Repository map

| Path | Purpose |
|---|---|
| [LLD](lld/README.md) | Complete solution design and implementation requirements |
| [Infrastructure plan](infra/README.md) | Planned Terraform layers and module boundaries |
| [Validation plan](docs/validation.md) | Acceptance tests and evidence required before claiming a working deployment |

## 7. Delivery status and safe-use rules

The first repository increment is documentation. It does not provision AWS resources and does not prove the architecture has been deployed.

The later implementation must:
1. Start with the approved AWS landing zone and a dedicated non-production account.
2. Use short-lived federated deployment credentials.
3. Require reviewed Terraform plans and explicit approval before apply.
4. Keep the agent's default role read-only.
5. Keep alerting independent of AgentCore availability.
6. Disable destructive automation by default.
7. Include a tested teardown path and residual-resource check.
8. Reconcile actual AWS billing data with every cost estimate.

Do not commit AWS access keys, SSO caches, Terraform state, plan files, kubeconfig files, kube secrets, model prompts containing secrets or production findings.
