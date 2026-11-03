# 78. Business Continuity & Disaster Recovery Planning

[← Category 12](../README.md) · [← Master catalogue](../../README.md)

> **Purpose:** Translate business impact and risk into workload-specific continuity, high-availability and disaster-recovery requirements. This guide owns the strategy and objectives—not Azure Backup configuration or Site Recovery deployment steps.

## 1. Start with business impact

Run a Business Impact Analysis (BIA) with business service owners. For each workload and critical user flow, capture:

- Business service, owner, users, operating hours and upstream/downstream dependencies.
- Financial, customer, safety, legal, regulatory and reputational impact of interruption.
- Maximum tolerable outage (MTO) or business tolerance window.
- Acceptable data loss, transaction loss and data consistency requirements.
- Recovery sequence, manual workaround, minimum viable service and communication needs.
- Recovery budget and the cost of standby capacity, replication, backup and testing.

Do not assign recovery objectives based only on technical preference.

## 2. Define recovery objectives

| Objective | Meaning | Architect's use |
|---|---|---|
| RTO — Recovery Time Objective | Maximum acceptable time to restore the defined service after disruption | Drives recovery automation, standby capacity, sequencing and validation |
| RPO — Recovery Point Objective | Maximum acceptable data loss measured as time | Drives backup frequency, replication mode and data consistency design |
| MTO — Maximum Tolerable Outage | Business limit beyond which impact becomes unacceptable | Sets the outer boundary for recovery planning |
| RLO — Recovery Level Objective | Minimum service capability that must be restored | Defines whether a partial/degraded service is acceptable |

Define what starts and stops the RTO clock. For example, infrastructure powered on is not the same as users completing a successful business transaction.

## 3. Classify workloads

Use organization-defined tiers such as mission-critical, business-critical, business-operational and administrative. Assign each workload with business stakeholders; avoid treating these as fixed Microsoft-prescribed RTO/RPO values.

For each tier, record:
- Business impact and risk tolerance.
- Required RTO/RPO per application flow or data store.
- Recovery order and minimum viable function.
- Data residency and region restrictions.
- Required identity, DNS, network, certificates and third-party dependencies.
- Approver for disaster declaration and service restoration.

## 4. Choose the right resilience pattern

| Pattern | Typical posture | Trade-off |
|---|---|---|
| Active-active | Multiple active deployments serve traffic | Fast continuity, complex consistency and higher operating cost |
| Warm standby | A reduced but running recovery environment | Faster recovery than cold standby, ongoing capacity cost |
| Cold standby / pilot light | Core recovery components prepared; most capacity starts during recovery | Lower idle cost, slower recovery and more orchestration |
| Backup and restore | Recover data/resources from retained recovery points | Lowest standby burden, but restore time and data loss depend on backup design |
| Native service DR | Use a service's native zone/geo-replication and recovery controls | Must verify service-specific behavior, support and failover model |

Choose at the workload-flow level. A single application can combine zone redundancy, database-native recovery, backup, Site Recovery and traffic failover.

## 5. Match risk to control

- Transient component failures generally need application resilience and high availability.
- Zone failure may require zonal redundancy or zone-to-zone recovery for supported services.
- Regional outage may require cross-region design, replication, restore or traffic failover.
- Data corruption or ransomware may require isolated, immutable or protected backup recovery points.
- Identity, DNS, secrets, network, certificates and external provider outages need explicit contingency plans.

Backup and replication are complementary, not interchangeable. Replication can carry corruption forward; backup restoration may take longer than a failover.

## 6. Build the BCDR decision record

For every critical workload, record:

1. Business owner and service criticality.
2. RTO, RPO, MTO and minimum viable recovery level.
3. Failure scenarios and declared-disaster thresholds.
4. Selected high-availability, backup and DR patterns.
5. Target region/site, data residency and service support assumptions.
6. Dependencies, capacity, identity and network arrangements.
7. Recovery sequence, decision authority and communication plan.
8. Cost estimate, risk acceptance and exceptions.
9. Test schedule, success criteria, evidence and remediation owner.

## 7. Review and governance

Review objectives when the business process, data classification, architecture, service region, dependency map or regulatory requirement changes. Do not leave recovery targets buried in an implementation document; obtain explicit business sign-off.

## Official references

- [Business continuity, high availability and disaster recovery](https://learn.microsoft.com/en-us/azure/reliability/concept-business-continuity-high-availability-disaster-recovery)
- [Azure Well-Architected disaster recovery strategies](https://learn.microsoft.com/en-us/azure/well-architected/reliability/disaster-recovery)
- [Develop a disaster recovery plan for multi-region deployments](https://learn.microsoft.com/en-us/azure/well-architected/design-guides/disaster-recovery)
- [Cloud Adoption Framework — BCDR](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-business-continuity-disaster-recovery)
