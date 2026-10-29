# Subnets & CIDR Planning

[← C. Networking & Private Connectivity](../README.md) · [← Master catalogue](../../README.md)

**Guide status:** Starter. Complete the checklist and validate component-specific details against current Microsoft Learn before production use.

## Checklist
- [ ] Explain purpose, scope, architecture placement and terminology
- [ ] Document use cases, non-use cases, alternatives and selection criteria
- [ ] Cover identity, RBAC, security and governance
- [ ] Cover network flows/private connectivity where relevant
- [ ] Cover availability, scale, recovery, limits and failure modes where relevant
- [ ] Explain cost drivers and optimization
- [ ] Add realistic enterprise scenario and trade-offs
- [ ] Add service-specific `architecture.mmd`
- [ ] Add validated Terraform/Bicep or policy/configuration samples where appropriate
- [ ] Add validation, deployment, expected output and cleanup steps
- [ ] Add interview Q&A and LinkedIn-ready post
- [ ] Cite current Microsoft Learn references

## What it is / where it fits
Describe the role, dependencies, control-plane/data-plane behavior, consumers and differences from alternatives.

## When to use it
Evaluate functional and non-functional requirements, security, network integration, availability, compliance, scale, skills and total cost. State assumptions and trade-offs.

## Design and security
- [ ] Apply least privilege and narrow scope
- [ ] Prefer Microsoft Entra ID and managed identity where supported; avoid hard-coded credentials
- [ ] Restrict public exposure and use private connectivity where appropriate
- [ ] Enable audit, diagnostics and actionable monitoring
- [ ] Verify quotas, regional availability, recovery objectives and failure domains

## Architecture
Create a service-specific diagram in `architecture.mmd` that shows boundaries, dependencies and key data/control flows.

## Infrastructure as Code
Add tested Terraform/Bicep under `infra/` where appropriate, with parameters and deployment/cleanup instructions. For governance concepts, use policy/configuration examples rather than fake deployable resources. Never commit secrets or production state.

## Scenario
Describe an enterprise workload that needs Subnets & CIDR Planning; compare alternatives and document the chosen design, risk, failure mode, operational ownership and cost drivers.

## Interview question
**Question:** How would you determine whether Subnets & CIDR Planning is the right fit?

**Model answer:** Start with requirements and constraints. Evaluate capabilities, integration, security, availability/recovery, quotas, compliance, operating model and total cost. Compare alternatives, state assumptions and validate against current Microsoft Learn documentation and a proof of concept.

## LinkedIn post
**Azure architecture note — Subnets & CIDR Planning:** Design from requirements, not product names. Evaluate security, network boundaries, resilience, operations, compliance and cost together; document trade-offs and validate service limits before implementation. #Azure #CloudArchitecture #SolutionArchitect

## References
- [Microsoft Learn — Azure](https://learn.microsoft.com/azure/)
- Add current component-specific documentation, pricing, limits and regional availability.
