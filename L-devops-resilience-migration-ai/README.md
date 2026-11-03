# L. DevOps, Resilience & Migration

> Delivery automation, infrastructure as code, workload continuity, migration and hybrid management.

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json) · [Architecture map index](../ARCHITECTURE-MAPS.md)

## Component checklist

- [ ] [Terraform](terraform/README.md)
- [ ] [Bicep / ARM Templates](bicep-arm-templates/README.md)
- [ ] [Azure DevOps Pipelines](azure-devops-pipelines/README.md)
- [ ] [GitHub Actions](github-actions/README.md)
- [ ] [Azure Backup](azure-backup/README.md)
- [ ] [Azure Site Recovery](azure-site-recovery/README.md)
- [ ] [Azure Migrate](azure-migrate/README.md)
- [ ] [Azure Arc](azure-arc/README.md)

## Engineering lifecycle

~~~mermaid
flowchart LR
  A[Plan infrastructure] --> B[Terraform / Bicep]
  B --> C[CI validation and security scans]
  C --> D[Approval and deployment]
  D --> E[Operate and monitor]
  E --> F[Backup and recovery]
  E --> G[Migration and hybrid management]
~~~

## Design principles

- Prefer reviewed, reusable infrastructure-as-code with pinned versions and controlled state.
- Use workload identity federation and least privilege in delivery pipelines; avoid long-lived credentials.
- Define RTO and RPO with business owners before selecting backup, replication or failover.
- Discover dependencies, data movement, downtime and rollback before migration.
- Use Azure Arc where hybrid management requirements justify its agent, connectivity and governance footprint.
- Test recovery and migration outcomes at the application level, not only at the infrastructure level.

## Topics

### Terraform
Use modules, remote state with access controls, version pinning, reviewed plans and controlled apply. Terraform state and plan files may contain sensitive information; do not commit them.

### Bicep / ARM templates
Use Bicep for Azure-native declarative deployments, explicit scopes, parameters and reusable modules. Review what-if output and validate API versions and regional support.

### Azure DevOps Pipelines
Use protected branches, PR validation, dependency and secret scanning, environment approvals, workload federation, deployment gates and post-deployment smoke tests.

### GitHub Actions
Use protected environments, least-privilege GitHub tokens, OIDC federation to Azure, reusable workflows and artifact provenance. Treat pipeline identities as production principals.

### Azure Backup
Define protected workload scope, retention, vault security, immutability requirements and restore testing. Backup provides point-in-time recovery; it does not alone provide application failover.

### Azure Site Recovery
Design replication and orchestrated recovery around supported source/target combinations, RTO/RPO, network mapping, DNS, identity dependencies and tested failover/failback.

### Azure Migrate
Discover inventory and dependencies; assess rehost/replatform/refactor/replace/retire; validate target region, quotas, licensing, network and data movement; plan cutover, rollback and business sign-off.

### Azure Arc
Extend supported Azure management capabilities to eligible hybrid and multicloud resources. Define connectivity, agent lifecycle, policy scope, patch ownership and the boundary of operational responsibility.

## Related learning paths

- [M — AI Platform & Engineering](../M-ai-platform-engineering/README.md)
- [12 — Automation, Backup and Disaster Recovery](../12-automation-backup-disaster-recovery/README.md)
- [LittleNest hands-on reference implementation](../littlenest-azure-reference/README.md)

## Official starting points

- [Terraform on Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/)
- [Bicep documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Azure Backup](https://learn.microsoft.com/en-us/azure/backup/backup-overview)
- [Azure Site Recovery](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview)
- [Azure Migrate](https://learn.microsoft.com/en-us/azure/migrate/migrate-services-overview)
- [Azure Arc](https://learn.microsoft.com/en-us/azure/azure-arc/overview)
