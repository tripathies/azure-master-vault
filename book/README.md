# Azure Cloud Architecture Playbook — Book Project

**Subtitle:** From Cloud Fundamentals to Enterprise-Grade Architecture  
**Format:** A4 PDF textbook, with Markdown source edition  
**Source of truth:** Azure Master Vault  
**Practical case study:** LittleNest Kidswear  
**Status:** Editorial blueprint

## Purpose

Transform the Azure Master Vault into a coherent technical textbook. Teach readers to understand Azure, make architecture decisions, select services, implement and deploy safely, secure workloads, operate them and optimise cost.

This is not a direct Markdown-to-PDF export. The book must provide a progressive learning journey, consistent explanations, original diagrams, worked examples, labs, assessments and traceable deployment guidance.

## Audience and progression

- Primary audience: aspiring and practising Azure engineers, cloud architects and solution architects.
- Secondary audience: infrastructure, network, security, platform, DevOps and application engineers moving into Azure.
- Starting point: basic IT literacy; Azure experience is not required.
- Progression: fundamentals → implementation → advanced design → enterprise architecture.

## Editorial principles

1. Teach the underlying concept before the Azure product.
2. Explain architecture placement, dependencies, consumers and service boundaries.
3. Separate identity, management plane, data plane, network path and operational responsibility.
4. Explain when to use a service, when not to use it and what alternatives exist.
5. Use diagrams to explain decisions and traffic/data flows, not as decoration.
6. Address security, reliability, cost, performance and operations in every relevant chapter.
7. Make deployment reproducible, scoped and safe. Never call generic snippets production-ready.
8. Label code honestly: repository implementation, CI-validated, live-Azure-validated, illustrative or conceptual.
9. Cite official Microsoft Learn for service behaviour, limits, regional availability, SKUs and commands.
10. Use original explanations and diagrams; do not copy third-party text or illustrations.

## Book structure

### Front matter
- Cover and title page
- Edition, version and publication date
- Copyright, licence and trademark notice
- Safety, security and cloud-cost disclaimer
- Preface and intended audience
- How to use the book and learning pathway
- Prerequisites and lab environment
- Diagram notation and conventions
- Full table of contents
- List of figures, tables, labs and code listings

### Main matter
See [TABLE-OF-CONTENTS.md](TABLE-OF-CONTENTS.md) for the proposed chapter sequence and catalogue mapping.

### Back matter
- Glossary and acronym list
- Azure CLI, PowerShell, Terraform and Bicep quick references
- Architecture decision record template
- Lab safety, budget and cleanup checklist
- Troubleshooting index
- References and further reading
- Catalogue-to-book source crosswalk
- Subject index

## Standard chapter pattern

Every chapter should follow a predictable structure:

1. Chapter opener: scenario, why it matters and learning objectives.
2. Prerequisites and concepts: plain-language explanation and mental model.
3. Azure capability: what it does, service boundaries and building blocks.
4. Architecture: diagram, request/data flow, trust boundaries and dependencies.
5. Design decisions: use cases, non-use cases, alternatives and trade-offs.
6. Security and governance: identity, permissions, network exposure, data protection and policy.
7. Reliability and operations: availability, scale, limits, failure modes, monitoring, backup/DR and ownership.
8. Cost and performance: billing dimensions, sizing, cost traps and optimisation.
9. Worked example: realistic scenario with assumptions and rationale.
10. **Code & Deployment page(s):** implementation, source files, prerequisites, identity, plan/what-if, deployment, verification, outputs, rollback and cleanup.
11. Lab or exercise with evidence to collect.
12. Knowledge check and answer guidance.
13. Key takeaways and official references.

## Mandatory Code & Deployment page

After every Azure component chapter, insert a distinct page titled:

**CODE & DEPLOYMENT — [COMPONENT NAME]**

