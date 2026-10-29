# F. Containers & Kubernetes

**[Component architecture map](architecture.mmd)** — arrows show a typical dependency/learning flow, not a mandatory deployment order.


[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json)

This category compares container packaging, image storage, serverless containers and Kubernetes. Pick the lowest operational model that satisfies workload needs.

## Checklist
- [ ] Explain image vs container, registry and runtime
- [ ] Secure and scan images in ACR
- [ ] Choose Container Apps vs AKS vs ACI
- [ ] Design AKS identity, network, ingress, node pools, upgrades and scaling
- [ ] Use workload identity instead of embedded credentials where supported
- [ ] Monitor container health, costs, supply chain and runtime security

## Decision guide

~~~mermaid
flowchart TD
    NeedOrchestration{Need Kubernetes API / ecosystem?}
    NeedOrchestration -->|Yes| AKS[Azure Kubernetes Service]
    NeedOrchestration -->|No| NeedAppScale{Long-running app or event-driven container?}
    NeedAppScale -->|Yes| CA[Azure Container Apps]
    NeedAppScale -->|No| Short[Short-lived/simple container job]
    Short --> ACI[Azure Container Instances where suitable]
    Source[Application source] --> Build[Build and test image]
    Build --> Scan[Scan and sign according to policy]
    Scan --> ACR[Azure Container Registry]
    ACR --> Deploy[Deploy to selected runtime]
~~~

## F1. Docker and container fundamentals

A container image packages application files, dependencies and runtime metadata; a container is a running instance of that image. Containers share the host kernel and are not equivalent to full virtual machines.

**Checklist:** use small trusted base images, multi-stage builds, non-root execution where possible, immutable tags/digests, health checks, dependency pinning, image scanning, secret injection at runtime and graceful shutdown. Never bake credentials into an image.

## F2. Azure Container Registry (ACR)

Managed registry for container images and related artifacts. Integrates with Azure identity and supported build/deployment workflows.

**Design:** disable anonymous/public access when not required; use private networking where supported; assign pull/push roles narrowly; separate build and runtime identities; configure retention/cleanup and vulnerability scanning according to capability and organizational tooling.

**Checklist**
- [ ] Use unique immutable release tags and digest pinning for production.
- [ ] Separate build push permissions from runtime pull permissions.
- [ ] Scan dependencies and image layers; remediate base-image vulnerabilities.
- [ ] Plan replication/geo-redundancy based on region and recovery requirements.
- [ ] Monitor registry access, image lifecycle and storage cost.

## F3. Azure Container Apps

Managed container application platform suited to APIs, microservices, background jobs and event-driven workloads without managing Kubernetes control plane directly. Supports revisions and scaling features depending on configuration.

**Use when:** teams need managed container deployment and app-level scaling with less cluster operations. **Consider AKS when:** Kubernetes API, ecosystem control, custom scheduling or cluster-level capabilities are required.

**Checklist:** configure ingress and internal/external exposure intentionally; use managed identity; define scaling rules and min/max replicas; manage secrets securely; use revisions for controlled rollout; monitor replica startup, logs and scale-to-zero implications.

## F4. Azure Kubernetes Service (AKS)

Managed Kubernetes control plane with customer responsibility for cluster configuration, node pools, workloads, network policy, identity, upgrades, security posture and operations. Management burden is lower than self-hosting Kubernetes but not zero.

**Architecture decisions**
- Separate system/user node pools when workload isolation or lifecycle needs justify it.
- Choose network model and address planning before deployment; pod/service CIDRs can be difficult to change later.
- Use workload identity for pod access to Entra-protected resources where supported.
- Select ingress implementation based on supported options and lifecycle; verify current Microsoft guidance because Kubernetes ecosystem components evolve.
- Define cluster/node autoscaling, pod requests/limits, disruption budgets and topology spread.
- Plan upgrades, node image updates, backup/recovery, policy, logging and cost ownership.

**AKS checklist**
- [ ] Private/public API endpoint posture and authorized network access.
- [ ] Entra integration, least-privilege Kubernetes/Azure RBAC and workload identity.
- [ ] Network policy, ingress TLS, secrets and image supply-chain controls.
- [ ] Requests/limits, autoscaling, health probes and graceful termination.
- [ ] Upgrade channels, maintenance windows, node pool rotation and rollback plan.
- [ ] Monitor control plane, nodes, pods, scheduling failures, latency and cost.
- [ ] Test cluster and workload recovery; don't assume Kubernetes manifests are a complete backup.

