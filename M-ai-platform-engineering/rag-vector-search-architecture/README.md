# RAG & Vector Search Architecture

[← M. AI Platform & Engineering](../README.md) · [← Master catalogue](../../README.md)

> **Purpose.** Build grounded AI experiences using governed content ingestion, hybrid retrieval and evaluation.

## Architecture placement

This capability is part of the AI workload lifecycle. Connect it to Microsoft Foundry, Azure OpenAI, Azure AI Search and Azure Machine Learning only where those services fit the workload. It depends on the platform foundations in identity, networking, data, compute, security, observability and DevOps.

## Ingestion pipeline

Connect approved sources, extract text and metadata, classify content, remove duplicates, chunk documents, create embeddings and index content. Define update, deletion and re-index behavior.

## Retrieval

Select keyword, vector, hybrid and semantic ranking strategies. Apply metadata filters and authorization filters. Test recall, precision, freshness, citation coverage and retrieval latency with a representative evaluation set.

## Generation

Construct bounded context, cite retrieved sources, require the model to distinguish evidence from inference and provide a safe no-answer path when evidence is insufficient.

## Security

Enforce user/document authorization before returning content. Treat retrieved documents as untrusted input; defend against prompt injection, poisoned content, data leakage and cross-tenant retrieval.

## Operations

Monitor ingestion lag, failed indexing, embedding model versions, index capacity, query latency, relevance, token consumption and feedback. Re-run quality evaluation after source, chunking, embedding or ranking changes.


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

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/search/vector-store)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/search/hybrid-search-overview)
- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/search/retrieval-augmented-generation-overview)
