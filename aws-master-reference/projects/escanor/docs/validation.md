# Escanor AWS — Validation and Evidence Checklist

**Status:** Acceptance test plan; no AWS deployment is claimed  
**Purpose:** Define evidence required before a component is marked validated.

## 1. Account and landing-zone preflight

- [ ] Confirm caller identity with `aws sts get-caller-identity`.
- [ ] Confirm expected account ID and assumed role.
- [ ] Confirm the account is the dedicated Escanor member account.
- [ ] Confirm selected Region is approved and governed.
- [ ] Confirm SCP / Control Tower controls and required service access.
- [ ] Confirm quotas and service availability.
- [ ] Confirm budget and cost-anomaly notification recipients.
- [ ] Confirm no deployment is targeting the Organizations management, Audit or Log Archive account.

Retain the command, timestamp, account ID, Region and identity details in the deployment record. Redact tokens and sensitive data.

## 2. Terraform and CI/CD

- [ ] Terraform version matches the project pin.
- [ ] Provider and module versions are pinned.
- [ ] Formatting and validation pass.
- [ ] Security scanning passes or exceptions are recorded.
- [ ] CI assumes AWS role through exact OIDC claims.
- [ ] An untrusted branch / repository cannot assume the deployment role.
- [ ] Plan shows only intended account, Region and resources.
- [ ] Apply requires protected environment approval.
- [ ] State bucket denies public access and unauthorised principals.
- [ ] State version restore and lock behaviour are tested.
- [ ] State, plan files, credentials and kubeconfig are not committed.

## 3. EKS, network and identity

- [ ] EKS minor version is in standard support at deployment time.
- [ ] Cluster endpoint access matches the approved profile.
- [ ] Node groups span the intended AZs and are sized as designed.
- [ ] Cluster add-ons are compatible and healthy.
- [ ] Pod Identity / IRSA mappings use dedicated service roles.
- [ ] Node role does not contain application data permissions.
- [ ] RDS is in private database subnets.
- [ ] Security groups allow only documented traffic.
- [ ] VPC endpoints / NAT paths match the cost and security design.
- [ ] DNS and API reachability tests pass from the intended network.

## 4. Four drift planes

For each plane test at least one positive, one negative, one duplicate and one stale / resolved case.

| Plane | Positive case | Negative case | Evidence |
|---|---|---|---|
| Infrastructure | Change a test resource outside Terraform | Approved / ignored resource change | Terraform plan, AWS Config, CloudTrail and resource ARN |
| GitOps | Make a test manifest out of sync | Intentional approved sync | Argo CD app, Git commit, sync / health state |
| Runtime | Create test replica mismatch | Expected autoscaling event | Kubernetes desired / observed replicas and timestamp |
| Economic | Create a known idle test resource | Resource with valid usage / owner exception | CUR line item, resource identity and utilisation history |

Check finding ID stability, account / Region identity, deduplication, source timestamp, evidence references, lifecycle and metric cardinality.

## 5. FinOps data and claims

- [ ] CUR 2.0 export is enabled and data arrives in S3.
- [ ] S3 objects are catalogued by Glue.
- [ ] Athena query totals reconcile with Cost Explorer for the same period and scope.
- [ ] Late / incomplete billing periods are marked as incomplete.
- [ ] Cost attribution uses activated tags / account mapping where available.
- [ ] Utilisation history covers the stated analysis window.
- [ ] Recommendation shows the metric window and percentile used.
- [ ] Identified / approved / implemented / realised states are separate.
- [ ] Realised savings are confirmed in a subsequent complete billing period.
- [ ] Cost to run the lab is not confused with the notional monthly waste detected.

## 6. AgentCore, tools and safety

- [ ] AgentCore feature and model are supported in the selected Region.
- [ ] Runtime and Gateway identity are configured with least privilege.
- [ ] Tool arguments are validated against strict schemas.
- [ ] Tool target account, Region and resource ARN are allowlisted.
- [ ] Default agent execution role is read-only.
- [ ] IAM simulation and direct API tests deny mutation and deletion.
- [ ] Prompt injection in resource descriptions / findings cannot bypass tool policy.
- [ ] Responses include source evidence for material claims.
- [ ] Unavailable or incomplete evidence is disclosed.
- [ ] An unapproved T2 action is rejected.
- [ ] No T3 destructive tool is exposed to an autonomous agent.
- [ ] Alerting continues with AgentCore deliberately disabled.

Candidate model evaluation thresholds are recorded in the [implementation plan](../lld/06-implementation-validation.md); they are not considered passed until measured on a labelled test set.

## 7. Security and audit

- [ ] CloudTrail events show expected principal, role and session.
- [ ] Security Hub CSPM receives findings from the workload account.
- [ ] GuardDuty is enabled according to the landing-zone design.
- [ ] S3 Block Public Access and bucket resource policies are verified.
- [ ] Secrets are not present in Git, images, logs or environment artifacts.
- [ ] RDS encryption and network exposure are verified.
- [ ] Security exceptions have owner, reason, expiry and approval.
- [ ] Cross-cloud OIDC allowed and denied claim tests pass, if the extension is enabled.

## 8. Operations, DR and teardown

- [ ] CloudWatch and Prometheus signals are visible.
- [ ] Alert routing works with AgentCore stopped.
- [ ] EKS / Argo CD drift runbooks have been executed.
- [ ] Database and S3 recovery tests are recorded.
- [ ] EKS rebuild time is measured.
- [ ] Regional recovery test produces measured RTO / RPO.
- [ ] SLO statements are reconciled with regional recovery objectives.
- [ ] Terraform destroy plan is reviewed and run in the lab.
- [ ] Kubernetes-created load balancers and EBS volumes are checked.
- [ ] EBS volumes, snapshots, Elastic IPs, NAT Gateways, load balancers, RDS, ECR and S3 retention are reviewed.
- [ ] Cost Explorer is checked after billing data updates.

## 9. Evidence record template

| Field | Value |
|---|---|
| Commit / release | |
| Environment | |
| AWS account ID | |
| Region | |
| Assumed role | |
| Test ID | |
| Test timestamp | |
| Result | Pass / Fail / Blocked |
| Evidence location | |
| Exception / ticket | |
| Reviewer | |
