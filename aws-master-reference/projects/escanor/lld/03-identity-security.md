# 03 — Identity and Security

## 1. Security objectives

Escanor observes and recommends. It must not obtain broad control of the AWS environment simply because an AI agent is part of the design.

Security objectives:
- Isolate the workload in a dedicated member account.
- Use federated, short-lived identity for people and CI/CD.
- Use separate IAM roles for EKS workloads, Lambda tools and agent runtime.
- Enforce least privilege at the AWS API layer.
- Keep telemetry and evidence private by default.
- Ensure a prompt or model output cannot grant itself additional AWS permissions.
- Require named human approval for consequential changes.

## 2. Trust boundaries

| Boundary | Trust decision | Required control |
|---|---|---|
| Organization management → member account | Platform administrators govern accounts | IAM Identity Center, approved roles, CloudTrail and SCPs |
| Human operator → console | User is authenticated and authorised | Cognito or approved enterprise identity integration, session control and MFA |
| Git provider → deployment role | CI identity may deploy approved code | OIDC federation, exact repository / branch / environment claims, scoped IAM role |
| EKS control plane → pod | Workload may call selected AWS APIs | EKS Pod Identity or IRSA, per-service role |
| AgentCore → Gateway / tools | Agent may invoke specific functions | Gateway auth, tool allowlist, schema validation and least-privilege IAM |
| Lambda tool → AWS API | Tool may retrieve defined evidence | Dedicated execution role with read-only actions / resource scoping |
| Azure executive view → AWS STS | Cross-cloud service may read approved output | OIDC trust policy and S3 prefix-scoped role |
| Workload account → central log / security accounts | Security services collect findings and audit data | Delegated administrator, resource policies and role trust |

## 3. Workforce and CI/CD identity

### 3.1 Workforce access

- Use AWS IAM Identity Center for workforce account access.
- Use federated SSO from the approved identity provider where appropriate.
- Assign permission sets by role and environment.
- Require MFA and short-lived sessions.
- Keep administration separate from day-to-day developer permissions.
- Record emergency access ownership and test the recovery procedure.
- Do not use root or long-lived IAM user credentials for routine work.

### 3.2 CI/CD deployment identity

For GitHub Actions or another approved CI service:
- Configure OIDC federation to AWS STS.
- Restrict the role trust to the exact provider, audience, repository and protected branch / environment.
- Use different roles for plan and apply where practical.
- Require a reviewed plan and environment approval before apply.
- Limit the role to the intended AWS account and Terraform resource scope.
- Keep backend access separate from workload runtime roles.
- Log role assumption and deployment identity.

Never store an IAM access key as a GitHub secret when OIDC federation is available.

## 4. EKS workload identity

Prefer a dedicated identity per service:
- Use EKS Pod Identity where supported and suitable.
- Use IRSA for integrations and add-ons that require it or where it provides the clearer supported path.
- Keep the node instance profile limited to cluster / node duties.
- Do not attach application data permissions to the node role.
- Scope S3, RDS connection retrieval, CloudWatch and AWS API access to the exact workload.
- Rotate and audit service credentials; avoid sharing one role across unrelated namespaces.

For RDS PostgreSQL, prefer IAM database authentication if supported by the selected PostgreSQL engine, client and connection pattern. Otherwise use Secrets Manager with rotation policy and a narrowly scoped read role.

## 5. AgentCore and tool security

The source uses Bedrock Agents Classic. New implementation uses AgentCore; the security principles remain the same.

### 5.1 Authority model

| Tier | Authority | Default |
|---|---|---|
| T0 — Report | Read, correlate and explain evidence | Enabled |
| T1 — Recommend | Propose actions without changing AWS resources | Enabled |
| T2 — Reversible | Execute a narrowly defined reversible action | Disabled until explicitly opted in and approved |
| T3 — Destructive | Delete, replace, detach, terminate, rotate critical state or otherwise cause irreversible impact | Never automatic; named approver and verified recovery point required |

### 5.2 Enforce at the AWS API boundary

- Read-only tools use dedicated IAM roles with only required `List`, `Describe`, `Get` and query actions.
- A read-only policy is not assumed from a prompt or tool description.
- Deny mutation APIs in the default agent/tool execution path.
- Use separate execution roles for any approved T2 operation.
- No T3 tool is exposed to an autonomous agent.
- Validate inputs against strict JSON schemas and allowlisted account / Region / resource scopes.
- Record caller, session, finding ID, tool name, arguments, approval, result and correlation ID.
- Apply throttling, timeout, pagination and retry limits.
- Treat logs, resource tags, issue text, Git content and user-provided data as untrusted input.

