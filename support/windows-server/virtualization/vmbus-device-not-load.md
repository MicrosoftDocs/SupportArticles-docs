---
title: VMBus device doesn't load
description: Describes an issue in which the VMBus device doesn't load on a virtual machine that was created by using Virtual Server 2005 or Virtual PC 2007.
ms.date: 09/08/2020
author: delhan
ms.author: Delead-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Integration components
ms.technology: HyperV
---
# The VMBus device doesn't load on a virtual machine that is running on a Windows Server 2008-based computer that has Hyper-V installed

This article provides help to fix an issue where the VMBus device doesn't load on a virtual machine that's created by using Virtual Server 2005 or Virtual PC 2007.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954282

> [!NOTE]
> Support for Windows Vista Service Pack 1 (SP1) ends on July 12, 2011. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see this Microsoft web page: [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs).

## Symptoms

Consider the following scenario.

- You have a Windows Server 2008-based computer that has Hyper-V installed.
- You create a virtual machine on the Windows Server 2008-based computer.
- You create the virtual machine from a virtual hard disk image (.vhd file) that was created by using Microsoft Virtual Server 2005 or Microsoft Virtual PC 2007.In this scenario, the **VMBus** Integration Services device does not load. When you open Device Manager on the virtual machine, a yellow triangle that has an exclamation point on it appears next to **VMBus**. When you double-click **VMBus**, the **VMBus Properties** dialog box displays one of the following messages: This device cannot find enough free resources that it can use. (Code 12).
This device cannot start. (Code 10).

## Cause

This issue occurs because the hardware abstraction layer (HAL) isn't automatically updated in Windows Server 2008. (This is also true in Windows Vista.)

When a virtual machine is created by using Virtual Server or Virtual PC, the Advanced Configuration and Power Interface (ACPI) HAL is used. The Integration Services requires an Advanced Programmable Interrupt Controller (APIC) HAL to load the **VMBus** device correctly.

## Resolution

To resolve this issue, follow these steps:
1. Start the virtual machine.
2. Click **Start**, click **Run**, type Msconfig.exe, and then click **OK**.
3. In the **System Configuration** dialog box, click the **Boot** tab, and then click **Advanced Options**.
4. In the **BOOT Advanced Options** dialog box, click to select the **Detect HAL** check box, and then click **OK**.
5. Click **Yes** to restart the virtual machine.
6. After the virtual machine is restarted, open Device Manager, and then verify that all Integration Services devices are installed.
7. In Device Manager, expand **Computer**, and then verify that an APIC-based PC HAL is listed. For x86 virtual machines, this item will be listed as **APIC x86-based PC**. For x64 virtual machines, this item will be listed as **APIC x64-based PC**.

> [!NOTE]
> You can clear the **Detect HAL** check box that you selected in step 4. If the **Detect HAL** check box is selected, the virtual machine takes a slightly longer time to start.

## More information

For more information about Hyper-V technology, visit the following Microsoft Web site: [https://technet2.microsoft.com/windowsserver2008/en/library/c513e254-adf1-400e-8fcb-c1aec8a029311033.mspx?mfr=true](https://technet2.microsoft.com/windowsserver2008/en/library/c513e254-adf1-400e-8fcb-c1aec8a029311033.mspx?mfr=true)
