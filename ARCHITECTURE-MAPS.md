# Cloud Architecture Playbook — Architecture Map Index

This index separates the catalogue mind map, reference architectures and category-specific diagrams. Each service or learning topic has one canonical home in the catalogue.

## Master visual navigation

- [Azure Cloud Mindmap — SVG](AZURE-COMPONENT-MINDMAP.svg)
- [Azure Cloud Mindmap — editable draw.io](AZURE-COMPONENT-MINDMAP.drawio)
- [End-to-end Azure reference architecture](AZURE-ENTERPRISE-REFERENCE-ARCHITECTURE.md)
- [Network topology — SVG](AZURE-NETWORK-ARCHITECTURE-MAP.svg)
- [Network topology — editable draw.io](AZURE-NETWORK-ARCHITECTURE-MAP.drawio)

## Catalogue overview

**120 unique topics across 14 categories.** Category L is DevOps/IaC/migration/hybrid management. Category M is AI platform and engineering. Category 12 is business continuity, backup and disaster recovery. These categories have distinct component ownership; no topic is intentionally counted twice.

| Domain | Category | Topics | Category guide | Diagram |
|---|---|---:|---|---|
| **A** | Cloud Foundation & Landing Zones | 10 | [Guide](A-cloud-foundation-landing-zones/README.md) | [SVG](A-cloud-foundation-landing-zones/architecture.svg) · [draw.io](A-cloud-foundation-landing-zones/architecture.drawio) · [Mermaid](A-cloud-foundation-landing-zones/architecture.mmd) |
| **B** | Identity & Access Management | 8 | [Guide](B-identity-access-management/README.md) | [SVG](B-identity-access-management/architecture.svg) · [draw.io](B-identity-access-management/architecture.drawio) · [Mermaid](B-identity-access-management/architecture.mmd) |
| **C** | Networking & Private Connectivity | 12 | [Guide](C-networking-private-connectivity/README.md) | [SVG](C-networking-private-connectivity/architecture.svg) · [draw.io](C-networking-private-connectivity/architecture.drawio) · [Mermaid](C-networking-private-connectivity/architecture.mmd) |
| **D** | Traffic Management & Delivery | 8 | [Guide](D-traffic-management-delivery/README.md) | [SVG](D-traffic-management-delivery/architecture.svg) · [draw.io](D-traffic-management-delivery/architecture.drawio) · [Mermaid](D-traffic-management-delivery/architecture.mmd) |
| **E** | Compute & Application Hosting | 8 | [Guide](E-compute-application-hosting/README.md) | [SVG](E-compute-application-hosting/architecture.svg) · [draw.io](E-compute-application-hosting/architecture.drawio) · [Mermaid](E-compute-application-hosting/architecture.mmd) |
| **F** | Containers & Kubernetes | 6 | [Guide](F-containers-kubernetes/README.md) | [SVG](F-containers-kubernetes/architecture.svg) · [draw.io](F-containers-kubernetes/architecture.drawio) · [Mermaid](F-containers-kubernetes/architecture.mmd) |
| **G** | Storage & Enterprise File Services | 8 | [Guide](G-storage-enterprise-file-services/README.md) | [SVG](G-storage-enterprise-file-services/architecture.svg) · [draw.io](G-storage-enterprise-file-services/architecture.drawio) · [Mermaid](G-storage-enterprise-file-services/architecture.mmd) |
| **H** | Databases & Data Platforms | 10 | [Guide](H-databases-data-platforms/README.md) | [SVG](H-databases-data-platforms/architecture.svg) · [draw.io](H-databases-data-platforms/architecture.drawio) · [Mermaid](H-databases-data-platforms/architecture.mmd) |
| **I** | Integration & API Management | 6 | [Guide](I-integration-api-management/README.md) | [SVG](I-integration-api-management/architecture.svg) · [draw.io](I-integration-api-management/architecture.drawio) · [Mermaid](I-integration-api-management/architecture.mmd) |
| **J** | Security, Secrets & Governance | 8 | [Guide](J-security-secrets-governance/README.md) | [SVG](J-security-secrets-governance/architecture.svg) · [draw.io](J-security-secrets-governance/architecture.drawio) · [Mermaid](J-security-secrets-governance/architecture.mmd) |
| **K** | Monitoring, Operations & Cost | 10 | [Guide](K-monitoring-operations-cost/README.md) | [SVG](K-monitoring-operations-cost/architecture.svg) · [draw.io](K-monitoring-operations-cost/architecture.drawio) · [Mermaid](K-monitoring-operations-cost/architecture.mmd) |
| **L** | DevOps, IaC, Migration & Hybrid Management | 6 | [Guide](L-devops-resilience-migration-ai/README.md) | [SVG](L-devops-resilience-migration-ai/architecture.svg) · [draw.io](L-devops-resilience-migration-ai/architecture.drawio) · [Mermaid](L-devops-resilience-migration-ai/architecture.mmd) |
| **M** | AI Platform & Engineering | 13 | [Guide](M-ai-platform-engineering/README.md) | [SVG](M-ai-platform-engineering/architecture.svg) · [draw.io](M-ai-platform-engineering/architecture.drawio) · [Mermaid](M-ai-platform-engineering/architecture.mmd) |
| **12** | Business Continuity, Backup & Disaster Recovery | 7 | [Guide](12-automation-backup-disaster-recovery/README.md) | [SVG](12-automation-backup-disaster-recovery/architecture.svg) · [draw.io](12-automation-backup-disaster-recovery/architecture.drawio) · [Mermaid](12-automation-backup-disaster-recovery/architecture.mmd) |

