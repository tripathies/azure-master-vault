# Azure Policy

[← A. Cloud Foundation & Landing Zones](../README.md) · [← Master catalogue](../../README.md) · [Architecture diagram](architecture.mmd)

**Purpose.** Definitions describe conditions/effects; initiatives group policies; assignments apply at a scope. Start with audit, remediate drift, then enforce deny/modify/deploy-if-not-exists where supported and safe.

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
establishes cloud hierarchy, guardrails, placement and operational boundaries that workloads inherit. It interacts with upstream identity, governance and network decisions, and downstream workloads, data or operations depending on the selected pattern.

## When to use it
Use before production deployment or when defining enterprise ownership, compliance and resource organization.

**Alternatives and trade-offs:** Compare governance patterns against tenant boundaries, policy inheritance, ownership and billing requirements.

## Architecture design
This component-level flow shows a typical source, component and outcome plus cross-cutting controls. Dashed arrows are relationships, not necessarily packet paths.

~~~mermaid
flowchart LR
  Source["A regulated enterprise creates shared platform subscriptions for identity/connectivity/security and workload subscriptions under management groups with inherited policy."] --> Component["Azure Policy"] --> Outcome["Workload outcome / consumer"]
  Identity["Microsoft Entra ID / RBAC where supported"] -. authorization .-> Component
  Network["Network / DNS / private connectivity where applicable"] -. access path .-> Component
  Operations["Monitoring / logs / cost"] -. observe .-> Component
~~~

## Security and governance
Define tenant/subscription ownership, least-privilege Azure RBAC, policy assignments and documented exceptions.

## Network and connectivity
Plan address allocation, DNS, hybrid paths, private access and egress ownership at platform scope.

## Availability, scale and recovery
Separate regional placement, zonal resilience, backup and disaster recovery; hierarchy does not provide runtime availability.

## Cost and operations
Set ownership, budgets, tags, quota monitoring and chargeback rules before broad rollout.

## Enterprise scenario
A regulated enterprise creates shared platform subscriptions for identity/connectivity/security and workload subscriptions under management groups with inherited policy. Document the exact scope, owner, dependencies, alert/runbook, rollback or recovery action, and evidence that proves the design works.

## Implementation and validation
1. Confirm region/SKU/feature support, quota, naming rules and required permissions.
2. Map each diagram dependency to a real Azure resource or control.
3. Use a repository Terraform/Bicep or configuration sample where available; use a policy/configuration sample rather than fake deployment code for conceptual governance topics.
4. Review Terraform plan or Bicep `what-if`; verify scope, identity, network access and cost before deployment.
5. Validate allowed and denied access, DNS/routing where applicable, telemetry, failure behavior and recovery.
6. Record expected outputs and operational ownership. Clean up only lab resources that are safe to delete.

## Component-specific design note
Definitions describe conditions/effects; initiatives group policies; assignments apply at a scope. Start with audit, remediate drift, then enforce deny/modify/deploy-if-not-exists where supported and safe.

## Common mistakes
- Treating the component as a standalone solution without documenting dependencies.
- Assuming identity, private networking or redundancy automatically grants authorization or guarantees recovery.
- Skipping failure testing, telemetry, cost ownership and change/rollback planning.
- Deploying a sample without validating current SKU, region, API/provider version and service limits.

## Interview questions

**Q1. Where does Azure Policy fit in an Azure solution?**  
It implements one part of the larger cloud foundation & landing zones design. Explain upstream dependencies, downstream consumers, identity/network boundaries, monitoring and recovery.

**Q2. What trade-off drives the design?**  
Compare supported alternatives on security, operational burden, availability, scale, compliance and total cost. State assumptions and test the critical failure mode.

## LinkedIn-ready summary
A strong Azure design explains not just what Azure Policy does, but where it fits, which identity and network boundaries apply, how failures are detected and recovered, and how cost is controlled. #Azure #CloudArchitecture #AzureSolutionsArchitect

## Official reference
- [Microsoft Learn: Azure Policy](<https://learn.microsoft.com/search/?terms=Azure%20Policy%20Azure>)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
