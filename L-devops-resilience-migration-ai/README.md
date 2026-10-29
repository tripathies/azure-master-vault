# L. DevOps, Resilience, Migration & AI

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json)

This category brings together infrastructure delivery, continuity, migration, hybrid management and AI platform design. These domains connect, but their controls are not interchangeable.

## Checklist
- [ ] Select Terraform vs Bicep from team and platform needs
- [ ] Secure CI/CD with federation, least privilege and approvals
- [ ] Define backup/DR by workload RTO/RPO
- [ ] Assess dependencies and cutover before migration
- [ ] Understand Azure Arc responsibility boundaries
- [ ] Choose Foundry, Azure OpenAI, AI Search and Azure ML by workload
- [ ] Secure data, identity, model access and retrieval
- [ ] Evaluate quality, safety, latency, quotas and cost

~~~mermaid
flowchart TB
    Repo[Git repository] --> CI[Validate / test / scan]
    CI --> Gate[Review and approval]
    Gate --> Deploy[Deploy with federated identity]
    Deploy --> Platform[Azure platform / workload]
    Platform --> Monitor[Monitor / security / cost]
    App[AI application] --> Model[Azure OpenAI / Foundry model]
    App --> Search[Azure AI Search retrieval]
    Data[Governed source data] --> Ingest[Ingestion and chunking]
    Ingest --> Search
    Model --> Eval[Evaluation / safety / tracing]
    Search --> Eval
~~~

## L1. Terraform
Declarative provider-based IaC. Use reusable modules, protected remote state, pinned versions, reviewed plans and controlled apply. State may contain sensitive data; do not commit it. Scope identities, monitor drift and inspect destructive replacements. See [Category 12 Terraform guide](../12-automation-backup-disaster-recovery/72-terraform/README.md).

## L2. Bicep / ARM templates
Bicep compiles to ARM templates and fits Azure-native deployments. Use explicit scope, modules, parameters and what-if review. Terraform may fit better for cross-provider workflows or an established module ecosystem. See [Bicep and ARM guide](../12-automation-backup-disaster-recovery/73-bicep-arm-templates/README.md).

## L3. Azure DevOps Pipelines and GitHub Actions
Use PR validation, dependency/security scans, plan/what-if, protected branches, production approvals, federated identity, scoped Azure roles and smoke tests. Treat pipeline identities as privileged production principals. See [CI/CD guide](../12-automation-backup-disaster-recovery/74-ci-cd-azure-devops-github-actions/README.md).

## L4. Azure Backup
Managed backup and restore for supported workloads. Define retention and recovery points, protect vault permissions and test restores. Backup is for point-in-time recovery; it does not alone provide application failover. See [Backup guide](../12-automation-backup-disaster-recovery/75-azure-backup/README.md).

## L5. Azure Site Recovery
Replicates and orchestrates recovery for supported workloads/source-target combinations. Define RTO/RPO, map network/DNS/identity dependencies, test failover in isolation and rehearse reprotect/failback. Replication health alone does not prove application recoverability. See [ASR guide](../12-automation-backup-disaster-recovery/76-azure-site-recovery-asr/README.md).

## L6. Azure Migrate
Assessment and migration capabilities for supported servers, databases and applications. Discover inventory and dependencies; classify rehost/replatform/refactor/replace/retire; assess target region, quotas, identity, networking, licensing and cost; plan waves, downtime, data sync, validation and rollback. Decommission the source only after stabilization and business sign-off.

## L7. Azure Arc
Extends Azure management capabilities to supported resources outside Azure, including selected servers, Kubernetes and data services. Arc does not mean the workload runs in Azure or that Microsoft assumes all operating responsibility. Validate supported resource types, connectivity, agents/extensions, permissions, policy impact, patch ownership and disconnected behavior.

## L8. Microsoft Foundry
Platform for building, evaluating, deploying and governing AI applications/agents and model experiences. Product naming/features evolve; verify current capabilities before architecture decisions. Define project boundaries, model access, identity, quotas, tool permissions, evaluations, tracing, safety, monitoring and cost. Treat agent tools/connectors as privileged interfaces and test prompt-injection risks.

