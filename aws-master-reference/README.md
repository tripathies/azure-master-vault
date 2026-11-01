# AWS Master Reference — Landing Zone and Workload Architecture

> An AWS-native architecture reference track alongside the existing Azure material in this repository. It starts with the AWS account foundation and uses Escanor as the first hands-on workload design.

## Start here

| Path | Purpose |
|---|---|
| [AWS landing zone](landing-zone/README.md) | Multi-account foundation, governance, identity, security, network, logging and FinOps |
| [Escanor AWS reference project](projects/escanor/README.md) | Runnable small-footprint EC2, RDS, S3 and VPC endpoint learning lab; larger AIOps platform roadmap |
| [Escanor low-level design](projects/escanor/lld/README.md) | Requirements, solution design, identity/security, operations/FinOps, DR and validation |
| [Escanor infrastructure plan](projects/escanor/infra/README.md) | Planned Terraform repository structure and implementation boundaries |

## Architecture principles

1. **AWS accounts are the primary isolation boundary.** Separate the organization management account, shared security/logging functions and workload accounts.
2. **Use AWS Organizations and AWS Control Tower for the foundation.** Define account and OU strategy before deploying workload resources.
3. **Use AWS IAM Identity Center for workforce access and IAM roles for workloads.** Do not introduce long-lived access keys as an application integration pattern.
4. **Apply preventive and detective controls deliberately.** Service Control Policies (SCPs), Control Tower controls and AWS Config have different responsibilities; none is a substitute for least-privilege IAM.
5. **Use AWS-native service names and design choices.** Do not translate Azure resources one-for-one where the underlying control model differs.
6. **Use Terraform as the workload infrastructure source of truth.** Protect remote state, plan files, deployment identities and CI/CD trust.
7. **Design and verify against all six AWS Well-Architected pillars:** Operational Excellence, Security, Reliability, Performance Efficiency, Cost Optimization and Sustainability.
8. **Separate design intent from deployed evidence.** A diagram, Terraform plan or local test is not proof of live AWS deployment.

## How this relates to the Azure track

The existing Azure learning catalogue and LittleNest workload remain unchanged. This AWS track is a parallel reference, not an Azure-to-AWS resource rename exercise. The concepts can be compared, but AWS account governance, IAM, networking, observability and cost controls must follow AWS semantics.

| Architecture concern | Azure reference vocabulary | AWS reference vocabulary |
|---|---|---|
| Platform hierarchy | Management Groups, Subscriptions | AWS Organizations, OUs, Accounts |
| Landing zone | Azure Landing Zones | AWS Control Tower landing zone / multi-account strategy |
| Human access | Microsoft Entra ID, Azure RBAC, PIM | IAM Identity Center, permission sets, IAM roles and SCPs |
| Workload identity | Managed identities | IAM roles, EKS Pod Identity or IRSA, Lambda execution roles |
| Policy and posture | Azure Policy, Defender for Cloud | SCPs, Control Tower controls, AWS Config, Security Hub CSPM, GuardDuty |
| Network | VNet, NSG, Private Link, Private DNS | VPC, security groups, VPC endpoints / PrivateLink, Route 53 private hosted zones |
| Telemetry | Azure Monitor, Log Analytics, Application Insights | CloudWatch, CloudTrail, AWS Config, OpenTelemetry and workload telemetry |
| Secrets and keys | Key Vault | Secrets Manager / Systems Manager Parameter Store, AWS KMS |
| Cost governance | Azure Cost Management | AWS Cost Explorer, Budgets, Cost Anomaly Detection, Cost and Usage Report (CUR) 2.0 |

These are conceptual comparisons, not equivalence claims. Select services based on workload requirements and the AWS shared-responsibility model.

## Scope and status

- **Landing zone:** architecture blueprint; it has not been provisioned by this documentation change.
- **Escanor learning lab:** Terraform and Python application code are provided for a reader-managed deployment using a small EC2 instance, private PostgreSQL RDS, S3 and VPC endpoints.
- **Full Escanor AIOps platform:** EKS, Argo CD, four drift collectors, CUR analytics and AgentCore remain the future architecture roadmap.
- **Regions:** the reference design retains `ap-south-1` as the primary region and `us-east-1` as the proposed recovery region. Service availability, model availability, quotas, data-residency implications and costs must be reconfirmed before implementation.

## AWS design references

- [AWS Control Tower — What it is](https://docs.aws.amazon.com/controltower/latest/userguide/what-is-control-tower.html)
- [AWS Control Tower — How it works](https://docs.aws.amazon.com/controltower/latest/userguide/how-control-tower-works.html)
- [AWS multi-account strategy](https://docs.aws.amazon.com/controltower/latest/userguide/aws-multi-account-landing-zone.html)
- [Organizing your AWS environment using multiple accounts](https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/organizing-your-aws-environment.html)
- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/)
- [AWS Security Hub CSPM](https://docs.aws.amazon.com/securityhub/latest/userguide/what-is-securityhub.html)

## Runnable first workload — Escanor learning lab

The [Escanor AWS project](projects/escanor/README.md) now includes Terraform, a Python sample application, database bootstrap tooling, Session Manager helpers, validation scripts and a GitHub Actions build pipeline. It is intentionally small: EC2 `t3.micro`, PostgreSQL RDS `db.t4g.micro`, a private/versioned S3 bucket, S3 Gateway Endpoint and Systems Manager PrivateLink endpoints.

Readers deploy it only in their own disposable AWS account by following the [getting-started guide](projects/escanor/docs/getting-started.md). CI performs code and Terraform validation; it does not deploy AWS resources. The original larger Escanor EKS / AIOps design is retained as a roadmap, not represented as already implemented.

