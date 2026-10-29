# Azure Enterprise Reference Architecture

> A practical reference blueprint for learning how Azure platform services fit together. This is a logical architecture, not a claim that every listed service belongs in every workload.

[← Back to learning tracker](README.md) · [Open visual diagram library](VISUAL-DIAGRAMS.md) · [Editable master diagram](architecture.drawio)

![Logical Azure platform architecture](architecture.svg)

## 1. Design intent

This design describes a representative enterprise platform for hosting internet-facing and internal applications, connecting data services privately, applying centralized governance and identity controls, and operating workloads with monitoring, security and recovery capabilities.

**Do not deploy the whole catalogue as one solution by default.** Select components based on workload classification, regulatory obligations, latency, data residency, RTO/RPO, scale and budget.

## 2. Logical layers

| Layer | Purpose | Representative components |
|---|---|---|
| Governance and platform foundation | Establish hierarchy, policy guardrails, ownership and environment separation | [Management Groups](A-cloud-foundation-landing-zones/management-groups/README.md), [Azure Subscriptions](A-cloud-foundation-landing-zones/azure-subscriptions/README.md), [Resource Groups](A-cloud-foundation-landing-zones/resource-groups/README.md), [Azure Policy](A-cloud-foundation-landing-zones/azure-policy/README.md), [Azure Landing Zones](A-cloud-foundation-landing-zones/azure-landing-zones/README.md) |
| Identity and privileged access | Authenticate people and workloads; scope permissions and protect privileged actions | [Microsoft Entra ID](B-identity-access-management/microsoft-entra-id/README.md), [Managed Identities](B-identity-access-management/managed-identities/README.md), [Azure RBAC](B-identity-access-management/azure-rbac/README.md), [PIM](B-identity-access-management/privileged-identity-management-pim/README.md) |
| Hybrid and private network | Connect on-premises, hub/spoke networks and private service endpoints | [Virtual Networks](C-networking-private-connectivity/virtual-networks-vnet/README.md), [VNet Peering](C-networking-private-connectivity/vnet-peering/README.md), [Azure Firewall](C-networking-private-connectivity/azure-firewall/README.md), [VPN Gateway](C-networking-private-connectivity/vpn-gateway/README.md), [ExpressRoute](C-networking-private-connectivity/expressroute/README.md), [Private Endpoints](C-networking-private-connectivity/private-link-and-private-endpoints/README.md), [Private DNS Zones](C-networking-private-connectivity/private-dns-zones/README.md) |
| Ingress and traffic management | Route public and private requests, apply web protection and distribute traffic | [Azure Front Door](D-traffic-management-delivery/azure-front-door/README.md), [Application Gateway and WAF](D-traffic-management-delivery/application-gateway-and-waf/README.md), [Azure Load Balancer](D-traffic-management-delivery/azure-load-balancer/README.md) |
| Application and compute | Host application services using a runtime appropriate to the workload | [Compute and application hosting](E-compute-application-hosting/README.md), [Containers and Kubernetes](F-containers-kubernetes/README.md) |
| Data and integration | Persist data, integrate services and publish governed APIs | [Storage and enterprise file services](G-storage-enterprise-file-services/README.md), [Databases and data platforms](H-databases-data-platforms/README.md), [Integration and API management](I-integration-api-management/README.md) |
| Security and secrets | Protect secrets, posture, workload access and threat detection | [Security, secrets and governance](J-security-secrets-governance/README.md) |
| Operations and delivery | Observe health, manage cost, automate delivery and recover from failures | [Monitoring, operations and cost](K-monitoring-operations-cost/README.md), [DevOps, resilience, migration and AI](L-devops-resilience-migration-ai/README.md), [Automation, backup and disaster recovery](12-automation-backup-disaster-recovery/README.md) |

> If a link's path differs in the catalogue, use the category tracker to find the canonical component page. Component pages are the source of detailed service guidance.

## 3. Request and data flow

A typical internet-facing request path can be:

1. A user resolves the application hostname through public DNS.
2. An edge service such as Azure Front Door may provide global entry, acceleration and WAF capabilities when justified by requirements.
3. Traffic reaches a regional application entry point such as Application Gateway/WAF, or another supported ingress pattern.
4. The application runs on a suitable platform such as App Service, Azure Functions, virtual machines or AKS.
5. The workload accesses approved data and platform dependencies using workload identity and least-privilege permissions.
6. Private endpoints and private DNS are used for supported PaaS services when private access is a requirement; routing, DNS resolution and firewall policy must be designed together.
7. Logs, metrics and security signals flow to the selected monitoring and security services.
8. Backup, replication and failover are designed and tested against explicit recovery objectives.

This is a pattern, not a required chain. For example, Front Door and Application Gateway are not automatically both needed; AKS is not automatically the best compute platform; and private endpoints do not replace network security, identity controls or correct DNS.

## 4. Platform governance and environment layout

