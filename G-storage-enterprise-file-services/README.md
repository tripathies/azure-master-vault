# G. Storage & Enterprise File Services

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json)

Storage selection begins with access pattern, data shape, protocol, latency, throughput, durability, recovery, compliance and cost—not simply “which storage service is cheapest?”

## Checklist
- [ ] Choose Blob vs ADLS Gen2 vs Azure Files vs NetApp Files vs Queue/Table
- [ ] Explain account-level settings, identity and network restrictions
- [ ] Choose redundancy from durability and recovery objectives
- [ ] Design lifecycle, retention, backup, immutability and data protection
- [ ] Use private endpoints/DNS where required
- [ ] Measure transactions, capacity, retrieval and replication cost

## Storage decision guide

~~~mermaid
flowchart TD
    Need[Workload data requirement] --> Object{Object / unstructured data?}
    Object -->|Analytics hierarchy| ADLS[ADLS Gen2]
    Object -->|General objects / backup / media| Blob[Blob Storage]
    Need --> Files{Shared file protocol?}
    Files -->|Managed SMB/NFS file share| FilesSvc[Azure Files]
    Files -->|High-performance enterprise NAS| ANF[Azure NetApp Files]
    Need --> Messaging{Message or key-value access?}
    Messaging -->|Queue messages| Queue[Queue Storage]
    Messaging -->|Simple NoSQL key/value| Table[Table Storage]
~~~

## G1. Storage Accounts

A storage account is the management, security, namespace and billing container for supported storage services. Account configuration affects network access, encryption, redundancy, endpoints and security posture.

**Checklist**
- [ ] Select account kind, performance tier and redundancy from workload needs.
- [ ] Prefer Entra ID/data-plane roles over account keys where supported.
- [ ] Disable public network access or constrain it where required; validate private endpoint/DNS path.
- [ ] Set secure transfer, minimum TLS, shared-key policy and anonymous blob access deliberately.
- [ ] Configure diagnostic logs, lifecycle, retention and cost alerts.
- [ ] Review key rotation, deletion protection and recovery capabilities.

## G2. Blob Storage

Object storage for unstructured data, media, backups, logs and application objects. Blob access tiers trade storage cost against access/retrieval cost and latency; tier eligibility and retrieval constraints vary.

**Design:** select hot/cool/cold/archive based on access and restore patterns; define lifecycle rules; use versioning/soft delete/immutability where appropriate; secure container access; use Entra data roles and private endpoints as needed.

**Checklist:** model transactions and retrieval, not just GB-month; avoid public containers; validate archive rehydration times against RTO; protect critical data from accidental/malicious deletion.

## G3. Azure Data Lake Storage Gen2

ADLS Gen2 builds analytics-oriented filesystem semantics on Blob Storage using hierarchical namespace. It supports directory/file organization and access-control patterns useful for data lakes.

**Design:** plan raw/curated/consumer zones, naming, lifecycle, data ownership and access model; choose Entra/RBAC plus filesystem ACLs correctly; private DNS/network access must work for compute engines; monitor transaction and analytics access cost.

**Common trap:** storage account RBAC and filesystem ACLs may both affect access. Diagnose the effective permission path instead of granting broad Owner or account keys.

## G4. Azure Files

Managed file shares accessed through supported SMB/NFS protocols and integration patterns. Useful when applications need shared file semantics without operating a file server.

**Checklist:** select protocol, authentication and identity integration; confirm region/SKU support; plan share quota/performance, networking and private endpoints; validate client OS compatibility, locking, permissions, backup and recovery; model provisioned or transaction-related costs for the chosen tier.

## G5. Azure NetApp Files

Enterprise file storage service for supported high-performance, low-latency workloads and advanced data management needs. It is suited to specific enterprise file/NFS/SMB and migration scenarios, with capacity/service-level choices affecting performance and cost.

**Checklist:** validate regional availability and workload support; design capacity pools, volumes, service levels, network integration and delegated subnet requirements; plan snapshots/replication and recovery; monitor throughput/latency and capacity; confirm licensing/application certification needs.

## G6. Queue Storage

Simple durable message queueing service for decoupling producers and consumers. It supports asynchronous processing but does not offer all semantics of a full enterprise message broker.

