# Azure Book — Source Inventory and Crosswalk Rules

This document governs how the PDF book uses the Azure Master Vault. The machine-readable source of truth is [../catalog.json](../catalog.json).

## Current source inventory

The catalogue contains **13 categories and 111 entries**.

| Key | Category | Entries | Planned book location |
|---|---|---:|---|
| A | Cloud Foundation & Landing Zones | 10 | Part I |
| B | Identity & Access Management | 8 | Part II |
| C | Networking & Private Connectivity | 12 | Part III |
| D | Traffic Management & Delivery | 8 | Part IV |
| E | Compute & Application Hosting | 8 | Part V |
| F | Containers & Kubernetes | 6 | Part VI |
| G | Storage & Enterprise File Services | 8 | Part VII |
| H | Databases & Data Platforms | 10 | Part VIII |
| I | Integration & API Management | 6 | Part IX |
| J | Security, Secrets & Governance | 8 | Part X |
| K | Monitoring, Operations & Cost | 10 | Part XI |
| L | DevOps, Resilience, Migration & AI | 12 | Parts XII–XIV |
| 12 | Automation, Backup and Disaster Recovery | 5 | Parts XII–XIII; consolidate duplicates |

## Canonical source locations

- Master catalogue: catalog.json
- Master README and learning tracker: README.md
- Enterprise architecture: AZURE-ENTERPRISE-REFERENCE-ARCHITECTURE.md
- Visual diagram index: VISUAL-DIAGRAMS.md
- Master diagrams: architecture.drawio, architecture.mmd and architecture.svg
- Category guides/diagrams: category README and category architecture files
- Component guides/diagrams: component README and matching architecture files
- LittleNest workload: littlenest-azure-reference/
- LittleNest LLD: littlenest-azure-reference/lld/
- LittleNest deployment and validation: littlenest-azure-reference/README.md, docs/validation.md, infra/ and app/

## Source priority

1. Actual code/configuration for claims about what the lab implements.
2. Component guide for existing concepts and service guidance.
3. Category guide and master architecture for dependencies and placement.
4. LittleNest LLD and implementation for the end-to-end case study.
5. Official Microsoft Learn for current service behaviour, deployment syntax, limits, SKUs, regions, pricing links and lifecycle.
6. Original editorial explanation and diagrams to connect and teach the material.

If sources conflict, record the discrepancy, inspect code and current official documentation, and resolve it with a dated editorial note.

## Required crosswalk columns

- Catalogue key and category name.
- Component name and canonical repository path.
- Book part and chapter/section.
- Standalone chapter, combined section or cross-reference.
- Source diagrams and code files.
- Deployment-page type: Terraform, Bicep, CLI, PowerShell, portal, application code, policy/configuration or conceptual.
- Existing code status and validation evidence.
- Missing content and technical gaps.
- Official Microsoft Learn references.
- Technical review status and last-reviewed date.

## Duplicate consolidation

Category L and category 12 overlap on:
- Terraform / Infrastructure as Code.
- Bicep and ARM templates.
- Azure DevOps Pipelines and GitHub Actions.
- Azure Backup.
- Azure Site Recovery.

Teach each topic once in the main body. Keep both catalogue paths in the crosswalk and point both entries to the canonical chapter. Do not silently drop a source guide.

## Content quality audit

The component completion checklist is not proof that a page is complete. Inspect every page and classify it:
- **Ready to adapt:** accurate, detailed and supported.
- **Needs editorial rewrite:** useful source, but too terse, repetitive or not beginner-friendly.
- **Needs technical expansion:** missing architecture, security, limits, deployment or validation.
- **Needs code:** no suitable deployable example exists.
- **Conceptual / not deployable:** use valid configuration or decision exercise, not fake resource code.
- **Needs verification:** commands, behaviour, regions/SKUs or API details need current validation.

## LittleNest use

LittleNest is a recurring worked example, not a substitute for the component curriculum. Map each workload resource to its service chapter and label:
- Implemented in repository code.
- Operational procedure requiring a human.
- Recommended extension not implemented.
- Live Azure validation not evidenced.

Preserve project boundaries: low-cost non-production workload; private app access; synthetic data; no payment gateway or customer PII; local Terraform state; controlled Storage runner-IP bootstrap exception; no claim of complete enterprise landing-zone deployment or production readiness.
