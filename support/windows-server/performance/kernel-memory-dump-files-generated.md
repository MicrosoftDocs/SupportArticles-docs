---
title: Kernel memory dump files are generated
description: This behavior occurs to help prevent kernel memory dump files from being written to a page file where the memory dump file is larger than the page file. Workaround is to modify the registry to enable this behavior.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, chwall
ms.custom: sap:slow-performance, csstroubleshoot
ms.subservice: performance
---
# Kernel memory dump files may not be generated on Windows Server 2008-based and Windows Vista SP1 or later based computers when physical memory is larger than the size of the page file

This article provides help to solve an issue where Kernel memory dump files are generated on computers when physical memory is larger than the size of the page file.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 949052

> [!NOTE]
> Support for Windows Vista Service Pack 1 (SP1) ends on July 12, 2011. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see this Microsoft web page: [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs).

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows.  

## Symptoms

Kernel memory dump files may not be generated on Windows Server 2008-based or Windows Vista Service Pack 1 (SP1)-based computers.

You may also notice the following event is logged in the System event log:

> Event ID: 49  
Event Type: Error  
Event Source: volmgr  
Description: Configuring the Page file for crash dump failed. Make sure there is a page file on the boot partition and that is large enough to contain all physical memory.

## Cause

This behavior occurs when more physical memory (RAM) is installed than the initial size that is set for the page file. If a STOP error occurs when the system is configured to generate a kernel or complete memory dump, no memory dump file will be generated.

To confirm how much physical memory is installed on the system, follow these steps:

1. Click **Start**, right-click **Computer**, and then click **Properties**.
2. Check the size displayed at Memory (RAM) entry of **System** section.

## Workaround

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To work around this behavior, modify the registry so that writing of the memory dump files is attempted even if the physical memory size is larger than the initial size that is set for the page file. To do this, follow these steps:

1. Click **Start**, type *regedit* in the **Start Search** box, and then click **regedit** in the **Programs** list.

    If you are prompted for an administrator password or for confirmation, type your password, or click **Continue**.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\CrashControl`
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *IgnorePagefileSize*, and then press ENTER.
5. Right-click **IgnorePagefileSize**, and then click **Modify**.
6. In the **Value data** box, type *1*, and then click **OK**.
7. Exit **Registry Editor**.
8. Reboot the system for the change to take effect.

## References

For more information about how to configure system failure and recovery options in earlier versions of Windows, click the following article number to view the article in the Microsoft Knowledge Base:

[307973](https://support.microsoft.com/help/307973) How to configure system failure and recovery options in Windows
