# GPU & Accelerated Compute

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Plan scarce accelerator capacity for AI training and inference across Azure VM and AKS patterns.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Selection

Choose GPU class, memory, interconnect, CPU/RAM balance and storage throughput from model size, batch size, context length, concurrency and latency. Validate exact VM SKU, region, quota and subscription capacity before architecture approval.

## AKS pattern

Use a dedicated GPU node pool with taints, tolerations, node labels, resource requests/limits, autoscaling and workload isolation. Use the AKS-managed GPU experience where it fits; self-manage drivers and device plugins only when requirements justify the operational burden.

## Operations

Track GPU utilization, memory, fragmentation, queue depth, cold starts, power/thermal signals where exposed, failed scheduling and node health. Use model-aware batching and admission control to avoid oversubscription.

## Cost and capacity

Budget for idle capacity, reserved/committed capacity where appropriate, data transfer, storage IOPS and scale-out headroom. Use scheduled scale-down for non-production and measure cost per training run or inference request.

## Failure modes

Test node drain, accelerator failure, quota exhaustion, image/driver mismatch, out-of-memory, zone capacity shortage and fallback to alternate model or region.


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

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/aks/use-nvidia-gpu)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes-gpu)
