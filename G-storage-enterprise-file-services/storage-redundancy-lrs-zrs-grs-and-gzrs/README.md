# Storage Redundancy: LRS, ZRS, GRS & GZRS

[← G. Storage & Enterprise File Services](../README.md) · [← Master catalogue](../../README.md) · [Architecture diagram](architecture.mmd)

**Purpose.** Design Storage Redundancy: LRS, ZRS, GRS & GZRS around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

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
stores objects, analytics files, shared files, messages and key-value data with service-specific access and durability characteristics. It interacts with upstream identity, governance and network decisions, and downstream workloads, data or operations depending on the selected pattern.

## When to use it
Select by access pattern, protocol, latency, hierarchy, durability, recovery and lifecycle rather than capacity price alone.

**Alternatives and trade-offs:** Compare service by protocol, access pattern, latency, durability, retrieval, lifecycle and recovery objectives.

## Architecture design
This component-level flow shows a typical source, component and outcome plus cross-cutting controls. Dashed arrows are relationships, not necessarily packet paths.

~~~mermaid
flowchart LR
  Source["ADLS Gen2 stores curated analytics data"] --> Component["Storage Redundancy LRS ZRS GRS and GZRS"] --> Outcome["Workload outcome / consumer"]
  Identity["Microsoft Entra ID / RBAC where supported"] -. authorization .-> Component
  Network["Network / DNS / private connectivity where applicable"] -. access path .-> Component
  Operations["Monitoring / logs / cost"] -. observe .-> Component
~~~

## Security and governance
Prefer Entra data roles where supported, restrict public access, configure private endpoints/DNS, protect keys and apply retention/immutability as required.

## Network and connectivity
Validate service endpoints, private DNS, client routing, firewall settings and hybrid access from every consumer network.

## Availability, scale and recovery
Choose LRS/ZRS/GRS/GZRS by failure needs, and separately configure versioning, soft delete, backup and tested restore.

## Cost and operations
Model capacity, transactions, retrieval tiers, replication, egress, provisioned throughput and restore costs.

## Enterprise scenario
ADLS Gen2 stores curated analytics data, private endpoints restrict access, managed identities access data, and lifecycle rules reduce long-term cost. Document the exact scope, owner, dependencies, alert/runbook, rollback or recovery action, and evidence that proves the design works.

## Implementation and validation
1. Confirm region/SKU/feature support, quota, naming rules and required permissions.
2. Map each diagram dependency to a real Azure resource or control.
3. Use a repository Terraform/Bicep or configuration sample where available; use a policy/configuration sample rather than fake deployment code for conceptual governance topics.
4. Review Terraform plan or Bicep `what-if`; verify scope, identity, network access and cost before deployment.
5. Validate allowed and denied access, DNS/routing where applicable, telemetry, failure behavior and recovery.
6. Record expected outputs and operational ownership. Clean up only lab resources that are safe to delete.

## Component-specific design note
Design Storage Redundancy: LRS, ZRS, GRS & GZRS around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

## Common mistakes
- Treating the component as a standalone solution without documenting dependencies.
- Assuming identity, private networking or redundancy automatically grants authorization or guarantees recovery.
- Skipping failure testing, telemetry, cost ownership and change/rollback planning.
- Deploying a sample without validating current SKU, region, API/provider version and service limits.

## Interview questions

**Q1. Where does Storage Redundancy: LRS, ZRS, GRS & GZRS fit in an Azure solution?**  
It implements one part of the larger storage & enterprise file services design. Explain upstream dependencies, downstream consumers, identity/network boundaries, monitoring and recovery.

**Q2. What trade-off drives the design?**  
Compare supported alternatives on security, operational burden, availability, scale, compliance and total cost. State assumptions and test the critical failure mode.

## LinkedIn-ready summary
A strong Azure design explains not just what Storage Redundancy: LRS, ZRS, GRS & GZRS does, but where it fits, which identity and network boundaries apply, how failures are detected and recovered, and how cost is controlled. #Azure #CloudArchitecture #AzureSolutionsArchitect

## Official reference
- [Microsoft Learn: Storage Redundancy: LRS, ZRS, GRS & GZRS](<https://learn.microsoft.com/search/?terms=Storage%20Redundancy%3A%20LRS%2C%20ZRS%2C%20GRS%20%26%20GZRS%20Azure>)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
