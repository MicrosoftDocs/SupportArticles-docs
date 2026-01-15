---
title: Azure Linux VM extensions stop running
description: VM Agent fails to process extensions, causing some extensions to stop running and affecting some dependent services, such as Azure Site Recovery.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: azure-virtual-machines
ms.custom: sap:VM Extensions not operating correctly, linux-related-content
ms.collection: linux
---
# Azure Linux VM extensions stop running

**Applies to:** :heavy_check_mark: Linux VMs

_Original KB number:_ &nbsp; 4099558

[!INCLUDE [VM assist troubleshooting tools](~/includes/azure/vmassist-include.md)]

## Symptoms

The Linux VM Agent doesn't process extensions. Because of this failure, some extensions stop running. This issue affects some dependent Azure services, such as Azure Backup Azure Site Recovery.

When this issue occurs, you see extension downgrade error entries in /var/log/waagent.log that resemble the following example:

> 2018/03/16 12:00:46.196121 ERROR Event: name=extensionName, op=None, message=[ExtensionError] Downgrade not allowed, duration=0

> [!NOTE]
> This behavior occurs in Linux VM Agent versions 2.2.21 to 2.2.24.

## Status

Microsoft is taking steps to automatically resolve this issue for affected VMs. On those VMs, an additional Microsoft extension is being installed:

- Extension Publisher: Microsoft.CPlat.Core
- Extension Type: RunCommandLinux  

## Resolution

To resolve this issue without waiting for the fix from Microsoft, you can remove all `*.manifest.xml` files in `/var/lib/waagent/`.

 
