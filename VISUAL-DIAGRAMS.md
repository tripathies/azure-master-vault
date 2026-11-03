# Cloud Architecture Playbook — Visual Architecture Library

This is the visual index for the Azure Edition. The machine-readable catalogue is `catalog.json`; component guides linked below are its canonical destinations.

## Master architecture and catalogue

![Azure Cloud Mindmap](AZURE-COMPONENT-MINDMAP.svg)

- [Full Azure Cloud Mindmap](AZURE-COMPONENT-MINDMAP.svg)
- [Editable mind map](AZURE-COMPONENT-MINDMAP.drawio)
- [Enterprise reference architecture](AZURE-ENTERPRISE-REFERENCE-ARCHITECTURE.md)
- [Master architecture SVG](architecture.svg) · [Editable draw.io](architecture.drawio) · [Mermaid](architecture.mmd)
- [Network topology SVG](AZURE-NETWORK-ARCHITECTURE-MAP.svg) · [Editable draw.io](AZURE-NETWORK-ARCHITECTURE-MAP.drawio)

## Category maps and topic guides

### A — Cloud Foundation & Landing Zones

![Cloud Foundation & Landing Zones architecture](A-cloud-foundation-landing-zones/architecture.svg)

- [Category guide](A-cloud-foundation-landing-zones/README.md) · [SVG](A-cloud-foundation-landing-zones/architecture.svg) · [Editable draw.io](A-cloud-foundation-landing-zones/architecture.drawio) · [Mermaid](A-cloud-foundation-landing-zones/architecture.mmd)

- [Microsoft Azure fundamentals](A-cloud-foundation-landing-zones/microsoft-azure-fundamentals/README.md)
- [Regions, Region Pairs & Availability Zones](A-cloud-foundation-landing-zones/regions-region-pairs-and-availability-zones/README.md)
- [Microsoft Entra ID tenants](A-cloud-foundation-landing-zones/microsoft-entra-id-tenants/README.md)
- [Management Groups](A-cloud-foundation-landing-zones/management-groups/README.md)
- [Azure Subscriptions](A-cloud-foundation-landing-zones/azure-subscriptions/README.md)
- [Resource Groups](A-cloud-foundation-landing-zones/resource-groups/README.md)
- [Azure Resource Manager (ARM)](A-cloud-foundation-landing-zones/azure-resource-manager-arm/README.md)
- [Azure Policy](A-cloud-foundation-landing-zones/azure-policy/README.md)
- [Azure Landing Zones](A-cloud-foundation-landing-zones/azure-landing-zones/README.md)
- [Azure Well-Architected Framework](A-cloud-foundation-landing-zones/azure-well-architected-framework/README.md)

### B — Identity & Access Management

![Identity & Access Management architecture](B-identity-access-management/architecture.svg)

- [Category guide](B-identity-access-management/README.md) · [SVG](B-identity-access-management/architecture.svg) · [Editable draw.io](B-identity-access-management/architecture.drawio) · [Mermaid](B-identity-access-management/architecture.mmd)

- [Microsoft Entra ID](B-identity-access-management/microsoft-entra-id/README.md)
- [App Registrations](B-identity-access-management/app-registrations/README.md)
- [Enterprise Applications & Service Principals](B-identity-access-management/enterprise-applications-and-service-principals/README.md)
- [Managed Identities](B-identity-access-management/managed-identities/README.md)
- [Azure RBAC](B-identity-access-management/azure-rbac/README.md)
- [MFA & Conditional Access](B-identity-access-management/mfa-and-conditional-access/README.md)
- [Privileged Identity Management (PIM)](B-identity-access-management/privileged-identity-management-pim/README.md)
- [OAuth 2.0 & OpenID Connect](B-identity-access-management/oauth-2-0-and-openid-connect/README.md)

### C — Networking & Private Connectivity

![Networking & Private Connectivity architecture](C-networking-private-connectivity/architecture.svg)

