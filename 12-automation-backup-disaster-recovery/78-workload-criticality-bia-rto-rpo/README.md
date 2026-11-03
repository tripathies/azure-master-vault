# Workload Criticality, BIA, RTO & RPO

[← 12. Business Continuity, Backup & Disaster Recovery](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Determine how much disruption a business service can tolerate and convert that tolerance into measurable technical recovery objectives. RTO and RPO must be business-approved and validated through exercises.

## Where this topic fits

This is a distinct business-continuity/recovery capability. It complements Azure Backup and Azure Site Recovery but does not replace those service guides. Use it to define requirements, controls or operating procedures that span multiple Azure services and business teams.

## Architecture and design detail

### Business impact analysis

Identify business processes, customer obligations, financial/regulatory impact, peak periods, tolerable outage, data loss impact and manual workarounds. Identify maximum tolerable downtime and dependencies that can block recovery.

### Criticality and tiering

Group workloads by business impact and dependency. A tier should drive recovery sequence, support hours, protection level, testing frequency and budget; it should not be assigned solely from infrastructure size or team preference.

### RTO and RPO

RTO is the target time to restore an agreed level of service. RPO is the target maximum data loss measured in time. Define them per workload and data set, including consistency requirements and the point at which service is considered restored.

### Dependency and sequencing

Map identity, DNS, network, key management, data platforms, integration endpoints and external providers. Recovery order must follow dependency readiness; recovering a web tier before its identity or database dependency may not restore the business service.

### Feasibility and cost

Compare the target with the capabilities and limits of the selected backup, replication, database, platform and region design. Quantify standby capacity, replicated storage, backup retention, network, licensing, operator effort and exercise costs.

## Implementation and review checklist

- [ ] Business impact and maximum tolerable downtime recorded
- [ ] RTO and RPO approved for each workload and data store
- [ ] Dependencies and recovery sequence documented
- [ ] Technical solution shown to meet targets in a test
- [ ] Cost and residual risk accepted
- [ ] Objectives reviewed after material change

## Example enterprise scenario

A customer-facing platform has a primary Azure region and an approved recovery region. The business owner defines service criticality and recovery objectives. Platform teams map identity, networking, data and application dependencies; the backup team proves clean restores; the DR team tests ordered failover and failback. The service is declared recovered only after user-facing transactions and data integrity are validated.

## Interview prompts

**What is the difference between a recovery capability and a recovery outcome?**  
A configured vault, replication job or recovery plan is only a capability. The outcome is a validated business service restored within the approved time and data-loss objectives.

**How do you avoid a false sense of DR readiness?**  
Exercise dependencies, permissions, clean targets, DNS, data integrity, recovery sequencing, failback and business acceptance. Record measured results, not just configuration status.

## Official Microsoft references

- [Microsoft Learn 1](https://learn.microsoft.com/en-us/azure/well-architected/reliability/)
