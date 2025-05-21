---
title: Resolve Task Scheduler Access Denied Error
description: Introduce how to resolve the Access Denied error that occurs when you use Task Scheduler.
ms.date: 03/19/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: ormaldon, warrenw, 5x5UEX
ms.custom:
- sap:system management components\Task Scheduler
- pcy:WinComm User Experience
---
# "Access Denied" error when using Task Scheduler 

When using Task Scheduler, you receive the following error message:

> Access is denied. The user account does not have the permissions to run this task.

## Cause

The issue occurs due to one of the following reasons:

- The user account that you used to run the task doesn't have the necessary administrative privileges.
- The permissions for the **C:\\Windows\\System32\\Tasks** folder were changed.
- The task is configured to run with a specific set of credentials that differ from your current user account.

> [!NOTE]
> If you connect to a remote host using **mmc.exe** with the Task Scheduler snap-in or **taskschd.msc** console using a regular account, it's expected to receive an access denied error. Only accounts that are part of the Local Administrators group or Domain Administrators group are allowed to remotely manage a system. For security reasons, a non-administrator user can't view or manage a Windows Task Scheduler task created by another user. For more information, see [What's New in Task Scheduler](/windows/win32/taskschd/what-s-new-in-task-scheduler#windows-10-and-windows-server-2016).

## Resolution

To resolve this issue, use one of the following methods.

### Run Task Scheduler as administrator

Right-click **Task Scheduler** and select **Run as administrator**. This approach can often resolve access issues.

### Check user account permissions

Ensure that the user account you're using has the necessary permissions to run the task. You might need to add your user account to the Administrators group.

### Modify task properties

1. Open **Task Scheduler**, find the task causing the issue, right-click it, and select **Properties**.
2. Go to the **General** tab and select **Run with highest privileges**.

### Check Group Policy settings

   1. Open the Group Policy Editor by typing **gpedit.msc** in the **Run** box.
   2. Navigate to **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **User Rights Assignment**.
   3. Ensure that your user account has the **Log on as a batch job** right.

### Manual task reinitialization

   1. Export the problematic task to an XML file before deleting it. To do so, run the following command:

      ```powershell
      Export-ScheduledTask -TaskName "<task_name>" -FilePath "<backup_xml_file_path>"
      ```

   2. Reimport the task after registry/file corrections:

      ```powershell
      Register-ScheduledTask -Xml (Get-Content "<backup_xml_file_path>" | Out-String) -TaskName "<task_name>"
      ```