### 5.3 Approval contract

Before a consequential action:
1. Resolve the target account, Region and resource ARN.
2. Retrieve current state and a recent evidence snapshot.
3. Show proposed action, impact, estimated cost and rollback procedure.
4. Require a named approver and change/ticket reference.
5. Revalidate that the target has not changed since approval.
6. Execute through the separate role.
7. Verify outcome and record before/after state.

Approval must be bound to the exact action and target, not to a broad natural-language intent.

## 6. AWS account and service controls

- SCPs restrict the maximum actions available to member-account principals; they do not grant permission.
- IAM policies and resource policies determine allowed access within those boundaries.
- AWS Config detects configuration compliance / drift; it is not a substitute for IAM authorisation.
- Control Tower controls establish selected landing-zone guardrails.
- Security Hub CSPM centralises security posture findings.
- GuardDuty detects suspicious or malicious activity.
- CloudTrail records API activity for audit.
- IAM Access Analyzer helps identify unintended external access.

Document exclusions and exceptions, including global services and the approved DR Region.

## 7. Network and data protection

- Keep the EKS API private in the production-oriented profile.
- Place RDS in private database subnets with security-group ingress only from approved application paths.
- Use VPC endpoints / PrivateLink for supported AWS service paths where justified.
- Encrypt data at rest with AWS-managed or customer-managed KMS keys based on classification and key-management needs.
- Use TLS for service and user traffic.
- Store secrets in AWS Secrets Manager or Systems Manager Parameter Store; use KMS for encryption.
- Do not place database passwords, AWS credentials, OIDC tokens or signing keys in Git or container images.
- Apply S3 Block Public Access and restrictive bucket policies to evidence, billing and archive buckets.
- Set object lifecycle, retention and deletion policy deliberately.
- Redact tokens and sensitive payloads from logs.

## 8. Cross-cloud federation security

For optional Azure-to-AWS publication:
- Register the Entra issuer as an AWS IAM OIDC provider where the trust pattern requires it.
- Validate issuer, audience and exact subject claims.
- Use `AssumeRoleWithWebIdentity` for temporary credentials.
- Restrict the role to read-only S3 actions and the Escanor findings prefix.
- Do not grant S3 bucket listing beyond the required prefix if not needed.
- Restrict Azure managed identity use to the intended web app / workload.
- Log STS role assumption and S3 data access.
- Test invalid audience, wrong subject and wrong issuer cases; all must be denied.

## 9. Threat scenarios

| Threat | Impact | Control / test |
|---|---|---|
| Prompt injection in finding text | Agent tries to execute unapproved action | Treat content as data; tool allowlist; mutation denied |
| Over-privileged Lambda role | Agent tool can modify production resources | IAM least privilege; policy simulation; negative API tests |
| Compromised CI identity | Unauthorised Terraform apply | OIDC claim restriction, protected environments, plan/apply separation |
| EKS pod compromise | Access to node or unrelated workload permissions | Pod identity isolation, minimal node role, network policy and image controls |
| Publicly exposed S3 evidence | Billing / infrastructure metadata disclosure | Block Public Access, bucket policy, encryption and access logging |
| Cross-account trust too broad | Unauthorised member-account access | Exact principal / condition constraints and assume-role tests |
| AgentCore unavailable | AI recommendations stop | Independent monitoring and alerting continue |
| Stale approval | Action executes against changed resource | Revalidate target state and action fingerprint before execution |
| Leaked token / secret | Credential compromise | Short lifetime, rotation / revocation, secret scanning and audit |

## 10. Security acceptance checklist

- [ ] Workload deployed only in the dedicated member account.
- [ ] Workforce access uses IAM Identity Center and MFA.
- [ ] CI deploys through exact-claim OIDC trust.
- [ ] EKS node and pod identities are separate.
- [ ] Lambda tools have separate execution roles.
- [ ] Agent default path cannot mutate AWS resources.
- [ ] IAM simulation denies destructive actions.
- [ ] Tool contract tests reject unapproved account, Region and resource targets.
- [ ] S3 Block Public Access and bucket policies are verified.
- [ ] RDS and EKS network paths are private in the production profile.
- [ ] KMS, Secrets Manager and log redaction controls are verified.
- [ ] Cross-cloud invalid-token tests are denied.
- [ ] CloudTrail confirms the expected caller and session identity.
