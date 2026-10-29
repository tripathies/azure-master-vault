# Azure Master Vault

A practical, solution-architect-oriented knowledge base for designing, securing, operating, and evolving Microsoft Azure environments.

## What this repository contains

The catalogue is organized into 12 domains, from cloud foundations and identity to networking, application platforms, data, security, operations, DevOps, resilience, migration, and AI.

Each service/component guide is intended to include:
- What it is, where it fits, when to use it, and alternatives
- Identity, security, networking, and private connectivity considerations
- Availability, disaster recovery, scaling, and cost considerations
- Common mistakes and a realistic architecture scenario
- Interview questions with model answers and a LinkedIn-ready post
- Azure-friendly architecture diagrams (Mermaid; SVG where useful)
- Terraform and/or Bicep examples, parameters, validation steps, and safe defaults where deployment code is appropriate

Governance and design-framework topics use policy, configuration, and decision examples rather than pretending every concept is a deployable resource.

## Catalogue

| Domain | Folder |
|---|---|
| A. Cloud Foundation & Landing Zones | [A-cloud-foundation-landing-zones](A-cloud-foundation-landing-zones/README.md) |
| B. Identity & Access Management | [B-identity-access-management](B-identity-access-management/README.md) |
| C. Networking & Private Connectivity | [C-networking-private-connectivity](C-networking-private-connectivity/README.md) |
| D. Traffic Management & Delivery | [D-traffic-management-delivery](D-traffic-management-delivery/README.md) |
| E. Compute & Application Hosting | [E-compute-application-hosting](E-compute-application-hosting/README.md) |
| F. Containers & Kubernetes | [F-containers-kubernetes](F-containers-kubernetes/README.md) |
| G. Storage & Enterprise File Services | [G-storage-enterprise-file-services](G-storage-enterprise-file-services/README.md) |
| H. Databases & Data Platforms | [H-databases-data-platforms](H-databases-data-platforms/README.md) |
| I. Integration & API Management | [I-integration-api-management](I-integration-api-management/README.md) |
| J. Security, Secrets & Governance | [J-security-secrets-governance](J-security-secrets-governance/README.md) |
| K. Monitoring, Operations & Cost | [K-monitoring-operations-cost](K-monitoring-operations-cost/README.md) |
| L. DevOps, Resilience, Migration & AI | [L-devops-resilience-migration-ai](L-devops-resilience-migration-ai/README.md) |

## Suggested learning path

1. Establish governance and landing-zone fundamentals.
2. Learn identity, network segmentation, private connectivity, and perimeter controls.
3. Select compute, container, storage, database, and integration services against requirements.
4. Add observability, security posture management, cost controls, and operational processes.
5. Automate repeatable deployments and test backup, recovery, migration, and AI platform patterns.

## Working safely

Examples are learning templates, not production approval. Review region and SKU availability, quotas, naming, RBAC scope, network ranges, data residency, compliance, private DNS, recovery objectives, and estimated cost before deployment. Never commit secrets, credentials, tenant-specific identifiers, or production state files. Pin provider/module versions and run validation and plan/what-if checks before applying changes.

## Status

The catalogue is designed to grow incrementally. Each guide should distinguish verified platform behavior from assumptions and should link to official Microsoft documentation for service limits and changing features.
