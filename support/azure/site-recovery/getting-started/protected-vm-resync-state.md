---
title: A protected VM goes into a resync state
description: Learn why a protected virtual machine in Azure Site Recovery repeatedly enters a resynchronization state and follow this fix to restore replication health.
ms.service: azure-site-recovery
author: kaushika-msft
ms.author: kaushika
ms.date: 04/09/2024
ms.reviewer: wenca, markstan
ms.custom: sap:I need help getting started with Site Recovery
---
# A virtual machine that Azure Site Recovery helps protect goes into a resynchronization state

## Summary

This article fixes an issue in which a protected virtual machine (VM) that uses Microsoft Azure Site Recovery (ASR) goes into a resynchronization state repeatedly.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3094171

## Symptoms

A virtual machine (VM) that Microsoft Azure Site Recovery (ASR) helps protect in a Hyper-V to Azure scenario might repeatedly go into a resynchronization state. You can't manually resynchronize, and you might receive the following error message for the replication health of the VM:

> Replication State: Resynchronization required  
> Replication Mode: Primary  
> Current Replica Server: Microsoft Azure  
> Replication Health: Critical  
> Resynchronization is required for the machine *X*. Resume replication to start resynchronization.  
> Successful replication cycles: 0 out of *Y* (0%). More than 20% of replication cycles are missed for virtual machine *X*.

> [!NOTE]
> In the error message, the placeholder *X* represents the name of the VM, and the placeholder *Y* represents the number of attempts.

## Cause

This issue occurs if the data disk size of the protected VM is greater than or equal to 1 terabyte (TB).

## Resolution

Azure supports a maximum disk size of 1 TB for data disks. To resolve this issue, reduce the hard disk size to less than 1 TB. For more information, see [Set up disaster recovery for Azure virtual machines using shared disk](/azure/site-recovery/tutorial-shared-disk).
