# Azure Master Vault — Book Project

> **End-to-End Azure Cloud, Infrastructure and Solution Architecture**  
> A complete illustrated textbook built from every topic in the Azure Master Vault catalogue.

This folder is the publishing workspace for the **Azure Master Vault** book. The repository remains the source of truth for the 120 catalogue topics, service guides, architecture assets, implementation code and the LittleNest reference workload.

## Book scope

- **Coverage:** all 120 catalogue topics across all 14 categories, with one identifiable chapter per topic.
- **Visual direction:** original hand-drawn notebook-style notes and diagrams, inspired only by the appearance of the attached DP-750 notebook reference. No DP-750 content or branding is reused.
- **Format:** A4 searchable and navigable PDF, supported by editable Markdown and vector diagram sources.
- **Audience:** learners progressing from Azure fundamentals to cloud engineering and solution architecture.
- **Teaching model:** understand → visualize → design → implement/configure → validate → operate → troubleshoot → optimize.
- **Publication rule:** the book is not called complete until every catalogue topic is covered and the technical, diagram, lab and PDF quality gates pass.

## Start here

1. [Complete book blueprint and 120-topic chapter crosswalk](BOOK-PLAN.md)
2. [Master catalogue](../catalog.json)
3. [Azure enterprise reference architecture](../AZURE-ENTERPRISE-REFERENCE-ARCHITECTURE.md)
4. [Visual architecture library](../VISUAL-DIAGRAMS.md)
5. [LittleNest implementation project](../littlenest-azure-reference/README.md)
6. [LittleNest low-level design](../littlenest-azure-reference/lld/README.md)

## Chapter standard

Each catalogue topic receives its own chapter with plain-language explanation, how it works, original hand-drawn-style architecture diagram, architecture placement, use cases, decisions and trade-offs, security, network/data flows, resilience, operations, cost, worked scenario, practical lab, validation checks, troubleshooting, knowledge questions and official references.

Every topic receives the correct practical treatment: Terraform, Bicep, CLI/PowerShell/API configuration or architecture design guidance. We will not invent a deployment template for a topic that is not a standalone deployable resource.

## Publishing approach

The first release will be one complete, navigable PDF. Draft chapters can be reviewed in stages, but a partial manuscript will not be presented as the finished book. Markdown and editable diagram sources remain in this repository so the book can be maintained as Azure services and the catalogue evolve.

## Scope and accuracy

This is a learning and architecture reference, not a substitute for current Microsoft documentation, a tenant-specific design review, compliance advice or production approval. Service features, SKUs, APIs, regions, quotas and prices change; each chapter must state assumptions and link to current official references.
