# 73. Bicep and ARM Templates

[← Category 12 checklist](../README.md) · [← Master catalogue](../../README.md)

## Learning checklist
- [ ] Explain ARM deployment and Bicep compilation
- [ ] Choose resource-group, subscription, management-group or tenant scope correctly
- [ ] Parameterize names, locations, SKUs, tags and environment differences
- [ ] Use modules, outputs, conditions, loops and dependency inference
- [ ] Validate with Bicep build/lint and ARM what-if
- [ ] Protect deployment identities and avoid secret literals
- [ ] Understand incremental deployment and deletion implications
- [ ] Test rollback/recovery assumptions for stateful resources

## What it is and where it fits

Azure Resource Manager is Azure's deployment and management control plane. ARM templates are JSON declarations; Bicep is a higher-level language that compiles to ARM templates. Bicep is a strong authoring choice for Azure-native workflows; ARM JSON remains useful when generated or required by tooling.

## Reference deployment flow

~~~mermaid
flowchart LR
    Source[Version-controlled Bicep] --> Lint[Build and lint]
    Lint --> Validate[Validate deployment]
    Validate --> WhatIf[ARM what-if]
    WhatIf --> Approval[Review changes]
    Approval --> Deploy[ARM deployment]
    Deploy --> Verify[Resource and policy checks]
~~~

## Design guidance

- Make deployment scope explicit; a resource-group template cannot perform every subscription or management-group operation.
- Keep parameters non-secret and environment-specific values separate from reusable modules.
- Use modules for clear boundaries, not simply to fragment every resource.
- Prefer managed identity and secure parameter passing; do not store credentials in templates or outputs.
- Understand incremental mode: resources omitted from a template are not generally deleted just because omitted. Complete mode and deployment-stack behavior have separate semantics and should be chosen deliberately.
- Use what-if as a review aid; also validate permissions, provider registration, quotas, policy compliance and runtime behavior.

## Starter files

- [Architecture diagram](./architecture.mmd)
- [Bicep sample](./infra/main.bicep)
- [Parameters example](./infra/main.parameters.example.json)

## Validation

~~~bash
az bicep build --file infra/main.bicep
az bicep lint --file infra/main.bicep
az deployment group validate --resource-group <resource-group> --template-file infra/main.bicep --parameters @infra/main.parameters.example.json
az deployment group what-if --resource-group <resource-group> --template-file infra/main.bicep --parameters @infra/main.parameters.example.json
~~~

Choose the deployment command matching the template's declared scope.

## Interview prompt

**When choose Bicep over Terraform?** For an Azure-focused team seeking native ARM integration, Azure resource types and scope-aware deployments, Bicep is a strong default. Terraform may fit better for cross-cloud estates or an established multi-provider module ecosystem. Decide from team skills, governance and lifecycle requirements.

## LinkedIn draft

Bicep gives Azure teams a readable way to declare infrastructure deployed through ARM. A production pattern includes versioned modules, secure parameters, lint/build/validate, what-if review, least-privilege identity and post-deployment verification. #Azure #Bicep #InfrastructureAsCode

## Official references
- [Bicep documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [ARM template deployment](https://learn.microsoft.com/azure/azure-resource-manager/templates/)
