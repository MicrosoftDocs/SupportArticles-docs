---
title: Azure Linux VM extensions stop running
description: VM Agent fails to process extensions, causing some extensions to stop running and affecting some dependent services, such as Azure Site Recovery.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
ms.custom: linux-related-content
ms.collection: linux
---
# Azure Linux VM extensions stop running

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4099558

## Symptoms

The Linux VM Agent fails to process extensions. This causes some extensions to stop running, which affects some dependent Azure services, such as Azure Backup Azure Site Recovery.

You will see extension downgrade errors similar to this recorded in /var/log/waagent.log:

> 2018/03/16 12:00:46.196121 ERROR Event: name=extensionName, op=None, message=[ExtensionError] Downgrade not allowed, duration=0

> [!NOTE]
> This behavior occurs in Linux VM Agent versions 2.2.21 to 2.2.24.

## Status

Microsoft is taking steps to automatically resolve this issue for affected VMs. On those VMs you will see an additional Microsoft extension installed:  

- Extension Publisher: Microsoft.CPlat.Core
- Extension Type: RunCommandLinux  

## Resolution

To resolve this issue without waiting for the fix from Microsoft, you can remove all `*.manifest.xml` files in `/var/lib/waagent/`.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
