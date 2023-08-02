---
title: "Troubleshoot allocation failures on virtual machine scale sets."
description: Troubleshoot an AllocationFailed or ZonalAllocationFailed error message when you create, restart, or resize Virtual Machine Scale Sets in Azure.
ms.date: 12/06/2021
ms.reviewer: saraic, nameier, shache, emanders, v-leedennis
ms.service: virtual-machine-scale-sets
#Customer intent: As an Azure Virtual Machine Scale Set user, I want to troubleshoot an AllocationFailed or ZonalAllocationFailed error so that I can successfully create, restart, or resize a scale set instance.
---
# Fix an AllocationFailed or ZonalAllocationFailed error when you create, restart, or resize Virtual Machine Scale Sets in Azure

> [!WARNING]
> If your Microsoft Azure Virtual Machine Scale Set is part of an Azure Service Fabric cluster, don't follow this troubleshooting guidance. This guidance may cause data loss and irreversible cluster damage in this scenario. For more information, see [Can I use large virtual machine scale sets in my Service Fabric cluster?](/azure/service-fabric/service-fabric-common-questions#can-i-use-large-virtual-machine-scale-sets-in-my-sf-cluster)

In this article, get information about:

- AllocationFailed or ZonalAllocationFailed errors in Microsoft Azure Virtual Machine Scale Sets.
- How to avoid allocation failures.
- The causes of the allocation failures.
- How to troubleshoot allocation failures when they arise.

To troubleshoot allocation failures for standard virtual machines (VMs), see [Troubleshoot allocation failures when you create, restart, or resize VMs in Azure](../virtual-machines/allocation-failure.md).

## Symptom

Because of high demand for Azure services, an allocation failure might occur if you try to create or start VM instances in certain regions. Azure attempts to allocate compute resources to your subscription whenever you:

- Create a virtual machine scale set.
- Restart a stopped (deallocated) scale set VM instance.
- Resize a scale set.

The following error details are an example of the allocation failure message.

**Error code**: AllocationFailed or ZonalAllocationFailed

**Error message 1**: Allocation failed. We do not have sufficient capacity for the requested VM size in this region. Read more about improving likelihood of allocation success at <https://aka.ms/allocation-guidance>.

**Error message 2**: Allocation failed. VM(s) with the following constraints cannot be allocated, because the condition is too restrictive. Please remove some constraints and try again. Constraints applied are:

- Availability zone
- VM size

**Error message 3**: Allocation failed. If you are trying to add a new VM to a Virtual Machine Scale Set with a single placement group or update/resize an existing VM in a Virtual Machine Scale Set with a single placement group, please note that such allocation is scoped to a single cluster, and it is possible that the cluster is out of capacity. Please read more about improving likelihood of allocation success at <https://aka.ms/allocation-guidance>.

## How to avoid allocation failures

To avoid allocation failures, you can apply some configuration settings to the scale set to optimize allocation requests.