- [Category guide](C-networking-private-connectivity/README.md) · [SVG](C-networking-private-connectivity/architecture.svg) · [Editable draw.io](C-networking-private-connectivity/architecture.drawio) · [Mermaid](C-networking-private-connectivity/architecture.mmd)

- [Virtual Networks (VNet)](C-networking-private-connectivity/virtual-networks-vnet/README.md)
- [Subnets & CIDR Planning](C-networking-private-connectivity/subnets-and-cidr-planning/README.md)
- [Network Security Groups (NSGs)](C-networking-private-connectivity/network-security-groups-nsgs/README.md)
- [Application Security Groups (ASGs)](C-networking-private-connectivity/application-security-groups-asgs/README.md)
- [VNet Peering](C-networking-private-connectivity/vnet-peering/README.md)
- [User-Defined Routes (UDRs)](C-networking-private-connectivity/user-defined-routes-udrs/README.md)
- [Azure Firewall](C-networking-private-connectivity/azure-firewall/README.md)
- [VPN Gateway](C-networking-private-connectivity/vpn-gateway/README.md)
- [ExpressRoute](C-networking-private-connectivity/expressroute/README.md)
- [Private Link & Private Endpoints](C-networking-private-connectivity/private-link-and-private-endpoints/README.md)
- [Private DNS Zones](C-networking-private-connectivity/private-dns-zones/README.md)
- [NAT Gateway](C-networking-private-connectivity/nat-gateway/README.md)

### D — Traffic Management & Delivery

![Traffic Management & Delivery architecture](D-traffic-management-delivery/architecture.svg)

- [Category guide](D-traffic-management-delivery/README.md) · [SVG](D-traffic-management-delivery/architecture.svg) · [Editable draw.io](D-traffic-management-delivery/architecture.drawio) · [Mermaid](D-traffic-management-delivery/architecture.mmd)

- [Azure Load Balancer](D-traffic-management-delivery/azure-load-balancer/README.md)
- [Application Gateway & WAF](D-traffic-management-delivery/application-gateway-and-waf/README.md)
- [Azure Front Door](D-traffic-management-delivery/azure-front-door/README.md)
- [Traffic Manager](D-traffic-management-delivery/traffic-manager/README.md)
- [Azure Bastion](D-traffic-management-delivery/azure-bastion/README.md)
- [Azure DNS](D-traffic-management-delivery/azure-dns/README.md)
- [DDoS Protection](D-traffic-management-delivery/ddos-protection/README.md)
- [Network Watcher](D-traffic-management-delivery/network-watcher/README.md)

### E — Compute & Application Hosting

![Compute & Application Hosting architecture](E-compute-application-hosting/architecture.svg)

- [Category guide](E-compute-application-hosting/README.md) · [SVG](E-compute-application-hosting/architecture.svg) · [Editable draw.io](E-compute-application-hosting/architecture.drawio) · [Mermaid](E-compute-application-hosting/architecture.mmd)

- [Virtual Machines](E-compute-application-hosting/virtual-machines/README.md)
- [Managed Disks](E-compute-application-hosting/managed-disks/README.md)
- [Availability Sets & Zones](E-compute-application-hosting/availability-sets-and-zones/README.md)
- [Virtual Machine Scale Sets](E-compute-application-hosting/virtual-machine-scale-sets/README.md)
- [Azure App Service](E-compute-application-hosting/azure-app-service/README.md)
- [Azure Functions](E-compute-application-hosting/azure-functions/README.md)
- [Logic Apps](E-compute-application-hosting/logic-apps/README.md)
- [Azure Batch](E-compute-application-hosting/azure-batch/README.md)

### F — Containers & Kubernetes

![Containers & Kubernetes architecture](F-containers-kubernetes/architecture.svg)

