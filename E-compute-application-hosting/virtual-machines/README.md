# Virtual Machines

[← E. Compute & Application Hosting](../README.md) · [← Master catalogue](../../README.md) · [Architecture diagram](architecture.mmd)

**Purpose.** Design Virtual Machines around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

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
runs applications and compute jobs with different levels of OS control and platform management. It interacts with upstream identity, governance and network decisions, and downstream workloads, data or operations depending on the selected pattern.

## When to use it
Choose the simplest hosting model that satisfies runtime, scaling, networking, availability and control requirements.

**Alternatives and trade-offs:** Compare VM control against managed PaaS/serverless options using runtime constraints, scale, patching, networking and operations.

## Architecture design
This component-level flow shows a typical source, component and outcome plus cross-cutting controls. Dashed arrows are relationships, not necessarily packet paths.

~~~mermaid
flowchart LR
  Source["An API uses App Service"] --> Component["Virtual Machines"] --> Outcome["Workload outcome / consumer"]
  Identity["Microsoft Entra ID / RBAC where supported"] -. authorization .-> Component
  Network["Network / DNS / private connectivity where applicable"] -. access path .-> Component
  Operations["Monitoring / logs / cost"] -. observe .-> Component
~~~

## Security and governance
Use managed identity where supported, patch/harden VMs, restrict management access, store secrets outside code and protect ingress/egress.

## Network and connectivity
Design ingress, outbound VNet integration, private endpoints, DNS and administrative access separately.

## Availability, scale and recovery
Use health checks, autoscale, zones where supported, tested backups/restore and deployment rollback.

## Cost and operations
Compare uptime, VM family/size, disks, plan/SKU, autoscale, licenses, egress and idle capacity.

## Enterprise scenario
An API uses App Service, event processing uses Functions, and a legacy dependency remains on VMs only where OS control is necessary. Document the exact scope, owner, dependencies, alert/runbook, rollback or recovery action, and evidence that proves the design works.

## Implementation and validation
1. Confirm region/SKU/feature support, quota, naming rules and required permissions.
2. Map each diagram dependency to a real Azure resource or control.
3. Use a repository Terraform/Bicep or configuration sample where available; use a policy/configuration sample rather than fake deployment code for conceptual governance topics.
4. Review Terraform plan or Bicep `what-if`; verify scope, identity, network access and cost before deployment.
5. Validate allowed and denied access, DNS/routing where applicable, telemetry, failure behavior and recovery.
6. Record expected outputs and operational ownership. Clean up only lab resources that are safe to delete.

## Component-specific design note
Design Virtual Machines around its documented capability boundary, supported consumers, dependencies, permission model and failure behavior. Confirm service limits and current regional/SKU support in Microsoft Learn before production use.

## Common mistakes
- Treating the component as a standalone solution without documenting dependencies.
- Assuming identity, private networking or redundancy automatically grants authorization or guarantees recovery.
- Skipping failure testing, telemetry, cost ownership and change/rollback planning.
- Deploying a sample without validating current SKU, region, API/provider version and service limits.

## Interview questions

**Q1. Where does Virtual Machines fit in an Azure solution?**  
It implements one part of the larger compute & application hosting design. Explain upstream dependencies, downstream consumers, identity/network boundaries, monitoring and recovery.

**Q2. What trade-off drives the design?**  
Compare supported alternatives on security, operational burden, availability, scale, compliance and total cost. State assumptions and test the critical failure mode.

## LinkedIn-ready summary
A strong Azure design explains not just what Virtual Machines does, but where it fits, which identity and network boundaries apply, how failures are detected and recovered, and how cost is controlled. #Azure #CloudArchitecture #AzureSolutionsArchitect

## Official reference
- [Microsoft Learn: Virtual Machines](<https://learn.microsoft.com/search/?terms=Virtual%20Machines%20Azure>)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
