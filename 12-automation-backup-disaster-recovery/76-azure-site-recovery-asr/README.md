# 76. Azure Site Recovery & Replication

[← Category 12](../README.md) · [← Master catalogue](../../README.md)

> **Purpose:** Replicate supported workloads to a recovery location and orchestrate planned or unplanned failover. This guide owns Site Recovery replication behavior. Recovery sequencing and exercise procedures are covered in [Recovery Plans, Failover & DR Testing](../79-recovery-plans-failover-testing/README.md).

## 1. What Azure Site Recovery does

Azure Site Recovery (ASR) supports disaster recovery for supported Azure virtual machines and selected on-premises or hybrid source environments. It replicates workload data to a target location and helps orchestrate failover and recovery. Supported source/target combinations, regions, operating systems and feature limits must be checked in the current support matrix.

ASR is not a backup service. Replication can reproduce corruption or unwanted changes; retain independent backup protection where point-in-time recovery is required.

## 2. Reference flow

~~~mermaid
flowchart LR
  Primary[Primary workload] --> Replication[ASR replication]
  Replication --> Recovery[Recovery region / target]
  Recovery --> Test[Test failover in isolated network]
  Test --> Evidence[Application and business validation]
  Incident[Declared disaster] --> Plan[Recovery plan]
  Plan --> Failover[Failover]
  Failover --> Validate[DNS, identity, routes and app checks]
  Validate --> Service[Recovered business service]
  Service --> Reprotect[Reprotect and failback]
~~~

## 3. Architecture decisions

### Source and target support
- Confirm the source platform, operating system, disk layout and target scenario are supported.
- Confirm region, zone and subscription support, capacity, quotas and required providers.
- Check the current [Azure Site Recovery support matrix](https://learn.microsoft.com/en-us/azure/site-recovery/).

### Replication configuration
- Select replication policy, recovery-point retention and app-consistent snapshot settings where supported.
- Understand initial replication, ongoing delta replication, churn, bandwidth and recovery-point processing.
- For Azure-to-Azure scenarios, assess cache storage, target storage and region/zone requirements.
- Monitor replication health and lag; a protected item with unhealthy replication is not a recoverable design.

### Target environment
- Pre-plan VNet, subnets, NSGs, routes, private endpoints, DNS, identity, certificates, secrets and external dependencies.
- Reserve compute and network capacity in the recovery location.
- Define how traffic reaches the recovered application and how users are redirected.
- Ensure operators can access the recovery environment if the primary identity or connectivity path is affected.

## 4. Failover lifecycle

Distinguish these operations:

1. **Test failover:** Validate recovery in an isolated test network without interrupting production replication.
2. **Planned failover:** Used when the primary environment is available and a controlled transition is possible.
3. **Unplanned failover:** Used after a disruption; select a recovery point based on business tolerance for data loss.
4. **Commit:** Confirm the selected recovery point after validating the failover VM/workload.
5. **Reprotect:** Resume replication in the reverse direction or to the intended protection target after failover.
6. **Failback:** Return to the intended primary environment when it is ready, following the supported workflow.

Never treat failover as complete until the application—not merely the VM—is validated.

## 5. Dependency design

Map the full recovery chain:

- Identity, privileged access and workload identities.
- DNS zones, resolver/forwarding, hostname changes and certificate dependencies.
- Network address mapping, routes, firewalls, NSGs and private endpoints.
- Databases, queues, storage, secrets, licensing and external integrations.
- Traffic routing, load balancing, health probes and user access.
- Monitoring, incident communications and business sign-off.

A VM can start successfully while the application remains unavailable because one of these dependencies is missing.

## 6. Operational checklist

- [ ] Verify source/target compatibility and current service limits.
- [ ] Define workload RTO/RPO and approved recovery-point choice.
- [ ] Confirm replication health and alert on lag or protection issues.
- [ ] Confirm target compute, network and quota capacity.
- [ ] Run test failover in an isolated network.
- [ ] Validate application transactions and dependencies.
- [ ] Measure RTO and observed data loss; record evidence.
- [ ] Exercise planned/unplanned failover and failback procedures where applicable.
- [ ] Revisit the plan after application, network, identity or platform changes.

Detailed sequencing, automated/manual steps and drill evidence belong in [Recovery Plans, Failover & DR Testing](../79-recovery-plans-failover-testing/README.md).

## 7. Common mistakes

- Using replication as the only protection against data corruption or malicious deletion.
- Failing to test a recovery environment isolated from production.
- Forgetting DNS, identity, certificates, network paths or application dependency order.
- Assuming a healthy replication status guarantees a successful service recovery.
- Failing to reserve or validate target-region capacity.
- Not rehearsing reprotect and failback.

## 8. Interview questions

**Q1. What is the difference between replication and backup?**  
Replication maintains a copy of workload changes at a recovery target for failover. Backup retains recovery points for restore and retention. Replication may reproduce logical corruption; backup gives a separate point-in-time recovery path.

**Q2. How do you prove an ASR design meets RTO/RPO?**  
Run controlled test failovers, measure time until business transactions succeed, record the selected recovery-point timestamp, compare observed data loss and recovery time against approved objectives, and track gaps.

## Official references

- [Azure Site Recovery documentation](https://learn.microsoft.com/en-us/azure/site-recovery/)
- [About Site Recovery](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview)
- [Recovery plans](https://learn.microsoft.com/en-us/azure/site-recovery/recovery-plan-overview)
- [Failover and failback — modernized VMware/physical scenarios](https://learn.microsoft.com/en-us/azure/site-recovery/failover-failback-overview-modernized)
- [Reliability in Azure Site Recovery](https://learn.microsoft.com/en-us/azure/reliability/reliability-site-recovery)
