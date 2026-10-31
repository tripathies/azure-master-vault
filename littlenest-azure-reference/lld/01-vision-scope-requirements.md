# 01 — Vision, Scope and Requirements

## 1. Vision

Build a small, understandable e-commerce workload that demonstrates how common Azure platform services work together to host a private web application and process orders asynchronously.

LittleNest Kidswear is a learning vehicle, not a commercial launch. Its purpose is to help a learner trace a user action through application, identity, network, data and operations layers, then map each design decision to Terraform and validation steps.

### Outcomes

- A learner can run a credential-free local storefront and understand the application flow.
- A learner can inspect the Terraform and identify the Azure resources and dependencies.
- A reviewer can understand the private connectivity and managed-identity trust model.
- A learner can deploy into a dedicated non-production subscription after checking permissions, region support, quota and cost.
- A learner can validate the order lifecycle and clean up lab resources.

### Architectural principles

| Principle | Application to LittleNest |
|---|---|
| Secure by default | Private inbound access for Azure-hosted apps; no public production-style ingress in Profile A |
| Identity over secrets | Managed identities and Entra ID data-plane authorisation |
| Least privilege | Scope role assignments to the workload resources and required data actions |
| Small, reversible lab | Dedicated non-production resource group and explicit teardown |
| Infrastructure as code | Terraform defines the workload resources |
| Observable operation | Validate health, app logs, worker execution, dependencies and cost |
| Honest scope | Mark optional, manual and future controls rather than implying they are deployed |

## 2. Scope

### 2.1 In scope — Profile A

- Node.js storefront hosted locally for demo, and designed for Azure App Service deployment.
- Azure Functions Flex Consumption order worker.
- Azure Cosmos DB for NoSQL for product and order data.
- Azure Storage Queue for asynchronous order processing.
- Azure Storage for Function host / deployment storage and related workload needs.
- Azure Key Vault for the optional synthetic-secret exercise.
- VNet, dedicated subnets, private endpoints and private DNS zones for private service connectivity.
- System-assigned managed identities and scoped role assignments.
- Terraform-based infrastructure provisioning.
- Azure context preflight, Cosmos seed helper and validation procedures.
- Basic operational and cost guidance.

### 2.2 Out of scope

- Entra tenant, management group, subscription or enterprise landing-zone creation.
- Hub-and-spoke network, central firewall, enterprise DNS resolver, ExpressRoute or VPN provisioning.
- Public internet ingress, Front Door, WAF, API Management or DDoS architecture.
- Production-grade payment processing, payment-card data, tax calculation, fulfilment or inventory integration.
- Real customer PII or production business records.
- Multi-region active-active, formal disaster recovery, production SLA or business continuity commitments.
- Enterprise SIEM integration, SOC processes or a fully managed observability platform.
- Automated budget enforcement or a hard spending cap.

These may be future extensions, but they are not silently assumed to exist in the baseline.

### 2.3 Assumptions and constraints

1. The learner has an existing, governed, disposable non-production Azure subscription.
2. The learner has authority to create the required resources and role assignments.
3. The selected region supports the chosen Functions Flex Consumption runtime and has sufficient quota.
4. Private access requires a client / runner with a route and DNS resolution into the VNet. A deployed app is not publicly reachable by design.
5. Terraform state is local in the current lab. It must be protected and must not be committed.
6. Cosmos DB Free Tier is conditional on subscription eligibility and account limits. Other services and private endpoints still incur charges.
7. All sample catalogue and order data is synthetic.

## 3. Stakeholders and users

| Persona | Need |
|---|---|
| Learner / developer | Run the local demo, understand code and test application behaviour |
| Cloud engineer | Review Terraform, deploy to a non-production subscription and troubleshoot |
| Security reviewer | Assess identities, permissions, network boundaries and data handling |
| Operations reviewer | Understand health signals, failure modes, recovery and cleanup |
| Cost owner | Understand cost drivers, budgets, tagging and teardown responsibilities |

## 4. Functional requirements

| ID | Requirement | Baseline acceptance evidence |
|---|---|---|
| FR-01 | Display a synthetic product catalogue | Storefront product page and `GET /api/products` |
| FR-02 | Expose an application health endpoint | `GET /healthz` returns healthy status |
| FR-03 | Accept a demo order | `POST /api/orders` creates an order in Received state |
| FR-04 | Queue order processing asynchronously | A message is sent to the Storage Queue |
| FR-05 | Process an order in the background | Function worker consumes the message |
| FR-06 | Persist order processing outcome | Order transitions to Processed after successful worker processing |
| FR-07 | Support local demo without Azure | Local demo mode uses bundled data / in-memory checkout and no Azure resources |
| FR-08 | Support infrastructure provisioning as code | Terraform format, init and validate checks pass |
| FR-09 | Support private service connectivity | Private endpoint, DNS and network validation procedures pass after deployment |
| FR-10 | Support identity-based service access | Managed identity and data-plane role validation passes |

## 5. Non-functional requirements

The following are design targets for this learning lab, not contractual production SLAs.

| ID | Area | Requirement / target | Validation |
|---|---|---|---|
| NFR-01 | Security | No secrets, keys or credentials committed to source control | Repository scan and code review |
| NFR-02 | Identity | Workload service calls use managed identities where supported | Inspect app settings, identity and role assignments |
| NFR-03 | Network | Azure-hosted app and data services are privately accessible | Private DNS, route and HTTPS checks from connected client |
| NFR-04 | Availability | Demo may tolerate interruption; no production uptime commitment | Health endpoint and manual recovery test |
| NFR-05 | Performance | Interactive catalogue and order API are suitable for low-volume learning use | Smoke test; no production load target |
| NFR-06 | Scalability | Background processing is decoupled through a queue | Verify queue-trigger processing; scale limits remain plan-dependent |
| NFR-07 | Recoverability | Lab can be recreated from source and synthetic seed data | Re-deploy and seed in a disposable environment |
| NFR-08 | Operability | App, queue and worker failure can be diagnosed from documented signals | Follow monitoring runbook |
| NFR-09 | Cost | Use small lab SKUs, tag resources and destroy after exercises | Cost review and post-destroy resource check |
| NFR-10 | Maintainability | Terraform and application source are version-controlled and documented | CI and pull-request review |

## 6. Acceptance criteria

A learner may mark the lab complete only when:

- [ ] Local demo works without Azure credentials.
- [ ] Terraform formatting and validation pass.
- [ ] Azure tenant, subscription, region and quota are checked before apply.
- [ ] A reviewed Terraform plan matches the intended lab scope.
- [ ] The deployed app is reachable only through the intended private path.
- [ ] Product read and order create operations work.
- [ ] The queue worker processes an order and updates its status.
- [ ] Identity and private DNS checks pass.
- [ ] Logs and operational signals are inspected.
- [ ] Terraform destroy is completed and residual resources / costs are checked.

Passing local CI is not equivalent to satisfying the live Azure acceptance criteria.
