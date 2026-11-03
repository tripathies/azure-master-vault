# Visual architecture diagrams

## Master architecture flow

- [View all 111 catalog components as an SVG diagram](architecture.svg)
- [Open the editable master diagram in diagrams.net](architecture.drawio)



**Editable source:** `.drawio` files open in [diagrams.net](https://app.diagrams.net/).  
**Quick preview:** `.svg` files render directly in GitHub.  
**Text model:** `.mmd` files are supplementary Mermaid source.


## Azure Master Vault — Azure Cloud Mindmap

- [View the complete Azure Master Vault — Azure Cloud Mindmap — all 111 catalogue components](AZURE-MASTER-MINDMAP.svg)
- [Open the editable mindmap in diagrams.net](AZURE-MASTER-MINDMAP.drawio)

The mindmap mirrors the canonical `catalog.json`: 13 domains and 111 component guides. The SVG is the quick visual preview; the draw.io file is the editable source. Select services according to workload requirements rather than treating the catalogue as a mandatory deployment stack.


## Azure Master Vault — Architecture Map

- [Open the linked Azure Master Vault — Architecture Map](AZURE-MASTER-ARCHITECTURE-MAP.md)
- [View the SVG overview](AZURE-MASTER-ARCHITECTURE-MAP.svg)
- [Open the editable catalogue mindmap](AZURE-MASTER-MINDMAP.drawio)

The architecture map groups the existing A–L catalogue into ten architecture lenses and provides a separate AI infrastructure specialization path. The SVG is a navigation overview; detailed service guidance remains in the existing category/component pages.


## Azure Component Mind Map

- [View the full component mind map (SVG)](AZURE-COMPONENT-MINDMAP.svg)
- [Edit the component mind map (draw.io)](AZURE-COMPONENT-MINDMAP.drawio)

The map contains all 13 catalogue categories and links every component node to its existing guide.


## Azure Network Architecture Map

- [View network topology (SVG)](AZURE-NETWORK-ARCHITECTURE-MAP.svg)
- [Edit network topology (draw.io)](AZURE-NETWORK-ARCHITECTURE-MAP.drawio)

A topology-first view covering hybrid connectivity, hub-and-spoke VNets, ingress, egress, segmentation, Private Link/DNS and observability.

## Category maps

- **A · Cloud Foundation & Landing Zones** — [SVG preview](A-cloud-foundation-landing-zones/architecture.svg) · [Editable draw.io](A-cloud-foundation-landing-zones/architecture.drawio) · [Category guide](A-cloud-foundation-landing-zones/README.md)
- **B · Identity & Access Management** — [SVG preview](B-identity-access-management/architecture.svg) · [Editable draw.io](B-identity-access-management/architecture.drawio) · [Category guide](B-identity-access-management/README.md)
- **C · Networking & Private Connectivity** — [SVG preview](C-networking-private-connectivity/architecture.svg) · [Editable draw.io](C-networking-private-connectivity/architecture.drawio) · [Category guide](C-networking-private-connectivity/README.md)
- **D · Traffic Management & Delivery** — [SVG preview](D-traffic-management-delivery/architecture.svg) · [Editable draw.io](D-traffic-management-delivery/architecture.drawio) · [Category guide](D-traffic-management-delivery/README.md)
- **E · Compute & Application Hosting** — [SVG preview](E-compute-application-hosting/architecture.svg) · [Editable draw.io](E-compute-application-hosting/architecture.drawio) · [Category guide](E-compute-application-hosting/README.md)
- **F · Containers & Kubernetes** — [SVG preview](F-containers-kubernetes/architecture.svg) · [Editable draw.io](F-containers-kubernetes/architecture.drawio) · [Category guide](F-containers-kubernetes/README.md)
- **G · Storage & Enterprise File Services** — [SVG preview](G-storage-enterprise-file-services/architecture.svg) · [Editable draw.io](G-storage-enterprise-file-services/architecture.drawio) · [Category guide](G-storage-enterprise-file-services/README.md)
- **H · Databases & Data Platforms** — [SVG preview](H-databases-data-platforms/architecture.svg) · [Editable draw.io](H-databases-data-platforms/architecture.drawio) · [Category guide](H-databases-data-platforms/README.md)
- **I · Integration & API Management** — [SVG preview](I-integration-api-management/architecture.svg) · [Editable draw.io](I-integration-api-management/architecture.drawio) · [Category guide](I-integration-api-management/README.md)
- **J · Security, Secrets & Governance** — [SVG preview](J-security-secrets-governance/architecture.svg) · [Editable draw.io](J-security-secrets-governance/architecture.drawio) · [Category guide](J-security-secrets-governance/README.md)
- **K · Monitoring, Operations & Cost** — [SVG preview](K-monitoring-operations-cost/architecture.svg) · [Editable draw.io](K-monitoring-operations-cost/architecture.drawio) · [Category guide](K-monitoring-operations-cost/README.md)
- **L · DevOps, Resilience, Migration & AI** — [SVG preview](L-devops-resilience-migration-ai/architecture.svg) · [Editable draw.io](L-devops-resilience-migration-ai/architecture.drawio) · [Category guide](L-devops-resilience-migration-ai/README.md)
- **12 · Automation, Backup and Disaster Recovery** — [SVG preview](12-automation-backup-disaster-recovery/architecture.svg) · [Editable draw.io](12-automation-backup-disaster-recovery/architecture.drawio) · [Category guide](12-automation-backup-disaster-recovery/README.md)

## Diagram standards

- Category maps show the components within that category and a conceptual flow for learning/design discussion.
- Component diagrams show the component's position between a source and consumer, with identity, network and operations/resilience controls where relevant.
- These are reference designs, not a claim that every service requires every cross-cutting component. Validate actual traffic paths, service support, identity model, regional/SKU limits and recovery behavior before production use.
- Microsoft Azure product icons can be added in draw.io using the official [Azure Architecture Center icon pack](https://learn.microsoft.com/en-us/azure/architecture/icons/).
