# K. Monitoring, Operations & Cost

**[Component architecture map](architecture.mmd)** — arrows show a typical dependency/learning flow, not a mandatory deployment order.


[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json)

Operations means detect impact, diagnose causes, recover safely and improve from evidence. Cost management belongs in the same operating model.

## Checklist
- [ ] Distinguish metrics, logs, traces and activity/audit logs
- [ ] Design Azure Monitor, Log Analytics and retention
- [ ] Instrument applications with Application Insights
- [ ] Create actionable alerts and action groups
- [ ] Use Service Health vs Resource Health correctly
- [ ] Set budgets, cost allocation and Advisor reviews
- [ ] Automate operations and patch management safely
- [ ] Use Resource Graph for inventory and governance queries

~~~mermaid
flowchart LR
    Workload[Workload and resources] --> Telemetry[Metrics / logs / traces]
    Telemetry --> Monitor[Azure Monitor]
    Monitor --> Alerts[Alert rules / action groups]
    Alerts --> OnCall[On-call and incident workflow]
    OnCall --> Runbook[Runbook / remediation]
    Runbook --> Verify[Recovery and health verification]
    Costs[Usage and billing] --> Cost[Cost Management / Advisor]
    Verify --> Improve[Post-incident improvement]
    Cost --> Improve
~~~

## K1. Azure Monitor
Monitoring platform for supported metrics, logs, alerts and diagnostics. Define service-level indicators, enable only required diagnostic categories, choose workspace/retention, protect sensitive telemetry, create dashboards and actionable alerts, and verify telemetry before production.

## K2. Log Analytics Workspace and KQL
Workspace design affects access boundaries, retention, ingestion and cost. Use workspace/table permissions where supported, data collection rules and intentional retention.

Example KQL (table availability depends on enabled sources):
~~~kusto
AzureActivity
| where TimeGenerated > ago(24h)
| summarize Events=count() by Caller, OperationNameValue
| top 20 by Events desc
~~~
~~~kusto
Heartbeat
| where TimeGenerated > ago(1h)
| summarize LastSeen=max(TimeGenerated) by Computer
| where LastSeen < ago(15m)
~~~
Monitor ingestion volume and schema changes; protect sensitive fields and version saved queries.

## K3. Application Insights
Application performance monitoring for requests, dependencies, exceptions and traces. Instrument important user journeys, correlate distributed traces, sample appropriately, avoid capturing secrets/personal data, alert on user-impacting symptoms and monitor telemetry cost.

## K4. Azure Monitor alerts and action groups
Alert rules evaluate supported metrics/logs/activity signals; action groups route notifications or actions. Define severity, owner, threshold, evaluation window, missing-data behavior, runbook and escalation. Test notification delivery and remediation; tune duplicates and noise.

## K5. Service Health and Resource Health
Service Health reports Azure service incidents, planned maintenance and advisories relevant to selected services/regions/subscriptions. Resource Health reports health status for an individual supported resource. Use both to distinguish platform events from workload-level failures.

## K6. Cost Management
Analyze usage/cost, forecasts, budgets and exports. Budget alerts generally notify; do not assume they automatically stop resources. Apply ownership/tags, anomaly alerts, cost exports, eligible reservation/savings reviews, idle resource cleanup and data/egress/logging cost reviews. Optimize within reliability and performance objectives.

## K7. Azure Advisor
Provides supported recommendations across cost, reliability, security, performance and operations. Assign owners/due dates, prioritize by impact/effort, document exceptions and validate recommendations against workload constraints before implementation.

## K8. Azure Automation
Automates runbooks and repeatable operations. Use managed identity where supported, least privilege, idempotency, retries, structured logs and non-production testing. Add approval gates for destructive actions and alert on failed jobs or runtime/module changes.

## K9. Azure Update Manager
Coordinates update management for supported Azure and connected machines. Define patch rings, maintenance windows, reboot policies and compliance reporting. Validate app/cluster drain behavior, dependencies and recovery assumptions; test patch failure scenarios.

## K10. Azure Resource Graph
Queries indexed Azure resource metadata at scale for inventory, change impact and governance. It is not a substitute for live application telemetry.

Example:
~~~kusto
Resources
| where type =~ 'microsoft.compute/virtualmachines'
| project name, resourceGroup, subscriptionId, location
| order by subscriptionId asc, resourceGroup asc
~~~
Use least-privilege read access and automate reports for missing tags, public exposure and policy gaps.

## Enterprise scenario
An API emits request/dependency telemetry to Application Insights; Azure Monitor tracks platform metrics and Log Analytics stores selected diagnostics. Alerts on error rate, latency and dependency health route to on-call with runbooks. Service Health adds platform context; Resource Graph reports inventory gaps; Advisor recommendations are triaged; Cost Management exports and budgets track spend; Update Manager applies approved patch rings.

## Common mistakes
- Collecting all logs without privacy, retention and cost design.
- Alerting on every metric with no owner or action.
- Confusing Service Health and Resource Health.
- Assuming budgets shut down resources automatically.
- Applying Advisor recommendations without context.
- Running privileged automation with static secrets or broad roles.

## Interview questions
**Metrics vs logs vs traces?** Metrics are numeric time series; logs are event records; traces show request/dependency paths. Combine them to diagnose impact and cause.

**How do you reduce alert fatigue?** Alert on user impact and actionable leading indicators; assign owners/runbooks; tune thresholds and deduplicate; review alert quality after incidents.

## LinkedIn-ready post
Observability is not collecting every log. It is measuring user impact, connecting metrics/logs/traces, alerting the right owner, following a runbook and learning from incidents. Combine operational signals with cost ownership and make every alert actionable. #AzureMonitor #SRE #FinOps

## Official references
- [Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/overview)
- [Log Analytics](https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-overview)
- [Application Insights](https://learn.microsoft.com/azure/azure-monitor/app/app-insights-overview)
- [Cost Management](https://learn.microsoft.com/azure/cost-management-billing/costs/overview-cost-management)
- [Azure Resource Graph](https://learn.microsoft.com/azure/governance/resource-graph/overview)

## Component dependency flow

The diagram includes every component in this catalog and shows a typical progression plus cross-cutting controls.

~~~mermaid
flowchart LR
  subgraph CATK["K · Monitoring Operations and Cost"]
    n1["Azure Monitor"]
    n2["Log Analytics Workspace and KQL"]
    n1 --> n2
    n3["Application Insights"]
    n2 --> n3
    n4["Azure Monitor Alerts and Action Groups"]
    n3 --> n4
    n5["Service Health and Resource Health"]
    n4 --> n5
    n6["Cost Management"]
    n5 --> n6
    n7["Azure Advisor"]
    n6 --> n7
    n8["Azure Automation"]
    n7 --> n8
    n9["Azure Update Manager"]
    n8 --> n9
    n10["Azure Resource Graph"]
    n9 --> n10
  end
  Identity[Entra ID / RBAC] -. cross-cutting .-> n1
  Network[Network / DNS / private access] -. cross-cutting .-> n5
  Operations[Monitor / logs / cost] -. cross-cutting .-> n10
~~~
