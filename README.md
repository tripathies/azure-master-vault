# Azure Master Vault

A checklist-driven Azure Solution Architect knowledge base. Each domain/category page contains the **actual component explanations, architecture guidance, decision criteria, security, operations, scenarios and interview preparation inline**. The component files are optional deep dives—not the primary learning experience.

## How to use this repository

1. Open a category from the master catalogue below.
2. Read and track the component checklists **on that category's page**.
3. Use the architecture diagrams, decision matrices, scenarios and official references in that same page.
4. Open optional component guides only when you want a deeper example or implementation artifact.
5. Contribute improvements through reviewed commits or pull requests.

> GitHub Markdown checkboxes are repository text, not a private progress tracker that automatically saves per user. Tick them by editing your own branch/fork or use them as a visible checklist. A Markdown link only opens an existing file; it cannot create a new GitHub page at click time. The category pages are therefore designed to hold the core content in one place.

## Master architecture flow

[Master architecture flow](architecture.mmd) includes every catalog component and its conceptual dependency arrows. [Architecture map index](ARCHITECTURE-MAPS.md).

## Master catalogue

| Domain | Complete category page |
|---|---|
| A | [Cloud Foundation & Landing Zones](A-cloud-foundation-landing-zones/README.md) |
| B | [Identity & Access Management](B-identity-access-management/README.md) |
| C | [Networking & Private Connectivity](C-networking-private-connectivity/README.md) |
| D | [Traffic Management & Delivery](D-traffic-management-delivery/README.md) |
| E | [Compute & Application Hosting](E-compute-application-hosting/README.md) |
| F | [Containers & Kubernetes](F-containers-kubernetes/README.md) |
| G | [Storage & Enterprise File Services](G-storage-enterprise-file-services/README.md) |
| H | [Databases & Data Platforms](H-databases-data-platforms/README.md) |
| I | [Integration & API Management](I-integration-api-management/README.md) |
| J | [Security, Secrets & Governance](J-security-secrets-governance/README.md) |
| K | [Monitoring, Operations & Cost](K-monitoring-operations-cost/README.md) |
| L | [DevOps, Resilience, Migration & AI](L-devops-resilience-migration-ai/README.md) |
| 12 | [Automation, Backup & Disaster Recovery — topics 72–76](12-automation-backup-disaster-recovery/README.md) |

- [Machine-readable catalogue](catalog.json)
- [License](LICENSE)

## Standard expected in every category

- [ ] Component-specific purpose, architecture placement, use cases and alternatives
- [ ] Real Azure design details, not generic placeholder paragraphs
- [ ] Identity, access, security, governance and data protection
- [ ] Network design and private connectivity where applicable
- [ ] Availability, scaling, backup/DR, limits and failure modes where applicable
- [ ] Cost drivers, monitoring, operations and common mistakes
- [ ] Enterprise scenario and decision trade-offs
- [ ] Azure-friendly Mermaid architecture diagram
- [ ] Validated Terraform/Bicep or policy/configuration samples where appropriate
- [ ] Validation, deployment, output and cleanup steps where applicable
- [ ] Interview questions/model answers and LinkedIn-ready summary
- [ ] Current official Microsoft Learn references

## Safe-use rules

Treat code as a learning baseline, not production approval. Verify provider/API versions, regions, SKU availability, quotas, naming, network ranges, RBAC scope, private DNS, data residency, recovery objectives and costs. Never commit secrets or production Terraform state. Use least privilege, review plans/what-if output and test recovery procedures.

Governance concepts (for example management groups, Azure Policy and the Well-Architected Framework) should use accurate hierarchy diagrams, policy/configuration samples and decision records rather than misleading deployable resource templates.
