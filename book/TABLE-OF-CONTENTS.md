# Azure Cloud Architecture Playbook — Proposed Table of Contents

**Subtitle:** From Cloud Fundamentals to Enterprise-Grade Architecture

The catalogue is the source inventory, not a requirement to create 111 isolated chapters. Closely related services are taught together, while every original catalogue entry remains traceable in the source crosswalk.

## Front matter
- Cover; title page; edition and publication information
- Copyright, licence, trademark and cloud-cost disclaimer
- Preface; audience; how to use the book; prerequisites and lab environment
- Learning pathway; symbols and diagram notation
- Table of contents; list of figures, tables, labs and code listings

## Part I — Cloud and Azure foundations
1. Cloud computing: service models, deployment models and shared responsibility
2. Azure global infrastructure: regions, region pairs, zones and data residency
3. Azure resource model: tenants, management groups, subscriptions, resource groups and resources
4. Azure Resource Manager: control plane, data plane, providers and deployment scopes
5. Governance foundations: naming, tagging, locks and policy
6. Azure Landing Zones: platform/workload landing zones and subscription vending
7. Azure Well-Architected Framework and quality attributes

**Vault A:** Azure fundamentals; Regions/Region Pairs/Availability Zones; Entra ID tenants; Management Groups; Subscriptions; Resource Groups; ARM; Azure Policy; Landing Zones; Well-Architected Framework.

## Part II — Identity, authentication and authorisation
8. Microsoft Entra ID: tenants, users, groups and enterprise identity
9. App registrations, service principals and enterprise applications
10. OAuth 2.0, OpenID Connect and tokens
11. Managed identities: system-assigned and user-assigned
12. Azure RBAC: scopes, role definitions and least privilege
13. MFA, Conditional Access and identity protection
14. Privileged Identity Management and just-in-time administration
15. Workload identity and service-to-service access

**Vault B:** Entra ID; App Registrations; Enterprise Applications & Service Principals; Managed Identities; RBAC; MFA & Conditional Access; PIM; OAuth 2.0 & OIDC.

## Part III — Azure networking and private connectivity
16. Azure networking foundations: address spaces, packets, routing and boundaries
17. Virtual Networks, subnets and CIDR planning
18. Network Security Groups and Application Security Groups
19. VNet peering, hub-and-spoke and Virtual WAN decision patterns
20. User-Defined Routes and routing design
21. Azure Firewall and central inspection
22. VPN Gateway: site-to-site, point-to-site and VNet-to-VNet
23. ExpressRoute and private hybrid connectivity
24. Private Link, private endpoints and service access
25. Private DNS zones, forwarding and name resolution
26. NAT Gateway, outbound connectivity and egress control

**Vault C:** VNet; Subnets & CIDR; NSGs; ASGs; VNet Peering; UDRs; Azure Firewall; VPN Gateway; ExpressRoute; Private Link/Private Endpoints; Private DNS Zones; NAT Gateway.

## Part IV — Edge, ingress and traffic delivery
27. Azure DNS and public/private name resolution
28. Azure Load Balancer: Layer 4 distribution and probes
29. Application Gateway and WAF
30. Azure Front Door: global entry, acceleration and WAF
31. Traffic Manager: DNS-based distribution
32. Azure Bastion and secure administration
33. DDoS Protection and network resilience
34. Network Watcher and troubleshooting

**Vault D:** Load Balancer; Application Gateway & WAF; Front Door; Traffic Manager; Bastion; Azure DNS; DDoS Protection; Network Watcher.

## Part V — Compute and application hosting
35. Compute decision framework: IaaS, PaaS, containers and serverless
36. Azure Virtual Machines and VM architecture
37. Managed Disks, snapshots and performance
38. Availability Sets, Zones and VM Scale Sets
39. Azure App Service: plans, slots, identity and networking
40. Azure Functions: triggers, bindings, hosting and event-driven design
41. Logic Apps and workflow integration
42. Azure Batch and parallel workloads

**Vault E:** Virtual Machines; Managed Disks; Availability Sets & Zones; VM Scale Sets; App Service; Functions; Logic Apps; Batch.

## Part VI — Containers and Kubernetes
43. Container fundamentals: images, registries, runtimes and orchestration
44. Azure Container Registry and image supply-chain security
45. Azure Container Apps
46. Azure Kubernetes Service: cluster architecture and operations
47. Azure Container Instances
48. AKS ingress, scaling, workload identity and network design

**Vault F:** Docker & Container Fundamentals; ACR; Container Apps; AKS; ACI; AKS Ingress, Scaling & Workload Identity.

## Part VII — Storage and enterprise file services
49. Azure Storage architecture, accounts, redundancy and security
50. Blob Storage, access tiers, lifecycle and private access
51. Data Lake Storage Gen2
52. Azure Files and hybrid file services
53. Azure NetApp Files
54. Queue Storage and asynchronous messaging
55. Table Storage
56. Storage redundancy: LRS, ZRS, GRS and GZRS

**Vault G:** Storage Accounts; Blob; ADLS Gen2; Azure Files; Azure NetApp Files; Queue; Table; Storage Redundancy.

