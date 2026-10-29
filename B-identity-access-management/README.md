# B. Identity & Access Management

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json)

This page contains the category's working notes and checklists inline. The core objective is to establish **who/what can authenticate, what it can do, at which scope, under what conditions, and how that access is reviewed**.

## Category checklist
- [ ] Explain Microsoft Entra tenant, identity, authentication and authorization
- [ ] Distinguish app registration from enterprise application/service principal
- [ ] Select managed identity vs app credentials correctly
- [ ] Design Azure RBAC scope and role assignments
- [ ] Use MFA, Conditional Access and PIM for privileged access
- [ ] Explain OAuth 2.0 and OpenID Connect flows
- [ ] Audit access and test emergency recovery

## Reference identity flow

~~~mermaid
flowchart LR
    User[User or workload] --> Auth[Microsoft Entra authentication]
    Auth --> Token[Access / ID token as appropriate]
    Token --> App[Application or Azure resource]
    App --> AuthZ[Authorization: app permissions or Azure RBAC]
    AuthZ --> Resource[Allowed operation]
    Admin[Privileged administrator] --> PIM[Eligible role + activation]
    PIM --> Scope[Time-bound scoped role]
    Scope --> AuthZ
~~~

Authentication proves identity; authorization decides what that identity may do. A valid token does not automatically grant access to a resource.

---

## B1. Microsoft Entra ID

**Role:** Cloud identity and access service for users, groups, applications, service principals, authentication methods, Conditional Access and tenant-level identity controls.

**Architecture choices**
- Use groups to assign access at scale rather than assigning every user individually.
- Use Conditional Access to evaluate signals and enforce access policy; test report-only and emergency-access behavior before broad enforcement.
- Separate tenant administration from Azure resource administration.
- Review app consent and privileged roles, and protect emergency access accounts.

**Checklist**
- [ ] Document tenant boundary, identity sources and synchronization/collaboration.
- [ ] Require appropriate MFA for privileged and interactive access.
- [ ] Review tenant roles, app consents and risky sign-ins.
- [ ] Test break-glass accounts and alert on their use.

## B2. App registrations

An **app registration** defines an application's identity/configuration in a tenant: client ID, redirect URIs, requested API permissions, credential configuration and supported account types. It is not itself the Azure RBAC assignment.

Use authorization code flow with PKCE for interactive public clients where applicable; use a confidential-client flow for server-side applications. Do not embed client secrets in mobile apps, browser code or source control.

**Checklist**
- [ ] Register only required redirect URIs and supported account types.
- [ ] Request least-privilege API permissions and use admin consent deliberately.
- [ ] Prefer certificates or federated credentials over long-lived client secrets where supported.
- [ ] Monitor credential expiry and remove unused credentials and permissions.

## B3. Enterprise applications and service principals

An **enterprise application** is the tenant-local service principal representing an application. The app registration defines application configuration; the service principal is the local instance that receives tenant-local assignments and consent.

For Azure resource access, an app's service principal may also receive Azure RBAC assignments. API permissions and Azure RBAC are separate authorization systems.

**Checklist**
- [ ] Identify owner and purpose for each service principal.
- [ ] Review sign-in activity, API consent and Azure role assignments.
- [ ] Remove unused principals, stale credentials and excessive permissions.
- [ ] Avoid using one highly privileged principal for unrelated workloads.

## B4. Managed identities

Managed identities provide Azure-managed identities for supported workloads without storing application-managed credentials. **System-assigned** identity lifecycle follows the Azure resource; **user-assigned** identity is a separate resource that can be attached to supported workloads.

Use managed identity when a workload running on a supported Azure service needs to access another Entra-protected service. Assign the target resource's supported data-plane role; enabling identity alone grants no data access.

**Checklist**
- [ ] Choose system-assigned for resource-tied lifecycle; user-assigned when shared lifecycle/reuse is justified.
- [ ] Grant least-privilege role at the narrowest supported scope.
- [ ] Confirm target service supports the intended identity/authentication method.
- [ ] Avoid fallback to embedded credentials when managed identity fails; alert and troubleshoot correctly.

## B5. Azure RBAC

Azure Role-Based Access Control authorizes actions through role definitions and role assignments at management group, subscription, resource group or resource scope. Built-in roles are preferable when they match the required actions; custom roles need explicit ownership and review.

**Least-privilege procedure**
1. Identify required operations, including data-plane vs management-plane access.
2. Select the narrowest role and scope that supports those operations.
3. Assign to a group or workload identity where appropriate.
4. Validate effective access, inherited assignments and deny assignments.
5. Review access periodically and remove stale grants.

