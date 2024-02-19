---
title: Error when you try to export a virtual machine
description: Describes an issue in which you can't export a virtual machine on a Windows Server 2008-based computer that uses Hyper-V if the hard disk configuration settings or network adapter configuration settings are incorrect. Provides a resolution.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:backup-and-restore-of-virtual-machines, csstroubleshoot
---
# Error when you try to export a virtual machine on a Windows Server 2008-based computer that uses Hyper-V: An error occurred while attempting to export the virtual machine

This article provides a resolution for an issue in which you can't export a virtual machine on a Windows Server 2008-based computer that uses Hyper-V if the hard disk configuration settings or network adapter configuration settings are incorrect.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954280

## Symptoms

When you try to export a virtual machine on a Windows Server 2008-based computer that uses Hyper-V, you may receive the following error message:

> An error occurred while attempting to export the virtual machine.  
 **Virtual machine name** failed to export.

## Cause

This issue may occur if one of the following conditions is true:  

- The virtual machine is configured to use a virtual hard disk that no longer exists.
- The virtual machine is configured to use a virtual hard disk for which the virtual hard disk path is incorrect.
- The virtual machine is configured to use a virtual network that no longer exists.

## Resolution

To resolve this issue, follow these steps:  

1. Open the Hyper-V Microsoft Management Console (MMC). To do this, click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.
2. Right-click the virtual machine that didn't export, and then click **Settings**.
3. Examine the network adapters or the legacy network adapters to see whether there's a configuration error message listed.
4. Take one of the following actions, depending on whether a configuration error message is listed:
    - If a configuration error message is listed, select the network adapter that lists the configuration error message, click a valid virtual network in the **Network** drop-down list, and then click **OK**.

    Or, click **Not connected** in the **Network** drop-down list, and then click **OK**.
    - If a configuration error message isn't listed, verify that the hard drives point to valid virtual hard disk (.vhd) files, and then click **OK**.
5. Right-click the virtual machine that didn't export, and then click **Export**.
6. Select the location where you want to export the virtual machine, and then click **Export**.