A common starting point is a management-group hierarchy for platform and workload subscriptions, with policy assignments at the narrowest scope that meets governance goals. Separate production and non-production environments where required by risk and operational boundaries. Use resource groups to organize resources with a shared lifecycle, access model or deployment boundary—not as a substitute for subscription strategy.

- Define naming, tagging, region, allowed-SKU and security baselines.
- Use Azure RBAC at the least-privileged practical scope; use privileged elevation workflows for administrative roles.
- Prefer managed identities over embedded credentials for Azure-hosted workloads where supported.
- Keep secrets in an approved secret store and rotate them.
- Test policy effects and exemptions before broad rollout.

## 5. Network and private access decisions

For hub-and-spoke or Virtual WAN designs, make the connectivity model explicit. Document address-space allocation, subnet purpose, routing intent, DNS ownership, ingress/egress control, hybrid connectivity, and failure domains. Avoid overlapping CIDRs and unreviewed route propagation.

For each private endpoint, verify:
- The target service supports the intended private-link configuration.
- The endpoint is placed in the correct network and subnet.
- Private DNS zones and VNet links resolve the service FQDN to the intended private address.
- Consumers can route to the endpoint and unauthorized paths are constrained.
- Public network access settings align with the intended design.

## 6. Identity, data protection and security

- Centralize workforce identity in Microsoft Entra ID and apply MFA/Conditional Access according to organizational policy.
- Assign workload identities explicit permissions; avoid broad subscription-level grants when resource-level access is sufficient.
- Encrypt data in transit and at rest using service-supported controls; assess customer-managed keys only where requirements justify the operational burden.
- Classify data, define retention and deletion, and consider residency and regulatory constraints.
- Monitor privileged activity, policy compliance, security posture and relevant data-plane operations.

## 7. Availability, backup and disaster recovery

Set RTO and RPO with business owners before choosing redundancy or replication. Availability zones, regional redundancy, geo-replication, backup and active-active designs solve different problems; none should be assumed to replace the others. Identify service-specific limits and dependencies, including DNS, identity, secrets, networking, build pipelines and operators.

For each critical workload, document:
- Failure domains and the failures the design is expected to tolerate.
- Backup scope, retention, immutability where required, and restore permissions.
- Replication mode and data consistency implications.
- Regional failover steps, decision authority, DNS/traffic changes and rollback.
- Recovery test frequency, evidence and measured RTO/RPO.

## 8. Observability and cost management

Define service-level indicators and actionable alerts before production launch. Collect platform metrics, application telemetry, audit events and security signals with appropriate retention and access. Avoid alert storms and unowned alerts. Review data ingestion and retention costs.

Cost reviews should include compute sizing and uptime, network egress, gateways and firewall throughput, logging ingestion/retention, storage transactions, database capacity, backup/replication and non-production schedules. Use budgets and anomaly alerts, but do not treat a budget alert as a hard spending cap.

## 9. Delivery and validation

A safe implementation workflow is:

1. Record assumptions, constraints, data classification and decision rationale.
2. Validate service support, regions, quotas, SKUs and network address plans.
3. Deploy infrastructure using reviewed Terraform or Bicep modules and a controlled state/backend strategy.
4. Run static validation and review Terraform plans or ARM/Bicep what-if output before applying.
5. Validate identity and authorization, DNS resolution, routes, private access, TLS, monitoring and policy compliance.
6. Exercise scaling, backup restoration and failover in a non-production environment.
7. Capture operational runbooks, ownership, cost baseline and known limitations.
8. Revisit the architecture when workload requirements or Azure service capabilities change.

The individual component pages provide deeper topic material. Treat any sample code as a starting point until versions, permissions, naming, dependencies and cleanup behavior have been checked in a test subscription.

## 10. Related learning paths

- [A — Cloud Foundation & Landing Zones](A-cloud-foundation-landing-zones/README.md)
- [B — Identity & Access Management](B-identity-access-management/README.md)
- [C — Networking & Private Connectivity](C-networking-private-connectivity/README.md)
- [D — Traffic Management & Delivery](D-traffic-management-delivery/README.md)
- [E — Compute & Application Hosting](E-compute-application-hosting/README.md)
- [F — Containers & Kubernetes](F-containers-kubernetes/README.md)
- [G — Storage & Enterprise File Services](G-storage-enterprise-file-services/README.md)
- [H — Databases & Data Platforms](H-databases-data-platforms/README.md)
- [I — Integration & API Management](I-integration-api-management/README.md)
- [J — Security, Secrets & Governance](J-security-secrets-governance/README.md)
- [K — Monitoring, Operations & Cost](K-monitoring-operations-cost/README.md)
- [L — DevOps, Resilience, Migration & AI](L-devops-resilience-migration-ai/README.md)

## 11. Official starting references

- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)
- [Azure landing zone design areas](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
- [Azure architecture icons](https://learn.microsoft.com/azure/architecture/icons/)
- [Azure Private Link overview](https://learn.microsoft.com/azure/private-link/private-link-overview)
