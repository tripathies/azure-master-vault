# A. Cloud Foundation & Landing Zones

**[Component architecture map](architecture.mmd)** — arrows show a typical dependency/learning flow, not a mandatory deployment order.


[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json)

This page is the **complete learning page for Category A**. Each component is explained below on this page; component links are optional references, not a requirement to navigate away. Use the checkboxes as your progress tracker.

## Category completion checklist

- [ ] Understand Azure's global hierarchy and resource model
- [ ] Explain region pairs, availability zones and resiliency boundaries
- [ ] Distinguish Microsoft Entra tenant, management group, subscription, resource group and resource
- [ ] Understand Azure Resource Manager and deployment scopes
- [ ] Design Azure Policy and landing-zone governance
- [ ] Apply the Well-Architected Framework to an actual workload
- [ ] Draw and explain an enterprise hierarchy
- [ ] Work through the enterprise scenario and interview questions at the end

---

## A1. Microsoft Azure fundamentals

**What it is.** Azure is Microsoft's cloud platform. Customers consume services such as compute, networking, storage, databases, identity, security, analytics and AI through regional Azure infrastructure and management APIs.

**Architecture placement.** Think in three planes:
- **Identity plane:** Microsoft Entra ID identities, authentication and tokens.
- **Management plane:** Azure Resource Manager (ARM), which receives resource create/update/delete and configuration operations.
- **Data plane:** The service-specific endpoint that reads/writes data or performs workload operations (for example, a storage data endpoint).

**Core terms**
- **Resource:** an instance of an Azure service.
- **Resource provider:** namespace/API that manages a resource type, such as `Microsoft.Compute`.
- **Control plane vs data plane:** permission to configure a resource is not necessarily permission to read its data.
- **Region / zone:** physical placement and failure-domain concepts; not all services support zones or every region.
- **Shared responsibility:** Microsoft operates the cloud infrastructure; the customer still owns workload configuration, identity, data, access, and many operating controls.

**When to use what.** Select a managed PaaS service when its capabilities, control and constraints meet requirements; use IaaS when operating-system or runtime control is required; use serverless for event-driven work where the execution model fits. Compare operational effort, security, portability, availability and cost—not just the service name.

**Checklist**
- [ ] Identify management-plane vs data-plane permissions for the services you use.
- [ ] Verify region, SKU, quota, feature and zone support before committing a design.
- [ ] Define subscription ownership, resource naming, tagging, budgets and diagnostic requirements.
- [ ] Prefer managed identity and managed services where they satisfy requirements.

## A2. Regions, Region Pairs & Availability Zones

**Region:** a geographic area containing one or more Azure datacenters. **Availability zone:** a physically separate location within a supported region, with independent power, cooling and networking. **Region pair:** a Microsoft-defined relationship between two regions for certain platform recovery and update scenarios.

**Decision rules**
- Use zone-redundant architecture when the service supports zones and the workload requires protection from a zonal failure.
- Use multi-region architecture when the business requires protection from a regional outage or low-latency geographic distribution. Multi-region requires explicit data replication, traffic routing, identity and failover design.
- Do not assume every service is zone-enabled, every paired region is adjacent, or a paired region automatically fails over your workload.
- Choose regions from data residency, compliance, service availability, latency, recovery objectives, capacity and cost requirements.

**Availability design checklist**
- [ ] Define workload RTO (time to restore) and RPO (acceptable data loss).
- [ ] Identify failure domains: process, VM, zone, region, identity, network and operator error.
- [ ] Confirm service-specific zone and regional capabilities.
- [ ] Decide active-active vs active-passive, data replication strategy and failover authority.
- [ ] Test failover and failback; a topology diagram alone is not evidence of recovery.

## A3. Tenants and Microsoft Entra ID tenants

**What it is.** A Microsoft Entra tenant is an identity directory and trust boundary containing identities, groups, applications, service principals and tenant-level configuration. Azure subscriptions are associated with a tenant for identity and access management.

