# 77. Backup Vault Architecture & Security Controls

[← Category 12](../README.md) · [← Master catalogue](../../README.md)

> **Purpose:** Design the vault boundary, access model and anti-tampering controls that protect recovery data from accidental or malicious destruction. This guide owns vault architecture—not backup schedules or the wider business DR strategy.

## 1. Vault types are not interchangeable

Azure Backup uses two principal vault types:

| Vault type | Typical workload families | Design action |
|---|---|---|
| Recovery Services vault | Azure VMs, SQL Server/SAP HANA on Azure VMs, Azure Files and supported hybrid/server-agent scenarios | Confirm exact source and feature support |
| Backup vault | Selected newer PaaS/data-source backup scenarios such as supported AKS, PostgreSQL and Cosmos DB patterns | Confirm workload-specific support and region availability |

The supported workload matrix is the authority. Do not choose a vault based only on the service name or a prior project.

## 2. Vault placement and isolation

Design vault boundaries based on:

- **Region and data residency:** Confirm vault region requirements for each source workload and any cross-region recovery capability.
- **Workload family:** Separate workload classes when their access, retention, recovery owners or security boundaries differ.
- **Environment:** Consider production and non-production separation to reduce accidental or malicious blast radius.
- **Business ownership:** Separate vaults where business units need independent RBAC, recovery operations, reporting or chargeback.
- **Lifecycle:** Keep vault configuration, policy changes, resource locks and deletion processes under controlled change management.

Do not create a vault per resource by default. Balance isolation with operational complexity and service limits.

## 3. Security layers

### Identity and access
- Assign narrow Azure RBAC roles for backup operators, restore operators, security approvers and auditors.
- Separate production workload administration from backup administration.
- Avoid granting the same principal both day-to-day vault control and independent approval authority for destructive operations.
- Monitor role changes, vault configuration changes, stop-protection and delete actions.

### Soft delete
Soft delete helps retain backup data after deletion attempts. Verify the current default, enhanced options, workload support and retention behavior for the selected vault and scenario.

### Immutable vaults
Azure Backup immutable vaults can block operations that would cause loss of recovery points. A vault can be configured in an enabled state and, where supported, locked to make immutability irreversible. **Locking is a consequential, irreversible decision.** Validate retention, restore, legal hold, supported workload and region requirements before locking.

### Multi-user authorization (MUA) and Resource Guard
MUA adds a separate authorization layer for critical vault operations. Resource Guard should be governed independently from the backup administrator where separation of duties is required. MUA and immutability address different risks; consider them together for critical backup data.

### Network and encryption
Use supported private connectivity, firewall and identity controls where required by the workload and vault type. Confirm feature availability for the exact backup scenario. Document encryption, key ownership and recovery access; do not design key controls that make recovery impossible during an incident.

## 4. Security design pattern

~~~mermaid
flowchart TB
  Workload[Protected workload] --> Backup[Azure Backup service]
  Backup --> Vault[Recovery Services vault / Backup vault]
  BackupAdmin[Backup operator] --> RBAC[Least-privilege RBAC]
  RBAC --> Vault
  Destructive[Critical delete / retention operation] --> MUA[Resource Guard / MUA approval]
  MUA --> Vault
  Immutable[Immutable vault / soft delete] -. protect recovery points .-> Vault
  Audit[Azure Monitor / activity logs / alerts] -. observe .-> Vault
  RestoreAdmin[Separate restore operator] --> Vault
~~~

## 5. Governance checklist

- [ ] Map each data source to the correct supported vault type.
- [ ] Document region, residency and cross-region recovery constraints.
- [ ] Separate vault permissions from production workload administration.
- [ ] Implement soft delete and evaluate immutable vault settings.
- [ ] Evaluate MUA with independently governed Resource Guard.
- [ ] Define vault owners, backup operators, restore operators and approvers.
- [ ] Alert on protection removal, policy changes, destructive actions and role changes.
- [ ] Test restore with the actual incident-time identities and access paths.
- [ ] Review service-specific feature, region and workload support before rollout.

## 6. Common mistakes

- Assuming all Azure Backup workloads use Recovery Services vaults.
- Treating RBAC alone as sufficient separation of duties.
- Locking immutability before validating the operational and legal impact.
- Placing every workload into one vault without considering blast radius and ownership.
- Forgetting that recovery operators need access during a tenant, network or production incident.
- Assuming private endpoint support is identical across all vault and workload types.

## Official references

- [Azure Backup security overview](https://learn.microsoft.com/en-us/azure/backup/security-overview)
- [Immutable vault concept](https://learn.microsoft.com/en-us/azure/backup/backup-azure-immutable-vault-concept)
- [Secure your Azure Backup deployment](https://learn.microsoft.com/en-us/azure/backup/secure-backup)
- [Recovery Services vault overview](https://learn.microsoft.com/en-us/azure/backup/backup-azure-recovery-services-vault-overview)
- [Azure Backup support matrix](https://learn.microsoft.com/en-us/azure/backup/backup-support-matrix)
- [Multi-user authorization quickstart](https://learn.microsoft.com/en-us/azure/backup/enable-multi-user-authorization-quickstart)