**Checklist:** design visibility timeout, retries, poison-message handling, idempotent consumers, message size/retention constraints and polling cost. Choose Service Bus when ordering, sessions, richer broker semantics or enterprise messaging capabilities are needed.

## G7. Table Storage

Schema-flexible NoSQL key/value storage organized by partition and row keys. Access patterns and partition design strongly affect scalability and query behavior.

**Checklist:** design partition/row keys around query patterns and hot-partition risk; understand consistency and transaction boundaries; choose a more feature-rich database if relational queries, complex indexing or broader guarantees are required.

## G8. Storage redundancy — LRS, ZRS, GRS and GZRS

- **LRS:** locally redundant copies in a single physical location within a region; lower-cost option but limited against broader regional/site failures.
- **ZRS:** synchronously replicates across availability zones in a supported region for zonal resilience.
- **GRS:** replicates regionally to a secondary region, generally with asynchronous replication; secondary access behavior depends on the option/configuration.
- **GZRS:** combines zone redundancy in the primary region with geo-replication to a secondary region.
- **RA-GRS / RA-GZRS:** read-access options for the secondary endpoint where supported.

**Decision checklist**
- [ ] Match redundancy to durability, regional outage risk, RPO/RTO, compliance and cost.
- [ ] Verify redundancy support for the specific service/account type and region.
- [ ] Understand replication is not backup: deletions/corruption can replicate.
- [ ] Define whether and how account failover is performed and how clients switch.
- [ ] Test restore independently of redundancy.

## Security and operations baseline

- [ ] Use Entra ID and least-privilege data roles where supported.
- [ ] Disable anonymous/public access unless explicitly required and approved.
- [ ] Configure private endpoints, DNS and routing as an end-to-end design.
- [ ] Enable logs, metrics, alerting and retention.
- [ ] Apply lifecycle policies and review retrieval/transaction charges.
- [ ] Protect critical data with appropriate versioning, soft delete, immutability and backup.
- [ ] Validate restore and application-level consistency.

## Enterprise scenario

An analytics platform stores raw and curated datasets in ADLS Gen2, uses private endpoints and managed identities for data-processing jobs, applies filesystem ACLs by data domain, and uses lifecycle rules for older datasets. Critical operational blobs have a tested recovery policy and geo-redundancy where required. Queue Storage decouples lightweight background processing, while Azure Files is used only for legacy shared-file semantics.

## Common mistakes
- Treating redundancy as a backup strategy.
- Enabling private endpoints without correct private DNS and client routing.
- Using account keys when scoped identity works.
- Choosing archive/cold tier without checking restore time and retrieval cost.
- Ignoring transaction, egress and replication charges.
- Misunderstanding ADLS ACLs vs Azure RBAC.

## Interview questions
**Q1. Blob vs ADLS Gen2?** ADLS Gen2 adds hierarchical namespace and filesystem-oriented capabilities for analytics while using Blob Storage foundations. Select based on analytics filesystem/access needs and integration.

**Q2. ZRS vs GZRS?** ZRS protects across supported availability zones within the primary region; GZRS adds geo-replication to a secondary region. Neither alone proves application recovery.

**Q3. Queue Storage vs Service Bus?** Queue Storage is a simpler queue; Service Bus provides richer broker semantics when required. Decide from ordering, sessions, duplicate handling, dead-lettering and messaging requirements.

## LinkedIn-ready post
Azure storage design is about access patterns and recoverability—not just capacity price. Compare protocol, latency, lifecycle, transactions, private access, identity, redundancy and restore objectives. Remember: replication can preserve deletion or corruption, so test backup and restore separately. #AzureStorage #DataArchitecture #Resilience

## Official references
- [Storage account overview](https://learn.microsoft.com/azure/storage/common/storage-account-overview)
- [Blob Storage](https://learn.microsoft.com/azure/storage/blobs/storage-blobs-introduction)
- [ADLS Gen2](https://learn.microsoft.com/azure/storage/blobs/data-lake-storage-introduction)
- [Azure Files](https://learn.microsoft.com/azure/storage/files/storage-files-introduction)
- [Storage redundancy](https://learn.microsoft.com/azure/storage/common/storage-redundancy)
