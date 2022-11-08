---
title: Error 25035 when enabling a VM protection
description: Fixes an issue that occurs when you try to turn on protection for a virtual machine in Azure Site Recovery. This triggers error code that indicates cluster resource could not be found.
ms.date: 04/26/2020
ms.reviewer: anbacker, markstan
---
# ASR: The cluster resource could not be found when you enable protection for a virtual machine

This article helps you fix an issue in which you receive error code 25035 when you try to turn on protection for a virtual machine in Azure Site Recovery.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, Azure Backup  
_Original KB number:_ &nbsp; 3010979

## Symptoms

When you try to enable protection for a virtual machine, the operation may fail by returning error code 25035. This error indicates that **The cluster resource could not be found** in Azure Site Recovery.

## Cause

This issue may occur after you apply Update Rollup 3 ([KB2965414](https://support.microsoft.com/help/2965414)) for System Center 2012 R2 Virtual Machine Manager.

After VMM is updated, the Virtual Machine Manager service tries to find a virtual machine cluster resource name that has a **SCVMM \<VMNAME>** prefix, where \<VMNAME> is the name of your virtual machine. However, Hyper-V Cluster Broker creates the cluster resource by using just the name of the virtual machine (\<VMNAME>). For example, if your machine name is *machine01*, VMM assumes that the name is *SCVMM machine01*. Whereas Hyper-V cluster broker assumes that the cluster resource name is just *machine01*.

This issue occurs if storage mapping is defined in Azure Site Recovery.

## Resolution

To resolve this issue, apply Update Rollup 4 for System Center 2012 R2 Virtual Machine Manager ([KB2992024](https://support.microsoft.com/help/2992024)) to the virtual machine.

## More Information

Azure Site Recovery portal error details display a message that resembles the following:

> **JOB ID**  
> *xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx-2014-XX-XX XX:XX:XXZ*  
> **ERRORS (1)**  
> **DRA could not prepare for initial replication. (Error code: 25035)**  
> **Provider error**  
> VMM cannot complete the WMI operation on the server (*abc.contoso.com*) because of an error:  
> [MSCluster_Resource.Name=\&quot;SCVMM SHAREPOINTVM\&quot;] The cluster resource could not be found.  
> Resolve the issue and then try the operation again. (Provider error code: 12711)  
> **Possible causes**  
> Check the provider error for more information.  
> **Recommendation**  
> Resolve the issue and retry the operation.

The screenshot of the Azure Site Recovery portal error details:

:::image type="content" source="media/enable-vm-protection-error-25035/error-25035.png" alt-text="DRA could not prepare for initial replication error code 25035.":::
