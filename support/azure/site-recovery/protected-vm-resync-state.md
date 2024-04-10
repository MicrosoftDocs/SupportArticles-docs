---
title: A protected VM goes into a resync state
description: A protected virtual machine that uses Azure Site Recovery goes into a resynchronization state repeatedly.
ms.date: 04/09/2024
ms.reviewer: wenca, markstan
---
# A virtual machine that Azure Site Recovery helps protect goes into a resynchronization state

This article fixes an issue in which a protected virtual machine (VM) that use Microsoft Azure Site Recovery (ASR) goes into a resynchronization state repeatedly.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3094171

## Symptoms

A virtual machine (VM) that Microsoft Azure Site Recovery (ASR) helps protect in a Hyper-V to Azure scenario may repeatedly go into a resynchronization state. You cannot manually resynchronize, and you may receive the following error message for the replication health of the VM:

> Replication State: Resynchronization required  
> Replication Mode: Primary  
> Current Replica Server: Microsoft Azure  
> Replication Health: Critical  
> Resynchronization is required for the machine *X*. Resume replication to start resynchronization.  
> Successful replication cycles: 0 out of *Y* (0%). More than 20% of replication cycles have been missed for virtual machine *X*.

> [!NOTE]
> In the error message, the placeholder *X* represents the name of the VM, and the placeholder *Y* represents the number of attempts.

## Cause

This issue can occur if the data disk size of the protected VM is greater than or equal to 1 terabyte (TB).

## Resolution

The maximum disk size that is supported for data disks in Azure is currently 1 TB. To work around this issue, reduce the hard disk to less than 1 TB. For more information, see the following article:

[Protecting large data disks using Azure Site Recovery](https://azure.microsoft.com/blog/protecting-large-data-disks-using-azure-site-recovery/)