- [Category guide](F-containers-kubernetes/README.md) · [SVG](F-containers-kubernetes/architecture.svg) · [Editable draw.io](F-containers-kubernetes/architecture.drawio) · [Mermaid](F-containers-kubernetes/architecture.mmd)

- [Docker & Container Fundamentals](F-containers-kubernetes/docker-and-container-fundamentals/README.md)
- [Azure Container Registry (ACR)](F-containers-kubernetes/azure-container-registry-acr/README.md)
- [Azure Container Apps](F-containers-kubernetes/azure-container-apps/README.md)
- [Azure Kubernetes Service (AKS)](F-containers-kubernetes/azure-kubernetes-service-aks/README.md)
- [Azure Container Instances (ACI)](F-containers-kubernetes/azure-container-instances-aci/README.md)
- [AKS Ingress, Scaling & Workload Identity](F-containers-kubernetes/aks-ingress-scaling-and-workload-identity/README.md)

### G — Storage & Enterprise File Services

![Storage & Enterprise File Services architecture](G-storage-enterprise-file-services/architecture.svg)

- [Category guide](G-storage-enterprise-file-services/README.md) · [SVG](G-storage-enterprise-file-services/architecture.svg) · [Editable draw.io](G-storage-enterprise-file-services/architecture.drawio) · [Mermaid](G-storage-enterprise-file-services/architecture.mmd)

- [Storage Accounts](G-storage-enterprise-file-services/storage-accounts/README.md)
- [Blob Storage](G-storage-enterprise-file-services/blob-storage/README.md)
- [Azure Data Lake Storage Gen2](G-storage-enterprise-file-services/azure-data-lake-storage-gen2/README.md)
- [Azure Files](G-storage-enterprise-file-services/azure-files/README.md)
- [Azure NetApp Files](G-storage-enterprise-file-services/azure-netapp-files/README.md)
- [Queue Storage](G-storage-enterprise-file-services/queue-storage/README.md)
- [Table Storage](G-storage-enterprise-file-services/table-storage/README.md)
- [Storage Redundancy: LRS, ZRS, GRS & GZRS](G-storage-enterprise-file-services/storage-redundancy-lrs-zrs-grs-and-gzrs/README.md)

### H — Databases & Data Platforms

![Databases & Data Platforms architecture](H-databases-data-platforms/architecture.svg)

- [Category guide](H-databases-data-platforms/README.md) · [SVG](H-databases-data-platforms/architecture.svg) · [Editable draw.io](H-databases-data-platforms/architecture.drawio) · [Mermaid](H-databases-data-platforms/architecture.mmd)

- [Azure SQL Database](H-databases-data-platforms/azure-sql-database/README.md)
- [Azure SQL Managed Instance](H-databases-data-platforms/azure-sql-managed-instance/README.md)
- [SQL Server on Azure VMs](H-databases-data-platforms/sql-server-on-azure-vms/README.md)
- [Azure Cosmos DB](H-databases-data-platforms/azure-cosmos-db/README.md)
- [Azure Database for PostgreSQL](H-databases-data-platforms/azure-database-for-postgresql/README.md)
- [Azure Database for MySQL](H-databases-data-platforms/azure-database-for-mysql/README.md)
- [Azure Managed Redis](H-databases-data-platforms/azure-managed-redis/README.md)
- [Azure Data Factory](H-databases-data-platforms/azure-data-factory/README.md)
- [Azure Databricks](H-databases-data-platforms/azure-databricks/README.md)
- [Microsoft Fabric / OneLake](H-databases-data-platforms/microsoft-fabric-onelake/README.md)

### I — Integration & API Management

![Integration & API Management architecture](I-integration-api-management/architecture.svg)

- [Category guide](I-integration-api-management/README.md) · [SVG](I-integration-api-management/architecture.svg) · [Editable draw.io](I-integration-api-management/architecture.drawio) · [Mermaid](I-integration-api-management/architecture.mmd)