## F5. Azure Container Instances (ACI)

Runs containers without managing VMs or a Kubernetes cluster. Fits simple isolated container workloads and some short-lived tasks where the supported features meet needs. It is not a replacement for a full orchestration platform for every long-running microservice estate.

**Checklist:** validate networking, restart behavior, persistence, identity, resource limits, logging and region support; compare with Container Apps Jobs or AKS based on scheduling, scale and operational requirements.

## F6. AKS ingress, scaling and workload identity

Ingress exposes HTTP(S) services through a controller/gateway implementation; it needs TLS, DNS, health checks and network policy aligned with the chosen implementation. Scaling occurs at different layers: pod replicas, node capacity and sometimes application event-driven scale.

**Checklist**
- [ ] Pick ingress based on support, lifecycle, WAF needs and private/public exposure.
- [ ] Configure pod resource requests/limits and HPA or supported event-driven scaling.
- [ ] Enable cluster autoscaler and verify node pool quota/capacity.
- [ ] Use workload identity and narrowly scoped roles; avoid static cloud credentials in Kubernetes secrets.
- [ ] Test DNS, certificates, pod disruption, node drain and zone loss.

## Enterprise scenario

A company containerizes a web API. ACR stores signed/scanned images; Container Apps hosts a team-owned service that does not need Kubernetes APIs; AKS is reserved for workloads requiring Kubernetes control and ecosystem compatibility. Each runtime uses managed/workload identity, private connectivity where needed, monitored deployment revisions and tested recovery.

## Common mistakes
- Choosing AKS when a simpler managed container service fits.
- Assuming a private cluster automatically secures all ingress and egress.
- Using mutable `latest` tags in production.
- Storing secrets in images or plain manifests.
- Ignoring node upgrades, pod disruption and quota during scale-out.
- Treating deployment manifests as sufficient disaster recovery.

## Interview questions
**Q1. Container Apps vs AKS?** Container Apps abstracts more platform operations for app-centric container workloads; AKS is appropriate when Kubernetes API and cluster-level control are requirements.

**Q2. How do you secure container supply chain?** Pin base images, scan dependencies and layers, build from trusted sources, use immutable digests, protect registry access, sign/verify according to policy and monitor runtime.

**Q3. What are the AKS scaling layers?** Application/pod replica scaling, node capacity scaling and workload/event-driven scaling where supported. Each needs metrics, bounds, quotas and graceful behavior.

## LinkedIn-ready post
Kubernetes is powerful, but it is not the default answer for every container. Compare Container Apps, ACI and AKS by control requirements, scale, networking, identity, operations and cost. Secure the image supply chain and plan upgrades before production. #Azure #AKS #Containers #DevSecOps

## Official references
- [Azure Kubernetes Service](https://learn.microsoft.com/azure/aks/what-is-aks)
- [Azure Container Apps](https://learn.microsoft.com/azure/container-apps/overview)
- [Azure Container Registry](https://learn.microsoft.com/azure/container-registry/container-registry-intro)
- [Azure Container Instances](https://learn.microsoft.com/azure/container-instances/container-instances-overview)

## Component dependency flow

The diagram includes every component in this catalog and shows a typical progression plus cross-cutting controls.

~~~mermaid
flowchart LR
  subgraph CATF["F · Containers and Kubernetes"]
    n1["Docker and Container Fundamentals"]
    n2["Azure Container Registry ACR"]
    n1 --> n2
    n3["Azure Container Apps"]
    n2 --> n3
    n4["Azure Kubernetes Service AKS"]
    n3 --> n4
    n5["Azure Container Instances ACI"]
    n4 --> n5
    n6["AKS Ingress Scaling and Workload Identity"]
    n5 --> n6
  end
  Identity[Entra ID / RBAC] -. cross-cutting .-> n1
  Network[Network / DNS / private access] -. cross-cutting .-> n3
  Operations[Monitor / logs / cost] -. cross-cutting .-> n6
~~~
