# 75. Azure Backup

[← Category 12 checklist](../README.md) · [← Master catalogue](../../README.md)

## Learning checklist
- [ ] Map workload type to supported Azure Backup protection
- [ ] Define workload-specific RPO, retention and restore requirements
- [ ] Choose Recovery Services vault or Backup vault based on workload support
- [ ] Apply supported soft delete, immutability and multi-user authorization controls where appropriate
- [ ] Separate backup administration from workload administration where possible
- [ ] Monitor failed jobs, stale recovery points and policy compliance
- [ ] Test restore for the protected workload
- [ ] Document clean-room recovery, dependencies and evidence

## What it is and where it fits

Azure Backup provides managed backup and restore for supported Azure and hybrid workloads. It protects recoverability; it is not a substitute for application-level replication, high availability or a tested disaster recovery plan.

## Reference recovery flow

~~~mermaid
flowchart TB
    Workload[Protected workload] --> Policy[Backup schedule and retention policy]
    Policy --> Vault[Supported Azure Backup vault]
    Vault --> Points[Recovery points]
    Points --> Monitor[Job status, alerts and compliance]
    Points --> Restore[Test restore / alternate target]
    Restore --> Evidence[Validation evidence and runbook update]
~~~

## Architecture and security decisions

- Select the correct vault and supported workload pattern; vault capabilities differ by workload and protection type.
- Align frequency and retention with business RPO, legal retention and recovery objectives.
- Protect the backup control plane from compromise of production subscriptions and identities.
- Evaluate soft delete, immutability, multi-user authorization and cross-region/cross-subscription restore capabilities for the exact workload and region.
- A successful job is not proof that the application can be restored. Test access to the vault, dependencies, DNS, data consistency and business validation.
- Define who may delete backups, change retention, disable protection or authorize destructive operations.

## Recovery runbook checklist

- [ ] Declare incident and select recovery point
- [ ] Confirm blast radius and clean target environment
- [ ] Verify vault access, approvals and key dependencies
- [ ] Restore to an isolated or alternate target where possible
- [ ] Validate data integrity and application behavior
- [ ] Reconnect dependencies only after security checks
- [ ] Record RTO achieved, observed data loss/RPO and follow-up actions

## Metrics to track

- Protected asset coverage and policy compliance
- Backup job success rate and age of last usable recovery point
- Restore-test pass rate and measured restore duration
- Backup storage growth and retention cost
- Time to detect and remediate protection gaps

## Interview prompt

**Why is backup-job success insufficient?** It only proves the job reported success. Recoverability requires a usable recovery point, vault access, dependencies, a clean target, data/application validation and a tested runbook. Measure restore success and achieved RTO/RPO too.

## LinkedIn draft

Backups are a promise that must be tested. Define RPO and retention per workload, isolate backup administration, alert on protection gaps and regularly restore into a safe target. A successful job is not the same as a recoverable business service. #AzureBackup #BusinessContinuity #CloudSecurity

## Official reference
- [Azure Backup documentation](https://learn.microsoft.com/azure/backup/)
