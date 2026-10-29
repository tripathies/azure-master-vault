# Azure Master Vault

A practical, checklist-driven Azure Solution Architect knowledge base, organized into 12 core domains (A–L) plus an explicit business-continuity learning path for topics 72–76.

## How to use this repository

1. Open a domain checklist.
2. Tick items as you study or complete the guide.
3. Click a component name to open its dedicated page under the repository.
4. Use each page's completion checklist to add validated architecture, security, networking, resilience, cost, code and interview material.
5. Improve pages through reviewed commits or pull requests.

> **Important:** Markdown links navigate to files that already exist. Clicking a link cannot create a GitHub file at that moment, so component pages are pre-created and then expanded.

## Master catalogue

| Domain | Checklist |
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

- [Machine-readable component catalogue](catalog.json)
- [License](LICENSE)

## Definition of done for each component

- [ ] Purpose, architecture placement, use cases and alternatives
- [ ] Identity, access, security and governance
- [ ] Network design and private connectivity where applicable
- [ ] Availability, scaling, backup/DR, limits and failure modes where applicable
- [ ] Cost model, monitoring and operations
- [ ] Real-world scenario and trade-offs
- [ ] Azure-friendly Mermaid diagram
- [ ] Validated Terraform/Bicep or policy/configuration samples where appropriate
- [ ] Validation, deployment, output and cleanup steps
- [ ] Interview questions/model answers and LinkedIn-ready post
- [ ] Current Microsoft Learn references verified

## Safe-use rules

Treat code as a learning baseline, not production approval. Verify provider/API versions, regions, SKU availability, quotas, naming, network ranges, RBAC scope, private DNS, data residency, recovery objectives and costs. Never commit secrets or production Terraform state. Use least privilege, review plans/what-if output and test recovery procedures.

Governance concepts (for example management groups, Azure Policy and the Well-Architected Framework) should use accurate hierarchy diagrams, policy/configuration samples and decision records rather than misleading deployable resource templates.
