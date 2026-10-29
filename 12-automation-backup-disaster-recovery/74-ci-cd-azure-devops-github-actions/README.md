# 74. Azure DevOps Pipelines and GitHub Actions

[← Category 12 checklist](../README.md) · [← Master catalogue](../../README.md)

## Learning checklist
- [ ] Separate pull-request validation from protected deployment
- [ ] Use workload identity federation/OIDC where supported
- [ ] Apply least privilege and environment-scoped permissions
- [ ] Pin actions/tasks and review third-party supply-chain risk
- [ ] Add format, validate, lint, security scans and IaC plan/what-if
- [ ] Protect production with approvals, protected branches and environment checks
- [ ] Store artifacts and deployment evidence; avoid leaking secrets in logs
- [ ] Add post-deployment smoke tests, rollback criteria and alerting

## What it is and where it fits

Azure DevOps Pipelines and GitHub Actions orchestrate CI/CD workflows. Both can validate code and deploy Azure infrastructure and application artifacts. Pick based on repository location, enterprise governance, audit needs, existing toolchain and team expertise; avoid duplicating pipeline engines without a reason.

## Reference pipeline

~~~mermaid
flowchart TD
    PR[Pull request] --> Validate[Format, lint, validate]
    Validate --> Scan[Security and policy scan]
    Scan --> Plan[Terraform plan / ARM what-if]
    Plan --> Review[Review and required checks]
    Review --> Merge[Protected main branch]
    Merge --> Test[Deploy to test]
    Test --> Smoke[Smoke and integration tests]
    Smoke --> Approval[Production approval]
    Approval --> Prod[Deploy production]
    Prod --> Verify[Health checks and evidence]
    Identity[Federated workload identity] --> Test
    Identity --> Prod
~~~

## Security and reliability controls

- Prefer OIDC/workload identity federation over long-lived client secrets where supported.
- Scope federated trust to the intended organization/project/repository/branch or environment; verify subject and audience claims.
- Give validation jobs no production deployment rights.
- Pin third-party GitHub Actions to full commit SHAs where practical and review Azure DevOps task extensions.
- Separate deployment roles by environment and scope. Production approval should not imply broad subscription Owner rights.
- Do not print tokens, secrets, sensitive plan output or state.
- Capture artifact versions, commit SHA, plan/what-if review, approvals, deployment result and smoke-test evidence.

## Implementation checklist

- [ ] Separate validation and deployment stages
- [ ] Prevent competing deployments with concurrency/locking controls
- [ ] Configure protected environments and approvals
- [ ] Use federated identity and minimal Azure roles
- [ ] Add rollback/forward-fix criteria
- [ ] Test failed deployments and expired identity scenarios

## Interview prompt

**How do you design a secure Azure infrastructure pipeline?** Use PR validation, security checks, reviewed plans, protected branches, environment approvals, federated identity, scoped roles, isolated environments, deployment evidence and post-deployment tests. Treat the pipeline identity as a privileged production principal.

## LinkedIn draft

A secure CI/CD pipeline is a control system, not just a deployment button. Validate early, scan changes, review plans, federate identity, scope permissions, gate production, preserve evidence and test the deployed service. #AzureDevOps #GitHubActions #DevSecOps
