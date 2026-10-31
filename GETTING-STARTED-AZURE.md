# Getting Started with Azure

> A safe local workflow for the Azure Master Vault. These steps inspect and select Azure context before any infrastructure is deployed.

[← Back to Azure Master Vault](README.md) · [Open the visual portal](docs/index.html)

## 1. Install the toolchain

Use PowerShell 7 and install Azure CLI, Terraform, Git and Visual Studio Code. Optional tools include Azure PowerShell, TFLint and Checkov.

Verify the local tools:

~~~powershell
$PSVersionTable.PSVersion
az version
terraform version
git --version
code --version
~~~

Use the official Microsoft, HashiCorp and Git download sources.

## 2. Sign in to Microsoft Entra ID

Interactive sign-in:

~~~powershell
az login
~~~

For a specific tenant:

~~~powershell
az login --tenant "<tenant-id>"
~~~

For a device-code flow:

~~~powershell
az login --use-device-code
~~~

Use the sign-in method permitted by your organisation. Do not put passwords, access tokens or client secrets into scripts.

## 3. Inspect and select the subscription

~~~powershell
az account list --output table
az account show --query "{tenant:tenantId,subscription:id,name:name,state:state,user:user.name}" --output table
az account set --subscription "<subscription-id>"
az account show --query "{tenant:tenantId,subscription:id,name:name,state:state,user:user.name}" --output table
~~~

Select by immutable subscription ID, not display name. Stop if the tenant or subscription ID is not the one approved for the lab.

## 4. Check access and regional readiness

~~~powershell
az ad signed-in-user show --query "{displayName:displayName,id:id,userPrincipalName:userPrincipalName}" --output table
az role assignment list --assignee "<user-object-id>" --all --output table
az account list-locations --output table
az vm list-usage --location "<azure-region>" --output table
~~~

Role-assignment visibility depends on your permissions and scope. Ask the subscription owner for the smallest role and scope that supports the exercise; do not request Owner simply to make a lab deploy.

## 5. Connect Terraform to the intended subscription

Keep the Azure CLI context and Terraform target aligned. Pass the subscription ID explicitly:

~~~powershell
$subscriptionId = az account show --query id --output tsv
terraform init -lockfile=readonly
terraform fmt -check
terraform validate
terraform plan -var "subscription_id=$subscriptionId"
~~~

The active Azure CLI subscription is useful context, but an explicit Terraform subscription ID makes the target visible in configuration and review. Inspect the plan before applying.

For CI/CD, prefer GitHub Actions OIDC with a federated identity credential and narrowly scoped role assignment. Avoid long-lived client secrets.

## 6. Provider registration

Inspect provider state first:

~~~powershell
az provider show --namespace Microsoft.Web --query registrationState --output tsv
az provider show --namespace Microsoft.Network --query registrationState --output tsv
~~~

Only register a provider when approved and authorised:

~~~powershell
az provider register --namespace Microsoft.Web
~~~

Provider registration is a subscription-level change. Do not run broad registration commands blindly.

## 7. Safe deployment and cleanup

~~~powershell
terraform init -lockfile=readonly
terraform fmt -check
terraform validate
terraform plan -out tfplan
terraform show tfplan
# Apply only after reviewing target, changes, permissions and cost:
terraform apply tfplan
~~~

Use a disposable non-production subscription. Clean up after the exercise:

~~~powershell
terraform destroy
~~~

Check for retained data, soft-deleted vaults, storage data, backups or resources created outside Terraform.

## 8. Protect local files and state

Never commit terraform.tfvars containing secrets, state files, backup state files, saved plans, credentials, tokens, certificates or private keys. Use an access-controlled remote backend for shared or persistent environments. Terraform state can contain sensitive values even when outputs are marked sensitive.

## Troubleshooting

| Symptom | Checks |
|---|---|
| Wrong tenant/subscription | Re-run az account show; sign in to the intended tenant and select by ID. |
| Terraform 401/403 | Confirm identity, role, scope, tenant and provider registration. |
| Region or SKU unavailable | Check service availability and quota for the selected subscription and region. |
| Private endpoint resolves publicly | Check private DNS zone, VNet link, resolver path and service FQDN. |
| App resolves but cannot connect | Check routes, NSGs, endpoint approval, service firewall and application authorisation. |

## Official references

- [Azure CLI sign-in](https://learn.microsoft.com/cli/azure/authenticate-azure-cli)
- [Manage Azure subscriptions with Azure CLI](https://learn.microsoft.com/cli/azure/manage-azure-subscriptions-azure-cli)
- [AzureRM provider authentication](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [GitHub Actions OIDC with Azure](https://learn.microsoft.com/azure/developer/github/connect-from-azure-openid-connect)
