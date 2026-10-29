# Azure AI Search

[← L. DevOps, Resilience, Migration & AI](../README.md) · [← Master catalogue](../../README.md)

**Status:** Starter guide. Complete the checklist and validate details against current Microsoft Learn before production use.

## Completion checklist
- [ ] Purpose, scope, architecture placement and terminology
- [ ] Use cases, alternatives and decision criteria
- [ ] Identity, RBAC, security and governance
- [ ] Network/private connectivity and data boundaries
- [ ] Availability, scaling, backup/DR, quotas and limits where applicable
- [ ] Cost drivers, optimization and operational ownership
- [ ] Enterprise scenario and decision trade-offs
- [ ] Service-specific architecture diagram
- [ ] Validated Terraform/Bicep or configuration sample where appropriate
- [ ] Validation, deployment and cleanup steps
- [ ] Interview questions/model answers
- [ ] LinkedIn-ready post and official references

## What it is and where it fits
Describe the component's role, dependencies, data flow, control-plane/data-plane boundaries, and how it differs from alternatives.

## When to use it
Compare functional and non-functional requirements, security, network integration, availability, scale, compliance, team skills, and total cost. Record assumptions and trade-offs.

## Security and operations checklist
- [ ] Prefer Microsoft Entra ID / managed identity where supported
- [ ] Apply least privilege and narrow role scopes
- [ ] Restrict public exposure and use private connectivity where appropriate
- [ ] Enable diagnostics, audit trails, monitoring and alerting
- [ ] Validate data protection, quotas, region support and recovery objectives

## Architecture
Add a component-specific Azure diagram as `architecture.mmd` and validate its data flows and trust boundaries.

## Infrastructure as Code
Add tested Terraform/Bicep and parameter files under `infra/` where appropriate. For platform concepts, use policy/configuration examples rather than fake deployment resources. Never commit secrets or production state.

## Enterprise scenario
Describe the workload requirements, alternatives, chosen design, failure modes, operating model and cost drivers for Azure AI Search.

## Interview question and model answer
**Question:** How would you decide whether Azure AI Search is suitable for a production workload?

**Model answer:** Begin with requirements and constraints. Evaluate native capabilities, identity and network integration, availability/recovery, quotas, compliance, operating skills and cost. Compare alternatives, state assumptions and validate the design against current Microsoft Learn guidance and a representative proof of concept.

## LinkedIn post
**Azure architecture note — Azure AI Search:** Strong cloud design starts with requirements, not product names. Evaluate security, networking, resilience, operations, compliance and cost together. Document trade-offs, validate limits and automate repeatable configuration. #Azure #CloudArchitecture #SolutionArchitect

## Official references
- [Microsoft Learn — Azure](https://learn.microsoft.com/azure/)
- Add current component-specific Learn, pricing, limits and regional support references.