- [API Management](I-integration-api-management/api-management/README.md)
- [Azure Service Bus](I-integration-api-management/azure-service-bus/README.md)
- [Azure Event Grid](I-integration-api-management/azure-event-grid/README.md)
- [Azure Event Hubs](I-integration-api-management/azure-event-hubs/README.md)
- [Azure Stream Analytics](I-integration-api-management/azure-stream-analytics/README.md)
- [Azure Data Explorer](I-integration-api-management/azure-data-explorer/README.md)

### J — Security, Secrets & Governance

![Security, Secrets & Governance architecture](J-security-secrets-governance/architecture.svg)

- [Category guide](J-security-secrets-governance/README.md) · [SVG](J-security-secrets-governance/architecture.svg) · [Editable draw.io](J-security-secrets-governance/architecture.drawio) · [Mermaid](J-security-secrets-governance/architecture.mmd)

- [Azure Key Vault](J-security-secrets-governance/azure-key-vault/README.md)
- [Key Vault Access Policies & RBAC](J-security-secrets-governance/key-vault-access-policies-and-rbac/README.md)
- [Microsoft Defender for Cloud](J-security-secrets-governance/microsoft-defender-for-cloud/README.md)
- [Microsoft Sentinel](J-security-secrets-governance/microsoft-sentinel/README.md)
- [Microsoft Purview](J-security-secrets-governance/microsoft-purview/README.md)
- [Azure Resource Locks](J-security-secrets-governance/azure-resource-locks/README.md)
- [Tagging & Naming Standards](J-security-secrets-governance/tagging-and-naming-standards/README.md)
- [Zero Trust Architecture](J-security-secrets-governance/zero-trust-architecture/README.md)

### K — Monitoring, Operations & Cost

![Monitoring, Operations & Cost architecture](K-monitoring-operations-cost/architecture.svg)

- [Category guide](K-monitoring-operations-cost/README.md) · [SVG](K-monitoring-operations-cost/architecture.svg) · [Editable draw.io](K-monitoring-operations-cost/architecture.drawio) · [Mermaid](K-monitoring-operations-cost/architecture.mmd)

- [Azure Monitor](K-monitoring-operations-cost/azure-monitor/README.md)
- [Log Analytics Workspace & KQL](K-monitoring-operations-cost/log-analytics-workspace-and-kql/README.md)
- [Application Insights](K-monitoring-operations-cost/application-insights/README.md)
- [Azure Monitor Alerts & Action Groups](K-monitoring-operations-cost/azure-monitor-alerts-and-action-groups/README.md)
- [Service Health & Resource Health](K-monitoring-operations-cost/service-health-and-resource-health/README.md)
- [Cost Management](K-monitoring-operations-cost/cost-management/README.md)
- [Azure Advisor](K-monitoring-operations-cost/azure-advisor/README.md)
- [Azure Automation](K-monitoring-operations-cost/azure-automation/README.md)
- [Azure Update Manager](K-monitoring-operations-cost/azure-update-manager/README.md)
- [Azure Resource Graph](K-monitoring-operations-cost/azure-resource-graph/README.md)

### L — DevOps, IaC, Migration & Hybrid Management

![DevOps, IaC, Migration & Hybrid Management architecture](L-devops-resilience-migration-ai/architecture.svg)

- [Category guide](L-devops-resilience-migration-ai/README.md) · [SVG](L-devops-resilience-migration-ai/architecture.svg) · [Editable draw.io](L-devops-resilience-migration-ai/architecture.drawio) · [Mermaid](L-devops-resilience-migration-ai/architecture.mmd)

- [Terraform](L-devops-resilience-migration-ai/terraform/README.md)
- [Bicep / ARM Templates](L-devops-resilience-migration-ai/bicep-arm-templates/README.md)
- [Azure DevOps Pipelines](L-devops-resilience-migration-ai/azure-devops-pipelines/README.md)
- [GitHub Actions](L-devops-resilience-migration-ai/github-actions/README.md)
- [Azure Migrate](L-devops-resilience-migration-ai/azure-migrate/README.md)
- [Azure Arc](L-devops-resilience-migration-ai/azure-arc/README.md)

