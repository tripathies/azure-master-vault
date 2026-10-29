# Azure RBAC

[← B. Identity & Access Management](../README.md) · [← Master catalogue](../../README.md) · [Architecture diagram](architecture.mmd)

**Purpose.** Role assignments combine principal, role definition and scope. Prefer built-in roles and groups; distinguish control-plane actions from data-plane access and verify effective access/inheritance.

## Completion tracker

- [ ] Purpose, scope and architecture placement
- [ ] Use cases, non-use cases, alternatives and decision criteria
- [ ] Identity, RBAC, security, governance and data protection
- [ ] Network paths, private connectivity and DNS where applicable
- [ ] Availability, scaling, backup/DR, limits and failure modes where applicable
- [ ] Pricing drivers, cost controls and common cost surprises
- [ ] Enterprise scenario, trade-offs and operational ownership
- [ ] Service-specific architecture diagram
- [ ] Terraform/Bicep or policy/configuration samples where appropriate
- [ ] Validation, deployment, expected outputs and cleanup where applicable
- [ ] Interview questions with model answers
- [ ] LinkedIn-ready summary and official Microsoft Learn references

## Where it fits
defines how users, applications and workloads authenticate and how permissions are granted to Azure resources or APIs. It interacts with upstream identity, governance and network decisions, and downstream workloads, data or operations depending on the selected pattern.

## When to use it
Use to establish identity boundaries, secure application-to-service access, govern privileged roles and reduce standing credentials.

**Alternatives and trade-offs:** Compare managed identity, federated identity and application credentials based on hosting support and credential lifecycle; distinguish authentication from authorization.

## Architecture design
This component-level flow shows a typical source, component and outcome plus cross-cutting controls. Dashed arrows are relationships, not necessarily packet paths.

~~~mermaid
flowchart LR
  Source["An App Service reads Key Vault using managed identity"] --> Component["Azure RBAC"] --> Outcome["Workload outcome / consumer"]
  Identity["Microsoft Entra ID / RBAC where supported"] -. authorization .-> Component
  Network["Network / DNS / private connectivity where applicable"] -. access path .-> Component
  Operations["Monitoring / logs / cost"] -. observe .-> Component
~~~

## Security and governance
Use MFA and Conditional Access for interactive access, PIM for privileged access, managed identity/federation for workloads and least-privilege roles.

## Network and connectivity
Identity controls do not replace network controls; verify endpoints, private access, DNS and conditional-access requirements independently.

## Availability, scale and recovery
Document emergency access, credential/certificate expiry, identity dependencies and monitoring for failed or suspicious sign-ins.

## Cost and operations
Review licensing requirements for Conditional Access/PIM and avoid unnecessary premium features.

## Enterprise scenario
An App Service reads Key Vault using managed identity, while administrators use group-based RBAC and eligible privileged roles activated through PIM. Document the exact scope, owner, dependencies, alert/runbook, rollback or recovery action, and evidence that proves the design works.

## Implementation and validation
1. Confirm region/SKU/feature support, quota, naming rules and required permissions.
2. Map each diagram dependency to a real Azure resource or control.
3. Use a repository Terraform/Bicep or configuration sample where available; use a policy/configuration sample rather than fake deployment code for conceptual governance topics.
4. Review Terraform plan or Bicep `what-if`; verify scope, identity, network access and cost before deployment.
5. Validate allowed and denied access, DNS/routing where applicable, telemetry, failure behavior and recovery.
6. Record expected outputs and operational ownership. Clean up only lab resources that are safe to delete.

## Component-specific design note
Role assignments combine principal, role definition and scope. Prefer built-in roles and groups; distinguish control-plane actions from data-plane access and verify effective access/inheritance.

## Common mistakes
- Treating the component as a standalone solution without documenting dependencies.
- Assuming identity, private networking or redundancy automatically grants authorization or guarantees recovery.
- Skipping failure testing, telemetry, cost ownership and change/rollback planning.
- Deploying a sample without validating current SKU, region, API/provider version and service limits.

## Interview questions

**Q1. Where does Azure RBAC fit in an Azure solution?**  
It implements one part of the larger identity & access management design. Explain upstream dependencies, downstream consumers, identity/network boundaries, monitoring and recovery.

**Q2. What trade-off drives the design?**  
Compare supported alternatives on security, operational burden, availability, scale, compliance and total cost. State assumptions and test the critical failure mode.

## LinkedIn-ready summary
A strong Azure design explains not just what Azure RBAC does, but where it fits, which identity and network boundaries apply, how failures are detected and recovered, and how cost is controlled. #Azure #CloudArchitecture #AzureSolutionsArchitect

## Official reference
- [Microsoft Learn: Azure RBAC](<https://learn.microsoft.com/search/?terms=Azure%20RBAC%20Azure>)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
