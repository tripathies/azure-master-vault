# 76. Azure Site Recovery (ASR)

[← Category 12 checklist](../README.md) · [← Master catalogue](../../README.md)

## Learning checklist
- [ ] Define workload-tier RTO and RPO with business owners
- [ ] Confirm supported source, target, region pair and replication prerequisites
- [ ] Plan network mapping, IP addressing, DNS, identity and application dependencies
- [ ] Configure recovery plans and ordered application tiers
- [ ] Run test failover in an isolated network and record evidence
- [ ] Define planned failover, unplanned failover and failback runbooks
- [ ] Monitor replication health, recovery points, capacity and configuration drift
- [ ] Schedule exercises and update dependencies after significant changes

## What it is and where it fits

Azure Site Recovery orchestrates replication and recovery for supported workloads between supported source and target locations. It is a disaster recovery capability, not a backup substitute. Backup provides point-in-time restore and retention; ASR focuses on bringing workloads up in a recovery location. Mature designs often use both when requirements call for both.

## Reference DR flow

~~~mermaid
flowchart LR
    Primary[Primary workload] --> Replication[Replication]
    Replication --> Recovery[Recovery region or target]
    Recovery --> Test[Test failover in isolated network]
    Test --> Evidence[Application validation and evidence]
    Primary --> Incident{Disaster declared?}
    Incident -->|No| Primary
    Incident -->|Yes| Failover[Failover and recovery plan]
    Failover --> Validate[DNS, identity, dependencies and smoke tests]
    Validate --> Business[Business service restored]
    Business --> Failback[Failback / reprotect plan]
~~~

## Design decisions

- Define RTO and RPO per application tier, not one enterprise-wide number.
- Validate exact source/target support, region availability, networking and capacity against current documentation.
- Map subnets, IP ranges, NSGs, routes, private endpoints, DNS, identity, certificates, secrets and external dependencies.
- Use recovery plans to sequence multi-tier workloads; orchestration does not automatically guarantee application consistency.
- Test failover without touching production, using an isolated network and business-level acceptance criteria.
- Distinguish planned failover, unplanned failover, reprotect and failback. Assign a decision owner and communication protocol.
- Monitor replication health and lag; replication without operational response can leave a recovery gap unnoticed.

## DR exercise checklist

- [ ] Confirm business owner, scope and success criteria
- [ ] Verify last recovery point and replication health
- [ ] Confirm recovery-region quotas, capacity, network and access
- [ ] Execute test failover in isolation
- [ ] Validate authentication, application dependencies, data and user access
- [ ] Measure achieved RTO and observed data loss against RPO
- [ ] Test failback/reprotect assumptions where safe and supported
- [ ] Record evidence, gaps, owners and due dates

## Interview prompt

**How do you prove a DR design meets RTO/RPO?** Run scoped failover exercises; measure time from declaration to validated business service; measure recovery-point data loss; test dependencies and DNS/identity; compare results with objectives; and track remediation. A diagram alone does not prove recoverability.

## LinkedIn draft

Disaster recovery is an operating capability, not a checkbox. Set RTO/RPO by workload, map identity/DNS/network dependencies, test failover in isolation, measure recovery time and data loss, and rehearse failback. #AzureSiteRecovery #DisasterRecovery #Resilience

## Official reference
- [Azure Site Recovery documentation](https://learn.microsoft.com/azure/site-recovery/)
