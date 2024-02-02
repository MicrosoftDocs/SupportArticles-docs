---
title: Access Denied when you run batch job
description: Describes an issue where you cannot run a batch job that runs as a regular user account on a Windows Server 2003-based member server. Includes detailed methods to resolve the issue.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, rmartin
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
ms.subservice: backup-and-storage
---
# Access is denied when you run a batch job on a Windows Server 2003-based computer

This article provides solution to an error (Access is denied) that occurs when you run a batch job on a Microsoft Windows Server 2003-based computer.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 867466

## Symptoms

When you run a batch job that runs under the context of a regular user account, the script may not run. If you run the batch job by using the Scheduled Tasks feature, the following error message may be logged in the Scheduled Tasks log file (Schedlgu.txt):

> 0x80070005: Access is denied.

If you use a debugger program to try to determine why the batch job does not work, the following error message may appear in the debug output:

> Access Denied (Error 5)

## Cause

This issue occurs if all the following conditions are true:

- You run the batch job on a Windows Server 2003-based member server.
- The batch job runs as a non-interactive process.
- The batch job is configured to run under the context of an account that is not a member of the Administrators group.

In Windows Server 2003, the Users group does not have Read and Execute permissions to the command processor (Cmd.exe). By default, the Cmd.exe program has the following permissions settings:

- The Interactive implicit group and the Service implicit group have Read and Execute permissions.

    > [!NOTE]
    > On a member server, the TelnetClients group also has Read and Execute permissions. On a domain controller, the Batch implicit group also has Read and Execute permissions.

- The Administrators group and the System implicit group have Full Control permissions.

To resolve this issue, use either of the following methods.

## Resolution 1: Grant Cmd.exe Read and Execute permissions

Grant the Cmd.exe program Read and Execute permissions for the user account that the batch job runs under. To do this, follow these steps:

1. Click **Start**, and then click **Windows Explorer**.
2. Locate and then right-click the Cmd.exe file. The Cmd.exe file is located in the %windir%\System32 folder.
3. Click **Properties**.
4. Click the **Security** tab.
5. Click **Add**.
6. In the **Enter the object names to select** box, type the user name that the batch job runs under, and then click **OK** two times.

    > [!NOTE]
    > When you add the user, the user is automatically granted Read and Execute permissions.

7. Click **Yes** when you are prompted to continue.

### Resolution 2: Grant Read and Execute permissions for Cmd.exe file to Batch group

Grant Read and Execute permissions for the Cmd.exe file to the Batch group. This permits all batch processes to run the command processor. To do this, follow these steps:

1. Click **Start**, and then click **Windows Explorer**.
2. Locate and then right-click the ****Cmd.exe**** file. The Cmd.exe file is located in the %windir%\System32 folder.
3. Click **Properties**.
4. Click the **Security** tab.
5. Click **Add**.
6. In the **Enter the object names to select** box, type *Batch*, and then click **OK** two times.
7. Click **Yes** when you are prompted to continue.

## More information

The behavior that is described in this article is different from the default behavior of Microsoft Windows 2000 Server. By default, Windows 2000 Server grants Read permissions and Execute permissions to the Users group.

For more information about implicit groups, visit the following Microsoft Web sites:

- [Default User Accounts and Groups](/previous-versions/windows/it-pro/windows-2000-server/bb726980(v=technet.10))
- [Using Default Group Accounts](/previous-versions/windows/it-pro/windows-2000-server/bb726982(v=technet.10))
