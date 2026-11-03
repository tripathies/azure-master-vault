# 12. Business Continuity, Backup & Disaster Recovery

> Protect recoverable data, maintain continuity through major disruptions, and prove that critical workloads can be restored or failed over within business-approved objectives.

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json) · [Architecture map index](../ARCHITECTURE-MAPS.md)

## This category owns recovery — not delivery engineering

- **L — DevOps, IaC, Migration & Hybrid Management** owns Terraform, Bicep, pipelines, migration and Arc.
- **12 — Business Continuity, Backup & Disaster Recovery** owns data protection, recovery architecture, vault security, business recovery objectives and DR exercises.
- Each component has one canonical category and one primary guide. Backup and Site Recovery appear only here.

## Component checklist

- [ ] [Azure Backup & Workload Protection](75-azure-backup/README.md)
- [ ] [Azure Site Recovery & Replication](76-azure-site-recovery-asr/README.md)
- [ ] [Backup Vault Architecture & Security Controls](77-backup-vault-architecture-security/README.md)
- [ ] [Business Continuity & Disaster Recovery Planning](78-bcdr-strategy-rto-rpo/README.md)
- [ ] [Recovery Plans, Failover & DR Testing](79-recovery-plans-failover-testing/README.md)

## Reference recovery lifecycle

~~~mermaid
flowchart TB
  Workload[Business workload and data] --> BIA[Business impact and criticality]
  BIA --> Objectives[Approved RTO / RPO / recovery priority]
  Objectives --> Strategy{Choose protection pattern}
  Strategy --> Backup[Azure Backup: point-in-time restore]
  Strategy --> ASR[Azure Site Recovery: continuous replication]
  Backup --> Vault[Vault architecture and security controls]
  ASR --> Target[Recovery region / target environment]
  Vault --> Exercise[Recovery plan and DR exercise]
  Target --> Exercise
  Exercise --> Evidence[Measured recovery evidence and remediation]
  Evidence --> Review[Review objectives and update design]
~~~

## Five deliberately separate topics

| Topic | Primary question | Boundary |
|---|---|---|
| Azure Backup | What data must be protected and how is it restored? | Backup workload and restore operations |
| Azure Site Recovery | How are supported workloads replicated and brought up at a recovery site? | Replication and failover service |
| Backup Vault Architecture & Security | How are vaults structured and protected from destructive access? | Vault boundary, MUA, immutability, soft delete and access |
| BCDR Planning | What does the business need to recover, and at what cost? | Criticality, risk, RTO/RPO and strategy selection |
| Recovery Plans & DR Testing | How is recovery executed and proven? | Sequencing, test failover, validation, failback and evidence |

## Core architecture principles

1. Define recovery from business impact, not from whichever Azure service is easiest to deploy.
2. Assign RTO and RPO per workload and, where necessary, per critical application flow or data store.
3. Treat high availability, backup and disaster recovery as related but distinct controls.
4. Use backup for point-in-time recovery and retention; use replication/failover when the design requires a recovery environment. Some workloads need both.
5. Design identity, DNS, networking, secrets, certificates, capacity and external dependencies into the recovery path.
6. Protect backup administration separately from production administration. A compromised production admin must not automatically be able to destroy recovery copies.
7. Test restores and failovers regularly, measure achieved RTO/RPO and track corrective actions to closure.

## Important distinctions

- A backup job marked successful does not prove that the application can be restored.
- Replication health does not prove that a multi-tier application starts in the right order or passes business tests.
- A Recovery Services vault and a Backup vault are different vault types with workload-specific support. Select from the current workload support matrix.
- A DR diagram is not evidence. Only measured exercises establish whether recovery objectives are met.

## Official Microsoft guidance

- [Azure Backup overview](https://learn.microsoft.com/en-us/azure/backup/backup-overview)
- [Azure Backup security overview](https://learn.microsoft.com/en-us/azure/backup/security-overview)
- [Azure Site Recovery overview](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview)
- [Business continuity, high availability and disaster recovery](https://learn.microsoft.com/en-us/azure/reliability/concept-business-continuity-high-availability-disaster-recovery)
- [Azure Well-Architected disaster recovery strategies](https://learn.microsoft.com/en-us/azure/well-architected/reliability/disaster-recovery)
