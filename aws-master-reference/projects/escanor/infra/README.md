# Escanor AWS — Terraform Infrastructure Plan

**Status:** Planned structure only; no executable Escanor Terraform modules are included in this initial documentation change.

## 1. Design rules

- Keep AWS landing-zone provisioning separate from workload provisioning.
- Run workload Terraform only in the dedicated Escanor member account.
- Use the AWS provider with pinned versions and an explicit Region.
- Use short-lived CI OIDC credentials / STS roles.
- Use a protected S3 remote backend with versioning, encryption, restrictive policy and state locking.
- Separate bootstrap, network, EKS, observability, drift, FinOps, AgentCore and console layers.
- Keep secrets out of variables, outputs, plans and source.
- Require a reviewed plan and approval before apply.
- Do not store Terraform state in the source repository.

## 2. Planned directory layout

```text
infra/
└── terraform/
    ├── bootstrap/
    │   ├── state-backend/
    │   └── deployment-identity/
    ├── environments/
    │   ├── lab/
    │   └── production/
    ├── modules/
    │   ├── network/
    │   ├── eks/
    │   ├── ecr/
    │   ├── gitops/
    │   ├── observability/
    │   ├── drift-exporter/
    │   ├── finops/
    │   ├── data/
    │   ├── agentcore/
    │   └── console/
    └── policies/
        ├── iam/
        └── bucket-policies/
```

This is a planned structure. Module boundaries may change after service availability, threat model, cost and dependency review. Do not create a single state file for the entire AWS Organization and Escanor workload.

## 3. State backend

The proposed workload backend is an S3 bucket in a separately governed tooling / state account, or in the Escanor account for a strictly isolated lab where a separate account is not available.

Required controls:
- S3 versioning.
- SSE-KMS or an approved encryption policy.
- Block Public Access.
- Bucket policy scoped to the deployment role and required state prefix.
- Native Terraform S3 backend locking supported by the pinned Terraform version.
- Access logging / CloudTrail data events where justified.
- Recovery procedure for state version restore.
- No public access or developer-wide read grants.

The exact backend and lock configuration must be validated with the pinned Terraform version before use.

## 4. Module responsibilities

| Module | Responsibilities |
|---|---|
| network | VPC, AZ-aware subnets, routes, security groups, endpoints, DNS and egress |
| eks | Cluster, managed node groups, access entries, encryption and add-ons |
| ecr | Container repositories, image scanning and lifecycle policy |
| gitops | Argo CD bootstrap and repository integration |
| observability | Prometheus / Grafana / Alertmanager / Fluent Bit and CloudWatch wiring |
| drift-exporter | Collector deployment, schema configuration and metrics endpoints |
| finops | CUR 2.0 destinations, S3, Glue, Athena and query resources |
| data | RDS PostgreSQL, subnet groups, KMS, backup and security groups |
| agentcore | Runtime / harness, Gateway, Identity, tool policies and logging configuration |
| console | Streamlit deployment, ingress, authentication and evidence API access |

Use separate state boundaries for resources with different owners, change cadence or blast radius. In particular, the landing zone and security accounts must not be managed by the Escanor workload state.

## 5. Required inputs

Avoid embedding account IDs, secrets or public IPs in code. Inputs should include:
- AWS account ID / role context.
- Primary Region and approved recovery Region.
- Environment and project tags.
- VPC CIDR and subnet plan.
- EKS supported version selected for the release.
- Node group instance family / size / capacity model.
- RDS engine version, storage and backup policy.
- S3 retention and replication requirements.
- AgentCore runtime / model choice and feature flags.
- Budget threshold and owner notification target.

Use validation blocks and preflight scripts to reject an unexpected account, unapproved Region or unsafe environment.

## 6. Future implementation gates

Before writing deployable modules, close the decisions in [02 — Detailed Solution Design](../lld/02-detailed-solution-design.md). Then implement and validate one layer at a time. A successful Terraform plan is not evidence that quotas, service-linked roles, EKS add-ons, model access or runtime networking will succeed during apply.
