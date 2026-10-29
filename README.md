# Azure Master Vault

A practical, checklist-driven Azure Solution Architect knowledge base, organized into **12 catalogues (A–L)** and dedicated component pages.

## How to use this repository

1. Open a domain below.
2. Use its **checkbox checklist** to track study/review/completion.
3. Click a component name to open its dedicated page under that domain folder.
4. Complete the component checklist, validate its architecture, add service-specific diagrams and IaC, and use a pull request to review improvements.

> **Important behavior:** A normal GitHub Markdown link cannot create a file when clicked. Component pages are therefore pre-created in the repository, so clicking a catalogue item opens the page that can then be expanded through commits or pull requests.

## Master catalogue

| Domain | Catalogue / checklist |
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

- [Machine-readable catalogue](catalog.json)
- [License](LICENSE)

## Definition of done for each component

- [ ] Service purpose, placement, use cases, alternatives
- [ ] Identity, access, security, governance
- [ ] Network design and private connectivity, where applicable
- [ ] HA, scaling, backup/DR, limits and failure modes, where applicable
- [ ] Cost model and optimization
- [ ] Real-world scenario and decision trade-offs
- [ ] Azure-friendly Mermaid diagram (SVG may be added for rendered diagrams)
- [ ] Terraform/Bicep samples, parameter files and validation where appropriate
- [ ] Interview questions and model answers
- [ ] LinkedIn-ready post
- [ ] Current Microsoft Learn references checked

## Safe-use rules

Treat code as a learning baseline, not production approval. Verify provider/API versions, regions, SKU availability, quotas, naming, network ranges, RBAC scope, private DNS, data residency, recovery objectives, and costs before deployment. Never commit secrets or production Terraform state. Use least privilege, review plans/what-if output, and test recovery procedures.

## Architecture guide quality

Every component guide should clearly label assumptions and known limitations, avoid unsupported claims, and link to current Microsoft documentation. Governance concepts (for example Azure Policy and the Well-Architected Framework) should use policy/configuration and decision records where appropriate, not misleading deployable resource templates.