- **Overprovisioning**. With overprovisioning turned on, the scale set actually spins up more VM instances than you asked for. It then deletes the extra VM instances once the requested number of VM instances are successfully provisioned. This practice improves provisioning success rates and reduces deployment time. You aren't billed for the extra VM instances, and they don't count toward your quota limits. To enable overprovisioning:

  1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machine scale sets**.
  
  1. Select the name of your scale set.

  1. In the menu pane, select **Configuration**.

  1. In the **Overprovisioning** heading, set **Enable overprovisioning** to **On**.

  1. Select **Save**.

  Learn more about [overprovisioning](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-design-overview#overprovisioning).

- **Enable large scale sets**. Large Virtual Machine Scale Sets are defined as a scale sets that can scale to greater than 100 VM instances. This capability is set by a scale set property (`singlePlacementGroup=false`). What makes a large scale set special isn't the number of VM instances, but the number of placement groups it contains. A placement group is similar to an Azure availability set, with its own fault domains and upgrade domains. With `singlePlacementGroup` set to `false`, you have a greater chance of allocation success, because the deployments can be spread across multiple clusters when deployed as a multiplacement group. Learn more about [working with large virtual machine scale sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups), specifically how to [convert an existing scale set to span multiple placement groups](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups#converting-an-existing-scale-set-to-span-multiple-placement-groups).

  > [!NOTE]
  > You can change a scale set from supporting a single placement group to supporting multiple placement groups, but you can't perform a conversion in the other direction. Once `singlePlacementGroup` is set to `false`, you can't change it back.

Reduce the number of instances of the requested VM size, and then retry the deployment operation. For larger deployments, you may want to evaluate [Azure Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/) with multiple placement groups. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.

### Other tips

Until your preferred VM type is available in your preferred region, customers who experience deployment issues should consider the guidance in the following sections as a temporary solution.

Identify the scenario that best matches your case. To increase the likelihood of allocation success, retry the allocation request by using the corresponding suggested solution. Or you can always retry later. Enough resources may have been freed in the cluster, region, or zone to accommodate your request at another time.

## Cause

The region or zone doesn't have enough core capacity for the requested SKU.

### Cause 1: Resized a scale set or added VM instances to an existing scale set

If there's a request to resize a scale set or add a VM instance to an existing scale set, it must be tried at the original cluster that hosts the existing scale set. Or the cluster supports the requested VM size but might not currently have sufficient capacity.

#### Solution for cause 1

Try one of the following actions:

- Attempt to move the scale set to a different cluster in the same region with adequate capacity.

  Stop (deallocate) all VM instances in the scale set, and then resize the scale set as needed. After the resize is completed, restart the VM instances. To stop the VM instances:

  1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machine scale sets**.
  
  1. Select the name of your scale set.

  1. Select **Stop**.
  
  After you stop all VM instances to execute the resize and then start the scale set, the new allocation attempt can identify a cluster with enough capacity to host the entire scale set.

- Configure your scale set to scale across more than one placement group.

  See [Creating a large scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups#creating-a-large-scale-set).

### Cause 2: Restarted a partially stopped (deallocated) VM

Partial deallocation means that you stopped (deallocated) one or more, but not all, VM instances in a scale set. When you deallocate a VM instance, the associated resources are released. Restarting VM instances in a partially deallocated availability set is the same as adding VM instances to an existing availability set. So you must try the allocation request at the original cluster that hosts the existing availability set, which might have insufficient capacity.

#### Solution for cause 2

Stop (deallocate) all VM instances in the scale set, and then restart each VM instance. To stop the VM instances:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machine scale sets**.

1. Select the name of your scale set.

1. In the menu pane, select **Instances**.

1. Select all virtual machine instances that are listed.

1. Select **Stop**.
  
After all VMs stop, select the first VM instance, and then select **Start**. Azure makes a new allocation attempt, and selects a new cluster that has sufficient capacity.

### Cause 3: Restarted VM instances that were fully stopped

Full deallocation means that you stopped (deallocated) all VM instances in an availability set. The allocation request to restart these VM instances will target all clusters that support the needed size within the region or zone.

#### Solution for cause 3

Change your allocation request using the suggestions in this article. Then retry the request to improve the chance of allocation success.

If you use older VM series or sizes (such as Dv1, DSv1, Av1, D15v2, or DS15v2), consider moving to newer versions. See these recommendations for specific VM sizes. Are you disallowed from using a different VM size? Then try deploying to a different region within the same geography. For more information about the available VM sizes in each region at <https://aka.ms/azureregions>.

If you use availability zones, try another zone within the region that may have available capacity for the requested VM size.

If your allocation request is large (more than 500 cores), see the following sections to break up the request into smaller deployments.

Try [redeploying the VM instance](../virtual-machines/redeploy-to-new-node-windows.md), which allocates the VM instance to a new cluster within the region.

## Allocation failures for older VM sizes

Some older series VM sizes don't run on our latest generation infrastructure. Customers may occasionally experience allocation failures for these legacy SKUs. We encourage customers who are using legacy series virtual machines to consider migrating to the equivalent newer VMs. The newer VMs are optimized for the latest hardware, and they let you take advantage of better pricing and performance.

See the following recommendations:

| Legacy VM series or size | Recommended newer VM series or size | Blog link |
| ------------------------ | ----------------------------------- | --------- |
| Av1-series | [Av2-series](/azure/virtual-machines/av2-series) | [New A_v2-Series VM sizes](https://azure.microsoft.com/blog/new-av2-series-vm-sizes/) |
| Dv1 or DSv1-series (D1 to D5) | [Dv3 or DSv3-series](/azure/virtual-machines/dv3-dsv3-series) | [Introducing the new Dv3 and Ev3 VM sizes](https://azure.microsoft.com/blog/introducing-the-new-dv3-and-ev3-vm-sizes/) |
| Dv1 or DSv1-series (D11 to D14) | [Ev3 or ESv3-series](/azure/virtual-machines/ev3-esv3-series) |  |
| D15v2 or DS15v2 | <p>If you use the Resource Manager deployment model to take advantage of the larger VM sizes, consider moving to D16v3/DS16v3 or D32v3/DS32v3. These sizes are designed to run on the latest generation hardware.</p><p>Do you use the Resource Manager deployment model to make sure your VM instance is isolated to hardware that's dedicated to a single customer? Then consider moving to the new isolated VM sizes, E64i_v3 or E64is_v3, which are designed to run on the latest generation hardware.</p> | [New isolated VM sizes now available](https://azure.microsoft.com/blog/new-isolated-vm-sizes-now-available/) |

## Background information

### How allocation works

The Azure platform tries to partition datacenter servers into clusters. Normally, it attempts an allocation request in multiple clusters. But certain constraints from the allocation request may force the Azure platform to attempt the request in only one cluster ("pinned to a cluster"). Diagram 1 below shows a normal allocation that's attempted in multiple clusters (Cluster 1 through Cluster *n*). In Diagram 2, an allocation is pinned to Cluster 2, because that cluster hosts the existing Cloud Service (CS_1) or availability set.

:::image type="content" source="media/allocationfailed-or-zonalallocationfailed/allocation-attempted-in-multiple-clusters-or-pinned-to-one-cluster.png" alt-text="Diagram 1: An Azure platform allocation attempted in multiple clusters. Diagram 2: An Azure platform allocation that's pinned to one cluster.":::

### Why allocation failures happen

If an allocation request is pinned to a cluster, there's a higher chance of failing to find free resources, because the available resource pool is smaller. What if your allocation request is pinned to a cluster that doesn't support the type of resource you requested? Then your request will fail even if the cluster has free resources. Diagram 3 below shows where a pinned allocation fails because the only candidate cluster doesn't have free resources. Diagram 4 shows where a pinned allocation fails, because the only candidate cluster doesn't support the requested VM size, even though the cluster has free resources.

:::image type="content" source="media/allocationfailed-or-zonalallocationfailed/pinned-cluster-allocation-failure-no-free-resource-or-unsupported-size.png" alt-text="Diagrams of allocation failures are pinned clusters. Diagram 3 shows no free resources are available. Diagram 4 shows the size isn't supported.":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
