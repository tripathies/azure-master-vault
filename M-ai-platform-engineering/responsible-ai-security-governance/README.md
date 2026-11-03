# Responsible AI, Security & Governance

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Apply risk controls across data, models, prompts, retrieval, agents and production operations.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Risk assessment

Classify impact and audience, define prohibited uses, identify affected people, set human oversight and document accountability. Apply stricter review to consequential decisions.

## Identity and data

Use managed identities and least privilege where supported, private connectivity when required, encryption, data classification, retention limits and approved data processing paths.

## AI threat controls

Test prompt injection, indirect injection in retrieved content, data exfiltration, insecure tool use, model abuse, sensitive data disclosure, poisoning and model supply-chain risk.

## Safety and human oversight

Apply content safety filters and policy checks appropriate to the use case. Provide escalation, human approval for consequential actions, audit logs and a clear user correction path.

## Governance evidence

Maintain model cards, data lineage, prompt versions, evaluations, approvals, risk exceptions, incident records and periodic reviews. Reassess when models, data, tools or use cases change.


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
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/well-architected/)
