# I. Integration & API Management

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json)

Integration design separates synchronous API requests from asynchronous messages and event notifications. Choose based on delivery guarantees, ordering, throughput, consumer coupling and replay requirements.

## Checklist
- [ ] Design API gateway, authentication, authorization, throttling and versioning
- [ ] Choose Service Bus vs Event Grid vs Event Hubs vs Queue Storage
- [ ] Explain event-driven vs message-driven architectures
- [ ] Design retries, dead-lettering, idempotency, schema and replay
- [ ] Secure identities, endpoints and secrets
- [ ] Monitor lag, failures, throttling and end-to-end delivery

## Reference integration architecture

~~~mermaid
flowchart LR
    Client[Client] --> APIM[API Management]
    APIM --> API[Application API]
    API --> Bus[Service Bus: commands/work queues]
    API --> Events[Event Grid: discrete events]
    Stream[Telemetry / clickstream] --> Hubs[Event Hubs: event streams]
    Hubs --> Process[Stream processing]
    Bus --> Worker[Background workers]
    Events --> Subscribers[Event subscribers]
    APIM --> Monitor[API metrics, logs and alerts]
~~~

These services are not interchangeable. Choose each by message/event semantics and operational requirements.

## I1. API Management (APIM)

API gateway and API lifecycle platform for publishing, securing, transforming, versioning, throttling and observing APIs. APIM is not a substitute for application authorization or backend security.

**Checklist**
- [ ] Choose tier from networking, scale, availability, features and cost.
- [ ] Define API products, subscriptions, versions/revisions and lifecycle.
- [ ] Validate JWT/OIDC, scopes/roles and backend authorization.
- [ ] Apply rate limits/quotas and protect backends from abusive traffic.
- [ ] Secure backend connectivity and credentials; prefer managed identity where supported.
- [ ] Avoid logging secrets or sensitive payloads; configure diagnostics and alerts.
- [ ] Test timeout, retry, throttling and backend failure behavior.

## I2. Azure Service Bus

Enterprise message broker for queues and topics/subscriptions, suited to decoupling commands/work, competing consumers, supported ordering/session patterns, dead-lettering and broker features.

**Checklist**
- Design queue/topic/subscription topology from ownership and consumer needs.
- Select duplicate detection, sessions/order and delivery/lock semantics where required.
- Make consumers idempotent; assume retries/redelivery can happen.
- Configure dead-letter monitoring and a safe replay procedure.
- Use managed identity and least-privilege data roles.
- Monitor active/dead-letter count, age, lock loss, throughput and throttling.
- Validate tier-specific features, message limits, regional/DR options and cost.

## I3. Azure Event Grid

Event routing service for discrete event notifications from supported publishers to subscribers. It is useful for reacting to state changes and distributing events, not as a high-throughput long-retention telemetry stream.

**Checklist:** define event schema and subscription filters; validate delivery/retry/dead-letter behavior for the chosen event source/destination; make handlers idempotent; secure endpoints; monitor delivery failures and latency; design replay from the source or an archive if needed.

## I4. Azure Event Hubs

High-throughput event ingestion and streaming platform, commonly used for telemetry, clickstream, logs and event streams. Partitions determine parallelism and ordering within a partition; consumer groups allow independent readers.

**Checklist:** choose partitions and retention based on throughput, ordering and consumers; use checkpoints; design consumer group ownership; plan capture/replay if required; monitor lag, throttling and partition skew; secure producer/consumer identity; validate throughput units/processing units and cost.

## I5. Azure Stream Analytics

Managed stream-processing service for supported streaming SQL queries, windows, temporal joins and output to supported destinations.

**Checklist:** define event-time vs arrival-time behavior; handle late/out-of-order events; size streaming units; validate query semantics with representative data; configure checkpoint/recovery and outputs; monitor input/output errors, watermark delay and resource utilization.

## I6. Azure Data Explorer

Analytics service optimized for fast exploration and analysis of high-volume time-series, telemetry and log-like data using Kusto Query Language (KQL).

**Checklist:** design ingestion mapping and retention; choose cluster/engine capacity; apply database/table permissions and network controls; optimize partitioning and query patterns; monitor ingestion lag and query resource use; control retention and export cost.

---

## Pattern selection matrix

| Need | Starting service | Why / caveat |
|---|---|---|
| Governed synchronous API access | API Management | Gateway policies, API lifecycle and observability; backend still needs auth |
| Durable commands and work queues | Service Bus | Broker semantics, dead-lettering and supported ordering/session patterns |
| Notify subscribers of discrete events | Event Grid | Event routing and filtering, not a long-retention telemetry stream |
| High-throughput telemetry/event stream | Event Hubs | Partitioned stream and independent consumer groups |
| Managed SQL-like stream transformations | Stream Analytics | Streaming query service with service-specific limits |
| Interactive analytics over telemetry/logs | Data Explorer | KQL-oriented ingestion and querying |

## Enterprise scenario

An order API is exposed through APIM with token validation and throttling. The order service places a command on Service Bus for durable processing. Event Grid notifies downstream systems of relevant resource/order events where its event semantics fit. Telemetry flows to Event Hubs for independent consumers and analytics in Data Explorer. Each consumer is idempotent, dead-letter and replay are documented, identities are scoped, and lag/delivery failures alert the owning team.

## Common mistakes
- Using Event Grid, Event Hubs and Service Bus interchangeably.
- Assuming at-least-once delivery means exactly-once business processing.
- Retrying poison messages indefinitely without dead-lettering and ownership.
- Using APIM as the only security control while leaving backend endpoints exposed.
- Ignoring partition design, consumer lag, schema evolution and replay.
- Logging bearer tokens or sensitive payloads.

## Interview questions
**Q1. Service Bus vs Event Grid vs Event Hubs?** Service Bus brokers business messages/commands; Event Grid routes discrete events; Event Hubs ingests high-volume streams. Choose from semantics, throughput, ordering, retention and replay.

**Q2. How do you avoid duplicate processing?** Design idempotent handlers, use supported duplicate detection where applicable, track business operation IDs, handle retries and dead-letter failures. Do not assume transport guarantees remove application-level duplicates.

**Q3. What does APIM add?** Central API publishing, policy, versioning, throttling, authentication integration, transformation and observability; the backend must still enforce appropriate authorization and protect data.

## LinkedIn-ready post
Event-driven architecture is strongest when every service has a clear role. Use an API gateway for governed synchronous access, a broker for durable commands, event routing for notifications and a stream platform for high-volume telemetry. Design idempotency, dead-lettering, replay and observability from day one. #AzureIntegration #EventDriven #APIManagement

## Official references
- [API Management](https://learn.microsoft.com/azure/api-management/api-management-key-concepts)
- [Service Bus](https://learn.microsoft.com/azure/service-bus-messaging/service-bus-messaging-overview)
- [Event Grid](https://learn.microsoft.com/azure/event-grid/overview)
- [Event Hubs](https://learn.microsoft.com/azure/event-hubs/event-hubs-about)
- [Stream Analytics](https://learn.microsoft.com/azure/stream-analytics/stream-analytics-introduction)
- [Azure Data Explorer](https://learn.microsoft.com/azure/data-explorer/data-explorer-overview)
