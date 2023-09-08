---
title: Users can't print after you install a service pack, update rollup, or printer hotfix on a server in Windows
description: Describes an issue where you can't print after you install a service pack or printer hotfix on a server.
ms.date: 04/20/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: eldenc, kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
ms.technology: windows-server-printing
---
# Users can't print after you install a service pack, update rollup, or printer hotfix on a Windows-based server

This article provides help to solve an issue where you can't print after you install a service pack or printer hotfix on a server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 832219

## Symptoms

After you install a service pack, an update rollup, or a hotfix that updates the Unidrvui.dll file on Windows Server, users may experience both of the following symptoms:

- When a client or server tries to print, the Print Spooler service appears to stop responding (or "hang"), and the following error message appears:

    > Unable to create Print job.

- When you try to print a test page from the server console, you receive the following error message:

    > Test page failed to print.

- The Add Driver or Add Printer wizards stop responding, either when you try to install the driver by using Devices and Printers, or by using the Print Management Console.

## Cause

This behavior may occur if you install the service pack or hotfix package on a server that has many Unidrv-based Printer Control Language (PCL) printer drivers.

When you install a service pack or hotfix file that updates Unidrvui.dll on a server with many Unidrv-based PCL printer drivers, the server may spend a long time (up to 2 hours) regenerating the parsed binary printer description files (.bud files) that are used to increase spooler efficiency for these drivers. During this time, Print Spooler can't receive incoming print jobs and may return messages to clients that indicate that the print queue is full. This is a one-time parsing operation and doesn't occur after the parsed binary .bud files are successfully regenerated.

Binary .bud files that are generated from generic printer description (GPD) files must be regenerated because the GPD parser file version is changed. After all the Unidrv-based PCL drivers are parsed, the spooler can again receive print jobs. Because of this, Microsoft recommends that you schedule service pack and hotfix installations on servers with many Unidrv-based PCL printer drivers to accommodate this up-to-two-hour .bud file compilation.

## Resolution

To resolve this issue, schedule sufficient time for the server to complete the parsing of all Unidrv-based printer drivers for each upgraded driver file, and then schedule sufficient time for each printer that uses these files.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

If you can't wait for the server to complete the parsing of all the Unidrv-based printer drivers, manually remove all cached binary printer description files (.bud files), and then let them be automatically re-created. Depending on the speed of your server, this automatic re-creation may be completed in a shorter time. Typically, this operation is completed within 30 minutes.

> [!NOTE]
> When Print Spooler starts, it installs a newer version of Unidrv.dll. As a result, the .bud files are out of date. The .bud files are the compiled versions of .ppd files and can be completely regenerated from those .ppd files. Because of this, you can remove the .bud files.

To do this, follow these steps:

1. Stop the Print Spooler service. To do this, run the following command from a command prompt:

    ```console
    net stop spooler
    ```

2. Search for all .bud files, and then make sure that they're stamped with the current time and date. The files appear with today's date.
3. Remove all .bud files that have a date and time stamp that is before today's date. These files are located in the following folder:

    %SYSTEMROOT%\\System32\\Spool\\Drivers\\w32x86\\3

4. Remove the following registry key if it exists:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\PostSPUpgrade`

    To do this, follow these steps:

    1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
    2. Locate, and then click the following registry subkey:  
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print`
    3. On the **Registry** menu, click **Export Registry File**.
    4. In the **File name** box, type *printkey*, and then click **Save**.

        > [!NOTE]
        > If you later have to restore the **Print** registry key, you can do so by double-clicking the Printkey.reg file that you saved.
    5. Locate, and then click the following registry subkey if it exists:  
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\PostSPUpgrade`

    6. On the **Edit** menu, click **Delete**, and then click **Yes** to confirm the removal of the **PostSPUpgrade** registry key.

        > [!NOTE]
        > The **PostSPUpgrade** registry key may reappear after you restart the computer. This behavior occurs if other .bud files exist that have not yet been parsed. After these files have been parsed, this registry key is automatically removed.
5. Restart the server.

After you restart the server, printing functionality is available to users after about 30 minutes.

## More information

In the .NET Framework 3.0, the unidrv.dll file is now included with XPS printing. The unidrv.dll file can also trigger this behavior.
