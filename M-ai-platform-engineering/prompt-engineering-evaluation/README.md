# Prompt Engineering & Evaluation

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Treat prompts and evaluations as versioned engineering assets, not informal text edits.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Prompt structure

Separate system instructions, user input, retrieved evidence and tool output. Define role, constraints, output schema, refusal behavior and citation requirements. Keep secrets and privileged instructions out of user-controlled context.

## Versioning

Store prompt templates with source control, owner, model compatibility, test cases and release history. Compare prompts with fixed datasets before promotion.

## Evaluation design

Measure task success, groundedness, relevance, completeness, citation accuracy, refusal quality, toxicity/safety, robustness and consistency. Combine automated evaluators with human review for high-impact workflows.

## Adversarial tests

Include prompt injection, jailbreak attempts, ambiguous requests, malformed data, conflicting sources, long context, multilingual inputs and tool misuse scenarios.

## Release gates

Set workload-specific thresholds and confidence criteria. Block releases for severe safety regressions, unauthorized data access or unsupported tool execution.


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

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/foundry/concepts/evaluation-overview)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/foundry/observability/how-to/evaluate-agent)