**Where it fits.** Tenant identities authenticate; Azure RBAC then authorizes actions at Azure scopes. Tenant-level identity configuration and subscription-level resource authorization are related but distinct.

**Design guidance**
- Use one primary workforce tenant unless legal, sovereignty, acquisition, isolation or operating-model requirements justify multiple tenants.
- Cross-tenant collaboration and B2B access are not the same as moving a subscription to another tenant.
- App registrations define application identity/configuration; service principals are tenant-local instances used for access.
- Protect privileged identities with MFA, Conditional Access, PIM and emergency-access procedures.

**Checklist**
- [ ] Document tenant boundaries, identity sources and cross-tenant collaboration.
- [ ] Apply least privilege to tenant administrators and application identities.
- [ ] Review app consent, credentials, certificates and service-principal assignments.
- [ ] Maintain monitored emergency access and test the procedure.

## A4. Management Groups

**What it is.** Management groups organize subscriptions into a hierarchy and provide a scope for governance inheritance, including Azure Policy and Azure RBAC assignments.

**Critical distinction:** A management group does **not** replace a subscription. The management group is the higher-level governance layer; a subscription remains a key boundary for billing, quotas and resource management.

~~~mermaid
flowchart TB
    Tenant[Microsoft Entra tenant<br/>Identity boundary] --> Root[Root management group<br/>Governance scope]
    Root --> Platform[Platform management group]
    Root --> Landing[Landing zones management group]
    Platform --> Identity[Identity subscription]
    Platform --> Connectivity[Connectivity subscription]
    Platform --> Management[Management subscription]
    Landing --> Prod[Production subscription]
    Landing --> NonProd[Non-production subscription]
    Prod --> RG1[Resource groups → resources]
    NonProd --> RG2[Resource groups → resources]
~~~

**Design guidance**
- Organize around governance needs, platform ownership and workload landing zones—not merely the organization chart.
- Assign broad policy only after testing effects; document exemptions and owners.
- Avoid unnecessary depth and branches with no distinct policy or ownership purpose.
- Moving a subscription changes inherited governance; assess policy and RBAC effects before moving it.

**Checklist**
- [ ] Define root, platform and workload branches.
- [ ] Map subscription placement and accountable owner.
- [ ] Review inherited policy, RBAC and exceptions.
- [ ] Establish change approval for moving subscriptions.

## A5. Azure Subscriptions

**What it is.** A subscription is a major resource-management, billing and quota boundary within a tenant. It contains resource groups and resources and is commonly used to separate environments, workloads, teams, billing or risk.

**When to split subscriptions**
- Separate production from non-production where access, quotas, billing or blast-radius requirements differ.
- Separate platform/shared services from application landing zones when operational ownership warrants it.
- Use dedicated subscriptions for regulatory or isolation needs when controls cannot be safely achieved within one subscription.

**Do not** create a subscription for every tiny component by default. Too many subscriptions add governance, identity, networking, quota and operational overhead.

**Checklist**
- [ ] Define owner, purpose, environment, budget and support model.
- [ ] Verify quota and regional needs.
- [ ] Apply policy, RBAC, tags, budgets and diagnostic settings through repeatable controls.
- [ ] Plan subscription vending, transfer, closure and resource ownership lifecycle.

## A6. Resource Groups

**What it is.** A resource group is a logical management container for resources in a subscription. It is useful for lifecycle, deployment, access and operational grouping. It is **not automatically a network or security boundary**.

**Design guidance**
- Group resources that share lifecycle and operational ownership.
- Avoid mixing resources with unrelated deletion/retention needs in one group.
- A resource can have dependencies outside its resource group; deletion may cause service impact or be blocked.
- RBAC can be assigned at resource-group scope and inherited by resources, but use the narrowest practical scope.

