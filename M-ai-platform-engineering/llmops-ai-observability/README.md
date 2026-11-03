# LLMOps & AI Observability

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Operate AI systems using correlated traces, quality signals, safety events and unit economics.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Telemetry

Capture request IDs, model/deployment version, prompt version, retrieval references, tool calls, token counts, latency, status, safety decisions and cost dimensions. Redact or exclude sensitive prompt content by policy.

## Quality monitoring

Track user feedback, groundedness, task success, hallucination indicators, retrieval relevance, tool failure and evaluation scores. Use offline test sets and production sampling.

## Reliability

Monitor throttling, timeouts, model availability, quota headroom, endpoint health, dependency latency, queue depth and fallback rates. Define actionable SLOs and incident runbooks.

## Cost management

Measure cost by app, model, environment, business unit and request. Apply quotas, token budgets, rate limits, caching, model routing and retention controls.

## Continuous improvement

Trace failures to prompt/model/retrieval/tool versions, create regression cases, run evaluations in CI/CD and compare before/after results.


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

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/foundry/)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/evaluate-agent)
