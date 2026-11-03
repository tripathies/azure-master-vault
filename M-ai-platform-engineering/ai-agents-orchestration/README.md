# AI Agents & Orchestration

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Design bounded agents that use tools and workflows safely under explicit identity and approval controls.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Agent boundaries

Define a narrow business goal, allowed tools, permitted data, maximum steps, budget, time limit and clear completion conditions. Prefer deterministic workflows for deterministic tasks.

## Orchestration

Model planning, retrieval, tool execution, state, retries, handoffs and human approval. Define when the agent must stop, ask for clarification or escalate.

## Tool security

Treat tools, APIs, MCP servers and connectors as privileged interfaces. Use separate workload identities, least-privilege scopes, allow-listed operations, input validation and output sanitization.

## Reliability

Make operations idempotent where possible; use bounded retries, timeout budgets, durable state and audit trails. Design for tool/model outages and partial completion.

## Evaluation

Test tool-selection accuracy, task completion, policy adherence, injection resistance, unsafe actions, cost and latency over multi-turn scenarios.


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

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/foundry/agents/overview)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/foundry/)
