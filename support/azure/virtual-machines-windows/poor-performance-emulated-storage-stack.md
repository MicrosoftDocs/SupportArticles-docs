---
title: Poor performance for VMs that run with an emulated mode storage stack on Windows Server 2012 R2
description: Describes an issue that causes poor performance to occur for VMs that run with an emulated mode storage stack on Windows Server 2012 R2.
ms.date: 07/21/2020
ms.reviewer: mohak, genli, scotro, clandis, jamesca, nagag, rakkim
ms.service: virtual-machines
ms.subservice: vm-performance
ms.collection: windows
---
# Poor performance for VMs that run with an emulated mode storage stack on Windows Server 2012 R2

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4056345

## Symptoms

Virtual machines (VMs) that are running Windows Server 2012 R2 may experience poor performance if the VM storage stack is in emulated mode. Additionally, you may experience a severe decrease in local resource VHD (temp disk) I/O performance.

## Cause

This issue occurs because of a recently discovered bug in Windows that's exposed when the image that's being provisioned has phantom IDE devices. When this issue occurs, the **storflt** driver is uninstalled from the VM  storage device stack unexpectedly. This causes the VM  storage stack to use the slower path that uses emulated mode each time the VM restarts.

The driver remains uninstalled and isn't reinstalled during successive restarts.

## Resolution

This issue is resolved by update 4057903 that is available through Windows Update. For more information, see [Hyper-V integration components update for Windows virtual machines](https://support.microsoft.com/help/4057903).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
