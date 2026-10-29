# D. Traffic Management & Delivery

[← Master catalogue](../README.md) · [Machine-readable catalogue](../catalog.json)

Keep traffic decisions together on this page: global vs regional entry, Layer 4 vs Layer 7, private administration, DNS, DDoS and observability.

## Checklist
- [ ] Choose global or regional entry point from latency, routing and failover needs
- [ ] Distinguish Load Balancer, Application Gateway/WAF, Front Door and Traffic Manager
- [ ] Design TLS, health probes, origin access and failover behavior
- [ ] Protect administration with Bastion and appropriate identity controls
- [ ] Design Azure DNS and private DNS interactions
- [ ] Apply DDoS protection based on workload exposure and risk
- [ ] Use Network Watcher to validate effective paths and troubleshoot

## Reference ingress pattern

~~~mermaid
flowchart TB
    User[Users] --> DNS[Azure DNS / public DNS]
    DNS --> Global[Azure Front Door or Traffic Manager when needed]
    Global --> Regional[Application Gateway + WAF]
    Regional --> LB[Internal Load Balancer when needed]
    LB --> App[Application instances]
    Admin[Administrator] --> Bastion[Azure Bastion]
    Bastion --> PrivateVM[Private VM management]
    App --> Monitor[Metrics, logs and alerts]
~~~

Choose only the layers that satisfy requirements. A global service, regional WAF and internal load balancer are not automatically all required.

## D1. Azure Load Balancer

Layer 4 TCP/UDP load balancing for supported inbound and outbound scenarios. Use it for high-performance network traffic distribution, including internal load balancing. It does not provide HTTP path routing or a web application firewall.

**Design:** frontend IP, backend pool, health probe, load-balancing rule, session persistence requirements and outbound configuration. Confirm SKU, zone and outbound behavior against current service docs.

**Checklist**
- [ ] Configure meaningful health probes and make the application probe endpoint accurate.
- [ ] Understand whether probe failure removes a backend from rotation.
- [ ] Design zone redundancy and outbound connectivity intentionally.
- [ ] Test backend failure and return-path behavior.

## D2. Application Gateway and WAF

Regional Layer 7 HTTP(S) application delivery. Application Gateway supports host/path-based routing and TLS termination; WAF capability helps detect/block supported web attack patterns.

**Use when:** regional HTTP(S) routing, private application ingress or WAF policy is required. **Not a replacement for:** global edge routing or generic TCP/UDP balancing.

**Checklist**
- [ ] Choose tier based on required features, autoscaling, zone support and cost.
- [ ] Configure listeners, certificates, backend settings, probes and routing rules.
- [ ] Tune WAF policy in detection/prevention rollout with logs and false-positive review.
- [ ] Restrict origin access and validate TLS end-to-end as required.
- [ ] Monitor backend health, capacity, WAF matches and latency.

## D3. Azure Front Door

Global edge entry point for HTTP(S), with acceleration, global routing, health-based origin selection and supported WAF/CDN capabilities depending on tier/configuration.

**Use when:** global web applications need edge routing, low-latency delivery, origin failover or centralized edge policy. It is not a generic substitute for private Layer 4 balancing.

**Checklist:** define origin groups, health probes, caching behavior, TLS, WAF policy, origin access restrictions and failover criteria. Verify private-origin support and feature/tier requirements for the selected design.

## D4. Traffic Manager

DNS-based traffic distribution across endpoints. Clients resolve a DNS name and receive endpoint responses according to routing method and health checks. It does not proxy each application request, so DNS TTL and client resolver caching affect failover timing.

**Use when:** DNS-level global endpoint selection, including supported non-HTTP endpoints. Compare with Front Door when HTTP proxying, edge acceleration or application-layer capabilities are needed.

**Checklist:** choose priority, weighted, performance, geographic or other supported routing method based on requirements; configure endpoint health; test TTL/caching and endpoint failover.

## D5. Azure Bastion

Managed secure RDP/SSH access to supported Azure VMs over TLS without exposing VM management ports directly to the public internet.

**Checklist:** deploy to the required dedicated subnet and supported configuration; enforce identity/MFA and administrative authorization; log sessions where supported; remove public IPs/NSG openings that are no longer required; review cost and SKU features.

