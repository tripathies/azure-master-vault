# AWS Landing Zone — Multi-Account Foundation

**Document status:** Reference architecture blueprint  
**Version:** 0.1  
**Scope:** AWS Organizations, AWS Control Tower, account governance, identity, security, network, logging and cost controls  
**Deployment status:** Not provisioned by this repository

## 1. Purpose

An AWS landing zone is the governed, multi-account foundation on which workloads are deployed. It is not the same thing as a VPC, an EKS cluster or a project resource group. AWS accounts provide workload isolation and blast-radius boundaries; organizational units (OUs), policies and shared security services provide centralized governance.

This reference establishes the foundation required before deploying Escanor. It is deliberately separate from the Escanor workload LLD.

## 2. Recommended foundation pattern

Use **AWS Organizations with AWS Control Tower** as the managed landing-zone foundation. Control Tower orchestrates account governance and controls across an AWS multi-account environment. The exact OU structure must be selected for the organization's needs; current Control Tower landing-zone versions support a customizable organizational structure.

Suggested logical structure:

```text
AWS Organization (Root)
|
+-- Security OU
|   +-- Log Archive account
|   +-- Audit / Security Tooling account
|
+-- Infrastructure OU
|   +-- Network Services account (optional central network)
|   +-- Shared Services / Tooling account
|
+-- Workloads OU
|   +-- NonProduction OU
|   |   +-- Escanor-NonProd account
|   +-- Production OU
|       +-- Escanor-Prod account (future)
|
+-- Sandbox OU
    +-- Individual learning / experimentation accounts
```

This is a recommended logical pattern, not a claim that every account or OU has already been created. AWS Control Tower's current landing-zone structure is configurable; do not assume that every organization must use an identically named default OU.

### Account responsibilities

| Account | Responsibility | Workload placement |
|---|---|---|
| Management | AWS Organizations and Control Tower administration, account governance and consolidated billing | No application workloads |
| Log Archive | Central storage for organization-level CloudTrail and AWS Config logs | Logging services only |
| Audit / Security Tooling | Security review, delegated security administration and cross-account assessment | Security tools only |
| Network Services | Optional shared connectivity, DNS, inspection and transit services | Shared network services only |
| Shared Services / Tooling | Optional CI runners, artifact services and common tooling | Approved shared services only |
| Escanor-NonProd | Escanor lab and non-production validation | Escanor lab workload |
| Escanor-Prod | Future production workload isolation | Not part of the initial lab |
| Sandbox | Disposable experiments with strict guardrails | No production data or critical services |

Do not run application workloads in the AWS Organizations management account. AWS explicitly recommends a separate member account for workloads.

## 3. Governance and account controls

### 3.1 Organizations and OUs

- Create and manage member accounts through AWS Organizations / Control Tower Account Factory.
- Place accounts into OUs based on their security and operational purpose.
- Use account-level separation for production, non-production and shared security functions.
- Keep account ownership, billing contact, email aliases and recovery ownership documented.
- Review OU placement and controls before moving accounts.

### 3.2 Preventive controls

Use Service Control Policies (SCPs) and Control Tower preventive controls to restrict actions that member-account IAM principals may perform.

Candidate guardrails, subject to an explicit exception process:
- Deny disabling or weakening mandatory organization logging.
- Restrict deployment to approved Regions, with explicit exceptions for global services and approved disaster-recovery Regions.
- Protect designated security and log-archive resources from deletion.
- Prevent member workloads from leaving the organization without approved change.
- Restrict use of high-risk services or public exposure patterns where appropriate.

**Important:** SCPs set maximum permissions for principals in member accounts; they do not grant permissions. A principal still needs an IAM identity policy and applicable resource policy to access a service. SCPs do not apply to the Organizations management account in the same way they apply to member accounts; protect that account through its own identity and access controls.

### 3.3 Detective controls

Use distinct services for distinct signals:
- **AWS Config:** resource configuration recording, rules and conformance packs.
- **AWS Config Aggregator:** central view across accounts and Regions.
- **AWS Security Hub CSPM:** consolidated security posture and standards-based findings.
- **Amazon GuardDuty:** threat detection.
- **Amazon Inspector:** supported vulnerability exposure and software findings.
- **AWS CloudTrail:** API activity and account audit trail.
- **IAM Access Analyzer:** external access and policy analysis.

Enable delegated administration where supported and centralise findings in the designated security account. Verify regional availability and service prerequisites during setup.

## 4. Workforce identity and privileged access

- Use **AWS IAM Identity Center** for workforce access to member accounts.
- Prefer federation to the organization's existing identity provider where approved.
- Define permission sets by job function and environment; avoid broad standing administrator access.
- Use short-lived sessions and MFA.
- Use a documented, tested break-glass process for account recovery.
- Protect the management account root user, secure its recovery factors and do not use it for routine administration.
- Do not distribute IAM user access keys to engineers.

For cross-account operations, assume narrowly scoped IAM roles and record the source identity, target account, session name and reason for access.

## 5. Workload identity

Use IAM roles for AWS workloads:
- EKS workloads: EKS Pod Identity where appropriate and supported by the workload/add-on; use IAM Roles for Service Accounts (IRSA) where the integration requires it or where it is the better-supported option.
- Lambda functions: dedicated execution role for each function or trust boundary.
- EC2 / node groups: instance profile limited to node-level duties, not application data access.
- CI/CD: short-lived OIDC federation from the approved Git provider to a narrowly scoped deployment role.
- Cross-cloud dashboard: OIDC web-identity federation to AWS STS with issuer, audience and subject constraints; no static AWS secret in Azure.

