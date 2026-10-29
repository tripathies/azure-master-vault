# Bicep / ARM Templates

[← L. DevOps, Resilience, Migration & AI](../README.md) · [← Master catalogue](../../README.md) · [Architecture diagram](architecture.mmd)

**Purpose.** Design Bicep / ARM Templates around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

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
automates infrastructure delivery, restores workloads, moves existing estates and enables governed AI applications. It interacts with upstream identity, governance and network decisions, and downstream workloads, data or operations depending on the selected pattern.

## When to use it
Use versioned IaC and protected pipelines; choose backup/replication from RTO/RPO; assess migration dependencies; choose AI services from the use case.

**Alternatives and trade-offs:** Choose tooling and platform from workload needs; validate identity, recovery objectives, model/data governance and current service support.

## Architecture design
This component-level flow shows a typical source, component and outcome plus cross-cutting controls. Dashed arrows are relationships, not necessarily packet paths.

~~~mermaid
flowchart LR
  Source["A pipeline deploys IaC with federation backup/DR is tested a RAG app uses authorized AI Search retrieval and a supported model deployment."] --> Component["Bicep / ARM Templates"] --> Outcome["Workload outcome / consumer"]
  Identity["Microsoft Entra ID / RBAC where supported"] -. authorization .-> Component
  Network["Network / DNS / private connectivity where applicable"] -. access path .-> Component
  Operations["Monitoring / logs / cost"] -. observe .-> Component
~~~

## Security and governance
Use federated CI/CD identity, least privilege, protected state, managed identity, data authorization and AI evaluation controls.

## Network and connectivity
Plan pipeline agent access, private deployment paths, hybrid connectivity, data-source access and private AI/search endpoints where supported.

## Availability, scale and recovery
Test restore/failover, migration rollback, pipeline recovery, model/search fallback and operational handover.

## Cost and operations
Model runners, recovery storage/replication, migration transfer, model tokens, search capacity and ML compute.

## Enterprise scenario
A pipeline deploys IaC with federation; backup/DR is tested; a RAG app uses authorized AI Search retrieval and a supported model deployment. Document the exact scope, owner, dependencies, alert/runbook, rollback or recovery action, and evidence that proves the design works.

## Implementation and validation
1. Confirm region/SKU/feature support, quota, naming rules and required permissions.
2. Map each diagram dependency to a real Azure resource or control.
3. Use a repository Terraform/Bicep or configuration sample where available; use a policy/configuration sample rather than fake deployment code for conceptual governance topics.
4. Review Terraform plan or Bicep `what-if`; verify scope, identity, network access and cost before deployment.
5. Validate allowed and denied access, DNS/routing where applicable, telemetry, failure behavior and recovery.
6. Record expected outputs and operational ownership. Clean up only lab resources that are safe to delete.

## Component-specific design note
Design Bicep / ARM Templates around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

## Common mistakes
- Treating the component as a standalone solution without documenting dependencies.
- Assuming identity, private networking or redundancy automatically grants authorization or guarantees recovery.
- Skipping failure testing, telemetry, cost ownership and change/rollback planning.
- Deploying a sample without validating current SKU, region, API/provider version and service limits.

## Interview questions

**Q1. Where does Bicep / ARM Templates fit in an Azure solution?**  
It implements one part of the larger devops, resilience, migration & ai design. Explain upstream dependencies, downstream consumers, identity/network boundaries, monitoring and recovery.

**Q2. What trade-off drives the design?**  
Compare supported alternatives on security, operational burden, availability, scale, compliance and total cost. State assumptions and test the critical failure mode.

## LinkedIn-ready summary
A strong Azure design explains not just what Bicep / ARM Templates does, but where it fits, which identity and network boundaries apply, how failures are detected and recovered, and how cost is controlled. #Azure #CloudArchitecture #AzureSolutionsArchitect

## Official reference
- [Microsoft Learn: Bicep / ARM Templates](<https://learn.microsoft.com/search/?terms=Bicep%20%2F%20ARM%20Templates%20Azure>)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
