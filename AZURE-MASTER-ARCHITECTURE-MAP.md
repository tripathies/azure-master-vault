# Cloud Architecture Playbook — Architecture Map

> The high-level platform view is complemented by a component catalogue and separate domain diagrams. Use diagrams to understand relationships; use canonical guide pages for service-level design details.

![Azure Cloud Mindmap](AZURE-COMPONENT-MINDMAP.svg)

**Catalogue:** 120 unique topics across 14 categories. [Open machine-readable catalogue](catalog.json) · [Open visual library](VISUAL-DIAGRAMS.md)

## Platform architecture layers

- **Foundation and governance:** tenant, subscriptions, management groups, landing zones and policy.
- **Identity and security:** Entra ID, workload identity, authorization, privileged access, secrets, threat protection and data governance.
- **Connectivity and traffic:** VNets, subnetting, routing, hybrid links, firewalls, Private Link, DNS, ingress and egress.
- **Compute and runtime:** VMs, app platforms, functions, containers and Kubernetes.
- **Storage and data:** object/file storage, databases, analytics and integration.
- **Operations and delivery:** monitoring, FinOps, infrastructure as code, CI/CD, migration and hybrid management.
- **AI engineering:** model platform, GPU/accelerated compute, model lifecycle, inference, RAG, agents, evaluation, LLMOps and responsible AI.
- **Business continuity and recovery:** impact analysis, RTO/RPO, backup, restore validation, replication, failover and failback.

## Category ownership

- **A — Cloud Foundation & Landing Zones (10)**: [Open category guide](A-cloud-foundation-landing-zones/README.md)
- **B — Identity & Access Management (8)**: [Open category guide](B-identity-access-management/README.md)
- **C — Networking & Private Connectivity (12)**: [Open category guide](C-networking-private-connectivity/README.md)
- **D — Traffic Management & Delivery (8)**: [Open category guide](D-traffic-management-delivery/README.md)
- **E — Compute & Application Hosting (8)**: [Open category guide](E-compute-application-hosting/README.md)
- **F — Containers & Kubernetes (6)**: [Open category guide](F-containers-kubernetes/README.md)
- **G — Storage & Enterprise File Services (8)**: [Open category guide](G-storage-enterprise-file-services/README.md)
- **H — Databases & Data Platforms (10)**: [Open category guide](H-databases-data-platforms/README.md)
- **I — Integration & API Management (6)**: [Open category guide](I-integration-api-management/README.md)
- **J — Security, Secrets & Governance (8)**: [Open category guide](J-security-secrets-governance/README.md)
- **K — Monitoring, Operations & Cost (10)**: [Open category guide](K-monitoring-operations-cost/README.md)
- **L — DevOps, IaC, Migration & Hybrid Management (6)**: [Open category guide](L-devops-resilience-migration-ai/README.md)
- **M — AI Platform & Engineering (13)**: [Open category guide](M-ai-platform-engineering/README.md)
- **12 — Business Continuity, Backup & Disaster Recovery (7)**: [Open category guide](12-automation-backup-disaster-recovery/README.md)

### Keep L and 12 separate

**L — DevOps, IaC, Migration & Hybrid Management** owns Terraform, Bicep/ARM, Azure DevOps Pipelines, GitHub Actions, Azure Migrate and Azure Arc.

**12 — Business Continuity, Backup & Disaster Recovery** owns business continuity strategy, BIA/RTO/RPO, Azure Backup, backup policy and vault security, restore testing, Azure Site Recovery and recovery plans/failover/failback.

They are related in enterprise architecture, but they are not interchangeable and should not share duplicate catalogue entries.

## AI platform and engineering

[M — AI Platform & Engineering](M-ai-platform-engineering/README.md) is a dedicated category with 13 component guides. AI workloads also consume foundation, identity, networking, compute, data, security, monitoring and delivery capabilities from other categories.

## Architecture decision principles

1. Choose components from business and workload requirements, not catalogue popularity.
2. Separate control plane, data plane and workload identity.
3. Design private connectivity, DNS and authorization together.
4. Test failure modes, restore and failover, not only deployment success.
5. Capture operational owner, monitoring, limits, cost and regional constraints.