## Architectural lenses

These are ways to reason about a solution. They are not extra catalogue categories and do not duplicate components.

1. **Governance and foundation:** tenant, subscription, management group, policy, landing zone and operating model.
2. **Identity and security:** human/workload identity, permissions, privileged access, secrets, posture and threat controls.
3. **Network and edge:** address planning, routing, hybrid connectivity, segmentation, ingress, egress and private access.
4. **Compute and application platform:** VMs, app hosting, functions, containers and Kubernetes.
5. **Storage and data:** object/file storage, databases, analytics and data movement.
6. **Integration:** APIs, messaging, eventing and streaming.
7. **Operations and FinOps:** telemetry, alerting, service health, resource inventory and cost.
8. **DevOps and platform engineering:** IaC, CI/CD, migration and hybrid control.
9. **AI platform engineering:** model lifecycle, accelerated compute, inference, RAG, agents, evaluation, LLMOps and responsible AI.
10. **Business continuity and recovery:** BIA, RTO/RPO, backup, restore, replication, failover and failback.

## AI platform architecture

[**M — AI Platform & Engineering**](M-ai-platform-engineering/README.md) is a full catalogue category, not a future placeholder. It includes 13 dedicated guides: Microsoft Foundry, Azure OpenAI, Azure AI Search, Azure Machine Learning, AI infrastructure foundations, GPU/accelerated compute, model catalog and lifecycle, deployment/inference, RAG/vector search, agents/orchestration, prompt engineering/evaluation, LLMOps/observability and responsible AI/security/governance.

## DevOps versus recovery — component ownership

- **L — DevOps, IaC, Migration & Hybrid Management:** Terraform, Bicep/ARM, Azure DevOps Pipelines, GitHub Actions, Azure Migrate and Azure Arc.
- **12 — Business Continuity, Backup & Disaster Recovery:** continuity strategy, BIA/RTO/RPO, Azure Backup, backup policy/vault security, restore testing, Azure Site Recovery and recovery plans/failover/failback.

Infrastructure deployment automation is not the same subject as restoring a business service. Backup is not the same as replication. A configured service is not proof of a recovered application.

## Design standards

- SVGs are quick-view assets for GitHub; `.drawio` files are editable in diagrams.net; `.mmd` files are Mermaid source.
- Use workload requirements to select services. The catalogue is a learning index, not a mandatory deployment stack.
- Validate region/SKU support, quota, service limits, identity, network and DNS behavior, retention, RTO/RPO and costs before production.
- Record decision rationale, operational ownership and recovery test evidence.

## Related resources

- [Visual diagram library](VISUAL-DIAGRAMS.md)
- [Enterprise Azure reference architecture](AZURE-ENTERPRISE-REFERENCE-ARCHITECTURE.md)
- [Machine-readable catalogue](catalog.json)
- [LittleNest implementation reference](littlenest-azure-reference/README.md)
- [Microsoft Azure Architecture Icons](https://learn.microsoft.com/en-us/azure/architecture/icons/)