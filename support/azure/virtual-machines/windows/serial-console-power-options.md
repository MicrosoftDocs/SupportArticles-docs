---
title: Azure Serial Console Power Options
description: VM power options available within the Azure Serial Console
services: virtual-machines
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: linux
ms.tgt_pltfrm: vm
ms.workload: infrastructure-services
ms.date: 10/16/2025
ms.author: jarrettr
ms.custom: sap:Cannot connect to my VM
---

# Power Options available from the Azure Serial Console

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

The Azure Serial Console provides several powerful tools for power management on your virtual machine (VM) or virtual machine scale set. This article provides an overview of each tool and its intended use case to minimize confusion about these power management options.

Serial Console feature | Description | Use case
:----------------------|:------------|:---------
Restart VM | A graceful restart of your VM or virtual machine scale set instance. This operation is the same as calling the restart feature that's available in the Overview page. | In most cases, this option should be your primary tool when you try to restart your VM. When you use this option, your Serial Console connection experiences a brief interruption, and then automatically resumes when the VM restarts.
Reset VM | A forceful power cycle of your VM or virtual machine scale that's set by the Azure platform. | This option is used to immediately restart your OS regardless of its current state. Because this operation isn't graceful, there's a risk of data loss or corruption. There's no interruption in the Serial Console connection. This condition is useful for sending commands early during startup (for example, getting to GRUB on a Linux VM or to Safe Mode in a Windows VM).
SysRq - Reboot (b) | A system request to force a guest restart. | This feature is applicable to only Linux systems, and requires [SysRq to be enabled](../linux/serial-console-nmi-sysrq.md#system-request-sysrq) in the OS. If the system is correctly configured for SysRq, this command causes the OS to restart.
NMI (Non-maskable Interrupt) | An interrupt command that's delivered to the OS. | This operation is available for both [Windows](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) and [Linux](../linux/serial-console-nmi-sysrq.md#non-maskable-interrupt-nmi) VMs. It requires NMI to be enabled. Sending an NMI typically causes your system to stop responding. You can configure your system to create a dump file and then restart upon receiving the NMI. This condition might be useful in low-level debugging.

## Next steps

* Learn more about the [Azure Serial Console for Linux VMs](../linux/serial-console-linux.md)
* Learn more about the [Azure Serial Console for Windows VMs](./serial-console-windows.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