## Part VIII — Databases and data platforms
57. Database selection: relational, NoSQL, cache and analytics
58. Azure SQL Database
59. Azure SQL Managed Instance
60. SQL Server on Azure VMs
61. Cosmos DB: APIs, partitioning, consistency and global distribution
62. Azure Database for PostgreSQL
63. Azure Database for MySQL
64. Azure Managed Redis
65. Azure Data Factory
66. Azure Databricks and lakehouse architecture
67. Microsoft Fabric and OneLake

**Vault H:** Azure SQL Database; SQL Managed Instance; SQL Server on VMs; Cosmos DB; PostgreSQL; MySQL; Managed Redis; Data Factory; Databricks; Fabric/OneLake.

## Part IX — Integration, messaging and APIs
68. API Management and API gateway architecture
69. Service Bus: queues, topics and enterprise messaging
70. Event Grid and event-driven integration
71. Event Hubs and streaming ingestion
72. Stream Analytics
73. Data Explorer and analytical event data

**Vault I:** API Management; Service Bus; Event Grid; Event Hubs; Stream Analytics; Data Explorer.

## Part X — Security, secrets and governance
74. Key Vault: secrets, keys and certificates
75. Key Vault access policies versus Azure RBAC
76. Defender for Cloud and security posture
77. Microsoft Sentinel and SIEM/SOAR
78. Microsoft Purview and data governance
79. Resource Locks and change protection
80. Naming, tagging and resource governance
81. Zero Trust architecture for Azure workloads

**Vault J:** Key Vault; Key Vault Access Policies & RBAC; Defender for Cloud; Sentinel; Purview; Resource Locks; Tagging & Naming; Zero Trust.

## Part XI — Monitoring, operations and FinOps
82. Operations model and observability fundamentals
83. Azure Monitor: metrics, logs and diagnostics
84. Log Analytics and KQL
85. Application Insights and distributed tracing
86. Alerts and action groups
87. Service Health and Resource Health
88. Cost Management, budgets, exports and allocation
89. Azure Advisor and recommendation governance
90. Azure Automation and runbooks
91. Azure Update Manager and patch governance
92. Azure Resource Graph and fleet inventory

**Vault K:** Azure Monitor; Log Analytics/KQL; Application Insights; Alerts/Action Groups; Service Health/Resource Health; Cost Management; Advisor; Automation; Update Manager; Resource Graph.

## Part XII — Infrastructure as Code and DevOps
93. Infrastructure as Code principles and Terraform on Azure
94. Bicep and ARM templates
95. Azure Verified Modules and reusable deployment patterns
96. Azure DevOps Pipelines
97. GitHub Actions, OIDC federation and secure CI/CD
98. State, environments, modules, drift and deployment governance

**Vault L and category 12:** Terraform; Bicep/ARM; Azure DevOps Pipelines; GitHub Actions. Consolidate duplicates rather than teach them twice.

## Part XIII — Backup, disaster recovery, migration and hybrid operations
99. Backup strategy, recovery objectives and Azure Backup
100. Azure Site Recovery and workload failover
101. Azure Migrate: discovery, assessment and migration
102. Azure Arc and hybrid/multicloud management
103. Recovery testing, runbooks and business continuity

**Vault L and category 12:** Azure Backup and Azure Site Recovery (ASR) appear in both catalogue groupings; each is taught once.

## Part XIV — AI and modern Azure platforms
104. Microsoft Foundry: platform concepts, projects and governance
105. Azure OpenAI: model access, identity, network and responsible use
106. Azure AI Search and retrieval-augmented generation
107. Azure Machine Learning: lifecycle, workspaces and compute
108. Secure AI workload architecture and operational guardrails

**Vault L:** Microsoft Foundry; Azure OpenAI; Azure AI Search; Azure Machine Learning.

## Part XV — End-to-end architecture and capstone projects
109. Solution architecture method: requirements, constraints and quality attributes
110. Reference patterns: web, API, event-driven, data and hybrid
111. LittleNest Kidswear: requirements to deployed Azure workload
112. Architecture reviews: ADRs, threat models and Well-Architected assessment
113. Production readiness: SLOs, security, operations, cost, recovery and handover

**Sources:** Azure Enterprise Reference Architecture; LittleNest application; Terraform; LLD; validation docs; repository diagrams.

## Back matter
- Azure hierarchy and service-selection quick reference
- Azure CLI and PowerShell command reference
- Terraform and Bicep quick reference
- Network ports, protocols and private DNS reference
- Architecture decision record template
- Lab safety, budget and cleanup checklist
- Troubleshooting playbook
- Glossary and acronyms
- Catalogue-to-book source crosswalk
- References and index

## Catalogue reconciliation

The source catalogue contains 111 entries in 13 categories. The outline above groups related services into 113 teaching chapters, including five architecture/capstone chapters. Category L and category 12 overlap on IaC, pipelines, Backup and Site Recovery. Teach each subject once, but map every original catalogue entry to its canonical chapter and retain both source paths in the crosswalk.

This is a proposed outline. Final chapter sequence and depth are subject to the complete content and code audit.