**Common mistake:** Contributor can manage many resources but does not automatically grant every data-plane permission. Data roles may be required separately.

## B6. MFA and Conditional Access

MFA adds an authentication factor. Conditional Access evaluates signals and applies controls such as requiring MFA, compliant devices, approved app access or blocking risky conditions, subject to supported licensing and configuration.

**Rollout pattern**
- Inventory existing authentication and dependencies.
- Use report-only to understand impact.
- Exclude only controlled emergency access accounts according to policy.
- Pilot by group, monitor sign-in logs, then enforce progressively.
- Test legacy authentication, service accounts and noninteractive workload flows separately; do not solve workload-auth issues by weakening user policies.

## B7. Privileged Identity Management (PIM)

PIM supports just-in-time and time-bound privileged access for supported roles. Use eligible assignments, activation requirements, justification, approval and alerts to reduce standing privilege.

**Checklist**
- [ ] Make privileged access eligible rather than permanently active where practical.
- [ ] Require MFA, justification and approval for high-impact roles when appropriate.
- [ ] Limit activation duration and notify security operations.
- [ ] Review assignments, activations and emergency-access process.
- [ ] Keep PIM licensing and feature availability in scope planning.

## B8. OAuth 2.0 and OpenID Connect

**OAuth 2.0** is an authorization framework for obtaining access tokens. **OpenID Connect (OIDC)** adds an identity layer and ID tokens on top of OAuth 2.0. An ID token is for the client to understand authentication; an access token is presented to the intended API. Do not use them interchangeably.

**Flow selection**
- Interactive web/mobile user sign-in: authorization code flow with PKCE.
- Server-side confidential client: authorization code flow with PKCE and securely managed client authentication.
- Service-to-service: client credentials or workload federation where appropriate; use managed identity for supported Azure-hosted workloads.
- Avoid implicit flow and resource-owner password patterns for new designs unless a documented legacy constraint dictates otherwise.

**Checklist**
- [ ] Validate issuer, audience, signature, expiry and scopes/roles at the API.
- [ ] Use exact redirect URIs and protect state/nonce as required by the chosen flow.
- [ ] Keep tokens and credentials out of logs and client-side storage where unsafe.
- [ ] Enforce API authorization independently of successful authentication.

---

## Enterprise scenario

A production App Service needs to read a secret from Key Vault and access a storage account. Enable a managed identity, assign only the required Key Vault and storage data roles at narrow scope, restrict network access as needed, monitor identity use, and avoid client secrets in app settings. Developers use group-based RBAC; production administrative roles are eligible through PIM and protected by Conditional Access.

## Common mistakes
- Treating app registration and service principal as the same object.
- Assuming a managed identity automatically has permissions.
- Confusing API permissions with Azure RBAC.
- Granting subscription Owner to an application for convenience.
- Using ID tokens to authorize API requests instead of validating access tokens.
- Applying Conditional Access globally without report-only/pilot and emergency access testing.

## Interview questions

**Q1. Managed identity vs service principal with a secret?**  
Both represent workload identity, but managed identity removes credential lifecycle from application code for supported Azure workloads. Use a service principal with federated credentials or securely managed credentials when workload identity federation/managed identity is not available.

**Q2. App registration vs enterprise application?**  
The app registration defines the application's configuration; the enterprise application is its tenant-local service principal, where local assignments, consent and sign-in settings are represented.

**Q3. RBAC vs Conditional Access?**  
RBAC authorizes Azure actions at scopes. Conditional Access applies identity/sign-in conditions. They complement one another.

**Q4. How do you implement least privilege?**  
Start from required actions, choose a narrow role and scope, assign through groups or workload identities, test effective access, monitor use and review grants periodically.

## LinkedIn-ready post

Cloud identity design is more than enabling sign-in. Separate authentication from authorization, understand app registrations vs service principals, prefer managed identity/federation over secrets, scope Azure RBAC narrowly, and use Conditional Access plus PIM for privileged access. Then monitor and test the controls. #MicrosoftEntra #AzureSecurity #ZeroTrust

## Official references
- [Microsoft Entra documentation](https://learn.microsoft.com/entra/)
- [Azure RBAC](https://learn.microsoft.com/azure/role-based-access-control/overview)
- [Managed identities](https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/overview)
- [OAuth 2.0 and OIDC on Microsoft identity platform](https://learn.microsoft.com/entra/identity-platform/v2-protocols)
