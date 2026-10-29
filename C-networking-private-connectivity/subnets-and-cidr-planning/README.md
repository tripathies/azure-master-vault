# Subnets & CIDR Planning

[← C. Networking & Private Connectivity](../README.md) · [← Master catalogue](../../README.md) · [Architecture diagram](architecture.mmd)

**Purpose.** Design Subnets & CIDR Planning around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

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
provides address space, traffic paths, segmentation, hybrid connectivity and private service access. It interacts with upstream identity, governance and network decisions, and downstream workloads, data or operations depending on the selected pattern.

## When to use it
Use to connect workloads with explicit trust boundaries and predictable routing, DNS and egress.

**Alternatives and trade-offs:** Compare native routing/security services against network virtual appliances and hybrid options using traffic path, throughput, inspection and operational burden.

## Architecture design
This component-level flow shows a typical source, component and outcome plus cross-cutting controls. Dashed arrows are relationships, not necessarily packet paths.

~~~mermaid
flowchart LR
  Source["A hub-spoke estate routes controlled egress through a hub firewall and reaches Storage through private endpoints with DNS forwarding."] --> Component["Subnets and CIDR Planning"] --> Outcome["Workload outcome / consumer"]
  Identity["Microsoft Entra ID / RBAC where supported"] -. authorization .-> Component
  Network["Network / DNS / private connectivity where applicable"] -. access path .-> Component
  Operations["Monitoring / logs / cost"] -. observe .-> Component
~~~

## Security and governance
Use NSGs for distributed L3/L4 filtering, central firewall inspection where required, narrow public exposure and service identity authorization.

## Network and connectivity
Plan non-overlapping CIDRs, effective routes, peering/gateway transit, private DNS and forward/return paths; validate from the actual client network.

## Availability, scale and recovery
Design gateway/firewall/zone redundancy where supported, test route convergence and failover, and avoid asymmetric paths through stateful appliances.

## Cost and operations
Model gateway, firewall, NAT, public IP, private endpoint, egress and data-processing charges.

## Enterprise scenario
A hub-spoke estate routes controlled egress through a hub firewall and reaches Storage through private endpoints with DNS forwarding. Document the exact scope, owner, dependencies, alert/runbook, rollback or recovery action, and evidence that proves the design works.

## Implementation and validation
1. Confirm region/SKU/feature support, quota, naming rules and required permissions.
2. Map each diagram dependency to a real Azure resource or control.
3. Use a repository Terraform/Bicep or configuration sample where available; use a policy/configuration sample rather than fake deployment code for conceptual governance topics.
4. Review Terraform plan or Bicep `what-if`; verify scope, identity, network access and cost before deployment.
5. Validate allowed and denied access, DNS/routing where applicable, telemetry, failure behavior and recovery.
6. Record expected outputs and operational ownership. Clean up only lab resources that are safe to delete.

## Component-specific design note
Design Subnets & CIDR Planning around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

## Common mistakes
- Treating the component as a standalone solution without documenting dependencies.
- Assuming identity, private networking or redundancy automatically grants authorization or guarantees recovery.
- Skipping failure testing, telemetry, cost ownership and change/rollback planning.
- Deploying a sample without validating current SKU, region, API/provider version and service limits.

## Interview questions

**Q1. Where does Subnets & CIDR Planning fit in an Azure solution?**  
It implements one part of the larger networking & private connectivity design. Explain upstream dependencies, downstream consumers, identity/network boundaries, monitoring and recovery.

**Q2. What trade-off drives the design?**  
Compare supported alternatives on security, operational burden, availability, scale, compliance and total cost. State assumptions and test the critical failure mode.

## LinkedIn-ready summary
A strong Azure design explains not just what Subnets & CIDR Planning does, but where it fits, which identity and network boundaries apply, how failures are detected and recovered, and how cost is controlled. #Azure #CloudArchitecture #AzureSolutionsArchitect

## Official reference
- [Microsoft Learn: Subnets & CIDR Planning](<https://learn.microsoft.com/search/?terms=Subnets%20%26%20CIDR%20Planning%20Azure>)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
