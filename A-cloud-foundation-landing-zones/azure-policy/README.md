# Azure Policy

[← A. Cloud Foundation & Landing Zones](../README.md) · [← Master catalogue](../../README.md)

**Status:** Starter guide — complete the checklist and replace generic examples with verified component-specific design before production use.

## Completion checklist
- [ ] Purpose, scope, Azure architecture placement and key terminology
- [ ] Use cases, non-use cases, alternatives and decision criteria
- [ ] Identity, RBAC, security, governance and data protection
- [ ] Network paths, private connectivity, DNS and ingress/egress where applicable
- [ ] Availability, scaling, backup/DR, quotas and failure modes where applicable
- [ ] Pricing drivers, cost controls and common cost surprises
- [ ] Realistic enterprise scenario with trade-offs and operational ownership
- [ ] Service-specific Azure architecture diagram
- [ ] Validated Terraform and/or Bicep with parameters where appropriate
- [ ] Validation, deployment, expected outputs and cleanup steps
- [ ] Interview questions with model answers
- [ ] LinkedIn-ready post and current Microsoft Learn references

## What it is
Describe the component's purpose, scope, control-plane/data-plane role and how it differs from alternatives.

## Where it fits
Map dependencies and consumers; explain its relationships with identity, networking, security, governance, monitoring and operations.

## When to use it
Select based on requirements and trade-offs across functionality, latency, availability, scale, compliance, team skills and total cost. Explicitly compare viable alternatives.

## Security and connectivity checklist
- [ ] Prefer Microsoft Entra ID / managed identity over embedded secrets where supported
- [ ] Apply least privilege and narrowly scoped access
- [ ] Use private connectivity and restrict public exposure where required and supported
- [ ] Enable diagnostics, audit logs and actionable alerts
- [ ] Validate encryption, data classification, retention and compliance needs

## Availability, operations and cost
Document regional scope, failure domains, recovery objectives, scaling behavior, quotas, service limits, monitoring ownership, support model and cost drivers. Do not assume zone or region support without checking the current service documentation.

## Architecture diagram
See [architecture.mmd](./architecture.mmd). This is a placeholder flow and must be replaced with a service-specific design.

## Infrastructure as Code
Add examples under `infra/terraform` and/or `infra/bicep` only after validating resource schemas, API/provider versions, prerequisites and parameterization. Governance/framework concepts should use policy/configuration samples rather than fake deployment resources. Never commit secrets or production state.

## Scenario and interview answer
**Scenario:** An enterprise team evaluates Azure Policy for a governed workload. Record requirements, options, decision rationale, security boundary, failure modes, and operations runbook.

**Interview question:** How do you decide whether Azure Policy is appropriate for a production workload?

**Model answer:** Start with functional and non-functional requirements. Assess native capabilities, identity/network integration, availability and recovery, quotas, compliance, operating skills and total cost. Compare alternatives, state assumptions, identify failure modes and validate against current Microsoft Learn documentation and a representative proof of concept.

## LinkedIn learning post
**Azure architecture note — Azure Policy:** Good cloud design starts with requirements, not product names. Evaluate identity, network boundaries, resilience, operations, compliance and cost together. Document trade-offs, validate limits and automate repeatable configuration. #Azure #CloudArchitecture #SolutionArchitect

## Official documentation
- [Microsoft Learn — Azure](https://learn.microsoft.com/azure/)
- Add the current component-specific Learn page, pricing, limits, regional availability and security guidance before marking this guide complete.
