---
title: Delete corrupt Event Viewer Log files
description: Describes a method to rename or move these files for troubleshooting purposes.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, lynnroe, jwojan
ms.custom: sap:System Management Components\WinRM, including event forwarding and collections, csstroubleshoot
---
# How to delete corrupt Event Viewer Log files

This article describes a method to rename or move these files for troubleshooting purposes.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 172156

## Symptoms

When you launch Windows Event Viewer, one of the following error messages may occur if one of the *.evt files is corrupt:

> The handle is invalid  

> Dr. Watson Services.exe  
Exception: Access Violation (0xc0000005), Address: 0x76e073d4

When you select **OK** or cancel on the Dr. Watson error message, you may also receive the following error message:

> Event Viewer  
Remote Procedure Call failed

The services.exe process may consume a high percentage of CPU utilization.

## Cause

The Event Viewer Log files (*Sysevent.evt*, *Appevent.evt*, *Secevent.evt*) are always in use by the system, preventing the files from being deleted or renamed. The EventLog service can't be stopped because it's required by other services, thus the files are always open.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756)

## NTFS Partition

1. Select the **Start** button, point to **Settings**, select **Control Panel**, and then double-click **Services**.

2. Select the **EventLog service** and select **Startup**. Change the Startup Type to **Disabled**, and then select **OK**. If you're unable to sign in the computer but can access the registry remotely, you can change the Startup value in the following registry key to 0x4:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog`

3. Restart Windows.

    > [!NOTE]
    > When the system starts up, several services may fail; a message informing the user to use Event Viewer to review errors may appear.

4. Rename or move the corrupt *.evt file from the following location:
    `%SystemRoot%\System32\Config`

5. In Control Panel Services tool, re-enable the EventLog service by setting it back to the default of Automatic startup, or change the registry Startup value back to 0x2.

## FAT partition (Alternative method)

1. Boot to an MS-DOS prompt using a DOS bootable disk.

2. Rename or move the corrupt *.evt file from the following location:
    `%SystemRoot%\System32\Config`

3. Remove the disk and restart Windows.

When Windows is restarted, the Event Log file will be recreated.