It must contain:
- Deployment goal and scope: tenant, management group, subscription, resource group or resource.
- Correct implementation method: Terraform, Bicep, Azure CLI, PowerShell, portal procedure, policy/configuration or application code.
- Exact repository path or companion file.
- Prerequisites: subscription, region, provider registration, quota, SKU and permissions.
- Deployment identity, workload identity and least-privilege roles.
- Network prerequisites and public/private exposure.
- Safe example inputs; no secrets or real identifiers.
- Review command: Terraform plan or Azure deployment what-if, where applicable.
- Deployment command and expected resources.
- Verification commands/tests and expected result.
- Cost notes, billing drivers and cleanup.
- Rollback, residual-resource and data-loss warnings.
- Validation status and evidence.

Not every topic is a deployable resource. For governance, frameworks and design concepts, the implementation page must show a valid policy, role assignment, configuration, decision record or validation exercise—not invented Terraform.

## LittleNest case study

LittleNest connects the component chapters to a real repository implementation:
- Explain architecture and decisions before showing code.
- Link each resource to its Vault component guide.
- Use actual Terraform and application source, not a parallel fictional implementation.
- Distinguish implemented controls, manual operational procedures and recommended extensions.
- Include LLD, deployment walkthrough, validation and teardown.
- Preserve the non-production, private-access, synthetic-data and cost limitations.

LittleNest is not a complete enterprise landing zone, production commerce platform or proof of multi-region resilience.

## Technical accuracy and release controls

- Microsoft Learn is the primary source for Azure behaviour and supported deployment patterns.
- Verify product names, lifecycle, API versions, CLI syntax, SKU/region availability, quotas, limits and pricing assumptions before publication.
- Add source date and last-reviewed date per chapter.
- Do not include tenant IDs, subscription IDs, secrets, customer data or personal data.
- Require technical and code review before marking a chapter final.

## PDF design and accessibility

- A4 portrait for chapters; landscape only for wide diagrams and reference tables.
- Consistent grid, typography, chapter colour, headers, footers and page numbering.
- Clickable contents, bookmarks, cross-references, URLs and internal navigation.
- Vector diagrams where possible; readable labels, captions and alt-text descriptions.
- Sufficient contrast; do not rely on colour alone.
- Searchable selectable text and embedded fonts; do not rasterise whole pages.
- Include a print-friendly PDF and accessible Markdown source.

## Production workflow

1. Audit the 13 catalogue categories, 111 entries, guides, diagrams, IaC, labs and LittleNest.
2. Map every source topic to a chapter; consolidate duplicates and identify missing foundations.
3. Audit generic pages, stale links, unverified code and missing deployment examples.
4. Approve the detailed table of contents and chapter template.
5. Author and diagram chapters in reviewable batches.
6. Validate code using format, lint, validate, plan/what-if and tests; use controlled non-production Azure for live tests.
7. Review architecture, security, networking, reliability, operations, cost and references.
8. Edit for progression, clarity, terminology and accessibility.
9. Build PDF with bookmarks, contents, figures, links and page numbers.
10. QA rendered pages, extracted text, links, diagrams and code listings; publish versioned PDF and source.

## Definition of done

- Every catalogue topic is mapped or explicitly excluded with rationale.
- Duplicates are consolidated and cross-referenced.
- Every component has its Code & Deployment page or a reason deployment code is not applicable.
- Every code example has a status and validation instructions.
- Chapters have objectives, worked examples and knowledge checks.
- Official references and review dates are present.
- PDF links, bookmarks, text extraction and page rendering pass QA.
- Limitations, costs, security boundaries and lab scope are stated accurately.

## Primary references

- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
- [Cloud Adoption Framework](https://learn.microsoft.com/azure/cloud-adoption-framework/)
- [Azure landing-zone deployment options](https://learn.microsoft.com/azure/architecture/landing-zones/landing-zone-deploy)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [Azure CLI](https://learn.microsoft.com/cli/azure/)
- [Bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Terraform on Azure](https://learn.microsoft.com/azure/developer/terraform/)
- [LittleNest implementation](../littlenest-azure-reference/README.md)
- [Azure catalogue](../catalog.json)
