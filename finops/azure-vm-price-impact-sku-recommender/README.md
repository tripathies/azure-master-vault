# Azure VM Price Impact & SKU Recommender

A read-only PowerShell assessment to identify Azure VM workloads that may be affected by the February 2027 regional pricing advisory, estimate the price impact, apply a configurable discount assumption, and compare lower-cost SKU candidates.

> **Important:** The February 2027 pricing figures and exclusions in this project are planning assumptions transcribed from a customer-facing advisory discussion. Validate the exact advisory, impacted resources, SKU exclusions, region, billing meter and contract rates inside your own Azure tenant before making financial decisions. This tool does not represent an official Microsoft pricing calculator.

## What it does

- Discovers Azure VM inventory across accessible subscriptions.
- Captures subscription, resource group, VM name, region, current size/SKU, power state, OS and hardware profile where available.
- Classifies regional pricing assumptions and named exclusions.
- Estimates current and post-change compute cost using public retail rates and configurable monthly hours.
- Applies a configurable discount percentage as a **what-if assumption**.
- Compares alternative VM sizes where region availability and pricing data can be queried.
- Exports detailed CSV and an executive HTML report with run metadata.

## Pricing assumptions included

Seven regions in the advisory discussion:

| Azure region | City reference | Planning uplift |
|---|---|---:|
| North Europe | Dublin | 17% |
| France Central | Paris | 11% |
| France South | Marseille | 11% |
| West Europe | Amsterdam | 9% |
| Norway East | Oslo | 9% |
| Norway West | Stavanger | 9% |
| Southeast Asia | Singapore | 8% |

City references are geographic context only; use the Azure region name returned by Azure Resource Manager in inventory and pricing queries.

### VM exclusion rules

The project records the following named exclusions from the regional update as working rules, subject to tenant verification:

- **v1:** Bv1, D, Ds, F, Fs, G, Gs, L, NP, HCS
- **v2:** Av2, Amv2, Dv2, Dsv2, Fsv2, Lsv2
- **Six Intel v7 series:** Dsv7, Ddsv7, Dlsv7, Dldsv7, Esv7, Edsv7

Do not infer that every v7 series is excluded. AMD v7 is not included in the six-series Intel v7 list. Confirm every exact SKU and billable meter against the tenant advisory.

## Cost model

The estimator uses:

- Monthly hours (default 730) × public hourly retail rate.
- Regional uplift only for qualifying region/series assumptions.
- Discount percent as a user-entered what-if adjustment.

A public retail rate is not the same as an effective enterprise invoice rate. The script does not automatically reconcile EA/CSP negotiated rates, reservation coverage, Savings Plans, Azure Hybrid Benefit, Spot pricing, licensing, taxes, storage, network egress or other ancillary charges unless explicitly included in a future implementation. Treat output as approximate compute-only planning.

## Safety

- Read-only discovery and report generation.
- Does not resize, stop, restart, redeploy or delete VMs.
- A cheaper candidate is not automatically compatible. Validate CPU architecture, vCPU, memory, disk/controller support, Premium IO, accelerated networking, Gen1/Gen2, availability zone, application/vendor certification, quota, maintenance window and performance requirements.
- No production change should be made solely from the report. Use a separately approved change plan and rollback procedure.

## Requirements

- PowerShell 7 recommended.
- Azure PowerShell modules: Az.Accounts, Az.Compute, and any additional modules stated in the script help.
- Sign-in and read permissions in the subscriptions to be inventoried.
- Internet access to the Azure Retail Prices API.

## Example

```powershell
Connect-AzAccount

./Azure-VM-Price-Impact-SKU-Recommender.ps1 `
  -DiscountPercent 15 `
  -MonthlyHours 730 `
  -CurrencyCode USD
```

Run `Get-Help ./Azure-VM-Price-Impact-SKU-Recommender.ps1 -Detailed` for parameters supported by the script version you are using.

## Output and audit

Each run should retain:
- Timestamp and run identifier.
- Selected subscriptions and scope.
- Pricing source and retrieval timestamp.
- Pricing assumptions and discount input.
- Per-VM current and projected cost.
- Alternative candidates and reasons for rejection/qualification, where available.
- Error and warning records.
- Script version and output file manifest.

Keep reports secure: resource names, subscription IDs and infrastructure details may be sensitive.

## Project files

- `Azure-VM-Price-Impact-SKU-Recommender.ps1` — main PowerShell assessment.
- `Azure-VM-Price-Impact-Workflow.mmd` — process flow diagram.
- `README-POST-CHECKLIST.md` — validation and publication checklist.
- `REPOSITORY-SETUP.md` — local Git publishing guidance.

## Sources

- [Microsoft Q&A: Azure VM and Storage pricing clarification](https://learn.microsoft.com/en-in/answers/questions/6026564/clarification-required-azure-vm-and-storage-pricin)
- [Azure Retail Prices API](https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices)
- [Azure Resource Graph](https://learn.microsoft.com/en-us/azure/governance/resource-graph/overview)
- [Azure VM sizes](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/overview)

## License

This project is intended for learning and assessment. Review the parent repository's license policy and applicable third-party terms before redistribution or commercial use.
