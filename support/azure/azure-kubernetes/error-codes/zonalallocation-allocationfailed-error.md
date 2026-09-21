---
title: Troubleshoot ZonalAllocationFailed, AllocationFailed, or OverconstrainedAllocationRequest error codes
description: Troubleshoot ZonalAllocationFailed and AllocationFailed errors in AKS create or update operations. Follow steps to fix capacity constraints quickly.
ms.date: 09/17/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, erbookbi, andraciobanu, yudian
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot ZonalAllocationFailed, AllocationFailed, or OverconstrainedAllocationRequest error codes

## Summary

This article describes how to identify and resolve the `ZonalAllocationFailed`, `AllocationFailed`, or `OverconstrainedAllocationRequest` errors that might occur when you try to create, deploy, or update an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

To troubleshoot these errors, it's suggested you have the following prerequisites:

- [Azure CLI](/cli/azure/install-azure-cli) (optional), version 2.86.0, or a later version. If Azure CLI is already installed, use `az --version` to check the version number.
- [Azure PowerShell](/powershell/azure/install-az-ps) (optional).

## Symptoms

When you try to create, upgrade, or scale up a cluster, you receive one of the following error messages:

Code: `ZonalAllocationFailed`

Message: `Allocation failed. We do not have sufficient capacity for the requested VM size in this zone. Read more about improving likelihood of allocation success at https://aka.ms/allocation-guidance. Please note that allocation failures can also arise if a proximity placement group is associated with this VMSS. See https://learn.microsoft.com/troubleshoot/azure/azure-kubernetes/error-code-zonalallocationfailed-allocationfailed for more details. This is not AKS controlled behavior, please ask help to VMSS team for allocation failure. If the error is due to capacity constrain, consider upgrade with maxUnavailable instead of maxSurge, details: aka.ms/aks/maxUnavailable.`

Code: `AllocationFailed`

Message: `The VM allocation failed due to an internal error. Please retry later or try deploying to a different location. Please note that allocation failures can also arise if a proximity placement group is associated with this VMSS. See https://learn.microsoft.com/troubleshoot/azure/azure-kubernetes/error-code-zonalallocationfailed-allocationfailed for more details. This is not AKS controlled behavior, please ask help to VMSS team for allocation failure.`

Code: `OverconstrainedAllocationRequest`

Message: `Create or update VMSS failed. Allocation failed. VM(s) with the following constraints cannot be allocated, because the condition is too restrictive. Please remove some constraints and try again. Constraints applied are: - Differencing (Ephemeral) Disks  - Networking Constraints (such as Accelerated Networking or IPv6)  - VM Size`

### Cause 1: Limited zone availability in a SKU

You're trying to deploy, upgrade, or scale up a cluster in a zone that has limited availability for the specific SKU.

### Solution 1: Use a different SKU, zone, or region

Try one or more of the following methods:

- Redeploy the cluster in the same region by using a different SKU.
- Redeploy the cluster in a different zone in that region.
- Redeploy the cluster in a different region.
- Create a new node pool in a different zone or use a different SKU.

For more information about how to fix this error, see [Resolve errors for SKU not available](/azure/azure-resource-manager/troubleshooting/error-sku-not-available).

### Solution 2: Resize a node pool in place when creation or scaling is blocked due to required VM size availability

If another compatible VM size has capacity, resize the existing Virtual Machine Scale Sets (VMSS) or virtual machine (VM) node pool to use that size. AKS replaces the nodes through a rolling operation, so you don't have to create a new node pool and migrate the workloads manually. This feature is currently in preview and requires surge capacity for the target VM size. For prerequisites, limitations, and instructions, see [Resize a VMSS node pool in place (preview)](/azure/aks/resize-node-pool?tabs=azure-cli#resize-a-vmss-node-pool-in-place-preview).

### Solution 3: Use automatic zone placement when creation or scaling is blocked by specific zonal limitation

For zone-spanning workloads, create or update the node pool with automatic zone placement. AKS selects availability zones that have capacity for the requested VM SKU and reevaluates zone availability during later scale-out operations. This feature is currently in preview, and an allocation can still fail if Azure can't allocate the requested nodes while honoring the per-zone limit. For prerequisites, limitations, and instructions, see [Automatic zone placement in Azure Kubernetes Service (preview)](/azure/aks/configure-automatic-zone-placement).

### Solution 4: Dynamically scale using Node Auto Provisioning

