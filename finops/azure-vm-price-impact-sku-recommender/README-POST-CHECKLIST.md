# Validation & Publication Checklist

## Before running
- [ ] Confirm the Azure tenant and subscription context.
- [ ] Confirm the signed-in identity has read access to all target subscriptions.
- [ ] Confirm the relevant Service Health advisory is visible in the tenant.
- [ ] Verify regional uplift percentages and SKU exclusion families against that advisory.
- [ ] Record the run's pricing assumptions, currency and discount input.
- [ ] Confirm public retail pricing is appropriate for this assessment; otherwise use approved billing exports.

## During review
- [ ] Check VM size, region, OS, power state and usage-hours assumptions.
- [ ] Check candidate SKU availability in the same region.
- [ ] Validate vCPU, memory, architecture, Premium IO, accelerated networking, disk/controller support and VM generation.
- [ ] Validate application performance, vendor support, quota and availability-zone constraints.
- [ ] Separate compute cost from disks, storage, bandwidth, licensing and tax.
- [ ] Verify reservation, Savings Plan, EA/CSP and negotiated rate treatment.

## Report quality and audit
- [ ] Retain the timestamp, run identifier and script version.
- [ ] Retain source pricing query and retrieval timestamp.
- [ ] Retain input assumptions, discount percentage and calculation basis.
- [ ] Retain candidate ranking and reasons for disqualification.
- [ ] Retain warnings and failed resource queries.
- [ ] Store inventory reports securely; they contain infrastructure metadata.

## Before implementing any recommendation
- [ ] Create a change record for each workload.
- [ ] Obtain application owner, architecture and operations approval.
- [ ] Confirm backup/recovery and rollback steps.
- [ ] Schedule a maintenance window.
- [ ] Apply changes through a controlled deployment process.
- [ ] Validate health, performance and actual billing after the change.

**The report is an estimate and decision-support artifact, not approval to resize production VMs.**
