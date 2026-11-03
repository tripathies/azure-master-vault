# L. DevOps, IaC, Migration & Hybrid Management

> Build, release, migrate and manage Azure infrastructure and workloads. This category owns the engineering lifecycle; it does **not** own backup policy or disaster-recovery design.

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json) · [Architecture map index](../ARCHITECTURE-MAPS.md)

## Component checklist

- [ ] [Terraform](terraform/README.md)
- [ ] [Bicep / ARM Templates](bicep-arm-templates/README.md)
- [ ] [Azure DevOps Pipelines](azure-devops-pipelines/README.md)
- [ ] [GitHub Actions](github-actions/README.md)
- [ ] [Azure Migrate](azure-migrate/README.md)
- [ ] [Azure Arc](azure-arc/README.md)

## Engineering lifecycle

~~~mermaid
flowchart LR
  Plan[Design and plan] --> IaC[Terraform or Bicep]
  IaC --> PR[Pull request and validation]
  PR --> Scan[Security, policy and quality checks]
  Scan --> Approve[Approval and release gates]
  Approve --> Deploy[Deploy infrastructure and application]
  Deploy --> Observe[Verify, monitor and manage drift]
  Estate[Existing on-premises / multicloud estate] --> Migrate[Azure Migrate assessment and migration]
  Estate --> Arc[Azure Arc hybrid management]
  Migrate --> Landing[Azure landing zone / target workload]
  Arc --> Govern[Azure governance and operations]
~~~

## Dedicated responsibility by topic

| Topic | Owns | Does not own |
|---|---|---|
| Terraform | Provider-based IaC, modules, state, plan/apply, drift | Backup retention or DR runbooks |
| Bicep / ARM | Azure-native templates, deployment scopes, modules, what-if | CI/CD orchestration itself |
| Azure DevOps Pipelines | Pipeline stages, artifacts, approvals, deployment evidence | IaC language or backup policy |
| GitHub Actions | Workflow orchestration, OIDC federation, protected environments | Azure resource definitions themselves |
| Azure Migrate | Discovery, assessment, dependency mapping, migration waves and cutover | Ongoing hybrid governance after migration |
| Azure Arc | Hybrid resource onboarding, connected management, policy and inventory | Workload migration or backup by itself |

## Design principles

- Separate source control, pipeline orchestration, IaC definitions and runtime configuration.
- Use workload identity federation/OIDC, least privilege, protected environments and reviewed changes.
- Keep Terraform state and deployment artifacts protected; never commit secrets or sensitive plans.
- Make Bicep deployment scope explicit and review what-if output before deployment.
- Discover workload dependencies and migration readiness before creating migration waves.
- Use Azure Arc only where hybrid control-plane management provides value; define agent, connectivity and ownership boundaries.
- Validate the destination workload after migration; a completed move does not prove the application is healthy.

## Migration and hybrid decision path

1. **Discover:** inventory servers, applications, databases, dependencies, licensing and owners.
2. **Assess:** select rehost, replatform, refactor, replace or retire; estimate target capacity and cost.
3. **Plan:** group dependencies into migration waves; define downtime, rollback, DNS and identity changes.
4. **Migrate:** execute a pilot, validate data and transactions, then progress in controlled waves.
5. **Operate:** onboard eligible hybrid resources to Arc where useful; apply policy, inventory and monitoring standards.
6. **Optimize:** right-size, modernize and decommission source systems only after formal acceptance.

## Scope boundary

- **Backup, recovery vaults, RTO/RPO and DR testing:** [Category 12 — Business Continuity, Backup & Disaster Recovery](../12-automation-backup-disaster-recovery/README.md).
- **AI services and model engineering:** [M — AI Platform & Engineering](../M-ai-platform-engineering/README.md).
- **Azure platform foundation:** [A — Cloud Foundation & Landing Zones](../A-cloud-foundation-landing-zones/README.md).

## Official starting points

- [Terraform on Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/)
- [Bicep documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Azure DevOps Pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/)
- [GitHub Actions documentation](https://docs.github.com/en/actions)
- [Azure Migrate](https://learn.microsoft.com/en-us/azure/migrate/migrate-services-overview)
- [Azure Arc overview](https://learn.microsoft.com/en-us/azure/azure-arc/overview)
