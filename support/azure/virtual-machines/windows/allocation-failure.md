---
title: Troubleshooting Azure VM allocation failures
description: Troubleshoot allocation failures when you create or resize a VM in Azure.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: top-support-issue,azure-resource-manager,azure-service-management
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 02/21/2025
ms.author: genli
ms.reviewer: clmendes
ms.custom: sap:Received an Allocation Failure
---
# Troubleshoot allocation failures when you create or resize VMs in Azure

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

When you create a virtual machine (VM), start any stopped (deallocated) VMs, or resize a VM, Microsoft Azure allocates compute resources to your subscription. We are continually investing in additional infrastructure and features to make sure that we always have all VM types available to support customer demand. However, you might occasionally experience resource allocation failures because of unprecedented growth in demand for Azure services in specific regions. This problem can occur when you try to create, start, or resize VMs in a region while the VMs might display an error code and message like the following text:

> **Error code**: AllocationFailed or ZonalAllocationFailed
>
> **Error message**: "Allocation failed. We do not have sufficient capacity for the requested VM size in this region. Read more about improving likelihood of allocation success at https:\//aka.ms/allocation-guidance"
>

Alternative recommendation: When you receive an alternative recommendation, it means that the VM size you requested is not currently available in the selected region or zone. To increase your chances of successfully allocating a virtual machine, you can select one of the alternative options. Simply apply the changes to your VM input selection or [resize](/azure/virtual-machines/sizes/resize-vm) the currently existing VM with the desired option and try to start or create the VM again.

For example, try one of these alternative options to improve the chance of allocation success:

- Alternative VM sizes for the same zone and region: Standard_A2_v2, Standard_A2m_v2, or Standard_D2a_v4
- Alternative zones for the same VM size and region: Zone 1 and 3

> [!NOTE]
> If you are troubleshooting a virtual machine scale set (VMSS), the process is the same as a standard VM. To resolve the issue, you should follow the directions in this article.
>
>**Error message**: "Allocation failed. If you are trying to add a new VM to a Virtual Machine Scale Set with a single placement group or update/resize an existing VM in a Virtual Machine Scale Set with a single placement group, please note that such allocation might be scoped to a single cluster, and it is possible that the cluster is out of capacity. Please read more about improving likelihood of allocation success at http:\//aka.ms/allocation-guidance."

This article explains the causes of some of the common allocation failures and suggests possible remedies.

Until your preferred VM type is available in your preferred region, we advise customers who encounter deployment issues to consider the guidance as a temporary workaround.

Identify the scenario that best matches your case, and then retry the allocation request by using the corresponding suggested workaround to increase the likelihood of allocation success. Alternatively, you can always retry later. This is because enough resources may have been freed in the cluster, region, or zone to accommodate your request.

To ensure that capacity is always available for your workloads, consider using [On-demand Capacity Reservations](/azure/virtual-machines/capacity-reservation-overview). This option allows you to reserve compute capacity in advance, ensuring that your VMs can be deployed as needed without allocation failures. This approach can improve the reliability and predictability of your deployments.

## Standalone VM

### Cause

If you have a standalone VM in Azure, meaning it's not part of an availability set or proximity placement group with other VMs, and you encounter allocation failures when attempting a **Create**, **Start**, or **Redeploy** operation, this indicates that Azure currently lacks sufficient capacity to fulfill your request in the specified region or zone.

### Workarounds

To work around this issue, use one of the following methods:

- Retry the allocation

  Sometimes, the issue might be temporary and retrying the allocation after a short period can resolve the problem.
- Resize the VM

  Consider changing the VM to a different size that might have more availability in the region or zone.
- Change the region or zone

  If the current region or zone is experiencing high demand, try deploying the VM in a different region or availability zone where there might be more capacity.


## Resize a VM, add VMs, or start partially stopped (deallocated) VMs, to an existing availability set

> [!NOTE]
> A VM can only be added to an availability set during creation. To add an existing VM to an availability set, or change a VM's availability set, the VM must be deleted and re-created. For more information, see [Change the availability set for a VM by using Azure PowerShell](/azure/virtual-machines/windows/change-availability-set).

### Cause

A request to resize a VM or add one to an existing availability set must be made at the original cluster that hosts the existing availability set. The cluster might not support the requested VM size or currently have sufficient capacity.

Partial deallocation means that you stopped (deallocated) one or more, but not all, VMs in an availability set. When you deallocate a VM, the associated resources are released. Starting VMs in a partially deallocated availability set is the same as adding VMs to an existing availability set. Therefore, the allocation request must be made at the original cluster hosting the existing availability set that might not have sufficient capacity.

### Workarounds

To work around this issue, use one of the following methods:

- For a new VM deployment, if it can be part of a different availability set, create the VM in a different availability set (in the same region or zone). This new VM can then be added to the same virtual network.

