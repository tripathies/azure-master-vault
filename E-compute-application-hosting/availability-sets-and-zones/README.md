# Availability Sets & Zones

[← E. Compute & Application Hosting](../README.md) · [← Master catalogue](../../README.md)

**Guide status:** Starter guide; verify current capabilities, limits and pricing before production use.

## Completion checklist
- [ ] Purpose, architecture placement and use cases
- [ ] Alternatives and decision criteria
- [ ] Identity, RBAC, security and governance
- [ ] Networking, ingress/egress and private connectivity
- [ ] Availability, scaling, recovery, quotas and failure modes
- [ ] Cost drivers, observability and operations
- [ ] Enterprise scenario and trade-offs
- [ ] Service-specific architecture diagram
- [ ] Validated Terraform/Bicep and parameters where appropriate
- [ ] Validation, deployment and cleanup steps
- [ ] Interview Q&A and LinkedIn-ready post
- [ ] Current Microsoft Learn references

## What it is and where it fits
Explain the workload type and operational model supported by Availability Sets & Zones, dependencies, scope and relationship to other Azure services.

## When to use it
Compare requirements for runtime, portability, control, scale, performance, availability, compliance, team skills and cost. State when alternatives fit better.

## Security and operations
- [ ] Use managed identity and least privilege where supported
- [ ] Restrict network exposure and document ingress/egress
- [ ] Patch/secure images or hosts where responsibility lies with the customer
- [ ] Configure monitoring, logs, health checks and alerts
- [ ] Test scale-out, upgrade, recovery and failure behavior
- [ ] Validate service limits, region support and cost model

## Architecture
Create a component-specific diagram showing workload, dependencies, trust boundaries, network paths and operations.

## Infrastructure as Code
Add tested Terraform/Bicep examples under `infra/` where appropriate, with parameters and validation/deployment/cleanup instructions. Do not commit secrets or production state.

## Enterprise scenario
Describe a workload that needs Availability Sets & Zones, options considered, selected architecture, scale/availability assumptions, security controls and operating runbook.

## Interview question
**Question:** How do you select and operate Availability Sets & Zones for a production workload?

**Model answer:** Match the service's control and operational model to workload requirements. Evaluate security, network integration, availability, scaling, deployment/upgrade process, observability, limits, skills and total cost. Compare alternatives and test failure and recovery paths.

## LinkedIn post
**Azure architecture note — Availability Sets & Zones:** Choose compute/container platforms by workload shape and required operational control. Include identity, networking, scaling, patching, observability, recovery and cost in the decision—not just deployment speed. #Azure #CloudNative #SolutionArchitect

## References
- [Microsoft Learn — Azure](https://learn.microsoft.com/azure/)
- Add current component-specific docs, limits and pricing.
