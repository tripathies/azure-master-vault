# L. DevOps, IaC, Migration & Hybrid Management

> Build, validate and deliver infrastructure safely; move workloads; govern eligible hybrid resources.

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
  A[Plan platform changes] --> B[Terraform / Bicep]
  B --> C[CI validation and security scans]
  C --> D[Review / approval]
  D --> E[Deploy through protected pipeline]
  E --> F[Verify / monitor / manage drift]
  G[Discover existing estate] --> H[Assess and migrate]
  H --> I[Operate eligible hybrid resources with Arc]
~~~

## Clear ownership boundaries

| Capability | This category owns | Separate category |
|---|---|---|
| Terraform, Bicep / ARM | Infrastructure as Code authoring, state, modules, plans and deployments | — |
| Azure DevOps, GitHub Actions | CI/CD, workload federation, approvals and release evidence | — |
| Azure Migrate | Discovery, assessment, migration waves and cutover planning | — |
| Azure Arc | Hybrid resource projection, governance and supported management | — |
| Backup and restore | Not owned here | [12 — Business Continuity, Backup & Disaster Recovery](../12-automation-backup-disaster-recovery/README.md) |
| Regional replication and failover | Not owned here | [12 — Business Continuity, Backup & Disaster Recovery](../12-automation-backup-disaster-recovery/README.md) |

## Design principles

- Pin tool/provider versions and protect remote state; state and plan files can contain sensitive data.
- Review Terraform plans or ARM what-if output before deployment; approval does not replace least privilege.
- Prefer workload identity federation over long-lived pipeline secrets where supported.
- Separate validation permissions from production deployment permissions.
- Use protected branches/environments, artifact provenance, dependency scanning and post-deployment verification.
- For migration, discover dependencies, assess data movement and downtime, agree rollback and obtain business sign-off before source decommission.
- Use Azure Arc only for supported resource types and define agent/connectivity and operational ownership.

## Related categories

- [12 — Business Continuity, Backup & Disaster Recovery](../12-automation-backup-disaster-recovery/README.md)
- [A — Cloud Foundation & Landing Zones](../A-cloud-foundation-landing-zones/README.md)
- [J — Security, Secrets & Governance](../J-security-secrets-governance/README.md)
- [K — Monitoring, Operations & Cost](../K-monitoring-operations-cost/README.md)
