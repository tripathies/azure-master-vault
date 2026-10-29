# Azure Bastion

[← D. Traffic Management & Delivery](../README.md) · [← Master catalogue](../../README.md)

**Guide status:** Starter guide. Verify current service behavior, limits and pricing in Microsoft Learn.

## Completion checklist
- [ ] Purpose and architecture placement
- [ ] Use cases, alternatives and decision matrix
- [ ] Identity, security and governance
- [ ] Traffic/data flow and private connectivity where applicable
- [ ] HA, scaling, failover, backup/DR and limits where applicable
- [ ] Cost drivers, monitoring and operational ownership
- [ ] Realistic enterprise scenario and trade-offs
- [ ] Service-specific architecture diagram
- [ ] Validated Terraform/Bicep and parameters where appropriate
- [ ] Validation, deployment, output and cleanup
- [ ] Interview Q&A, LinkedIn post and official references

## What it is and where it fits
Describe Azure Bastion's role, traffic or workload it serves, dependencies, scope, and how it differs from alternatives.

## When to use it
Assess protocol/application needs, performance, scale, availability, security, global vs regional requirements, operational complexity and total cost. Explain alternatives and assumptions.

## Design checklist
- [ ] Document ingress/egress and trust boundaries
- [ ] Apply least privilege and restrict management-plane exposure
- [ ] Validate TLS/certificates, DNS and health probes where relevant
- [ ] Design for failure domains and test failover behavior
- [ ] Enable logs, metrics, alerts and operational runbooks
- [ ] Verify regional availability, quotas and pricing

## Architecture
Add a service-specific diagram showing traffic direction, health/failover paths, dependencies and security boundaries.

## Infrastructure as Code
Add tested Terraform/Bicep under `infra/` where appropriate. Include parameters, prerequisites, validation, deployment and cleanup; never commit secrets or state.

## Scenario
Describe an enterprise workload needing Azure Bastion, alternatives considered, design rationale, failure modes, operational handoffs and cost trade-offs.

## Interview question and model answer
**Question:** What factors drive the design of Azure Bastion for production?

**Model answer:** Translate requirements into routing/traffic, performance, security, availability, recovery, operational and cost criteria. Compare alternatives, document assumptions and failure paths, then validate health checks, DNS, access and failover in a representative test.

## LinkedIn post
**Azure architecture note — Azure Bastion:** Traffic design should explicitly address health, failover, trust boundaries, observability and cost—not just route requests. Document assumptions and test failure paths before production. #Azure #CloudArchitecture #Reliability

## References
- [Microsoft Learn — Azure](https://learn.microsoft.com/azure/)
- Add service-specific docs, limits and pricing.