- Consider resizing the VM to a different size that might have more availability in the region or zone. To ensure that the VM sizes are supported in your availability set, use [availability sets - List Available Sizes - REST API](virtual-machines-availability-set-supportability.md).

- Stop (deallocate) all VMs in the same availability set, and then start all applicable VMs in a batch to allow the allocation from all available clusters, rather than just the cluster where the availability set is currently allocated.
  
  To stop all the VMs in the availability set, follow these steps:

    1. Navigate to **Virtual machines** in the Azure portal.
    2. Select **Add filter** and add a filter for the availability set that you want to manage.
    3. Check the box for all VMs in the availability set.
    4. Select **Stop**, and wait for the operation to complete and all VMs to report the **Stopped (deallocated)** status.
    5. Select **Start** to allocate all VMs again.

## Start fully stopped (deallocated) VMs in an availability set

### Cause

Full deallocation means that you stopped (deallocated) all VMs in an availability set. The allocation request to start these VMs will target all clusters that support the desired sizes within the region or zone.

### Workarounds

To work around this issue, use one of the following methods:

- Retry the allocation

  Sometimes, the issue might be temporary and retrying the allocation after a short period can resolve the problem.

- Resize the VMs

  Consider resizing the VM to a different size that might have more availability in the region or zone. To ensure that the VM sizes are supported in your Availability Set, use [Availability Sets - List Available Sizes - REST API](virtual-machines-availability-set-supportability.md).

- Change the region or zone

  If the current region or zone is experiencing high demand, try deploying or migrating the VMs to a different region or availability zone where there might be more capacity.

## Allocation failures for VMs in availability zones

### Cause

Azure availability zones are physically and logically separate datacenters within an Azure region. Each availability zone has its own independent power, cooling, and networking infrastructure. They are designed to ensure high availability and resilience by isolating failures to a single zone, thereby minimizing the impact on other zones within the same region.

However, due to the additional deployment constraint conditions associated with availability zones, the allocation failures might occur.

### Workarounds

To work around this issue, use one of the following methods:

- Retry the allocation

  Sometimes, retrying the allocation request later can help as resources might have been freed up in the zone.

- Resize the VM

  Consider resizing the VM to a different size that might have more availability in the region or zone.

- Change the region or zone

  If the current region or zone is experiencing high demand, try deploying or migrating the VMs to a different region or availability zone where there might be more capacity. The region or zone can be changed with the following methods:
  
   - Create a new VM, using a copy of the OS disk, in a different zone or without the zonal constraint. Removing the zonal constraint expands the allocation options to the entire region, rather than limiting them to a single zone.

      For more information, see the following articles:

       - [Create a snapshot of a virtual hard disk](/azure/virtual-machines/snapshot-copy-managed-disk)
       - [Create a VM from a snapshot](/azure/virtual-machines/scripts/create-vm-from-snapshot)

   - Migrate or create the VM in a different region. For more information, see [Move Azure VMs across regions](/azure/resource-mover/tutorial-move-region-virtual-machines).


## Overconstrained allocation failures

### Cause

When the Azure Compute platform can't allocate a VM to meet the required constraints specified in the request, overconstrained allocation failures occur. These failures typically happen when specific requirements can't be met within the available resources. They are often indicated by errors like `OverconstrainedZonalAllocationRequest` or `OverconstrainedAllocationRequest`.

These constraints usually (but not always) include the following items:

- VM size/SKU
- Accelerated Networking
- Availability Zone
- Ephemeral disk
- Proximity Placement Group (PPG)
- Ultra disk or PremiumSSDv2

### Workarounds

To work around this issue, use one of the following methods:

- Retry the allocation

  Sometimes, retrying the allocation request later can help as resources might have been freed up in the zone.

- Resize the VM

  Consider resizing the VM to a different size that might have more availability in the region or zone.

- Change the region or zone

  If the current region or zone is experiencing high demand, try deploying or migrating the VMs to a different region or availability zone where there might be more capacity. The region or zone can be changed with the following methods:
  
   - Create a new VM, using a copy of the OS disk, in a different zone or without the zonal constraint. Removing the zonal constraint expands the allocation options to the entire region, rather than limiting them to a single zone.

      For more information, see the following articles:

       - [Create a snapshot of a virtual hard disk](/azure/virtual-machines/snapshot-copy-managed-disk)
       - [Create a VM from a snapshot](/azure/virtual-machines/scripts/create-vm-from-snapshot)

   - Migrate or create the VM in a different region. For more information, see [Move Azure VMs across regions](/azure/resource-mover/tutorial-move-region-virtual-machines).

- Adjust constraints that might limit the allocation: There might be sufficient availability for the VM SKU in the zone. However, the defined constraints might prevent allocation. To increase the likelihood of successful allocation, consider adjusting the constraints by:
  - Disabling accelerated networking.
  - Removing the VM from any proximity placement group.
  - Removing any UltraSSD or PemiumSSDv2 disks.

