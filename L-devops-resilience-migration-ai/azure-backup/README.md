# Azure Backup

[← L. DevOps, Resilience, Migration & AI](../README.md) · [← Master catalogue](../../README.md)

**Status:** Starter guide. Complete the checklist and validate details against current Microsoft Learn before production use.

## Completion checklist
- [ ] Purpose, scope, architecture placement and terminology
- [ ] Use cases, alternatives and decision criteria
- [ ] Identity, RBAC, security and governance
- [ ] Networking/private connectivity where applicable
- [ ] Availability, scaling, backup/DR and limits where applicable
- [ ] Cost drivers and optimization
- [ ] Enterprise scenario and trade-offs
- [ ] Service-specific architecture diagram
- [ ] Validated Terraform/Bicep or policy/configuration sample where appropriate
- [ ] Validation, deployment, output and cleanup steps
- [ ] Interview questions/model answers
- [ ] LinkedIn-ready post and official references

## What it is and where it fits
Describe the component's purpose, dependencies, scope and place in the Azure architecture. Distinguish it from alternatives.

## When to use it
Compare requirements, security, network integration, availability, recovery, scale, compliance, team skills and total cost. Document assumptions and trade-offs.

## Security and operations checklist
- [ ] Prefer Microsoft Entra ID and managed identity where supported
- [ ] Apply least privilege and narrow role scope
- [ ] Restrict public exposure and use private connectivity where appropriate
- [ ] Enable diagnostics, audit trails and actionable alerts
- [ ] Validate quotas, regional support, failure modes and recovery objectives

## Architecture
Add a component-specific Azure diagram as `architecture.mmd`; include it in the review checklist before marking this guide complete.

## Infrastructure as Code
Add validated Terraform/Bicep under `infra/` where appropriate, including parameter files and deployment/cleanup steps. Governance concepts should use policy/configuration examples, not fake resource deployments. Never commit secrets or production state.

## Enterprise scenario
Describe a production requirement that calls for Azure Backup, alternatives considered, chosen design, failure modes, operational ownership and cost drivers.

## Interview question and model answer
**Question:** How would you decide whether Azure Backup is right for a production workload?

**Model answer:** Start with requirements. Evaluate capabilities, identity and network integration, availability and recovery, quotas, compliance, operating skills and cost. Compare alternatives, state assumptions and validate against current Microsoft Learn guidance and a proof of concept.

## LinkedIn post
**Azure architecture note — Azure Backup:** Good cloud design starts with requirements, not product names. Evaluate identity, networking, resilience, operations, compliance and cost together. Document trade-offs, validate limits and automate repeatable configuration. #Azure #CloudArchitecture #SolutionArchitect

## Official references
- [Microsoft Learn — Azure](https://learn.microsoft.com/azure/)
- Add current component-specific Learn, pricing, limits and regional-availability references.
