# Model Deployment & Inference

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Design reliable, secure and cost-aware online and batch model serving.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Serving patterns

Choose managed online endpoints, serverless model APIs, batch endpoints or self-managed container serving from latency, throughput, customization, isolation, portability and cost requirements.

## Endpoint design

Define authentication, network ingress, private access, request schema, payload limits, timeouts, retries, rate limits, idempotency and error contracts. Keep model and endpoint versions explicit.

## Performance

Measure time-to-first-token, tokens per second, p50/p95/p99 latency, concurrency, queue time, cold start, batch efficiency and accelerator utilization. Tune batching, caching and context limits using representative traffic.

## Release strategy

Use shadow traffic, canary rollout, weighted routing and rollback. Maintain model-specific safety and quality gates; do not treat a successful deployment as proof of response quality.

## Resilience and cost

Use health probes, autoscaling, circuit breakers and graceful fallback. Track cost per request/token/task and include endpoint idle capacity, accelerator, network and logging costs.


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

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/machine-learning/concept-endpoints-online)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/machine-learning/concept-endpoints-batch)
