# AI Infrastructure Foundations

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Design the platform foundation for AI workloads before selecting models or orchestration frameworks.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Architecture scope

Separate experimentation, development, evaluation and production environments. Classify workloads as training, fine-tuning, batch inference, real-time inference, retrieval, or agent execution. Record data sensitivity, regions, latency, throughput, availability and cost-per-task targets.

## Platform building blocks

Plan identity, subscription boundaries, network isolation, compute pools, container registry, storage, data pipelines, model access, secrets, observability and policy. Prefer managed services when their capability, control and regional support meet the requirement.

## Workload placement

Use CPU for orchestration and preprocessing where appropriate; GPU/accelerated compute for supported training and inference workloads; AKS for containerized control when operational flexibility is needed; managed model endpoints when they reduce platform burden.

## Design decisions

Compare managed AI platform services with self-managed frameworks using capability, control, portability, skills, compliance, availability, operations and total cost. Avoid choosing Kubernetes or GPUs simply because a workload is labelled AI.

## Validation

Prove data access, model endpoint reachability, identity, private DNS, quotas, capacity, scaling, telemetry, backup/recovery and teardown in a non-production subscription.


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

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/well-architected/)
