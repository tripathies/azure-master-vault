# Azure Solution Blueprint Catalogue

[← Back to Azure Master Vault](README.md) · [Open visual portal](docs/index.html) · [Open visual diagram library](VISUAL-DIAGRAMS.md)

The component catalogue explains individual Azure services. This catalogue explains how multiple services are composed into a business solution.

## How the Vault is organised

| Layer | Question answered | Source |
|---|---|---|
| Component catalogue | What does each Azure service do? | Existing 13 Azure Vault domains |
| Foundation designs | How are tenants, management groups, subscriptions, identity and policy organised? | Cloud Foundation & Landing Zones |
| Architecture patterns | How do services connect and work together? | Network, security, application, data and integration patterns |
| Solution blueprints | How does a business workload run end-to-end? | This catalogue |
| Implementation labs | How do I deploy, validate, operate and clean it up? | Per-solution code and runbooks |

**Do not duplicate component definitions here.** Link to the canonical component page and describe only the role that component plays in the specific solution.

## Available blueprints

| Blueprint | Scope | Deployment profile | Status |
|---|---|---|---|
| [LittleNest Kidswear E-commerce](solutions/littlenest-kidswear-profile-a/README.md) | Retail web application, private service access, identity and data | Profile A — low-cost non-production lab | Initial reference design |

## Blueprint template

Every future blueprint should document:

1. Business scenario, users and functional requirements.
2. Explicit scope, assumptions and non-goals.
3. Management group and subscription placement.
4. Resource-group and network layout.
5. Architecture diagram and request/data flows.
6. Azure Vault components reused, with canonical links.
7. Identity, roles and service-to-service authorisation.
8. Private connectivity and DNS.
9. Compute, data, integration and storage decisions.
10. Deployment tooling and version assumptions.
11. Cost drivers and optional paid extensions.
12. Security, monitoring, recovery and operational ownership.
13. Deployment, validation, test and cleanup procedures.
14. Known limitations and production-readiness gap list.

## Design rule

A solution blueprint is a reference design, not a guarantee that a deployment is production-ready. Production readiness must be assessed against business availability targets, data classification, compliance, capacity, cost, operational support and tested recovery.
