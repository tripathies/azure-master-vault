# Model Catalog, Registry & Lifecycle

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Control model discovery, provenance, versioning, approval and promotion across environments.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Model intake

Record provider, model family/version, license, source, capabilities, supported modalities, context limits, safety profile, region and deployment options. Treat model cards and licenses as architecture inputs.

## Registry and artifacts

Version model references, fine-tuning data, adapters, evaluation sets, prompts, container images and runtime environments. Capture lineage, checksums, owners, approval state and reproducible build metadata.

## Promotion

Define dev → test → staging → production gates. Require functional, quality, safety, security, latency, load and cost evaluations before promotion. Keep rollback to a previously approved model and configuration.

## Governance

Define allowed model sources, prohibited data use, retention, residency, intellectual-property review and exception process. Restrict who can register, approve and deploy models.

## Lifecycle operations

Track deprecation notices, model retirement, endpoint compatibility, quota changes and data drift. Re-evaluate workloads when a model or provider version changes.


## Architecture review checklist

- [ ] Record use case, workload class, data classification and owner.
- [ ] Validate identity, authorization, network paths and regional/SKU support.
- [ ] Define failure modes, quotas, scaling and cost ceilings.
- [ ] Add security, quality and operational tests to the delivery process.
- [ ] Document rollback, monitoring, incident response and lifecycle ownership.

## Enterprise scenario

A regulated enterprise team introduces this capability for a bounded AI workload. The platform team provides approved identities, private network paths, logging and deployment controls; the product team owns evaluation datasets, quality thresholds, user experience and runbooks. Production promotion requires measurable quality, security, reliability and cost evidence.

## Interview questions

**Q1. What is the primary architectural decision?**  
State the workload requirement first, then compare managed and self-managed alternatives based on control, reliability, compliance, performance and total cost.

**Q2. How do you make this production-ready?**  
Prove identity and data boundaries, test failure and scale behavior, establish quality/security gates, instrument cost and latency, and assign operational ownership.

## Official references

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/machine-learning/concept-model-catalog)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/machine-learning/concept-model-management-and-deployment)
