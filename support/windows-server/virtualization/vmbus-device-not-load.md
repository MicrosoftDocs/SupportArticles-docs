---
title: VMBus device doesn't load
description: Describes an issue in which the VMBus device doesn't load on a virtual machine.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, leons, v-srisan
ms.custom: sap:integration-components, csstroubleshoot
ms.subservice: hyper-v
---
# The VMBus device doesn't load on a virtual machine that is running on a computer with Hyper-V installed

This article provides help to fix an issue where the VMBus device doesn't load on a virtual machine that's created by using Virtual Server 2005 or Virtual PC 2007.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954282

## Symptoms

Consider the following scenario.

- You have a computer that has Hyper-V installed.
- You create a virtual machine on the computer.
- You create the virtual machine from a virtual hard disk image (.vhd file) that was created by using Microsoft Virtual Server 2005 or Microsoft Virtual PC 2007.

In this scenario, the **VMBus** Integration Services device does not load. When you open **Device Manager** on the virtual machine, a yellow triangle that has an exclamation point on it appears next to **VMBus**. When you double-click **VMBus**, the **VMBus Properties** dialog box displays one of the following messages:

> This device cannot find enough free resources that it can use. (Code 12).

> This device cannot start. (Code 10).

## Cause

This issue occurs because the hardware abstraction layer (HAL) isn't automatically updated.

When a virtual machine is created by using Virtual Server or Virtual PC, the Advanced Configuration and Power Interface (ACPI) HAL is used. The Integration Services requires an Advanced Programmable Interrupt Controller (APIC) HAL to load the **VMBus** device correctly.

## Resolution

To resolve this issue, follow these steps:

1. Start the virtual machine.
2. Click **Start**, click **Run**, type *Msconfig.exe*, and then click **OK**.
3. In the **System Configuration** dialog box, click the **Boot** tab, and then click **Advanced Options**.
4. In the **BOOT Advanced Options** dialog box, click to select the **Detect HAL** check box, and then click **OK**.
5. Click **Yes** to restart the virtual machine.
6. After the virtual machine is restarted, open **Device Manager**, and then verify that all Integration Services devices are installed.
7. In **Device Manager**, expand **Computer**, and then verify that an APIC-based PC HAL is listed. For x86 virtual machines, this item will be listed as **APIC x86-based PC**. For x64 virtual machines, this item will be listed as **APIC x64-based PC**.

> [!NOTE]
> You can clear the **Detect HAL** check box that you selected in step 4. If the **Detect HAL** check box is selected, the virtual machine takes a slightly longer time to start.

## More information

For more information, see [Hyper-V technology](/windows-server/virtualization/hyper-v/hyper-v-technology-overview).