A cluster/node role must not become a shared application role. Do not grant the EKS node group the permissions intended for an application pod.

## 6. Network foundation

The initial reference pattern is a **VPC per workload account** with subnets across at least two Availability Zones for production-like profiles.

- Public subnets: only for approved internet-facing edge components or NAT gateways.
- Private application subnets: EKS worker nodes and internal services.
- Isolated data subnets: RDS and other data stores where no direct internet path is required.
- Security groups: primary stateful traffic control at workload ENI level.
- Network ACLs: additional stateless subnet controls only where justified.
- VPC endpoints: gateway or interface endpoints for supported AWS service access without general internet routing.
- Route 53 private hosted zones and Resolver endpoints: private service and cross-VPC DNS.
- NAT Gateway: controlled outbound path where endpoints do not cover required traffic.
- Transit Gateway / Cloud WAN: introduce only when shared connectivity between multiple VPCs/accounts justifies it.
- AWS Network Firewall: optional centralised inspection; do not deploy it in a cost-sensitive lab without a clear need.

For Escanor, keep the EKS API private in the production-oriented profile. Document any lab-only public access exception explicitly and protect it with narrow source ranges and short duration.

## 7. Central logging and security telemetry

At minimum, design for:
- Organization CloudTrail with central log delivery to the Log Archive account.
- AWS Config recording in required accounts and Regions, with central aggregation.
- S3 log retention controls, versioning where appropriate, encryption, lifecycle and restrictive bucket policies.
- Security Hub CSPM and GuardDuty delegated administration.
- CloudWatch logs, metrics and alarms for account-local services.
- Cross-account access for security operations through roles and audited sessions.

Keep the Control Tower-managed resources intact. Changes to resources owned by Control Tower can impair governance or compliance reporting.

## 8. FinOps foundation

- Use consolidated billing through the Organizations management account.
- Create AWS Budgets for the organization and each workload account.
- Use Cost Explorer and Cost Anomaly Detection for analysis and alerting.
- Export CUR 2.0 / AWS Data Exports to a controlled S3 location for detailed analytics.
- Define cost allocation tags and activate the required user-defined and AWS-generated cost allocation tags.
- Use Cost Categories for business grouping where needed.
- Review unused public IPv4 addresses, NAT Gateways, idle load balancers, unattached EBS volumes, snapshots and oversized compute.
- Assign an accountable owner to every non-production account and define a teardown policy.

Budgets and anomaly alerts are notifications, not hard spending caps. Lab teardown and account guardrails remain necessary.

## 9. Region strategy

The Escanor source design proposes:
- Primary workload / Control Tower home Region: `ap-south-1` (Mumbai).
- Proposed recovery Region: `us-east-1` (N. Virginia).

Before deployment:
1. Confirm Control Tower support and governance coverage for the chosen home / governed Regions.
2. Confirm every required AWS service, feature, instance type and EKS add-on is available in the workload and recovery Regions.
3. Confirm data residency and cross-region data transfer requirements.
4. Confirm model, AgentCore feature and inference-profile availability.
5. Confirm service quotas and capacity.
6. Recalculate cost for both Regions.

A Region pair is not an AWS-managed equivalent of an Azure region pair. Recovery must be engineered and tested at the workload and data layers.

## 10. Landing-zone acceptance checklist

- [ ] AWS Organizations strategy and account ownership approved.
- [ ] Control Tower home Region and governed Regions selected.
- [ ] Management account protected and reserved for platform governance.
- [ ] Log Archive and Audit / Security Tooling accounts established.
- [ ] Workload accounts separated from shared/security accounts.
- [ ] IAM Identity Center access model and MFA validated.
- [ ] SCPs and Control Tower controls reviewed with exception paths.
- [ ] Organization CloudTrail and AWS Config aggregation verified.
- [ ] GuardDuty and Security Hub CSPM delegated administration verified.
- [ ] Central log bucket encryption, retention and access controls reviewed.
- [ ] Network/DNS connectivity model and egress controls approved.
- [ ] Cost allocation tags, budgets and alert recipients configured.
- [ ] Account vending and decommissioning procedures documented.
- [ ] Evidence retained for each test; no landing-zone deployment claimed based on design alone.

## 11. Implementation boundaries

This repository change adds design documentation only. It does not:
- Create an AWS Organization or AWS Control Tower landing zone.
- Create or invite AWS accounts.
- Enable security services or organization trails.
- Provision network hubs, VPCs or endpoints.
- Create an AWS budget or cost allocation configuration.

Those actions require an authorised AWS organization administrator, a deliberate account strategy and an approved deployment plan.

## References

- [How AWS Control Tower works](https://docs.aws.amazon.com/controltower/latest/userguide/how-control-tower-works.html)
- [AWS multi-account strategy](https://docs.aws.amazon.com/controltower/latest/userguide/aws-multi-account-landing-zone.html)
- [AWS shared accounts](https://docs.aws.amazon.com/controltower/latest/userguide/what-shared.html)
- [Control Tower resource modification guidance](https://docs.aws.amazon.com/controltower/latest/userguide/getting-started-guidance.html)
- [Organizing your AWS environment using multiple accounts](https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/organizing-your-aws-environment.html)
