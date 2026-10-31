# 06 — Implementation and Validation Plan

## 1. Delivery approach

Implement Escanor in controlled increments. Do not deploy the entire production diagram as a single Terraform apply. Establish the AWS foundation, build the non-production profile, validate each drift plane, then introduce AgentCore after the evidence and tool contracts are stable.

## 2. Preconditions

- Approved AWS Organization and Control Tower landing zone.
- Dedicated Escanor non-production member account.
- IAM Identity Center access and a named deployment identity.
- Region decision: proposed `ap-south-1`; recovery `us-east-1`.
- Service availability, EKS version, AgentCore features, model access, AZs, quotas and cost checked.
- Protected Git repository and OIDC deployment trust.
- Terraform version and provider versions pinned and tested.
- Remote state design approved before any shared / CI apply.
- AWS Budgets and cost-anomaly alerts configured with active recipients.
- Data classification and retention rules approved.

## 3. Implementation stages

| Stage | Scope | Exit gate |
|---|---|---|
| 0 — Foundation readiness | Verify landing zone, target account, identity, budgets and Regions | Account boundary, access, audit and cost controls proven |
| 1 — Terraform bootstrap | State bucket, KMS, lock mechanism, deployment roles and CI OIDC | State access restricted; no static credentials; plan identity tested |
| 2 — Network | VPC, subnets, routes, security groups, VPC endpoints and DNS | Private paths and egress rules validated |
| 3 — EKS foundation | Cluster, node groups, cluster access, add-ons and ECR | Supported EKS version; cluster health and access verified |
| 4 — GitOps and workload | Argo CD, namespaces, service accounts and deployment pipeline | Git-to-cluster reconciliation validated |
| 5 — Observability | Prometheus, Grafana, Alertmanager, Fluent Bit and CloudWatch integration | Required telemetry and independent alert delivery verified |
| 6 — Drift planes 1–3 | Terraform/AWS Config, Argo CD and Kubernetes runtime collectors | Test fixtures produce correct, deduplicated findings |
| 7 — FinOps plane | CUR 2.0, S3, Glue, Athena and utilisation history | Query results reconcile with billing data and resource inventory |
| 8 — Evidence contract | Normaliser, RDS schema, S3 evidence, lifecycle and cardinality controls | Schema, concurrency, stale finding and retry tests pass |
| 9 — AgentCore | Runtime / harness, Gateway, Identity, approved tools and evaluations | IAM negative tests pass; citations and safe behaviour meet thresholds |
| 10 — Console | Streamlit UI, authentication, network exposure and evidence links | Authenticated user can inspect evidence; no unauthorised actions |
| 11 — Hardening and recovery | Threat tests, backup restore, teardown and runbooks | Security and recovery gates signed off |

FinOps collection should begin early enough to build utilisation history. A rightsizing feature cannot truthfully analyse a long historical window if data collection begins only after the agent is built.

## 4. Infrastructure code structure

The planned Terraform module layout is documented in [infra/README.md](../infra/README.md). Keep modules small, composable and owned by one layer. Do not create one monolithic root module for both the landing zone and Escanor workload.

## 5. Engineering quality gates

### 5.1 Terraform and CI
- `terraform fmt -check -recursive`
- `terraform init -backend=false` for static validation where appropriate
- `terraform validate`
- `terraform plan` with explicit account and Region
- Static security checks (for example, Checkov or equivalent)
- Provider and module version pinning
- Plan artifact review and approval before apply
- No state / plan / credentials in source control

### 5.2 Application and collector tests
- Unit tests for each collector and normaliser.
- Contract tests for the versioned finding schema.
- Fixture-based tests for missing resource, changed resource, duplicate event and collection race.
- Retry, pagination, rate-limit and timeout tests.
- Exporter cardinality and scrape-performance tests.
- Integration tests against disposable AWS resources, never production.

### 5.3 Identity and agent tests
- IAM policy simulation for each execution role.
- Explicit denial tests for write, delete, terminate and detach operations in the default agent path.
- OIDC tests for allowed and rejected repository claims.
- Cross-cloud issuer / audience / subject negative tests where enabled.
- Tool schema tests for malformed and out-of-scope arguments.
- Prompt-injection and untrusted-finding-text tests.
- Approval binding tests against a changed resource state.
- Ensure alert delivery works with AgentCore disabled.

## 6. Agent evaluation gates

The source LLD proposes the following quality thresholds. They should be retained as candidate release gates and validated against a representative, labelled evaluation set before adoption:

| Measure | Candidate gate |
|---|---:|
| Tool selection accuracy | ≥95% |
| Evidence / citation completeness | 100% |
| Recommendation correctness | ≥90% |
| Unsupported factual claims in evaluated answers | 0 |
| p95 response latency | <14 seconds |

Measure results by task category, not only as one aggregate score. A high tool-selection score does not compensate for an unsafe action or missing evidence.

## 7. Cost and teardown gates

Before each apply:
- Review every planned resource and recurring cost.
- Check Region-specific rate, data transfer, public IPv4, NAT and VPC endpoint cost.
- Confirm EKS cluster and node-group hours.
- Confirm RDS, EBS, load balancer and snapshot retention.
- Confirm CloudWatch, Prometheus, Athena and AgentCore usage assumptions.
- Confirm the account budget and alert recipients.

Before leaving a lab:
- Run the reviewed destroy plan.
- Check Kubernetes LoadBalancer Services and PVC-created EBS volumes.
- Inspect ECR, snapshots, EBS volumes, Elastic IPs, NAT Gateways, load balancers, RDS and S3 retention.
- Confirm no manual resources remain.
- Review Cost Explorer after billing data updates.

Terraform destroy is not proof that all cloud resources are gone. Kubernetes controllers, snapshots, retained data and manually created resources must be checked separately.

## 8. Production-readiness exit criteria

Do not label Escanor production-ready until:
1. All four drift planes have validated collectors and defined coverage.
2. Identity and cross-account boundaries have passed security review.
3. Agent authority has been enforced and tested at the AWS API boundary.
4. The alerting path works independently of the agent.
5. FinOps findings reconcile with CUR and actual subsequent billing.
6. Backup restore and regional recovery have been measured.
7. Cost and scale tests match the stated workload objectives.
8. Operations, ownership, escalation and change approval are defined.
9. Relevant AWS Well-Architected reviews have been completed and actions closed.
10. Deployment evidence and the exact tested commit are retained.

## 9. Status reporting

Every project release should classify each capability as:
- Designed.
- Implemented in source.
- Static validation passed.
- Tested in an AWS account.
- Observed in a running environment.
- Production-ready (only after formal review and approval).

Do not collapse these into a single "complete" status.