## Allocation failures for VMs using proximity placement groups

Proximity Placement Groups ensure that resources are collocated within the same data center to reduce latency. However, the added deployment constraint can sometimes result in allocation failures. For more information and best practices, see [Proximity Placement Groups](/azure/virtual-machines/co-location).

### Cause

When you request to start or allocate the first VM in a proximity placement group, the data center is selected automatically. If the required VM size is unavailable in that data center, the request fails. In scenarios with elastic workloads where VM instances are added or removed dynamically, enforcing a proximity placement group constraint might lead to an allocation failure, indicating that the allocation request can't be completed.

### Workaround

Deallocate all VMs in the proximity placement group and try changing the order in which you start your VMs. Starting your VMs with the most restrictive SKU first can increase the chances of successful allocations.

## Allocation failures for older VM sizes (Av1, Dv1, DSv1, D15v2, DS15v2, etc.)

As we expand Azure infrastructure, we deploy newer-generation hardware that's designed to support the latest virtual machine types. Some of the older series VMs do not run on our latest generation infrastructure. For this reason, customers might occasionally experience allocation failures for these legacy SKUs. To avoid this problem, we encourage customers who are using legacy series virtual machines to consider moving to the equivalent newer VMs per the following recommendations. These VMs are optimized for the latest hardware and enable you to take advantage of better pricing and performance.

|Legacy VM-series/size|Recommended newer VM-series/size|More information|
|----------------------|----------------------------|--------------------|
|Av1-series|[Av2-series](/azure/virtual-machines/av2-series)|<https://azure.microsoft.com/blog/new-av2-series-vm-sizes/>
|Dv1 or DSv1-series (D1 to D5)|[Dv3 or DSv3-series](/azure/virtual-machines/dv3-dsv3-series)|<https://azure.microsoft.com/blog/introducing-the-new-dv3-and-ev3-vm-sizes/>
|Dv1 or DSv1-series (D11 to D14)|[Ev3 or ESv3-series](/azure/virtual-machines/ev3-esv3-series)|
|D15v2 or DS15v2|Consider moving to D16v3/DS16v3 or D32v3/DS32v3. These are designed to run on the latest generation hardware. If you want to make sure your VM instance is isolated to hardware dedicated to a single customer, consider moving to the new isolated VM sizes, E64i_v3 or E64is_v3, which are designed to run on the latest generation hardware. |<https://azure.microsoft.com/blog/new-isolated-vm-sizes-now-available/>

## Allocation failures for large deployments (more than 500 cores)

Reduce the number of instances of the requested VM size, and then retry the deployment operation. Additionally, for larger deployments, you may want to evaluate [Azure virtual machine scale sets](/azure/virtual-machine-scale-sets) with multiple placement groups. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule, and you have a greater chance of allocation success because the deployments can be spread across multiple clusters when deployed as a multi-placement group. Learn more about working with [large virtual machine scale sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups) and how to [convert an existing scale set to span multiple placement groups](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-placement-groups#converting-an-existing-scale-set-to-span-multiple-placement-groups). Note that you can change a scale set from supporting a single placement group to supporting multiple placement groups, but you cannot perform a conversion in the other direction.

## Background information

### How allocation works

The servers in Azure datacenters are partitioned into clusters. Normally, an allocation request is attempted in multiple clusters, but it's possible that certain constraints (such as VM size, Ultra SSD, and proximity placement groups) from the allocation request force the Azure platform to attempt the request in only one cluster. The following Diagram 1 illustrates the case of a normal allocation that's attempted in multiple clusters.

:::image type="content" source="media/virtual-machines-common-allocation-failure/how-allocation-works.png" alt-text="Screenshot of Diagram 1 showing allocation attempted in multiple clusters." lightbox="media/virtual-machines-common-allocation-failure/how-allocation-works.png":::

### Why allocation failures happen

When an allocation has a large number of restrictions, there's a higher chance of failing to find free resources since the available resource pool is smaller. Furthermore, if your allocation request is restricted (for example, when using proximity placement groups but the type of resource you requested isn't supported by the set of clusters and nearby ones), your request fails even if the cluster has free resources. The following Diagram 2 illustrates the case where an allocation fails because the candidate clusters associated with the proximity placement group don't have free resources. Diagram 3 illustrates the case where an allocation fails because the candidate clusters associated with the  proximity placement group don't support the requested VM size, even though the clusters have free resources.

:::image type="content" source="media/virtual-machines-common-allocation-failure/allocation-failures-ppg.png" alt-text="Screenshot of Diagram 2 showing allocation failed with no free resource available and Diagram 3 showing allocation failed with size not supported." lightbox="media/virtual-machines-common-allocation-failure/allocation-failures-ppg.png":::

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
