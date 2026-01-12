---
title: Troubleshoot the ZonalAllocationFailed, AllocationFailed, or OverconstrainedAllocationRequest error code
description: Troubleshoot the ZonalAllocationFailed, AllocationFailed, or OverconstrainedAllocationRequest error when you create, deploy, or update a Kubernetes cluster.
ms.date: 09/05/2024
author: axelgMS
ms.author: axelg
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the ZonalAllocationFailed, AllocationFailed, or OverconstrainedAllocationRequest error code

This article describes how to identify and resolve the `ZonalAllocationFailed`, `AllocationFailed`, or `OverconstrainedAllocationRequest` error that might occur when you try to create, deploy, or update a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) (optional), version 2.0.59 or a later version. If Azure CLI is already installed, you can find the version number by using `az --version`.

- [Azure PowerShell](/powershell/azure/install-az-ps) (optional).

## Symptoms

When you try to create, upgrade or scale up a cluster, you receive one of the following error messages:

> Code: Code="ZonalAllocationFailed"
>
> Message="Allocation failed. We do not have sufficient capacity for the requested VM size in this zone. Read more about improving likelihood of allocation success at https://aka.ms/allocation-guidance. Please note that allocation failures can also arise if a proximity placement group is associated with this VMSS. See https://learn.microsoft.com/troubleshoot/azure/azure-kubernetes/error-code-zonalallocationfailed-allocationfailed for more details. This is not AKS controlled behavior, please ask help to VMSS team for allocation failure. If the error is due to capacity constrain, consider upgrade with maxUnavailable instead of maxSurge, details: aka.ms/aks/maxUnavailable."

> Code="AllocationFailed"
>
> Message="The VM allocation failed due to an internal error. Please retry later or try deploying to a different location. Please note that allocation failures can also arise if a proximity placement group is associated with this VMSS. See https://learn.microsoft.com/troubleshoot/azure/azure-kubernetes/error-code-zonalallocationfailed-allocationfailed for more details.This is not AKS controlled behavior, please ask help to VMSS team for allocation failure."

> Code="OverconstrainedAllocationRequest"
>
> Message="Create or update VMSS failed. Allocation failed. VM(s) with the following constraints cannot be allocated, because the condition is too restrictive. Please remove some constraints and try again. Constraints applied are: - Differencing (Ephemeral) Disks  - Networking Constraints (such as Accelerated Networking or IPv6)  - VM Size"

## Cause 1: Limited zone availability in a SKU

You're trying to deploy, upgrade or scale up a cluster in a zone that has limited availability for the specific SKU.

## Solution 1: Use a different SKU, zone, or region

Try one or more of the following methods:

- Redeploy the cluster in the same region by using a different SKU.
- Redeploy the cluster in a different zone in that region.
- Redeploy the cluster in a different region.
- Create a new node pool in a different zone or use a different SKU.

For more information about how to fix this error, see [Resolve errors for SKU not available](/azure/azure-resource-manager/troubleshooting/error-sku-not-available).

## Solution 2: Dynamically scale using Node Auto Provisioning

[Node Auto Provisioning](https://learn.microsoft.com/azure/aks/node-auto-provisioning) allows you to automatically provision VM SKUs based on your workload needs. If a SKU is not available due to capacity constraints, Node Auto Provisioning will select another SKU type based on the specifications provided in the customer resource definitions (CRDs) such as the NodePool and AKSNodeClass. This can be helpful for scaling scenarios when certain sku capacity becomes limited. For best practice on configuring your NAP cluster, see documentation on Node Auto Provisioning [NodePools](https://learn.microsoft.com/azure/aks/node-auto-provisioning-node-pools) and [AKSNodeClass](https://learn.microsoft.com/en-us/azure/aks/node-auto-provisioning-aksnodeclass).

## Solution 3: Upgrade in place using MaxUnavailable

If you don’t need surge node(s) during upgrades, leverage [MaxUnavailable](https://learn.microsoft.com/en-us/azure/aks/upgrade-options#optimize-upgrades-to-improve-performance-and-minimize-disruptions) to upgrade with the existing capacity. Set MaxUnavailable to a value greater than 0 and set MaxSurge equal to 0. Existing nodes will be cordoned and drained one at a time and pods will be evicted to remaining nodes. No buffer node will be created.

## Solution 4: Use Deployment Recommender in portal for new cluster creates

During an AKS cluster create in the Azure portal, if the selected nodepool sku is not available in the chosen region and zone(s), the deployment recommender will recommend an alternative sku, zones, and region combination that has availability.

## Solution 5: Use Priority Expanders with Cluster Autoscaler

The Cluster Autoscaler [priority expander](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/expander/priority/readme.md) lets you define an ordered list of node pools to attempt scaling in sequence. Example: Spot pools first (cost optimization), then on-demand pools (availability fallback). CA will attempt the highest priority pool first. If scaling fails (e.g. due to allocation failure), it attempts the next pool.

Limitations:

- CA does NOT create new node pools; it only works with existing pools. If you want dynamic SKU provisioning, use Node Auto Provisioning (NAP), which can create pools based on SKU availability.

- Priority expander works at node pool level, not SKU level. You must pre-create pools for each SKU family you want to use.

## Cause 2: Too many constraints for a virtual machine to accommodate

If you receive an `OverconstrainedAllocationRequest` error code, the Azure Compute platform can't allocate a new virtual machine (VM) to accommodate the required constraints. These constraints usually (but not always) include the following items:

- VM size
- VM SKU
- Accelerated networking
- Availability zone
- Ephemeral disk
- Proximity placement group (PPG)

## Solution 1: Don't associate a proximity placement group with the node pool

If you receive an `OverconstrainedAllocationRequest` error code, you can try to create a new node pool that isn't associated with a proximity placement group.

## Cause 3: Not enough dedicated hosts or fault domains

You're trying to deploy a node pool in a dedicated host group that has limited capacity or doesn't satisfy the fault domain constraint.

## Solution 1: Ensure you have enough dedicated hosts for your AKS nodes/VMSS

As per [Planning for ADH Capacity on AKS](/azure/aks/use-azure-dedicated-hosts#planning-for-adh-capacity-on-aks), you're responsible for planning enough dedicated hosts to span as many fault domains as required by your AKS VMSS. For example, if the AKS VMSS is created with *FaultDomainCount=2*, you need at least two dedicated hosts in different fault domains (*FaultDomain 0* and *FaultDomain 1*).

## More information

Ensuring capacity for users is a top priority for Microsoft, and we're working around the clock to reach this goal. The increasing popularity of Azure services emphasizes the need to scale up our infrastructure even more rapidly. With that in mind, we're expediting expansions and improving our resource deployment process to respond to strong customer demand. We're also adding a large amount of computing infrastructure monthly.

We have identified several methods to improve how we load-balance under a high-resource-usage situation and how to trigger the timely deployment of needed resources. Additionally, we're significantly increasing our capacity and will continue to plan for strong demand across all regions. For more information about the improvements that we're making toward delivering a resilient cloud supply chain, see [Advancing reliability through a resilient cloud supply chain](https://azure.microsoft.com/blog/advancing-reliability-through-a-resilient-cloud-supply-chain/).

## References

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

- [Virtual Machine Scale Sets - What to expect when using proximity placement groups](/azure/virtual-machine-scale-sets/proximity-placement-groups#what-to-expect-when-using-proximity-placement-groups)

- [Fix an AllocationFailed or ZonalAllocationFailed error when you create, restart, or resize Virtual Machine Scale Sets in Azure](../../virtual-machine-scale-sets/allocationfailed-or-zonalallocationfailed.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
