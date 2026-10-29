# 72. Terraform — Infrastructure as Code

[← Category 12 checklist](../README.md) · [← Master catalogue](../../README.md)

## Learning checklist
- [ ] Explain providers, resources, data sources, modules, variables, outputs and dependency graph
- [ ] Define state ownership, locking, encryption, access and recovery
- [ ] Separate reusable modules from environment-specific root modules
- [ ] Pin Terraform/provider versions and commit the lock file
- [ ] Use remote state with restricted access and locking support
- [ ] Add plan review, policy/security scans and approval gates
- [ ] Handle drift, imports, refactors and state moves safely
- [ ] Demonstrate non-production deployment and cleanup

## What it is and where it fits

Terraform is a declarative Infrastructure as Code tool. Configuration describes desired resources; Terraform compares configuration, state and provider observations to propose changes. It is useful for repeatable multi-environment infrastructure and modular platform engineering.

## Reference delivery flow

~~~mermaid
flowchart LR
    Code[Git repository] --> Format[Format and validate]
    Format --> Scan[Security and policy scans]
    Scan --> Plan[Plan with remote state]
    Plan --> Review[Pull request review / approval]
    Review --> Apply[Apply approved plan]
    Apply --> Verify[Smoke tests and drift monitoring]
    State[(Protected remote state)] <--> Plan
    State <--> Apply
~~~

## Production design decisions

- **State:** use a supported remote backend, restrict access, enable locking where supported, protect state contents and define recovery. State can contain sensitive values even when output is marked sensitive.
- **Identity:** use federated identity/OIDC from CI where supported; avoid long-lived service-principal secrets.
- **Environments:** isolate state and permissions by environment/workload according to blast-radius and team boundaries.
- **Modules:** use versioned modules with explicit inputs/outputs; avoid over-generalized modules and hidden defaults.
- **Change control:** plan is a proposal, not proof of safety. Review destructive replacements, address changes, RBAC scope and data-loss implications.
- **Drift:** decide whether configuration or observed state is authoritative; do not blindly apply plans after manual production changes.
- **Secrets:** never commit state files, credentials, secret variable files or generated plans containing sensitive data.

## Starter files

- [Architecture diagram](./architecture.mmd)
- [Terraform sample](./infra/main.tf)
- [Variables](./infra/variables.tf)
- [Example non-secret values](./infra/terraform.tfvars.example)

The sample intentionally creates a resource group only. Extend it with reviewed modules for the workload rather than copying a monolithic template.

## Validation

~~~bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
terraform plan -var-file=terraform.tfvars
~~~

For production, configure the intended backend before planning. Review the plan and cost/security impacts before apply. Clean up only resources explicitly approved for deletion.

## Interview prompt

**How do you prevent unsafe production changes?** Use isolated state and least-privilege identities, pinned versions, automated format/validate/security checks, reviewed plans, environment approvals, protected branches, drift handling and tested recovery. Pay special attention to replacement of stateful resources.

## LinkedIn draft

Infrastructure as Code is more than turning clicks into files. Production discipline means remote-state protection, least privilege, reviewed plans, pinned providers, reusable modules, drift management and safe environment promotion. A good pipeline makes the intended change understandable before it makes the change. #Terraform #Azure #DevOps #PlatformEngineering

## Official references
- [Terraform on Azure](https://learn.microsoft.com/azure/developer/terraform/)
- [Terraform language](https://developer.hashicorp.com/terraform/language)
