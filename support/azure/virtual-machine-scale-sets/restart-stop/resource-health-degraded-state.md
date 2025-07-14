---
title: Health state shows Degraded in Azure Virtual Machine Scale Set 
description: Explains the transient Degraded state that's displayed in Azure Virtual Machine Scale Set Resource Health or Activity Log.
ms.date: 04/07/2022
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-virtual-machine-scale-sets
ms.reviewer: macla, pudesira
ms.custom: sap:My instance was restarted or stopped unexpectedly
---
# Resource health state is "Degraded" in Azure Virtual Machine Scale Set

This article explains the transient "Degraded" state that's displayed in Azure Virtual Machine Scale Set (VMSS) **Resource Health** or **Activity log** and provides a solution for this issue.

## Symptoms

You may receive an alert in Azure VMSS **Resource Health** or **Activity log** in one of the following scenarios:

- VMs in the Azure VMSS are in the process of being stopped, deallocated, deleted, or started.
- You have performed scaling in or out operations on the VMSS.

The alert indicates that the aggregated platform health of the VMSS is in a transient state of "Degraded."

## Cause

Because of the operations mentioned in the [Symptoms](#symptoms) section, VMs are destroyed, and a new VM is created. When the VMs are destroyed, they send out degraded health signals to the platform, which causes the transient state of "Degraded." Until the new VM is fully started and can send out an available status, the "Degraded" state will continue to be sent out.

## Resolution

To eliminate this transient state, destroyed VMs will be prevented from sending out a heath report that may distort the aggregated availability of a VMSS.

Microsoft is investing in better coordinating and reporting of platform health. The investment is part of [Project Flash](https://azure.microsoft.com/blog/advancing-azure-virtual-machine-availability-monitoring-with-project-flash/), which aims to display highly accurate and actionable VM availability information.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
