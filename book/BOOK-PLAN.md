# Azure Master Vault — Complete Book Production Blueprint

**Book title:** Azure Master Vault  
**Subtitle:** End-to-End Azure Cloud, Infrastructure and Solution Architecture  
**Repository:** [tripathies/azure-master-vault](https://github.com/tripathies/azure-master-vault)  
**Catalogue source of truth:** [`catalog.json`](../catalog.json)  
**Book format:** A4, navigable, searchable PDF, supported by editable Markdown and vector diagram source  
**Scope:** Every one of the 120 catalogue topics in all 14 categories, plus foundations, end-to-end architecture case studies, hands-on labs and reference appendices.

---

## 1. What this book is

Azure Master Vault is a complete, end-to-end Azure learning and architecture book. It must take a reader from cloud fundamentals to the ability to assess requirements, design an Azure platform, select and connect services, deploy or configure them, secure and operate the resulting solution, troubleshoot failures, manage resilience and control cost.

This is a textbook and illustrated field reference—not a copy of the repository README files and not a certification cram guide. The repository is the source inventory. The book adds a coherent teaching sequence, worked examples, architecture reasoning and practical implementation.

**Coverage rule:** all 120 catalogue topics must appear as individually identifiable chapters in the finished book. Do not remove, silently merge, rename or replace a catalogue topic. Supporting foundation and capstone chapters may be added, but they do not count as substitutes for catalogue chapters.

## 2. Visual direction: DP-750 as appearance reference only

The attached DP-750 notebook is a visual reference for the *look and feel* of handwritten learning notes. It is not a source for Azure subject matter, technical content, chapter sequence, diagrams, logos or wording.

Use an original Azure notebook aesthetic:
- Clean notebook-paper backgrounds, subtle ruled/grid lines where they help, generous white space and clear page hierarchy.
- Handwritten-style headings, labels, callout annotations and diagram captions.
- Original hand-drawn-style architecture sketches: pen-like strokes, boxes, cloud/service symbols, numbered arrows, boundaries, legends and short margin notes.
- A restrained Azure-inspired blue palette, supported by dark ink and occasional accent colors for warnings, decisions and flow direction.
- Clear, professionally typeset body text and code. Handwritten styling is for visual explanation and annotations—not for long paragraphs or dense code.
- Every figure must be redrawn or authored for the topic and must be technically correct, legible at A4 size, captioned and explained in the nearby text.

Do not reproduce the DP-750 cover, brand, logo, page content or exact composition. Do not use one generic diagram repeatedly. The drawings must explain the Azure topic on that page.

## 3. Learning journey

The reader should repeatedly move through this sequence:

**Requirement → concept → internal working → architecture placement → design decision → implementation/configuration → validation → operations/troubleshooting → resilience → cost and trade-offs.**

The book begins with the language and operating model of cloud architecture, then follows the repository's category structure. The final section brings the catalogue together in end-to-end enterprise scenarios and the LittleNest learning workload.

## 4. Complete catalogue coverage — mandatory 120 chapters

The titles below are taken directly from the current `catalog.json`. Each item is a required, distinct chapter and links to its canonical repository guide. Chapter numbering is the book's reading sequence, not a change to the catalogue's category names or folder structure.

### A. Cloud Foundation & Landing Zones — 10 chapters
1. **Microsoft Azure fundamentals** — [canonical repository guide](../A-cloud-foundation-landing-zones/microsoft-azure-fundamentals/README.md)
2. **Regions, Region Pairs & Availability Zones** — [canonical repository guide](../A-cloud-foundation-landing-zones/regions-region-pairs-and-availability-zones/README.md)
3. **Microsoft Entra ID tenants** — [canonical repository guide](../A-cloud-foundation-landing-zones/microsoft-entra-id-tenants/README.md)
4. **Management Groups** — [canonical repository guide](../A-cloud-foundation-landing-zones/management-groups/README.md)
5. **Azure Subscriptions** — [canonical repository guide](../A-cloud-foundation-landing-zones/azure-subscriptions/README.md)
6. **Resource Groups** — [canonical repository guide](../A-cloud-foundation-landing-zones/resource-groups/README.md)
7. **Azure Resource Manager (ARM)** — [canonical repository guide](../A-cloud-foundation-landing-zones/azure-resource-manager-arm/README.md)
8. **Azure Policy** — [canonical repository guide](../A-cloud-foundation-landing-zones/azure-policy/README.md)
9. **Azure Landing Zones** — [canonical repository guide](../A-cloud-foundation-landing-zones/azure-landing-zones/README.md)
10. **Azure Well-Architected Framework** — [canonical repository guide](../A-cloud-foundation-landing-zones/azure-well-architected-framework/README.md)

### B. Identity & Access Management — 8 chapters
11. **Microsoft Entra ID** — [canonical repository guide](../B-identity-access-management/microsoft-entra-id/README.md)
12. **App Registrations** — [canonical repository guide](../B-identity-access-management/app-registrations/README.md)
13. **Enterprise Applications & Service Principals** — [canonical repository guide](../B-identity-access-management/enterprise-applications-and-service-principals/README.md)
14. **Managed Identities** — [canonical repository guide](../B-identity-access-management/managed-identities/README.md)
15. **Azure RBAC** — [canonical repository guide](../B-identity-access-management/azure-rbac/README.md)
16. **MFA & Conditional Access** — [canonical repository guide](../B-identity-access-management/mfa-and-conditional-access/README.md)
17. **Privileged Identity Management (PIM)** — [canonical repository guide](../B-identity-access-management/privileged-identity-management-pim/README.md)
18. **OAuth 2.0 & OpenID Connect** — [canonical repository guide](../B-identity-access-management/oauth-2-0-and-openid-connect/README.md)

### C. Networking & Private Connectivity — 12 chapters
19. **Virtual Networks (VNet)** — [canonical repository guide](../C-networking-private-connectivity/virtual-networks-vnet/README.md)
20. **Subnets & CIDR Planning** — [canonical repository guide](../C-networking-private-connectivity/subnets-and-cidr-planning/README.md)
21. **Network Security Groups (NSGs)** — [canonical repository guide](../C-networking-private-connectivity/network-security-groups-nsgs/README.md)
22. **Application Security Groups (ASGs)** — [canonical repository guide](../C-networking-private-connectivity/application-security-groups-asgs/README.md)
23. **VNet Peering** — [canonical repository guide](../C-networking-private-connectivity/vnet-peering/README.md)
24. **User-Defined Routes (UDRs)** — [canonical repository guide](../C-networking-private-connectivity/user-defined-routes-udrs/README.md)
25. **Azure Firewall** — [canonical repository guide](../C-networking-private-connectivity/azure-firewall/README.md)
26. **VPN Gateway** — [canonical repository guide](../C-networking-private-connectivity/vpn-gateway/README.md)
27. **ExpressRoute** — [canonical repository guide](../C-networking-private-connectivity/expressroute/README.md)
28. **Private Link & Private Endpoints** — [canonical repository guide](../C-networking-private-connectivity/private-link-and-private-endpoints/README.md)
29. **Private DNS Zones** — [canonical repository guide](../C-networking-private-connectivity/private-dns-zones/README.md)
30. **NAT Gateway** — [canonical repository guide](../C-networking-private-connectivity/nat-gateway/README.md)

### D. Traffic Management & Delivery — 8 chapters
31. **Azure Load Balancer** — [canonical repository guide](../D-traffic-management-delivery/azure-load-balancer/README.md)
32. **Application Gateway & WAF** — [canonical repository guide](../D-traffic-management-delivery/application-gateway-and-waf/README.md)
33. **Azure Front Door** — [canonical repository guide](../D-traffic-management-delivery/azure-front-door/README.md)
34. **Traffic Manager** — [canonical repository guide](../D-traffic-management-delivery/traffic-manager/README.md)
35. **Azure Bastion** — [canonical repository guide](../D-traffic-management-delivery/azure-bastion/README.md)
36. **Azure DNS** — [canonical repository guide](../D-traffic-management-delivery/azure-dns/README.md)
37. **DDoS Protection** — [canonical repository guide](../D-traffic-management-delivery/ddos-protection/README.md)
38. **Network Watcher** — [canonical repository guide](../D-traffic-management-delivery/network-watcher/README.md)

### E. Compute & Application Hosting — 8 chapters
39. **Virtual Machines** — [canonical repository guide](../E-compute-application-hosting/virtual-machines/README.md)
40. **Managed Disks** — [canonical repository guide](../E-compute-application-hosting/managed-disks/README.md)
41. **Availability Sets & Zones** — [canonical repository guide](../E-compute-application-hosting/availability-sets-and-zones/README.md)
42. **Virtual Machine Scale Sets** — [canonical repository guide](../E-compute-application-hosting/virtual-machine-scale-sets/README.md)
43. **Azure App Service** — [canonical repository guide](../E-compute-application-hosting/azure-app-service/README.md)
44. **Azure Functions** — [canonical repository guide](../E-compute-application-hosting/azure-functions/README.md)
45. **Logic Apps** — [canonical repository guide](../E-compute-application-hosting/logic-apps/README.md)
46. **Azure Batch** — [canonical repository guide](../E-compute-application-hosting/azure-batch/README.md)

### F. Containers & Kubernetes — 6 chapters
47. **Docker & Container Fundamentals** — [canonical repository guide](../F-containers-kubernetes/docker-and-container-fundamentals/README.md)
48. **Azure Container Registry (ACR)** — [canonical repository guide](../F-containers-kubernetes/azure-container-registry-acr/README.md)
49. **Azure Container Apps** — [canonical repository guide](../F-containers-kubernetes/azure-container-apps/README.md)
50. **Azure Kubernetes Service (AKS)** — [canonical repository guide](../F-containers-kubernetes/azure-kubernetes-service-aks/README.md)
51. **Azure Container Instances (ACI)** — [canonical repository guide](../F-containers-kubernetes/azure-container-instances-aci/README.md)
52. **AKS Ingress, Scaling & Workload Identity** — [canonical repository guide](../F-containers-kubernetes/aks-ingress-scaling-and-workload-identity/README.md)

### G. Storage & Enterprise File Services — 8 chapters
53. **Storage Accounts** — [canonical repository guide](../G-storage-enterprise-file-services/storage-accounts/README.md)
54. **Blob Storage** — [canonical repository guide](../G-storage-enterprise-file-services/blob-storage/README.md)
55. **Azure Data Lake Storage Gen2** — [canonical repository guide](../G-storage-enterprise-file-services/azure-data-lake-storage-gen2/README.md)
56. **Azure Files** — [canonical repository guide](../G-storage-enterprise-file-services/azure-files/README.md)
57. **Azure NetApp Files** — [canonical repository guide](../G-storage-enterprise-file-services/azure-netapp-files/README.md)
58. **Queue Storage** — [canonical repository guide](../G-storage-enterprise-file-services/queue-storage/README.md)
59. **Table Storage** — [canonical repository guide](../G-storage-enterprise-file-services/table-storage/README.md)
60. **Storage Redundancy: LRS, ZRS, GRS & GZRS** — [canonical repository guide](../G-storage-enterprise-file-services/storage-redundancy-lrs-zrs-grs-and-gzrs/README.md)

### H. Databases & Data Platforms — 10 chapters
61. **Azure SQL Database** — [canonical repository guide](../H-databases-data-platforms/azure-sql-database/README.md)
62. **Azure SQL Managed Instance** — [canonical repository guide](../H-databases-data-platforms/azure-sql-managed-instance/README.md)
63. **SQL Server on Azure VMs** — [canonical repository guide](../H-databases-data-platforms/sql-server-on-azure-vms/README.md)
64. **Azure Cosmos DB** — [canonical repository guide](../H-databases-data-platforms/azure-cosmos-db/README.md)
65. **Azure Database for PostgreSQL** — [canonical repository guide](../H-databases-data-platforms/azure-database-for-postgresql/README.md)
66. **Azure Database for MySQL** — [canonical repository guide](../H-databases-data-platforms/azure-database-for-mysql/README.md)
67. **Azure Managed Redis** — [canonical repository guide](../H-databases-data-platforms/azure-managed-redis/README.md)
68. **Azure Data Factory** — [canonical repository guide](../H-databases-data-platforms/azure-data-factory/README.md)
69. **Azure Databricks** — [canonical repository guide](../H-databases-data-platforms/azure-databricks/README.md)
70. **Microsoft Fabric / OneLake** — [canonical repository guide](../H-databases-data-platforms/microsoft-fabric-onelake/README.md)

### I. Integration & API Management — 6 chapters
71. **API Management** — [canonical repository guide](../I-integration-api-management/api-management/README.md)
72. **Azure Service Bus** — [canonical repository guide](../I-integration-api-management/azure-service-bus/README.md)
73. **Azure Event Grid** — [canonical repository guide](../I-integration-api-management/azure-event-grid/README.md)
74. **Azure Event Hubs** — [canonical repository guide](../I-integration-api-management/azure-event-hubs/README.md)
75. **Azure Stream Analytics** — [canonical repository guide](../I-integration-api-management/azure-stream-analytics/README.md)
76. **Azure Data Explorer** — [canonical repository guide](../I-integration-api-management/azure-data-explorer/README.md)

### J. Security, Secrets & Governance — 8 chapters
77. **Azure Key Vault** — [canonical repository guide](../J-security-secrets-governance/azure-key-vault/README.md)
78. **Key Vault Access Policies & RBAC** — [canonical repository guide](../J-security-secrets-governance/key-vault-access-policies-and-rbac/README.md)
79. **Microsoft Defender for Cloud** — [canonical repository guide](../J-security-secrets-governance/microsoft-defender-for-cloud/README.md)
80. **Microsoft Sentinel** — [canonical repository guide](../J-security-secrets-governance/microsoft-sentinel/README.md)
81. **Microsoft Purview** — [canonical repository guide](../J-security-secrets-governance/microsoft-purview/README.md)
82. **Azure Resource Locks** — [canonical repository guide](../J-security-secrets-governance/azure-resource-locks/README.md)
83. **Tagging & Naming Standards** — [canonical repository guide](../J-security-secrets-governance/tagging-and-naming-standards/README.md)
84. **Zero Trust Architecture** — [canonical repository guide](../J-security-secrets-governance/zero-trust-architecture/README.md)

### K. Monitoring, Operations & Cost — 10 chapters
85. **Azure Monitor** — [canonical repository guide](../K-monitoring-operations-cost/azure-monitor/README.md)
86. **Log Analytics Workspace & KQL** — [canonical repository guide](../K-monitoring-operations-cost/log-analytics-workspace-and-kql/README.md)
87. **Application Insights** — [canonical repository guide](../K-monitoring-operations-cost/application-insights/README.md)
88. **Azure Monitor Alerts & Action Groups** — [canonical repository guide](../K-monitoring-operations-cost/azure-monitor-alerts-and-action-groups/README.md)
89. **Service Health & Resource Health** — [canonical repository guide](../K-monitoring-operations-cost/service-health-and-resource-health/README.md)
90. **Cost Management** — [canonical repository guide](../K-monitoring-operations-cost/cost-management/README.md)
91. **Azure Advisor** — [canonical repository guide](../K-monitoring-operations-cost/azure-advisor/README.md)
92. **Azure Automation** — [canonical repository guide](../K-monitoring-operations-cost/azure-automation/README.md)
93. **Azure Update Manager** — [canonical repository guide](../K-monitoring-operations-cost/azure-update-manager/README.md)
94. **Azure Resource Graph** — [canonical repository guide](../K-monitoring-operations-cost/azure-resource-graph/README.md)

### L. DevOps, IaC, Migration & Hybrid Management — 6 chapters
95. **Terraform** — [canonical repository guide](../L-devops-resilience-migration-ai/terraform/README.md)
96. **Bicep / ARM Templates** — [canonical repository guide](../L-devops-resilience-migration-ai/bicep-arm-templates/README.md)
97. **Azure DevOps Pipelines** — [canonical repository guide](../L-devops-resilience-migration-ai/azure-devops-pipelines/README.md)
98. **GitHub Actions** — [canonical repository guide](../L-devops-resilience-migration-ai/github-actions/README.md)
99. **Azure Migrate** — [canonical repository guide](../L-devops-resilience-migration-ai/azure-migrate/README.md)
100. **Azure Arc** — [canonical repository guide](../L-devops-resilience-migration-ai/azure-arc/README.md)

### M. AI Platform & Engineering — 13 chapters
101. **Microsoft Foundry** — [canonical repository guide](../M-ai-platform-engineering/microsoft-foundry/README.md)
102. **Azure OpenAI** — [canonical repository guide](../M-ai-platform-engineering/azure-openai/README.md)
103. **Azure AI Search** — [canonical repository guide](../M-ai-platform-engineering/azure-ai-search/README.md)
104. **Azure Machine Learning** — [canonical repository guide](../M-ai-platform-engineering/azure-machine-learning/README.md)
105. **AI Infrastructure Foundations** — [canonical repository guide](../M-ai-platform-engineering/ai-infrastructure-foundations/README.md)
106. **GPU & Accelerated Compute** — [canonical repository guide](../M-ai-platform-engineering/gpu-accelerated-compute/README.md)
107. **Model Catalog, Registry & Lifecycle** — [canonical repository guide](../M-ai-platform-engineering/model-catalog-registry-lifecycle/README.md)
108. **Model Deployment & Inference** — [canonical repository guide](../M-ai-platform-engineering/model-deployment-inference/README.md)
109. **RAG & Vector Search Architecture** — [canonical repository guide](../M-ai-platform-engineering/rag-vector-search-architecture/README.md)
110. **AI Agents & Orchestration** — [canonical repository guide](../M-ai-platform-engineering/ai-agents-orchestration/README.md)
111. **Prompt Engineering & Evaluation** — [canonical repository guide](../M-ai-platform-engineering/prompt-engineering-evaluation/README.md)
112. **LLMOps & AI Observability** — [canonical repository guide](../M-ai-platform-engineering/llmops-ai-observability/README.md)
113. **Responsible AI, Security & Governance** — [canonical repository guide](../M-ai-platform-engineering/responsible-ai-security-governance/README.md)

### 12. Business Continuity, Backup & Disaster Recovery — 7 chapters
114. **Business Continuity & Disaster Recovery Strategy** — [canonical repository guide](../12-automation-backup-disaster-recovery/77-business-continuity-disaster-recovery-strategy/README.md)
115. **Workload Criticality, BIA, RTO & RPO** — [canonical repository guide](../12-automation-backup-disaster-recovery/78-workload-criticality-bia-rto-rpo/README.md)
116. **Azure Backup & Workload Protection** — [canonical repository guide](../12-automation-backup-disaster-recovery/75-azure-backup/README.md)
117. **Backup Policy, Retention & Vault Security** — [canonical repository guide](../12-automation-backup-disaster-recovery/79-backup-policy-retention-vault-security/README.md)
118. **Restore Operations & Recovery Testing** — [canonical repository guide](../12-automation-backup-disaster-recovery/80-restore-operations-recovery-testing/README.md)
119. **Azure Site Recovery & Replication** — [canonical repository guide](../12-automation-backup-disaster-recovery/76-azure-site-recovery-asr/README.md)
120. **Recovery Plans, Failover & Failback** — [canonical repository guide](../12-automation-backup-disaster-recovery/81-recovery-plans-failover-failback/README.md)


**Verified catalogue total: 120 topic chapters across 14 categories.** This list is generated from the repository catalogue. Any future catalogue change must trigger a corresponding update to this book crosswalk.

## 5. Additional book sections (in addition to the 120 catalogue chapters)

### Front matter
- Cover and title page
- Copyright, licence, version and publication date
- About the book and intended audience
- Prerequisites and lab safety / Azure cost warning
- How to use the notebook-style diagrams, callouts and labs
- Clickable table of contents, list of figures and abbreviations

### Part 0 — Think like an Azure architect
- What solution architecture is responsible for
- Start with business, functional and non-functional requirements
- Shared responsibility and cloud operating models
- Azure global infrastructure and service models
- Control plane vs. data plane
- Architecture views: context, logical, deployment, network, identity, data and operations
- Azure Well-Architected Framework and Cloud Adoption Framework
- How to read topology diagrams, decision records and deployment examples

### End-to-end architecture and capstone chapters
- Enterprise platform foundation: tenant, management groups, subscriptions, policy and landing zones
- Hub-and-spoke and hybrid connectivity design
- Secure three-tier web application
- Private PaaS access: private endpoint, private DNS, routing and identity end to end
- Container and Kubernetes application platform
- Event-driven and integration architecture
- Data platform and analytics architecture, including Databricks and Fabric
- AI application and RAG architecture
- Central monitoring, security operations and FinOps
- Backup, disaster recovery, failover and recovery testing
- Infrastructure delivery with Terraform, Bicep and CI/CD
- LittleNest Kidswear: end-to-end reference workload, with implemented controls separated from proposed enhancements
- Enterprise architecture review and Well-Architected assessment

### Back matter
- Azure CLI and PowerShell command reference
- Terraform and Bicep patterns
- Architecture decision record (ADR) examples
- Troubleshooting playbooks and decision trees
- Glossary and acronym index
- Interview and scenario question bank
- Official Microsoft Learn references
- Repository source index, topic-to-chapter crosswalk, version history and errata

## 6. Standard template for every catalogue chapter

Every one of the 120 topic chapters uses this learning structure. Sections that genuinely do not apply to a topic must be marked **Not applicable** with a reason; they must not be filled with generic boilerplate.

1. **Notebook opener:** topic title, one-line purpose, learning goals and a small hand-drawn concept sketch.
2. **What problem does it solve?** Plain-language explanation, terminology, real-world analogy and boundaries.
3. **How it works:** components, lifecycle, request/data/control flow and key mechanics.
4. **Hand-drawn architecture diagram:** topic-specific drawing, legend, numbered flow and annotated explanation.
5. **Where it fits:** upstream dependencies, downstream consumers and cross-cutting Azure services.
6. **When to use / when not to use:** use cases, non-use cases and alternatives.
7. **Architectural decisions:** topology, tiers/SKUs, region, scale, quotas, limits, availability and decision trade-offs.
8. **Security and identity:** authentication, authorization, RBAC, managed identity, secrets, encryption, network exposure and governance as applicable.
9. **Networking and data flow:** ingress, egress, routing, DNS, private access, protocols and data boundaries as applicable.
10. **Reliability and recovery:** failure modes, redundancy, backup, restore, RTO/RPO and DR dependencies as applicable.
11. **Operations:** metrics, logs, alerts, diagnostics, troubleshooting, patching, ownership and runbooks.
12. **Cost and FinOps:** billing dimensions, cost drivers, cost traps, estimation approach and optimization levers.
13. **Worked enterprise example:** requirement, assumptions, selected pattern, diagram and explanation of rejected alternatives.
14. **Deploy / configure / design lab:** correct implementation method and guided exercise.
15. **Validate it:** expected output, success checks, negative tests and failure injection where safe.
16. **Common mistakes and troubleshooting:** symptoms, likely causes, diagnostic sequence and corrective action.
17. **Knowledge check:** questions, scenario prompts and model answers.
18. **References:** current official Microsoft Learn material plus the canonical repository topic guide.

## 7. Hand-drawn diagram requirements

Each catalogue chapter must have at least one original, topic-specific hand-drawn-style technical diagram. Complex topics should have several, for example a logical architecture view, a numbered traffic/data-flow sequence and a failure/recovery view.

Every diagram must:
- Name real Azure components and show clear trust/network/resource boundaries.
- Distinguish control-plane actions from data-plane traffic where relevant.
- Label protocols, ports, routes, identity, DNS and direction of flow when technically meaningful.
- Distinguish a conceptual relationship from an actual network path.
- Show assumptions and optional components instead of implying every architecture requires them.
- Include a figure number, descriptive caption, legend and source/revision note.
- Be authored as editable vector/source artwork (SVG and, where useful, draw.io) before PDF placement.
- Be checked against the accompanying text and official service documentation.

Use a hand-drawn visual treatment without sacrificing technical precision. Rough pen strokes are decorative; arrows, labels, boundaries and relationships must remain unambiguous.

## 8. Implementation standard

Every topic gets an appropriate practical treatment. Do not force every concept into a Terraform resource block.

Use one or more of these labels:
- **DEPLOY — Terraform:** an Azure resource can be provisioned with a reusable Terraform example.
- **DEPLOY — Bicep:** Bicep is the clearer Azure-native deployment example.
- **CONFIGURE — CLI / PowerShell / Portal / API:** the topic is primarily identity, permission, policy, platform or service configuration.
- **DESIGN — Architecture method:** the topic is a framework, design discipline or decision pattern without a standalone deployable resource.

Every lab must state:
- Objective, prerequisites, scope and required permissions.
- Tool/provider/API versions and region/SKU assumptions.
- Required dependencies and safe sample parameters.
- Complete code or configuration steps, with secrets excluded.
- Login and subscription-context checks.
- Format/validation/plan or what-if steps before applying changes.
- Deployment/configuration commands and expected outputs.
- Positive and negative validation checks.
- Troubleshooting guidance.
- Cleanup, rollback and data-retention warnings.
- Expected cost drivers and steps to avoid unintended charges.
- Evidence status: **reviewed**, **static-validated**, **lab-deployed**, or **not yet live-tested**.

A plan or successful syntax check is not proof of a live Azure deployment. State evidence honestly. Never label the LittleNest workload production-ready.

## 9. LittleNest learning workload

Use LittleNest as a recurring example to show how catalogue topics interact in a real workload. Preserve the implementation boundaries documented in its source code and LLD. Clearly distinguish:
- What currently exists in code and has validation evidence.
- What is demonstrated only as a lab/configuration step.
- What is an architecture recommendation or future enhancement.

Do not claim tenant-wide landing zones, hub networks, central monitoring, budgets, public exposure, remote Terraform state or other capabilities unless the current source proves they exist. Keep resource-cost caveats and safe cleanup instructions visible.

## 10. Editorial and technical quality rules

- The catalogue is authoritative for topic names, category membership and source links.
- Expand the repository material into teaching prose; do not concatenate existing README files.
- Explain service boundaries, dependencies, alternatives and trade-offs.
- Prefer current official Microsoft Learn sources for service behavior, limits, pricing meters, SKU/region availability and deployment syntax.
- Date-stamp volatile details and state assumptions.
- Separate generally available, preview, deprecated and region/SKU-specific features accurately.
- Keep examples internally consistent across diagrams, prose, commands and IaC.
- Avoid invented Azure capabilities, fake Terraform resources, misleading network arrows and unsupported production claims.
- Use the five Well-Architected pillars throughout: reliability, security, cost optimisation, operational excellence and performance efficiency.

## 11. Page design and PDF production

- A4 portrait for teaching pages; landscape only where a wide diagram or table genuinely needs it.
- Consistent margins, headers, footers, folio, part/chapter markers and generous whitespace.
- Readable typeset body text, clear code blocks and high-contrast annotations.
- Notebook-style chapter openers and diagram pages, with hand-drawn titles, callouts and arrows.
- Figure and code-listing numbers, captions and cross-references.
- Clickable contents, internal links, PDF bookmarks and clickable references.
- Searchable/selectable text; never flatten the whole book into page images.
- Embedded fonts, accessible reading order, legible diagrams and no clipped content.
- Print and screen rendering checks before release.

## 12. Production workflow and release gates

| Stage | Work | Exit criteria |
|---|---|---|
| 1. Catalogue lock | Read `catalog.json` and build the 120-topic crosswalk | Exactly 120 topics and 14 categories accounted for |
| 2. Visual prototype | Create cover, chapter opener, body page, diagram page and lab page | User approves the notebook visual language and legibility |
| 3. Pilot chapter | Produce one complete chapter with original diagram, lab and questions | Technical and visual review passes |
| 4. Category production | Write and illustrate chapters category by category | Every topic has a completed chapter and source link |
| 5. Capstones | Connect the component chapters in enterprise scenarios and LittleNest | End-to-end designs are internally consistent |
| 6. Technical review | Verify service details, security, network flows, code and citations | No known critical technical errors |
| 7. PDF build | Generate TOC, bookmarks, links, figures and searchable text | No clipping, broken links or unreadable diagrams |
| 8. Release review | Inspect the full PDF on screen and in print layout | Versioned release candidate approved |

Do not publish a partial PDF as the complete book. Draft sections can be shared for review but must be clearly marked incomplete.

## 13. Definition of done

The Azure Master Vault book is complete only when:
- All **120 catalogue topics across 14 categories** have distinct chapters and are cross-checked against `catalog.json`.
- All 120 chapters contain topic-specific learning content and at least one original hand-drawn-style technical diagram.
- All topics have appropriate deploy/configure/design treatment and honest evidence labels.
- End-to-end reference architectures and capstones connect the catalogue topics.
- Official references, volatile-detail dates and assumptions are included.
- LittleNest matches its actual source implementation and documented boundaries.
- The final PDF has searchable text, bookmarks, clickable contents and references, embedded fonts and readable figures.
- Technical, editorial, diagram, lab and PDF quality checks pass.