## D6. Azure DNS

Hosts public DNS zones and records; private DNS zones are covered in the networking category. DNS controls name resolution, not authorization or network reachability by itself.

**Checklist:** use correct registrar delegation, record TTLs, ownership and change control; plan DNSSEC only where supported and required; monitor certificate and record dependencies; validate split-horizon/public-private name resolution.

## D7. DDoS Protection

Azure DDoS Network Protection protects supported public IP resources in virtual networks against network-layer attacks; application-layer HTTP protection is a separate concern typically addressed with WAF and edge design. Exact capabilities and charging depend on current plan and service model.

**Checklist:** inventory exposed public IPs, confirm supported resources/regions, define alert/response contacts, integrate telemetry and validate incident procedures. Do not assume a WAF alone covers every DDoS vector.

## D8. Network Watcher

Network diagnostic service/tooling for supported connection troubleshooting, effective security rules, routing diagnostics, packet capture and flow visibility.

**Checklist:** enable only required diagnostics in appropriate regions, protect captured traffic because it may contain sensitive information, define retention, and use connection troubleshoot/effective routes/NSG diagnostics to isolate path failures.

## Selection matrix

| Requirement | Likely starting point | Important distinction |
|---|---|---|
| TCP/UDP distribution | Load Balancer | Layer 4, not HTTP WAF |
| Regional HTTP(S), path routing, WAF | Application Gateway | Regional Layer 7 |
| Global HTTP(S), edge routing/failover | Front Door | Global edge/proxy service |
| DNS-level endpoint selection | Traffic Manager | DNS TTL/caching affects failover |
| Private VM administration | Bastion | Avoid exposing SSH/RDP publicly |
| Public name hosting | Azure DNS | DNS alone does not secure endpoint |
| Network-layer DDoS risk | DDoS Protection | Pair with app-layer controls as needed |
| Diagnose route/connection issue | Network Watcher | Observability/diagnostics, not a traffic gateway |

## Enterprise scenario

A global application uses Front Door for edge routing and global origin health. Each region has Application Gateway/WAF for regional HTTP routing; internal Load Balancer is used only if a backend requires Layer 4 distribution. Bastion provides VM administration. DNS, WAF, backend health, DDoS telemetry and origin access are reviewed together. The design is tested by failing a region and validating DNS, TLS, application health and recovery objectives.

## Common mistakes
- Stacking every traffic service without a requirement.
- Assuming Traffic Manager proxies requests or fails over instantly regardless of DNS caching.
- Misconfigured health probes that mark unhealthy applications as healthy.
- Exposing origins so clients can bypass intended Front Door/WAF controls.
- Assuming WAF covers network-layer DDoS or all application threats.
- Leaving public SSH/RDP open after Bastion is deployed.

## Interview questions
**Q1. Front Door vs Traffic Manager?** Front Door is a global HTTP(S) edge/proxy service with application-layer capabilities; Traffic Manager selects endpoints via DNS and clients connect to those endpoints directly.

**Q2. Load Balancer vs Application Gateway?** Load Balancer is Layer 4 TCP/UDP; Application Gateway is regional Layer 7 HTTP(S) with host/path routing and optional WAF.

**Q3. How do you prove failover works?** Simulate a backend/region failure in a controlled test, observe health detection and routing/DNS behavior, validate application transactions, and measure recovery time.

## LinkedIn-ready post
Traffic architecture should be requirement-driven. Layer 4 load balancing, regional Layer 7 WAF, global edge routing and DNS failover solve different problems. Select the minimum set that meets requirements, secure origins, configure truthful health probes and test failure behavior. #AzureNetworking #ApplicationDelivery #CloudArchitecture

## Official references
- [Azure Front Door](https://learn.microsoft.com/azure/frontdoor/front-door-overview)
- [Application Gateway](https://learn.microsoft.com/azure/application-gateway/overview)
- [Load Balancer](https://learn.microsoft.com/azure/load-balancer/load-balancer-overview)
- [Traffic Manager](https://learn.microsoft.com/azure/traffic-manager/traffic-manager-overview)
- [Azure Bastion](https://learn.microsoft.com/azure/bastion/bastion-overview)
- [Network Watcher](https://learn.microsoft.com/azure/network-watcher/network-watcher-overview)