**Checklist**
- [ ] Name consistently and tag owner, workload, environment and cost center.
- [ ] Define deletion protection and resource locks where justified.
- [ ] Document cross-resource-group dependencies.
- [ ] Review whether role scope is too broad.

## A7. Azure Resource Manager (ARM)

**What it is.** ARM is Azure's management layer and API surface for deploying and managing resources. Azure portal, CLI, PowerShell, Terraform providers and Bicep/ARM templates interact with Azure resource APIs through their respective tooling.

**Deployment scopes**
- Resource group: deploy/manage resources in a group.
- Subscription: subscription-scoped resources and organization of resource groups.
- Management group: governance resources such as policy assignments at that scope.
- Tenant: selected tenant-level deployments and governance operations.

**Operational implications**
- A successful ARM deployment does not guarantee application health; add post-deployment validation.
- Dependencies should be explicit when they cannot be inferred.
- Use what-if/plan, change review and least-privilege deployment identities.
- Deployment scope and authorization scope must match the intended operation.

**Checklist**
- [ ] Choose the correct deployment scope.
- [ ] Validate resource-provider registration and permissions.
- [ ] Review what-if/plan output before production changes.
- [ ] Add smoke tests and drift/health monitoring after deployment.

## A8. Azure Policy

**What it is.** Azure Policy evaluates resources against organizational rules and can audit, deny, append/modify supported properties, deploy related configuration through deployIfNotExists, or remediate existing resources depending on the definition and effect.

**Policy vs RBAC**
- RBAC asks: *Who can perform an action?*
- Policy asks: *Does the resource configuration comply with the rule?*
- A user can have permission to create a resource and still be blocked by a deny policy.

**Design guidance**
- Start with audit effects to understand impact; use deny/modify effects after validation.
- Scope assignments carefully and use initiatives to bundle related policies.
- For deployIfNotExists/modify, ensure the managed identity, permissions and remediation tasks are correctly configured.
- Treat exemptions as time-bound, justified and owned—not as a silent bypass.

**Checklist**
- [ ] Define policy objective, scope, effect and exception process.
- [ ] Test in a non-production scope.
- [ ] Review compliance results and false positives.
- [ ] Validate remediation permissions before enabling automatic remediation.
- [ ] Track exemption owner, rationale and expiry.

## A9. Azure Landing Zones

**What it is.** Azure Landing Zones are an enterprise-scale conceptual and implementation approach for a governed Azure environment, covering platform foundations and workload landing zones. They align governance, identity, network, management, security and automation.

**Typical logical areas**
- **Platform:** shared identity, connectivity and management capabilities, sized to actual organizational needs.
- **Landing zones:** application/workload subscriptions governed by platform guardrails.
- **Governance:** management groups, Azure Policy, RBAC, naming, tagging, budgets and compliance.
- **Operations:** monitoring, inventory, patching, backup, incident response and recovery.
- **Automation:** subscription vending, reusable IaC modules and policy-as-code.

**Design checklist**
- [ ] Define platform vs workload responsibilities and service ownership.
- [ ] Decide hub-spoke, Virtual WAN or another network topology from traffic and operations needs.
- [ ] Establish identity, policy, logging, security, cost and resilience baselines.
- [ ] Automate repeatable subscription provisioning and guardrail assignment.
- [ ] Validate workload onboarding with a pilot before scaling.

## A10. Azure Well-Architected Framework

**What it is.** A review framework for designing and operating workloads across five pillars:
1. **Reliability** — recovery, redundancy, failure handling and operational testing.
2. **Security** — identity, segmentation, data protection and threat response.
3. **Cost Optimization** — right-sizing, consumption visibility and avoiding idle spend.
4. **Operational Excellence** — automation, observability, safe changes and learning from incidents.
5. **Performance Efficiency** — meeting demand through suitable architecture and scaling.

**How to apply it**
- Record business requirements and measurable service-level objectives.
- Review each pillar against the workload's actual architecture and operating model.
- Prioritize risks by business impact, likelihood and remediation effort.
- Track design decisions, owners, due dates and evidence; repeat the review as workload changes.

