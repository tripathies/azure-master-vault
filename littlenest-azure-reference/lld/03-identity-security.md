# 03 — Identity and Security Design

## 1. Security objectives

- Authenticate workloads without embedding long-lived credentials.
- Authorise only the data-plane and control-plane actions required.
- Keep application and data services on private paths in Profile A.
- Protect deployment inputs, Terraform state and secrets.
- Use synthetic data and keep the lab isolated from production.
- Make security assumptions and exceptions visible to reviewers.

## 2. Trust boundaries

| Boundary | Trusted actors / systems | Required control |
|---|---|---|
| Learner workstation → Azure control plane | Authorised learner / deployment identity | Entra authentication, correct tenant and subscription selection, least-privilege RBAC |
| Browser → App Service | Client with private network route | HTTPS and private inbound access |
| App Service → Cosmos / Queue / Key Vault | App Service system-assigned identity | Entra ID token and scoped data-plane role |
| Storage Queue → Functions | Azure Functions trigger runtime | Managed identity-based host / trigger configuration as defined in app settings |
| Functions → Cosmos DB | Function system-assigned identity | Entra ID token and scoped Cosmos data-plane role |
| Terraform runner → Azure | Human or CI deployment identity | Explicit subscription ID, reviewed plan, controlled role-assignment rights |
| Source repository → deployment | Maintainers and CI | Review, secret hygiene, protected credentials |

## 3. Identity design

### 3.1 Workload identities

The App Service and Function App use system-assigned managed identities. Their lifecycle is tied to their respective Azure resources.

| Identity | Intended access | Control |
|---|---|---|
| App Service identity | Cosmos DB catalogue / order operations; Storage Queue send; optional Key Vault secret read | Assign only required data-plane roles at the narrowest supported scope |
| Function identity | Read and update order data in Cosmos DB; access required host / trigger resources | Assign only required data-plane roles; validate host storage identity configuration |
| Terraform deployment identity | Create / update workload resources and role assignments; manage required Storage data-plane objects during bootstrap | Use a dedicated non-production scope; remove elevated temporary permissions after deployment where appropriate |

The precise role names and scopes must match the Terraform role assignment resources. Do not grant subscription-wide Owner simply to make the lab work.

### 3.2 Human and automation access

- Use Entra ID interactive sign-in for learner exercises.
- Select the subscription using its immutable ID, not a display name.
- For CI, prefer workload identity federation / OIDC where the pipeline supports it; avoid long-lived client secrets.
- Restrict who can modify Terraform, workflow files and deployment environments.
- Separate the identity that provisions infrastructure from the runtime identities used by the application.
- Review and remove temporary bootstrap privileges after the deployment process is complete.

### 3.3 Storage data-plane bootstrap

Storage shared-key access is disabled. Terraform uses Entra ID for Blob and Queue data-plane operations. The deploying principal therefore needs the documented Storage Blob and Queue data roles before Terraform creates the required data-plane objects.

The Storage firewall has a default-deny rule and a single explicit Terraform runner public IPv4 exception for bootstrap. The application uses private endpoints and managed identity. The exception must be the actual egress IPv4 observed by Storage, not a laptop RFC1918 address and not a CIDR suffix.

## 4. Network security

| Control | Baseline design | Validation |
|---|---|---|
| App ingress | App Service and Function App private inbound endpoints; no public internet ingress | Confirm public network access settings and private endpoint connection |
| App outbound | VNet integration as configured | Inspect integration subnet and route behaviour |
| Data services | Private endpoints and private DNS | Resolve FQDNs from connected client and verify private IP |
| Key Vault | Private endpoint; managed identity access | Confirm network access and secret-read permission |
| Storage | Firewall default deny with explicit runner IPv4 bootstrap exception; private endpoints for workload | Inspect firewall, endpoint and DNS settings |
| Administrative access | No public SSH requirement for optional test VM | Use documented private management path / Azure Run Command |

Private endpoint creation alone does not prove a secure path. DNS, routing, endpoint approval, service network policy and identity authorisation must all be validated.

## 5. Data protection and secrets

- All data is synthetic. Production PII and payment data are prohibited in this lab.
- Use HTTPS for application requests.
- Use platform-managed encryption at rest for Azure services as provided by the selected service configuration; customer-managed keys are not part of Profile A.
- Do not place secrets, access keys, SAS tokens, connection strings, certificates or credentials in Git.
- Do not commit `terraform.tfvars`, Terraform state, plan files, local environment files or deployment output that may contain sensitive values.
- Use Key Vault only for the optional secret exercise. Retrieve secrets at runtime through managed identity; do not duplicate secret values into app settings.
- Rotate or remove any credential that is accidentally exposed; deleting it from the latest commit is not sufficient if it remains in repository history.

## 6. Threat considerations

| Threat | Potential impact | Baseline mitigation / response |
|---|---|---|
| Wrong subscription selected | Resources created in an unintended environment | Explicit subscription ID, read-only preflight, inspect plan |
| Public exposure of app or data | Unauthorised access | Private access defaults; verify service-level public network settings |
| Over-privileged deployment identity | Unintended resource or role changes | Scope RBAC, separate runtime identities, review role assignments |
| Leaked Terraform state / plan | Exposure of infrastructure metadata or secrets | Local protected storage; never commit; remote backend before team use |
| Secret committed to Git | Credential compromise | Secret scanning, rotate/revoke, remove from history where required |
| Storage bootstrap IP too broad / stale | Unnecessary exposure or failed deployment | One confirmed egress IPv4; remove exception when no longer needed if operationally feasible |
| Queue message replay / duplication | Duplicate order processing | Validate current worker behaviour; add idempotency before production use |
| Malicious or malformed order payload | Worker errors or data integrity issues | Input validation, bounded payloads, safe logging and future poison-message controls |
| Excessive log detail | Sensitive data disclosure | Never log tokens, secrets or full sensitive payloads |

## 7. Security validation checklist

- [ ] Confirm tenant and subscription IDs before deployment.
- [ ] Confirm the deployment identity is authorised only at the intended lab scope.
- [ ] Inspect all role assignments and verify principal IDs.
- [ ] Confirm App Service and Function App system-assigned identities are enabled.
- [ ] Confirm app settings use managed identity configuration rather than embedded credentials.
- [ ] Confirm Cosmos DB and Key Vault private endpoint / public network settings.
- [ ] Confirm Storage shared-key access is disabled and firewall rules are understood.
- [ ] Confirm private DNS zones are linked to the intended VNet.
- [ ] Confirm no secrets or Terraform artifacts are tracked by Git.
- [ ] Test the application and worker with their runtime identities.
- [ ] Review logs for accidental secret or sensitive payload disclosure.
- [ ] Destroy the lab and inspect residual resources.

## 8. Security backlog before production use

LittleNest is not production-hardened. A production adoption would require, at minimum:

1. Formal threat modelling and security architecture review.
2. Managed private connectivity from approved user and deployment networks.
3. Centralised policy, Defender for Cloud posture and vulnerability management.
4. Central log retention, SIEM integration, alert ownership and incident response.
5. Explicit data retention, privacy, backup and recovery requirements.
6. Queue poison-message handling, idempotency and reconciliation.
7. Secure software supply chain, dependency scanning, artifact signing and controlled release.
8. Formal access reviews, privileged access management and break-glass procedures.
9. Load, penetration, resilience and recovery testing.
10. Documented RTO / RPO and operational ownership.
