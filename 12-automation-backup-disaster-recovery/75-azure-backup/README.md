# 75. Azure Backup & Workload Protection

[← Category 12](../README.md) · [← Master catalogue](../../README.md)

> **Purpose:** Protect supported Azure and hybrid workloads with policy-driven recovery points, retention and restore operations. This guide owns the Azure Backup service workflow. Vault topology and destructive-operation protection are covered separately in [Backup Vault Architecture & Security Controls](../77-backup-vault-architecture-security/README.md).

## 1. What Azure Backup does

Azure Backup is a managed data-protection service. It schedules and manages backup operations, stores recovery points in supported vault types and provides restore workflows for supported data sources. It is designed for point-in-time recovery and retention—not as a substitute for application high availability or continuous replication.

Official service behavior and workload support can change. Confirm the current [support matrix](https://learn.microsoft.com/en-us/azure/backup/backup-support-matrix) before selecting a design.

## 2. Where it fits

~~~mermaid
flowchart LR
  Source[Azure / hybrid workload] --> Policy[Backup policy]
  Policy --> Job[Scheduled or on-demand backup]
  Job --> Vault[Recovery Services vault or Backup vault]
  Vault --> Points[Recovery points]
  Points --> Restore[Restore to original or alternate target]
  Restore --> Validate[Application and data validation]
  Monitor[Azure Monitor / Backup reports] -. observe .-> Job
~~~

## 3. Select protection by workload

Start with the source data and recovery requirement, then verify the supported Azure Backup workload and vault type.

| Workload pattern | Design questions |
|---|---|
| Azure virtual machines | VM-level recovery, file-level recovery, application consistency, disk exclusions, crash-consistent vs application-consistent recovery points |
| SQL Server / SAP HANA on Azure VMs | Workload-aware backup, log backup requirements, database-level restore, application credentials and consistency |
| Azure Files | Share-level or file-level restore, snapshot/ vault tier choices, retention and change rate |
| AKS, PostgreSQL, Cosmos DB and other supported PaaS workloads | Confirm the correct Backup vault support, extension/backup model, region and feature availability |
| Hybrid servers and protected on-premises workloads | Agent/server requirements, network egress, credential handling, operational ownership and recovery target |

Do not assume every workload uses the same vault type, backup model or restore granularity.

## 4. Design the backup policy

For every protected workload, specify:

- **Schedule and frequency:** Select a backup frequency that can meet the approved RPO. Consider workload write rate, supported schedule granularity and backup windows.
- **Retention:** Define daily, weekly, monthly and yearly retention from legal, business and operational requirements. Avoid retaining everything indefinitely by default.
- **Consistency:** Decide whether crash-consistent or application-consistent recovery points are required and supported.
- **Restore objectives:** Specify the target (same resource, alternate resource, subscription or region as supported), permissions and expected recovery steps.
- **Change and deletion controls:** Treat backup policy changes, stop-protection actions and data deletion as controlled operations.
- **Cost:** Model protected instances, storage consumed, retention duration, redundancy, restore operations and any workload-specific charges.

A configured backup frequency is not proof that the achieved RPO is being met. Monitor job completion, recovery-point age and failures.

## 5. Restore is the proof

A restore test should demonstrate more than a successful portal job:

1. Identify the workload owner and recovery scenario.
2. Select a valid recovery point and target location.
3. Restore to an isolated or alternate target when possible.
4. Validate data integrity, database recovery, application startup and access.
5. Measure elapsed time and compare with the workload RTO.
6. Record the recovery point timestamp and compare data loss with the approved RPO.
7. Capture evidence, gaps and owners; remediate and retest.

Test granular restores as well as full-workload recovery where the business requires both.

## 6. Operational controls

- Monitor backup job status, missed schedules, recovery-point age and protected-item health.
- Alert on critical failures, protection stopped, policy changes and unusual deletion activity.
- Review workload coverage against the approved inventory; an unprotected workload is a governance issue.
- Restrict who can configure protection, change policy, stop protection and initiate restores.
- Keep restore permissions and recovery procedures available during a production identity or network incident.
- Include backup status in workload reviews and business continuity evidence.

Vault-level controls—including soft delete, immutable vaults and Multi-user authorization—are covered in the dedicated [vault security guide](../77-backup-vault-architecture-security/README.md).

## 7. Common design mistakes

- Treating a successful backup job as proof of a successful application recovery.
- Assuming backup replaces zone redundancy, application HA or Site Recovery replication.
- Choosing retention before legal and business requirements are known.
- Ignoring alternate-region restore support, target capacity or data-residency constraints.
- Allowing production administrators unrestricted ability to delete recovery data.
- Never testing a restore or not recording the measured recovery time.

## 8. Interview questions

**Q1. Azure Backup vs Azure Site Recovery?**  
Azure Backup provides protected recovery points and restore/retention workflows. Azure Site Recovery continuously replicates supported workloads and orchestrates failover to a recovery location. They address different failure and recovery needs; a critical workload may need both.

**Q2. How do you prove an Azure Backup design meets its objective?**  
Measure recovery-point age against RPO, run restore tests, validate application integrity and access, measure elapsed recovery time against RTO and retain evidence.

## Official references

- [What is Azure Backup?](https://learn.microsoft.com/en-us/azure/backup/backup-overview)
- [Azure Backup support matrix](https://learn.microsoft.com/en-us/azure/backup/backup-support-matrix)
- [Azure Backup guidance and best practices](https://learn.microsoft.com/en-us/azure/backup/guidance-best-practices)
- [Azure Backup security overview](https://learn.microsoft.com/en-us/azure/backup/security-overview)
- [Azure Backup reliability](https://learn.microsoft.com/en-us/azure/reliability/reliability-backup)