## End-to-end enterprise scenario

**Scenario:** A company is migrating customer-facing applications to Azure and needs controlled onboarding, separate production/non-production access, consistent security policy and regional resilience.

**Reference approach**
1. Establish tenant and privileged identity controls.
2. Create a management-group hierarchy aligned to platform and workload governance.
3. Create subscriptions based on ownership, environment, billing, quota and isolation.
4. Apply baseline Azure Policy and RBAC at the highest safe scope.
5. Provision workload resource groups and resources using approved IaC.
6. Choose regions and availability zones based on service support and RTO/RPO.
7. Add monitoring, backup/restore, incident runbooks and cost controls.
8. Validate the design against the Well-Architected pillars and test recovery.

## Common architecture mistakes

- Confusing tenant, management group, subscription and resource group.
- Treating management groups as a substitute for subscriptions.
- Assuming a region pair automatically replicates or fails over every service.
- Assuming resource groups provide network isolation.
- Applying restrictive policy at root without a safe rollout and exception process.
- Treating IaC deployment success as proof of application health or recoverability.
- Creating hierarchy complexity without clear governance or ownership value.

## Interview questions

**Q1. What is the difference between management group and subscription?**  
A management group organizes subscriptions and provides governance inheritance. A subscription is a key billing, quota and resource-management boundary. The management group does not replace the subscription.

**Q2. How do you choose a region and availability strategy?**  
Start with data residency, latency, service/zone support, capacity, cost and business RTO/RPO. Use zones for supported zonal failure protection and multi-region architecture when regional resilience is required. Test failover and data consistency.

**Q3. Azure Policy vs Azure RBAC?**  
RBAC authorizes identities to perform actions at a scope. Policy evaluates/enforces resource configuration. They complement one another and solve different governance problems.

**Q4. What makes a landing zone production-ready?**  
Clear ownership, identity controls, network topology, policy/RBAC guardrails, monitoring, security operations, cost management, repeatable provisioning, backup/DR and evidence that controls work.

## LinkedIn-ready post

Azure governance is not just a folder structure. Microsoft Entra establishes the identity boundary; management groups organize subscriptions and provide governance inheritance; subscriptions remain key billing, quota and resource-management boundaries; resource groups organize resources by lifecycle. Add policy, identity, network, operations and recovery guardrails—and validate them with a real workload. #Azure #LandingZones #CloudArchitecture

## Official references

- [Azure architecture center](https://learn.microsoft.com/azure/architecture/)
- [Management groups](https://learn.microsoft.com/azure/governance/management-groups/overview)
- [Azure Policy](https://learn.microsoft.com/azure/governance/policy/overview)
- [Azure landing zones](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)

## Component dependency flow

The diagram includes every component in this catalog and shows a typical progression plus cross-cutting controls.

~~~mermaid
flowchart LR
  subgraph CATA["A · Cloud Foundation and Landing Zones"]
    n1["Microsoft Azure fundamentals"]
    n2["Regions Region Pairs and Availability Zones"]
    n1 --> n2
    n3["Microsoft Entra ID tenants"]
    n2 --> n3
    n4["Management Groups"]
    n3 --> n4
    n5["Azure Subscriptions"]
    n4 --> n5
    n6["Resource Groups"]
    n5 --> n6
    n7["Azure Resource Manager ARM"]
    n6 --> n7
    n8["Azure Policy"]
    n7 --> n8
    n9["Azure Landing Zones"]
    n8 --> n9
    n10["Azure Well-Architected Framework"]
    n9 --> n10
  end
  Identity[Entra ID / RBAC] -. cross-cutting .-> n1
  Network[Network / DNS / private access] -. cross-cutting .-> n5
  Operations[Monitor / logs / cost] -. cross-cutting .-> n10
~~~
