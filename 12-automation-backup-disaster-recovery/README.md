# 12. Business Continuity, Backup & Disaster Recovery

> Protect critical data, design business continuity, and prove that workloads can be restored or failed over within business-approved objectives.

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json) · [Architecture map index](../ARCHITECTURE-MAPS.md)

![Business continuity, backup and disaster recovery architecture](architecture.svg)

- [Edit recovery architecture in draw.io](architecture.drawio) · [Mermaid source](architecture.mmd)

## Responsibility boundary

**L — DevOps, IaC, Migration & Hybrid Management** owns Terraform, Bicep, CI/CD, Azure Migrate and Azure Arc. This category owns protection and recovery. No component is shared between L and 12.

**M — AI Platform & Engineering** is a separate category. AI workload availability and data recovery should use the same BCDR principles, but AI topics are not duplicated here.

## Component catalogue

### 1. Business Continuity & Disaster Recovery Strategy

Business service continuity, crisis governance and recovery strategy across the enterprise. 

[Open the dedicated component guide](77-business-continuity-disaster-recovery-strategy/README.md)

### 2. Workload Criticality, BIA, RTO & RPO

Business impact analysis, workload criticality, recovery tiers and measurable RTO/RPO. 

[Open the dedicated component guide](78-workload-criticality-bia-rto-rpo/README.md)

### 3. Azure Backup & Workload Protection

Azure Backup service selection, workload protection, backup execution and recovery-point creation. 

[Open the dedicated component guide](75-azure-backup/README.md)

### 4. Backup Policy, Retention & Vault Security

Backup frequency, retention, vault design, soft delete, immutability, MUA and protection governance. 

[Open the dedicated component guide](79-backup-policy-retention-vault-security/README.md)

### 5. Restore Operations & Recovery Testing

Restore scenarios, clean recovery targets, data validation, restore drills and measured recovery time. 

[Open the dedicated component guide](80-restore-operations-recovery-testing/README.md)

### 6. Azure Site Recovery & Replication

Azure Site Recovery source/target design, replication health, recovery location and supported failover workflows. 

[Open the dedicated component guide](76-azure-site-recovery-asr/README.md)

### 7. Recovery Plans, Failover & Failback

Application recovery sequencing, activation decisions, test failover, failback and post-exercise evidence. 

[Open the dedicated component guide](81-recovery-plans-failover-failback/README.md)


## Recovery lifecycle

~~~mermaid
flowchart TB
  BIA[Business impact and criticality] --> Objectives[Approved workload RTO / RPO]
  Objectives --> Strategy[BCDR strategy and recovery pattern]
  Strategy --> Backup[Azure Backup]
  Strategy --> ASR[Azure Site Recovery]
  Backup --> Policy[Backup policy, retention and vault security]
  Policy --> Restore[Restore operations and recovery testing]
  ASR --> Plan[Recovery plans, failover and failback]
  Restore --> Evidence[Measured outcomes and remediation]
  Plan --> Evidence
~~~

## Design principles

1. Set business recovery objectives before choosing Azure services.
2. Use Azure Backup for point-in-time protection and restore; use Site Recovery for supported replication and failover scenarios. A critical workload may require both.
3. Treat vault configuration, retention, soft delete, immutability and MUA as security architecture—not default checkboxes.
4. Design DNS, identity, routes, secrets, certificates, target capacity and external dependencies into the recovery plan.
5. Test restore and failover separately. A successful backup or replication job is not proof that the business service can recover.
6. Measure actual RTO/RPO and assign owners to every failed test.
7. Review recovery plans after meaningful workload, identity, network, region or data changes.

## Official Microsoft references

- [Azure Backup overview](https://learn.microsoft.com/en-us/azure/backup/backup-overview)
- [Azure Backup security overview](https://learn.microsoft.com/en-us/azure/backup/security-overview)
- [Azure Site Recovery overview](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview)
- [Business continuity, high availability and disaster recovery](https://learn.microsoft.com/en-us/azure/reliability/concept-business-continuity-high-availability-disaster-recovery)
- [Azure Well-Architected disaster recovery strategies](https://learn.microsoft.com/en-us/azure/well-architected/reliability/disaster-recovery)
