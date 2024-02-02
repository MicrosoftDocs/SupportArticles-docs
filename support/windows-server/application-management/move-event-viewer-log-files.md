---
title: Move Event Viewer log files to another location
description: Describes how to move Event Viewer log files to another location on the hard disk.
ms.date: 07/22/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jwojan
ms.custom: sap:event-system, csstroubleshoot
---
# How to move Event Viewer log files to another location

This article describes how to move Windows Server 2016 and Windows Server 2019 Event Viewer log files to another location on the hard disk.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 315417

## Summary

Windows Server records events in the following logs:

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

By default, Event Viewer log files use the .evt extension and are located in the *%SystemRoot%\\System32\\winevt\\Logs* folder.

Log file name and location information is stored in the registry. You can edit this information to change the default location of the log files. You may want to move log files to another location if you require more disk space in which to log data.

## Create an event log folder in another location

Create a folder where you want to store the event logs in your local drive and assign correct permissions. Here are the steps:

1. Create a folder (for example, *C:\EventLogs*).
2. Right-click the folder and select **Properties**.
3. Select the **Security** tab, and then select **Advanced** for special permissions or advanced settings.

    > [!NOTE]
    > The folder has "inheritance" enabled by default.

4. Select **Change** to change the **Owner** to *SYSTEM*, and then select **Disable Inheritance** as follows:

    :::image type="content" source="media/move-event-viewer-log-files/advanced-security-settings-eventlogs.png" alt-text="Screenshot of the Advanced Security Settings for EventLogs window.":::

    You'll be prompted to convert or remove inherited permissions. Select **Convert inherited permissions into explicit permissions on this object**, and you'll see the same permissions explicitly set on the folder.

    > [!NOTE]
    > To create subfolders for the logs, check the **Replace all child object permission entries with inheritable permissions entries from this object** option. The permissions set at the parent level are applied to all subfolders and files.


5. Adjust permissions so that the folder is assigned the correct permissions and check the **Applies to** column. These permissions should be the same as the advanced permissions of the default folder (*%SystemRoot%\\System32\\winevt\\Logs*) that stores the Event Viewer logs. Make sure that the **Authenticated Users** only have **Read** permission for **This folder and subfolders**.

    :::image type="content" source="media/move-event-viewer-log-files/advanced-security-settings-logs.png" alt-text="Screenshot of the Advanced Security Settings for Logs window.":::

    > [!NOTE]
    > To add the **EventLog** user, go to the **Security** tab of the properties dialog box and follow these steps:
    >
    > 1. Select **Edit** > **Add**.
    > 2. Select **Locations**, select the local computer name, and then select **OK**.
    > 3. Type *NT SERVICE\EventLog* in **Enter the object names to select** and select **Check Names**. The name should be resolved to **EventLog**. Select **OK** to finish.
    >
    > Make sure **Full Control** is selected under **Permissions for EventLog** for the **EventLog** user.

## Move Event Viewer log files to another location

You can move the log files to the created folder by using the **Event Viewer** as follows:

1. Open the **Event Viewer**.
2. Right-click the log name (for example, **System**) under **Windows Logs** in the left pane and select **Properties**.
3. Change the **Log path** value to the location of the created folder and leave the log file name at the end of the path (for example, *C:\EventLogs\System.evtx*).

    :::image type="content" source="media/move-event-viewer-log-files/system-log-properties.png" alt-text="Screenshot of the Log Properties window with the General tab opened.":::

4. Select **Clear Log**, and then select **Save and Clear** to retain the event log files in a different location.
5. Select **Apply** > **OK**.

    > [!NOTE]
    > Check the folder you moved the event logs to. If the event logs are not in the folder, restart the system.

You can confirm that the log path has been updated by using Registry Editor. For example, go to the following registry path and check the **Value data** of the **File** value.

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\System` 

## Move Event Viewer log files by using Powershell

It is possible to utilize Powershell for this purpose. In the sample, *Security* event logs will be migrated to *C:\\Logs*:

```powershell
$originalFolder = "$env:SystemRoot\system32\winevt\Logs"
$targetFolder = "C:\logs"
$logName = "Security"

$originalAcl = Get-Acl -Path $originalFolder -Audit -AllCentralAccessPolicies
Set-Acl -Path $targetFolder -AclObject $originalAcl -ClearCentralAccessPolicy
$targetAcl = Get-Acl -Path $targetFolder -Audit -AllCentralAccessPolicies
$targetAcl.SetOwner([System.Security.Principal.NTAccount]::new("SYSTEM"))

New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\$logName" -Name "AutoBackupLogFiles" -Value "1" -PropertyType "DWord"
New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\$logName" -Name "Flags" -Value "1" -PropertyType "DWord"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\$logName" -Name "File" -Value "$targetFolder\$logName.evtx"
```
    
## References

For more information about how to view and manage logs in the Event Viewer, see [How to delete corrupt Event Viewer Log files](https://support.microsoft.com/help/172156). To learn more about general Event Viewer usage, select the **Action** menu in Event Viewer, and then select **Help**.
