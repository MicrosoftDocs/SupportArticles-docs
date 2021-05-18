---
title: Move Event Viewer log files to another location
description: Describes how to move Event Viewer log files to another location on the hard disk.
ms.date: 10/14/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jwojan
ms.prod-support-area-path: Event System
ms.technology: windows-server-application-compatibility
---
# How to move Event Viewer log files to another location

This article describes how to move Microsoft Windows 2000 and Windows Server 2003 Event Viewer log files to another location on the hard disk.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 315417

## Summary

Windows 2000 and Windows Server 2003 record events in the following logs:

- Application log

    The application log contains events that are logged by programs. Events that are written to the application log are determined by the developers of the software program.

- Security log

    The security log contains events such as valid and invalid logon attempts. It also contains events that are related to resource use, for example, when you create, open, or delete files. You must be logged on as an administrator or as a member of the Administrators group to turn on, to use, and to specify which events are recorded in the security log.

- System log

    The system log contains events that are logged by Windows system components. These events are predetermined by Windows.

- Directory Service log

    The Directory Service log contains Active Directory-related events. This log is available only on domain controllers.

- DNS Server log

    The DNS Server log contains events that are related to the resolution of DNS names to or from Internet protocol (IP) addresses. This log is available only on DNS servers.

- File Replication Service log

    The File Replication Service log contains events that are logged during the replication process between domain controllers. This log is available only on domain controllers.

By default, Event Viewer log files use the .evt extension and are located in the `%SystemRoot%\System32\Config` folder.

Log file name and location information is stored in the registry. You can edit this information to change the default location of the log files. You may want to move log files to another location if you require more disk space in which to log data.

## Move Event Viewer log files to another location

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To move Event Viewer log files to another location on the hard disk, follow these steps:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *regedit*, and then click **OK**.
3. Locate and click the registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog`.
4. Click the subkey that represents the event log that you want to move, for example, click **Application**.
5. In the right pane, double-click **File**.
6. Type the complete path to the new location (including the log file name) in the **Value data** box, and then click **OK**.

    For example, if you want to move the application log (Appevent.evt) to the **Eventlogs** folder on the E drive, type *e:\eventlogs\appevent.evt*.
7. Repeat steps 4 through 6 for each log file that you want to move.
8. Click **Exit** on the **Registry** menu.
9. Restart the computer.

## View the name and location of Event Viewer log files

To view the name and the location of Event Viewer log files, follow these steps:

1. Click **Start**, point to **Settings**, and then click **Control Panel**.
2. Double-click **Administrative Tools**, and then double-click **Event Viewer**.

    Alternatively, open the snap-in that contains Event Viewer.
3. Click to expand Event Viewer (if it is not already expanded).
4. Right-click the log that you want to view, and then click **Properties**.
5. Click the **General** tab.

    The name and the location of the log file is displayed under **Log name**.

## References

For more information about how to view and manage logs in Event Viewer, see the following article:

- [How to Delete Corrupt Event Viewer Log Files](https://support.microsoft.com/help/172156)

For more information about how to use Event Viewer, see Event Viewer Help. To do so, click the **Action** menu in Event Viewer, and then click **Help**.
