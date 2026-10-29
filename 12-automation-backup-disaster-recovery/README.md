# Category 12 — Automation, Backup and Disaster Recovery

[← Master catalogue](../README.md) · [Browse all domains](../catalog.json)

**Purpose:** Design repeatable infrastructure delivery and prove business continuity through governed backup, restore, replication, failover and failback.

## Learning tracker

Tick each item in your GitHub checklist as you complete the guide. Each item opens a dedicated component page in this repository.

- [ ] [72. Terraform — Infrastructure as Code](./72-terraform/README.md)
- [ ] [73. Bicep and ARM Templates](./73-bicep-arm-templates/README.md)
- [ ] [74. Azure DevOps Pipelines and GitHub Actions](./74-ci-cd-azure-devops-github-actions/README.md)
- [ ] [75. Azure Backup](./75-azure-backup/README.md)
- [ ] [76. Azure Site Recovery (ASR)](./76-azure-site-recovery-asr/README.md)
- [ ] [Cross-cutting: Management group and subscription hierarchy](../A-cloud-foundation-landing-zones/management-groups/README.md)

**Numbering note:** Topics 72–75 are retained as supplied. Azure Site Recovery is included as topic 76 because it is a distinct disaster-recovery capability.

## Target reference architecture

~~~mermaid
flowchart TB
    Entra[Microsoft Entra tenant] --> Root[Root management group]
    Root --> Platform[Platform management group]
    Root --> Landing[Landing zones management group]
    Platform --> Identity[Identity subscription]
    Platform --> Connectivity[Connectivity subscription]
    Platform --> Management[Management subscription]
    Landing --> Prod[Production subscription]
    Landing --> NonProd[Non-production subscription]
    Prod --> Workload[Resource groups and Azure resources]
    Pipeline[CI/CD pipeline with workload identity] --> Validate[Validate and plan / what-if]
    Validate --> Deploy[Approved infrastructure deployment]
    Deploy --> Workload
    Workload --> Backup[Azure Backup]
    Workload --> ASR[Azure Site Recovery]
    Backup --> Restore[Restore test and evidence]
    ASR --> Failover[Test / planned / unplanned failover]
~~~

This is a logical reference, not a mandatory subscription layout. Actual hierarchy and recovery design depend on governance, isolation, compliance, RTO/RPO and ownership.

## Solution-architect checklist

- [ ] Management groups provide governance and policy inheritance above subscriptions; they do not replace subscriptions.
- [ ] Separate platform services from workload landing zones when ownership and blast-radius requirements justify it.
- [ ] Use workload identity federation for pipelines where supported; avoid long-lived secrets.
- [ ] Run lint, validation, security checks and Terraform plan / ARM what-if before production deployment.
- [ ] Separate deployment permissions by environment and scope; require production approval.
- [ ] Define RTO/RPO per workload and map each workload to backup and/or replication.
- [ ] Test restores and failovers without disrupting production; record evidence and close gaps.
- [ ] Protect backup, replication, state and recovery credentials from the same administrative blast radius where possible.
- [ ] Monitor pipeline failures, backup jobs, replication health, recovery points and recovery-test results.

## Definition of done

A topic is complete only when its checklist is reviewed, the diagram reflects the design, code/configuration is validated, security and cost are documented, and a repeatable test demonstrates the intended behavior.