## L9. Azure OpenAI
Access to supported OpenAI models through Azure's platform, subject to model/region availability, quotas, deployment type and responsible-use requirements.

**Checklist:** verify model availability and capacity; use managed identity/least privilege where supported; restrict endpoint access and use private networking when required; handle rate limits/timeouts/retries; evaluate task quality, safety and groundedness; track tokens/latency/cost; do not send sensitive data without approved governance.

## L10. Azure AI Search
Search/retrieval service used for indexing content and querying it, often in retrieval-augmented generation (RAG). Quality depends on ingestion, chunking, metadata, embeddings, hybrid/vector retrieval, ranking and evaluation.

**Checklist:** define source of truth and update/deletion behavior; design chunking and filters from evaluation; enforce document-level authorization before returning results; secure index endpoints; use managed identity where supported; test stale data, prompt injection in retrieved documents, citations, recall and latency; monitor indexing lag and capacity cost.

## L11. Azure Machine Learning
Managed ML lifecycle platform for supported data preparation, training, experiment tracking, model registry, deployment and monitoring.

**Checklist:** secure workspace/storage; use managed identity; isolate network/compute as required; track data/model lineage; pin environments; version and register models; evaluate bias/quality/drift; secure endpoints; monitor latency/cost; define approval and rollback for model releases.

## AI application security checklist
- [ ] Define use case, success metric, unacceptable outcomes and human escalation.
- [ ] Classify data sent to prompts, logs, embeddings and training pathways.
- [ ] Enforce document-level authorization before retrieval; model access does not authorize source data access.
- [ ] Test prompt injection, unsafe tool calls, data exfiltration, hallucination and stale knowledge.
- [ ] Evaluate retrieval quality, groundedness, task success, safety, latency and cost.
- [ ] Use managed identity, least privilege and private connectivity where supported.
- [ ] Add rate limiting, monitoring, feedback and fallback behavior when model/search/tools fail.

## Migration and resilience checklist
- [ ] Discover dependencies, licensing, data movement and target capacity.
- [ ] Define RTO/RPO and choose backup, replication or both.
- [ ] Test restore/failover and application-level validation.
- [ ] Define rollback criteria and business sign-off before source decommission.
- [ ] Assign operational ownership after migration.

## Common mistakes
- Exposing production via long-lived pipeline secrets.
- Assuming a successful migration means application health.
- Treating Azure Arc as a transfer of all workload responsibility.
- Building RAG without document authorization or evaluation.
- Assuming every AI model/feature is available in every region or has unlimited quota.
- Logging sensitive prompts or retrieved documents without governance.
- Treating backup and replication as interchangeable.

## Interview questions
**Azure Backup vs ASR?** Backup supports point-in-time restore/retention; ASR replicates and orchestrates recovery for supported workloads. Many critical workloads need both.

**How do you secure RAG?** Enforce document-level authorization before retrieval, secure ingestion/index access, use managed identity, evaluate retrieved content, defend against prompt injection and log safely.

**What is first in migration?** Discover inventory/dependencies and business criticality; then assess target readiness, cost, downtime and rollback before planning waves.

## LinkedIn-ready post
Modernization succeeds when delivery, resilience, governance and application behavior are designed together. Automate safe changes, test restore and failover, map migration dependencies, and evaluate AI applications for authorization, grounding, safety, latency and cost. #Azure #DevOps #AIEngineering #Resilience

## Official references
- [Azure Migrate](https://learn.microsoft.com/azure/migrate/)
- [Azure Arc](https://learn.microsoft.com/azure/azure-arc/overview)
- [Azure OpenAI](https://learn.microsoft.com/azure/ai-services/openai/overview)
- [Azure AI Search](https://learn.microsoft.com/azure/search/search-what-is-azure-search)
- [Azure Machine Learning](https://learn.microsoft.com/azure/machine-learning/overview-what-is-azure-machine-learning)
- [Azure Backup](https://learn.microsoft.com/azure/backup/)
- [Azure Site Recovery](https://learn.microsoft.com/azure/site-recovery/)