### M — AI Platform & Engineering

![AI Platform & Engineering architecture](M-ai-platform-engineering/architecture.svg)

- [Category guide](M-ai-platform-engineering/README.md) · [SVG](M-ai-platform-engineering/architecture.svg) · [Editable draw.io](M-ai-platform-engineering/architecture.drawio) · [Mermaid](M-ai-platform-engineering/architecture.mmd)

- [Microsoft Foundry](M-ai-platform-engineering/microsoft-foundry/README.md)
- [Azure OpenAI](M-ai-platform-engineering/azure-openai/README.md)
- [Azure AI Search](M-ai-platform-engineering/azure-ai-search/README.md)
- [Azure Machine Learning](M-ai-platform-engineering/azure-machine-learning/README.md)
- [AI Infrastructure Foundations](M-ai-platform-engineering/ai-infrastructure-foundations/README.md)
- [GPU & Accelerated Compute](M-ai-platform-engineering/gpu-accelerated-compute/README.md)
- [Model Catalog, Registry & Lifecycle](M-ai-platform-engineering/model-catalog-registry-lifecycle/README.md)
- [Model Deployment & Inference](M-ai-platform-engineering/model-deployment-inference/README.md)
- [RAG & Vector Search Architecture](M-ai-platform-engineering/rag-vector-search-architecture/README.md)
- [AI Agents & Orchestration](M-ai-platform-engineering/ai-agents-orchestration/README.md)
- [Prompt Engineering & Evaluation](M-ai-platform-engineering/prompt-engineering-evaluation/README.md)
- [LLMOps & AI Observability](M-ai-platform-engineering/llmops-ai-observability/README.md)
- [Responsible AI, Security & Governance](M-ai-platform-engineering/responsible-ai-security-governance/README.md)

### 12 — Business Continuity, Backup & Disaster Recovery

![Business Continuity, Backup & Disaster Recovery architecture](12-automation-backup-disaster-recovery/architecture.svg)

- [Category guide](12-automation-backup-disaster-recovery/README.md) · [SVG](12-automation-backup-disaster-recovery/architecture.svg) · [Editable draw.io](12-automation-backup-disaster-recovery/architecture.drawio) · [Mermaid](12-automation-backup-disaster-recovery/architecture.mmd)

- [Business Continuity & Disaster Recovery Strategy](12-automation-backup-disaster-recovery/77-business-continuity-disaster-recovery-strategy/README.md)
- [Workload Criticality, BIA, RTO & RPO](12-automation-backup-disaster-recovery/78-workload-criticality-bia-rto-rpo/README.md)
- [Azure Backup & Workload Protection](12-automation-backup-disaster-recovery/75-azure-backup/README.md)
- [Backup Policy, Retention & Vault Security](12-automation-backup-disaster-recovery/79-backup-policy-retention-vault-security/README.md)
- [Restore Operations & Recovery Testing](12-automation-backup-disaster-recovery/80-restore-operations-recovery-testing/README.md)
- [Azure Site Recovery & Replication](12-automation-backup-disaster-recovery/76-azure-site-recovery-asr/README.md)
- [Recovery Plans, Failover & Failback](12-automation-backup-disaster-recovery/81-recovery-plans-failover-failback/README.md)

## Ownership boundaries

- **L:** delivery engineering, Infrastructure as Code, CI/CD, migration and hybrid management.
- **M:** AI platform, Azure AI services, AI workloads, model lifecycle, agents, evaluation, LLMOps and responsible AI.
- **12:** business continuity, workload criticality, RTO/RPO, Azure Backup, vault security, restore validation, Site Recovery and recovery plans.

No topic is intentionally duplicated between L and 12. Each component has one canonical guide.
