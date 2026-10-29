# Management Groups

[← A. Cloud Foundation & Landing Zones](../README.md) · [← Master catalogue](../../README.md)

## Solution-architect checklist

- [ ] Explain the hierarchy from Microsoft Entra tenant to management groups, subscriptions, resource groups and resources
- [ ] Distinguish identity boundary, governance scope, billing boundary and deployment scope
- [ ] Design management group branches around policy, platform ownership and landing-zone governance
- [ ] Explain policy and RBAC inheritance and how exceptions are governed
- [ ] Keep the hierarchy shallow enough to operate and avoid mirroring every organizational chart
- [ ] Document subscription placement, naming, ownership and lifecycle
- [ ] Test policy effects and exemptions before broad assignment
- [ ] Link the design to [Azure Landing Zones](../azure-landing-zones/README.md) and [Azure Policy](../azure-policy/README.md)

## 1. What it is

A management group is a governance scope above Azure subscriptions. Management groups let teams organize subscriptions and apply Azure Policy and access governance across groups of subscriptions. They do **not** replace a subscription: subscriptions remain important boundaries for billing, quotas, resource management and workload isolation.

## 2. Where it fits in Azure architecture

~~~mermaid
flowchart TB
    Tenant[Microsoft Entra tenant<br/>Identity boundary]
    Tenant --> Root[Root management group<br/>Top-level governance scope]
    Root --> Platform[Platform management group]
    Root --> LandingZones[Landing zones management group]
    Platform --> Identity[Identity subscription]
    Platform --> Connectivity[Connectivity subscription]
    Platform --> Management[Management subscription]
    LandingZones --> Prod[Production subscription]
    LandingZones --> NonProd[Non-production subscription]
    Identity --> IRG[Resource groups and resources]
    Connectivity --> CRG[Resource groups and resources]
    Management --> MRG[Resource groups and resources]
    Prod --> PRG[Resource groups and resources]
    NonProd --> NRG[Resource groups and resources]
~~~

Illustrative enterprise hierarchy. Actual management-group branches and subscription placements depend on governance requirements. Platform subscriptions are examples, not mandatory separate subscriptions for every organization.

## 3. Understand each layer

| Layer | Primary role | Does not replace |
|---|---|---|
| Microsoft Entra tenant | Identity directory and tenant boundary | Azure subscription |
| Management group | Organize subscriptions and inherit governance | Subscription billing/quota/resource boundary |
| Subscription | Resource-management, billing and quota boundary | Resource group |
| Resource group | Lifecycle and management grouping for resources | Network/security boundary by itself |
| Resource | Individual service instance or Azure object | Governance design |

## 4. Design principles

- Organize by governance needs, policy inheritance, platform ownership and workload landing zones—not just by org chart.
- Keep platform capabilities (such as connectivity, identity and management) logically distinct from workload subscriptions where this helps ownership and blast-radius control.
- Assign policies at the highest safe scope, then use carefully governed exceptions. Test effects and compliance before broad rollout.
- Remember that Azure RBAC and Azure Policy are different: RBAC controls who can perform actions; Policy evaluates/enforces resource configuration and compliance.
- Avoid deep, fragile trees and uncontrolled exemptions. Document who approves placement changes.
- Use subscription vending and landing-zone automation to apply repeatable naming, tags, budgets, diagnostic settings and guardrails.

## 5. Common mistakes

- Treating a management group as if it were a subscription.
- Assigning restrictive policy at root without testing impact on platform and recovery operations.
- Assuming management group placement alone provides network isolation.
- Creating branches for every team or project without a clear governance reason.
- Forgetting policy inheritance, exemptions, role scope and operational ownership when moving subscriptions.

## 6. Scenario

An enterprise needs shared connectivity and management capabilities while isolating production and non-production workloads. A possible design places platform subscriptions under a Platform management group and workload subscriptions under Landing zones, then applies baseline policy and RBAC at appropriate scopes. The final hierarchy should be validated against actual ownership, compliance, scale and exception requirements.

## Interview question

**Does a management group replace an Azure subscription?**

**Model answer:** No. It is a higher-level organizational and governance scope above subscriptions. It helps group subscriptions and inherit policy/access governance. A subscription remains a key boundary for billing, quotas and resource management. Resource groups organize resources within a subscription.

## LinkedIn-ready post

Azure governance starts with understanding the hierarchy. Microsoft Entra defines the identity boundary; management groups organize subscriptions and provide governance inheritance; subscriptions remain key billing, quota and resource-management boundaries; resource groups organize resources. The hierarchy should reflect policy and ownership needs—not merely the org chart. #Azure #CloudGovernance #LandingZones

## Official references
- [Management groups](https://learn.microsoft.com/azure/governance/management-groups/overview)
- [Azure landing zones](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Azure Policy](https://learn.microsoft.com/azure/governance/policy/overview)