[Node Auto Provisioning](/azure/aks/node-auto-provisioning) allows you to automatically provision VM SKUs based on your workload needs. If a SKU isn't available due to capacity constraints, Node Auto Provisioning (NAP) selects another SKU type based on the specifications provided in the customer resource definitions (CRDs) like `NodePool` and `AKSNodeClass`. This can be helpful for scaling scenarios when certain SKU capacity becomes limited. For more information on configuring your NAP cluster, see [Configure node pools for node auto-provisioning (NAP) in Azure Kubernetes Service (AKS)](/azure/aks/node-auto-provisioning-node-pools) and [Configure AKSNodeClass resources for node auto-provisioning (NAP) in Azure Kubernetes Service (AKS)](/azure/aks/node-auto-provisioning-aksnodeclass).

### Solution 5: Upgrade in place by using `MaxUnavailable`

If you don't need surge nodes during upgrades, see [Customize unavailable nodes](/azure/aks/upgrade-aks-node-pools-rolling#customize-unavailable-nodes) for information on how to upgrade with the existing capacity. Set `MaxUnavailable` to a value greater than zero and set `MaxSurge` to zero. The upgrade process cordons and drains existing nodes one at a time and evicts pods to remaining nodes. The process doesn't create a buffer node.

### Solution 6: Use deployment recommender in portal for new cluster creates

During an AKS cluster creation in the Azure portal, if the selected node pool SKU isn't available in the chosen region and zones, the deployment recommender recommends an alternative SKU, zones, and region combination that has availability.

### Solution 7: Use priority expanders with cluster-autoscaler

The cluster-autoscaler [priority expander](https://github.com/openshift/kubernetes-autoscaler/blob/main/cluster-autoscaler/expander/priority/readme.md) lets you define an ordered list of node pools to attempt scaling in sequence. For example: Spot pools first (cost optimization), then on-demand pools (availability fallback). Conditional Access tries to implement the highest priority pool first. If scaling fails (for example, due to allocation failure), it tries the next pool.

#### Limitations

The following limitations apply to the priority expander:

- Conditional Access doesn't create new node pools. It only works with existing pools. If you want dynamic SKU provisioning, use NAP, which can create pools based on SKU availability.
- Priority expander works at the node pool level, not SKU level. You must precreate pools for each SKU family you want to use.

### Cause 2: Too many constraints for a virtual machine to accommodate

If you receive an `OverconstrainedAllocationRequest` error code, the Azure Compute platform can't allocate a new VM to accommodate the required constraints. These constraints usually (but not always) include the following items:

- VM size
- VM SKU
- Accelerated networking
- Availability zone
- Ephemeral disk
- Proximity placement group (PPG)

### Solution: Don't associate a proximity placement group with the node pool

If you receive an `OverconstrainedAllocationRequest` error code, try creating a new node pool that isn't associated with a proximity placement group.

### Cause 3: Not enough dedicated hosts or fault domains

You're trying to deploy a node pool in a dedicated host group that has limited capacity or doesn't satisfy the fault domain constraint.

### Solution: Ensure you have enough dedicated hosts for your AKS nodes/VMSS

As per [Planning for ADH Capacity on AKS](/azure/aks/use-azure-dedicated-hosts#planning-for-adh-capacity-on-aks), you're responsible for planning enough dedicated hosts to span as many fault domains as required by your AKS VMSS. For example, if the AKS VMSS is created with *FaultDomainCount=2*, you need at least two dedicated hosts in different fault domains (*FaultDomain 0* and *FaultDomain 1*).

## More information

Ensuring capacity for users is a top priority for Microsoft. The increasing popularity of Azure services emphasizes the need to scale up our infrastructure even more rapidly. With that goal in mind, we're expediting expansions and improving our resource deployment process to respond to strong customer demand. We're also adding a large amount of computing infrastructure monthly.

We identified several methods to improve how we load-balance under a high-resource-usage situation and how to trigger the timely deployment of needed resources. Additionally, we're significantly increasing our capacity and continue to plan for strong demand across all regions. For more information about the improvements that we're making toward delivering a resilient cloud supply chain, see [Advancing reliability through a resilient cloud supply chain](https://azure.microsoft.com/blog/advancing-reliability-through-a-resilient-cloud-supply-chain/).

## References

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)
- [Virtual Machine Scale Sets - What to expect when using proximity placement groups](/azure/virtual-machine-scale-sets/proximity-placement-groups#what-to-expect-when-using-proximity-placement-groups)
- [Fix an AllocationFailed or ZonalAllocationFailed error when you create, restart, or resize Virtual Machine Scale Sets in Azure](../../virtual-machine-scale-sets/allocationfailed-or-zonalallocationfailed.md)