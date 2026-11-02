# Component Code & Deployment Page — Authoring Template

Duplicate this template after each component chapter. Replace all bracketed instructions. Remove a section only when it is genuinely not applicable and explain why.

# CODE & DEPLOYMENT — [COMPONENT]

**Learning objective:** By the end, the reader can [measurable outcome].  
**Deployment status:** [Repository implementation / CI-validated / Live Azure validated / Illustrative only / Conceptual configuration]  
**Scope:** [Tenant / management group / subscription / resource group / resource]  
**Estimated effort:** [time range]  
**Cost warning:** [billable dimensions; never promise zero cost]

## 1. What will be deployed or configured?
Describe the outcome, exact resources/configuration and explicit exclusions.

## 2. Architecture and dependencies
Include a small deployment diagram. Identify resource providers, regions, SKUs, quotas, network/DNS dependencies, identity/RBAC prerequisites, upstream platform services and downstream consumers.

## 3. Repository implementation

| Item | Value |
|---|---|
| Source path | [canonical GitHub path] |
| IaC / tool | [Terraform / Bicep / ARM / CLI / PowerShell / portal / application code] |
| Entry point | [file or command] |
| Inputs | [parameters / variables] |
| Outputs | [IDs, endpoints, names and evidence] |
| Validation | [lint, validate, plan, what-if, tests or live checks] |

If the repository does not contain a suitable implementation, say so. Add a companion sample only after technical review. Never invent a source path.

## 4. Prerequisites
- Azure tenant and subscription selection.
- Required permissions, including role-assignment permissions if needed.
- CLI, SDK, provider and tool versions.
- Resource-provider registration.
- Supported region, SKU and quota.
- Network access from the deployment runner.
- Budget and cost approval.
- Safe synthetic input values.

## 5. Identity and security
Explain deployment identity and workload identity. Show least-privilege role and scope. Explain secret handling, authentication, public network exposure, encryption and policy constraints.

Never publish passwords, client secrets, SAS tokens, private keys or real tenant/subscription identifiers.

## 6. Configure inputs
Show safe parameter/variable examples. Explain non-obvious settings and their security/cost impact.

## 7. Review before deployment

Terraform review pattern:

    terraform fmt -check -recursive
    terraform init
    terraform validate
    terraform plan -out tfplan
    terraform show tfplan

Bicep review pattern:

    az deployment group what-if --resource-group <resource-group> --template-file main.bicep --parameters @main.parameters.json

Use the correct scope and command for the actual component. Explain what the reader must inspect.

## 8. Deploy
Provide exact commands for the chosen implementation. Explain expected duration, asynchronous operations, approvals and stop conditions.

## 9. Verify the result
Include resource inventory, configuration, identity, network/DNS, functional tests, telemetry and negative tests proving prohibited actions are denied where relevant. State expected results. A successful command alone is not verification.

## 10. Cost, limits and operational ownership
List billable resources, capacity/transaction/egress drivers, free-tier caveats, quotas, region constraints, log ingestion and retention. Identify owners for alerts, patching, backup, certificates, access reviews and incidents.

## 11. Cleanup and rollback
Give exact safe cleanup steps. Identify data-loss effects, retained/soft-deleted resources, dependencies and resources that must not be deleted. For shared/production environments, provide change-control rollback rather than a blanket destroy command.

## 12. Troubleshooting

| Symptom | Likely cause | Evidence | Corrective action |
|---|---|---|---|
| [symptom] | [cause] | [logs / command / metric] | [safe fix] |

## 13. Lab challenge
Give a task, test and evidence to submit. Include an advanced extension.

## 14. Evidence and references
- Code review date.
- Test environment or explicit no-live-test statement.
- CI run / validation output / live deployment evidence.
- Official Microsoft Learn links.
- Related chapters and Vault guide.

## Editorial acceptance checklist
- [ ] Correct service and deployment scope.
- [ ] Current supported API/provider/tool versions.
- [ ] Safe placeholders; no secrets.
- [ ] Identity and RBAC explicit and least-privileged.
- [ ] Network path and public/private exposure explained.
- [ ] Plan/what-if shown before deployment.
- [ ] Verification goes beyond command success.
- [ ] Cost, quota, limits and regional support addressed.
- [ ] Cleanup and residual resources explained.
- [ ] Code status accurately labelled.
- [ ] Official references linked and dated.
