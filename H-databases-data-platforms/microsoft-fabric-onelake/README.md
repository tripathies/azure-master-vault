# Microsoft Fabric / OneLake

[← H. Databases & Data Platforms](../README.md) · [← Master catalogue](../../README.md) · [Architecture diagram](architecture.mmd)

**Purpose.** Design Microsoft Fabric / OneLake around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

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
persists and processes structured, document, key-value and analytical data using different consistency, query and scale models. It interacts with upstream identity, governance and network decisions, and downstream workloads, data or operations depending on the selected pattern.

## When to use it
Choose from data model, query patterns, compatibility, consistency, latency, migration needs, operations and skills.

**Alternatives and trade-offs:** Compare data models, consistency, query patterns, compatibility, migration effort, HA/DR and total cost.

## Architecture design
This component-level flow shows a typical source, component and outcome plus cross-cutting controls. Dashed arrows are relationships, not necessarily packet paths.

~~~mermaid
flowchart LR
  Source["A transactional SQL database remains isolated from analytics workloads"] --> Component["Microsoft Fabric / OneLake"] --> Outcome["Workload outcome / consumer"]
  Identity["Microsoft Entra ID / RBAC where supported"] -. authorization .-> Component
  Network["Network / DNS / private connectivity where applicable"] -. access path .-> Component
  Operations["Monitoring / logs / cost"] -. observe .-> Component
~~~

## Security and governance
Separate control-plane roles from data-plane permissions, use Entra/managed identity where supported, private connectivity, encryption and auditing.

## Network and connectivity
Design private endpoints/VNet integration, DNS, firewall allowlists and connectivity from apps, pipelines and operations tools.

## Availability, scale and recovery
Define backup/PITR, HA, replication, regional failover and restore tests according to explicit RTO/RPO.

## Cost and operations
Model compute, storage, transactions/RUs, backups, replicas, egress, analytics capacity and query inefficiency.

## Enterprise scenario
A transactional SQL database remains isolated from analytics workloads, which use governed pipelines and a separate data-processing platform. Document the exact scope, owner, dependencies, alert/runbook, rollback or recovery action, and evidence that proves the design works.

## Implementation and validation
1. Confirm region/SKU/feature support, quota, naming rules and required permissions.
2. Map each diagram dependency to a real Azure resource or control.
3. Use a repository Terraform/Bicep or configuration sample where available; use a policy/configuration sample rather than fake deployment code for conceptual governance topics.
4. Review Terraform plan or Bicep `what-if`; verify scope, identity, network access and cost before deployment.
5. Validate allowed and denied access, DNS/routing where applicable, telemetry, failure behavior and recovery.
6. Record expected outputs and operational ownership. Clean up only lab resources that are safe to delete.

## Component-specific design note
Design Microsoft Fabric / OneLake around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

## Common mistakes
- Treating the component as a standalone solution without documenting dependencies.
- Assuming identity, private networking or redundancy automatically grants authorization or guarantees recovery.
- Skipping failure testing, telemetry, cost ownership and change/rollback planning.
- Deploying a sample without validating current SKU, region, API/provider version and service limits.

## Interview questions

**Q1. Where does Microsoft Fabric / OneLake fit in an Azure solution?**  
It implements one part of the larger databases & data platforms design. Explain upstream dependencies, downstream consumers, identity/network boundaries, monitoring and recovery.

**Q2. What trade-off drives the design?**  
Compare supported alternatives on security, operational burden, availability, scale, compliance and total cost. State assumptions and test the critical failure mode.

## LinkedIn-ready summary
A strong Azure design explains not just what Microsoft Fabric / OneLake does, but where it fits, which identity and network boundaries apply, how failures are detected and recovered, and how cost is controlled. #Azure #CloudArchitecture #AzureSolutionsArchitect

## Official reference
- [Microsoft Learn: Microsoft Fabric / OneLake](<https://learn.microsoft.com/search/?terms=Microsoft%20Fabric%20%2F%20OneLake%20Azure>)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
