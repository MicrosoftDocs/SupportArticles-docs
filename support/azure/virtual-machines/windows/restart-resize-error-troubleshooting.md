---
title: VM restarting or resizing issues in Azure
description: Troubleshoot Resource Manager deployment issues with restarting or resizing an existing Virtual Machine in Azure
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: top-support-issue
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 11/16/2021
ms.author: genli
ms.custom: sap:Cannot start or stop my VM, H1Hack27Feb2017

---
# Troubleshoot deployment issues with restarting or resizing an existing Windows VM in Azure

**Applies to:** :heavy_check_mark: Windows VMs

When you try to start a stopped Azure Virtual Machine (VM), or resize an existing Azure VM, the common error you encounter is an allocation failure. This error results when the cluster or region either does not have resources available or cannot support the requested VM size.

[!INCLUDE [support-disclaimer](../../../includes/support-disclaimer.md)]

## Collect activity logs

To start troubleshooting, collect the activity logs to identify the error associated with the issue. The following links contain detailed information on the process:

[View deployment operations](/azure/azure-resource-manager/templates/deployment-history)

[View activity logs to manage Azure resources](/azure/azure-resource-manager/management/view-activity-logs)

## Issue: Error when starting a stopped VM

You try to start a stopped VM but get an allocation failure.

### Cause

The request to start the stopped VM has to be attempted at the original cluster that hosts the cloud service. However, the cluster does not have free space available to fulfill the request.

### Resolution

* Stop all the VMs in the availability set, and then restart each VM.
  
  1. Click **Resource groups** > *your resource group* > **Resources** > *your availability set* > **Virtual Machines** > *your virtual machine* > **Stop**.
  2. After all the VMs stop, select each of the stopped VMs and click Start.
* Retry the restart request at a later time.

## Issue: Error when resizing an existing VM

You try to resize an existing VM but get an allocation failure.

### Cause

The request to resize the VM has to be attempted at the original cluster that hosts the cloud service. However, the cluster does not support the requested VM size.

### Resolution

* Retry the request using a smaller VM size.
* If the size of the requested VM cannot be changed：
  
  1. Stop all the VMs in the availability set.

     * Click **Resource groups** > *your resource group* > **Resources** > *your availability set* > **Virtual Machines** > *your virtual machine* > **Stop**.
  2. After all the VMs stop, resize the desired VM to a larger size.
  3. Select the resized VM and click **Start**, and then start each of the stopped VMs.
  
## Error when you stop, start, restart, or redeploy an existing VM

When you try to stop, start, restart, or redeploy an existing VM, the process fails, and you receive an "An unexpected error occurred while processing the network profile of the VM. Please retry later" error message. When this error occurs, the VM is put into a failed state.

### Cause  

This issue occurs if there is a problem in allocating or updating network resources.

### Resolution

Try to reapply the virtual machine state. This operation reruns VM provisioning, and helps resolve the VM state failure that occurs if VM provisioning failed when you ran a previous VM action.

1. Navigate to the VM that's stuck in the failed state.
2. Under **Help**, select **Redeploy + reapply**.
3. Select the **Reapply** option.

## Next steps

If you encounter issues when you create a new Windows VM in Azure, see [Troubleshoot deployment issues with creating a new Windows virtual machine in Azure](./troubleshoot-deployment-new-vm-windows.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
