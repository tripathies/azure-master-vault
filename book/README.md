# Cloud Architecture Playbook — Azure Edition (Book Project)

> **From Cloud Fundamentals to Enterprise-Grade Architecture**  
> A structured, implementation-led textbook built from the Azure Master Vault.

This folder is the publishing workspace for the PDF book. The repository remains the source of truth for component guides, catalogue entries, diagrams, Terraform, application code and the LittleNest reference workload.

## Book status

- **Status:** Production blueprint approved; manuscript and PDF not yet published.
- **Format:** A4 digital PDF, with print-friendly layout considered from the start.
- **Audience:** Beginners progressing to cloud engineers, infrastructure engineers, developers, technical leads and solution architects.
- **Teaching model:** Explain the concept → show the architecture → make the design decision → deploy or configure it → validate it → troubleshoot it → review the trade-offs.
- **Implementation rule:** Every Azure component receives a clearly marked implementation/deployment treatment. If a service is not meaningfully deployed as a standalone resource, the book explains the correct configuration workflow or governance procedure instead of inventing Terraform.

## Start here

1. [Book production plan and detailed table of contents](BOOK-PLAN.md)
2. [Master learning catalogue](../catalog.json)
3. [Azure enterprise reference architecture](../AZURE-ENTERPRISE-REFERENCE-ARCHITECTURE.md)
4. [Visual architecture library](../VISUAL-DIAGRAMS.md)
5. [LittleNest implementation project](../littlenest-azure-reference/README.md)
6. [LittleNest low-level design](../littlenest-azure-reference/lld/README.md)

## Manuscript principles

- Preserve the 13-domain learning catalogue and its topic coverage; consolidate repeated subjects into one authoritative chapter with cross-references.
- Rewrite repository notes into a coherent teaching narrative. Do not paste README files together.
- Reuse repository diagrams where they are technically clear; redraw or improve diagrams where they are not.
- Keep architecture patterns, service capabilities, implementation examples and production recommendations clearly distinguished.
- Include source links and a references section. Prefer current Microsoft Learn documentation for Azure service behaviour.
- Every code sample must have prerequisites, version assumptions, parameters, deployment commands, validation evidence, cleanup guidance and cost/security notes.
- Never label a sample production-ready or deployment-tested unless that status has evidence.
- Keep the LittleNest lab's real scope and limitations explicit.

## Planned output

The first release will be a single navigable PDF. The Markdown manuscript and source diagrams will remain in this repository so the book can be reviewed, maintained and rebuilt. The PDF will be published only after editorial, technical, code and rendering checks pass.

## Scope boundary

This book is a learning and architecture reference. It is not a substitute for service-specific Microsoft documentation, a tenant-specific design review, a compliance assessment, or a production deployment approval. Azure features, SKUs, API versions, regional availability, quotas and prices change; readers must verify these before deployment.
