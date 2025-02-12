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
ms.date: 12/15/2023
ms.author: genli
ms.reviewer: clmendes
ms.custom: sap:Received an Allocation Failure
---
# Troubleshoot allocation failures when you create or resize VMs in Azure

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

When you create a virtual machine (VM), start any stopped (deallocated) VMs, or resize a VM, Microsoft Azure allocates compute resources to your subscription. We are continually investing in additional infrastructure and features to make sure that we always have all VM types available to support customer demand. However, you may occasionally experience resource allocation failures because of unprecedented growth in demand for Azure services in specific regions. This problem can occur when you try to create, start, or resize VMs in a region while the VMs may display a similar error code and message to the following:

**Error code**: AllocationFailed or ZonalAllocationFailed

**Error message**: "Allocation failed. We do not have sufficient capacity for the requested VM size in this region. Read more about improving likelihood of allocation success at https:\//aka.ms/allocation-guidance"

**Alternative Recommendation**: When you receive an alternative recommendation, it means that the VM size you requested is not currently available in the selected region or zone. To increase your chances of successfully allocating a virtual machine, you can select one of the alternative options. Simply apply the changes to your VM input selection or [resize](https://learn.microsoft.com/azure/virtual-machines/sizes/resize-vm?tabs=portal) the currently existing VM with the desired option and try to start or create the VM again

>Example:
>>"Try one of these alternative options to improve the chance of allocation success:
>>
>> - Alternative VM sizes for the same zone and region: Standard_A2_v2, Standard_A2m_v2, or Standard_D2a_v4
>> - Alternative zones for the same VM size and region: (1 and 3)"  

> [!NOTE]
> If you are troubleshooting a virtual machine scale set (VMSS), the process is the same as a standard VM. To resolve the issue, you should follow the directions in this article.
>
>**Error message**: "Allocation failed. If you are trying to add a new VM to a Virtual Machine Scale Set with a single placement group or update/resize an existing VM in a Virtual Machine Scale Set with a single placement group, please note that such allocation might be scoped to a single cluster, and it is possible that the cluster is out of capacity. Please read more about improving likelihood of allocation success at http:\//aka.ms/allocation-guidance."

This article explains the causes of some of the common allocation failures and suggests possible remedies.

Until your preferred VM type is available in your preferred region, we advise customers who encounter deployment issues to consider the guidance as a temporary workaround.

Identify the scenario that best matches your case, and then retry the allocation request by using the corresponding suggested workaround to increase the likelihood of allocation success. Alternatively, you can always retry later. This is because enough resources may have been freed in the cluster, region, or zone to accommodate your request.

To ensure that capacity is always available for your workloads, you might want to consider using [On-demand Capacity Reservations](https://learn.microsoft.com/azure/virtual-machines/capacity-reservation-overview). This option allows you to reserve compute capacity in advance, ensuring that your virtual machines can be deployed whenever needed without encountering allocation failures. This proactive approach can greatly enhance the reliability and predictability of your deployments.

## Standalone VM

### Cause

If you have a standalone VM, meaning it's not in an Availability Set or Proximity Placement Group with other VMs, in Azure and receive allocation failures when trying to perform Creation, Start, or Redeploy operations it means that Azure does not have sufficient capacity to fulfill your request in the desired region or zone at that moment.

### Workarounds

- **Retry the allocation:** Sometimes, the issue is temporary and retrying the allocation after a short period can resolve the problem.
- **Resize the VM:** Consider resizing the VM to a different size that might have more availability in the region or zone.
- **Change the Region or Zone:** If the current region or zone is experiencing high demand, try deploying the VM in a different region or availability zone where there might be more capacity.

## Resize a VM, add VMs, or start partially stopped (deallocated) VMs, to an existing Availability Set

> [!NOTE]
> A VM can only be added to an Availability Set during creation. To add an existing VM to an Availability Set, or change a VM's Availability Set the VM must be deleted and recreated. [See here](https://learn.microsoft.com/azure/virtual-machines/windows/change-availability-set) for more details.

### Cause

A request to resize a VM or add a VM to an existing Availability Set must be tried at the original cluster that hosts the existing Availability Set. The requested VM size may or may not be supported by the cluster, or the cluster may not currently have sufficient capacity.  

Partial deallocation means that you stopped (deallocated) one or more, but not all, VMs in an Availability Set. When you deallocate a VM, the associated resources are released. Starting VMs in a partially deallocated Availability Set is the same as adding VMs to an existing Availability Set. Therefore, the allocation request must be tried at the original cluster that hosts the existing Availability Set that may not have sufficient capacity.

### Workarounds

- If this is a new VM deployment and it can be part of a different Availability Set, create the VM in a different Availability Set (in the same region or zone). This new VM can then be added to the same virtual network.
- Consider resizing the VMs to a different size that may have more availability in the region or zone. You can use [this API](https://learn.microsoft.com/troubleshoot/azure/virtual-machines/windows/virtual-machines-availability-set-supportability) to ensure that the VM sizes in your Availability Set are supported together.
- Stop (deallocate) all VMs in the same Availability Set, then start all applicable VMs in a batch to allow the allocation to select from all available clusters, not just the cluster where the Availability Set is currently allocated.
  - To stop all the VMs in the Availability Set:
    1. Navigate to **Virtual machines** in the Azure portal
    1. Click **Add filter** and add a filter for the Availability Set that you want to manage
    1. Check the box for all of the VMs in the Availability Set
    1. Click **Stop**, and wait for the operations to complete and all of the VMs to report a Status of **Stopped (deallocated)**
    1. Finally, click **Start**, to allocate all of the VMs again

## Start fully stopped (deallocated) VMs in an Availability Set

### Cause

Full deallocation means that you stopped (deallocated) all VMs in an Availability Set. The allocation request to start these VMs will target all clusters that support the desired sizes within the region or zone.

### Workarounds

- **Retry the allocation:** Sometimes, the issue is temporary and retrying the allocation after a short period can resolve the problem.
- **Resize the VMs:** Consider resizing the VMs to a different size that may have more availability in the region or zone. You can use [this API](https://learn.microsoft.com/troubleshoot/azure/virtual-machines/windows/virtual-machines-availability-set-supportability) to ensure that the VM sizes in your Availability Set are supported together.
- **Change the Region or Zone:** If the current region or zone is experiencing high demand, try deploying or migrating the VMs to a different region or availability zone where their might be more capacity.

## Allocation Failures for Virtual Machines in Availability Zones

### Cause

Azure availability zones are physically and logically separate datacenters within an Azure region. Each availability zone has its own independent power, cooling, and networking infrastructure. They are designed to ensure high availability and resilience by isolating failures to a single zone, thereby minimizing the impact on other zones within the same region.

However, due to the additional deployment constraint conditions associated with availability zones, the following allocation failures may occur:

### Workarounds

- **Retry the allocation:** Sometimes, retrying the allocation request later can help as resources may have been freed up in the zone.
- **Resize the VM:** Consider resizing the VM to a different size that might have more availability in the region or zone.
- **Change the Region or Zone:** If the current region or zone is experiencing high demand, try deploying or migrating the VMs to a different region or availability zone where their might be more capacity. The Region or Zone can be changed with the following steps.
  - Create a new VM, using a copy of the OS disk, in a different zone or without the zonal constraint. Removing the zonal constraint will expand the allocation options to the entire region, rather than limiting them to a single zone.
    - [Create a snapshot of a virtual hard disk](https://learn.microsoft.com/azure/virtual-machines/snapshot-copy-managed-disk?tabs=portal)
    - [Create a VM from a snapshot](https://learn.microsoft.com/azure/virtual-machines/scripts/create-vm-from-snapshot)
  - [Migrate](https://learn.microsoft.com/azure/resource-mover/tutorial-move-region-virtual-machines) or create the VM in a different region.

## Overconstrained Allocation Failures

### Cause

Overconstrained Allocation Failures occur when the Azure Compute platform can't allocate a VM to meet the required constraints specified in the request. This typically happens when specific requirements, cannot be met within the available resources. These failures are often indicated by errors like OverconstrainedZonalAllocationRequest or OverconstrainedAllocationRequest  

These constraints usually (but not always) include the following items:

- VM size/SKU
- Accelerated Networking
- Availability Zone
- Ephemeral disk
- Proximity Placement Group (PPG)
- Ultra disk or PremiumSSDv2

### Workarounds

- **Retry the allocation:** Sometimes, retrying the allocation request later can help as resources may have been freed up in the zone.
- **Resize the VM:** Consider resizing the VM to a different size that might have more availability in the region or zone.
- **Change the Region or Zone:** If the current region or zone is experiencing high demand, try deploying or migrating the VMs to a different region or availability zone where their might be more capacity. The Region or Zone can be changed with the following steps.
  - Create a new VM, using a copy of the OS disk, in a different zone or without the zonal constraint. Removing the zonal constraint will expand the allocation options to the entire region, rather than limiting them to a single zone.
    - [Create a snapshot of a virtual hard disk](https://learn.microsoft.com/azure/virtual-machines/snapshot-copy-managed-disk?tabs=portal)
    - [Create a VM from a snapshot](https://learn.microsoft.com/azure/virtual-machines/scripts/create-vm-from-snapshot)
  - [Migrate](https://learn.microsoft.com/azure/resource-mover/tutorial-move-region-virtual-machines) or create the VM in a different region.
- **Adjust constraints that could be limiting the allocation:** There may be sufficient availability for the VM SKU in the zone, however, the defined constraints might be preventing allocation. To increase the likelihood of successful allocation, consider adjusting the constraints by:
  - Disabling accelerated networking
  - Removing the VM from any Proximity Placement Group
  - Remove any UltraSSD or PemiumSSDv2 disks

## Allocation Failures for Virtual Machines using Proximity Placement Groups

Proximity Placement Groups ensure that resources are colocated within the same data center to reduce latency. However, this added deployment constraint can sometimes result in allocation failures. For more information and best practices, please refer to the [Proximity Placement Groups](https://learn.microsoft.com/azure/virtual-machines/co-location) article.

### Cause

When you request to start or allocate the first VM in a proximity placement group, the data center is selected automatically. If the required VM size is unavailable in that data center, the request will fail. In scenarios with elastic workloads, where VM instances are added or removed dynamically, enforcing a proximity placement group constraint can lead to an Allocation Failure, indicating that the allocation request could not be completed.

### Workaround

Deallocate all the Virtual Machines in the Proximity Placement Group and try changing the order in which you start your VMs. Starting your VMs beginning with the most restrictive SKU first can increase the chances of successful allocations.

## Allocation failures for older VM sizes (Av1, Dv1, DSv1, D15v2, DS15v2, etc.)

As we expand Azure infrastructure, we deploy newer-generation hardware that’s designed to support the latest virtual machine types. Some of the older series VMs do not run on our latest generation infrastructure. For this reason, customers may occasionally experience allocation failures for these legacy SKUs. To avoid this problem, we encourage customers who are using legacy series virtual machines to consider moving to the equivalent newer VMs per the following recommendations. These VMs are optimized for the latest hardware and will let you take advantage of better pricing and performance.

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

The servers in Azure datacenters are partitioned into clusters. Normally, an allocation request is attempted in multiple clusters, but it's possible that certain constraints (such as VM size, Ultra SSD, proximity placement groups, etc) from the allocation request force the Azure platform to attempt the request in only one cluster. Diagram 1 below illustrates the case of a normal allocation that is attempted in multiple clusters.

:::image type="content" source="media/virtual-machines-common-allocation-failure/how-allocation-works.svg" alt-text="Diagram 1 shows allocation attempted in multiple clusters and Diagram 2 shows allocation pinned to one cluster.":::

### Why allocation failures happen

When an allocation has a high number of restrictions, there's a higher chance of failing to find free resources since the available resource pool is smaller. Furthermore, if your allocation request is restricted, such as when using Proximity Placement Groups (PPG) but the type of resource you requested is not supported by the set of clusters and nearby ones, your request will fail even if the cluster has free resources. The following Diagram 2 illustrates the case where an allocation fails because the candidate clusters associated with the PPG do not have free resources. Diagram 3 illustrates the case where an allocation fails because the candidate clusters associated with PPG do not support the requested VM size, even though the clusters have free resources.

:::image type="content" source="media/virtual-machines-common-allocation-failure/allocation-failures-ppg.svg" alt-text="Diagram 3 shows allocation failed at pinned cluster: No free resource available and Diagram 4 shows allocation failed at pinned cluster: Size not supported.":::

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
