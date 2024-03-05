---
title: Profile loading fails
description: Describes an issue in which profile loading fails when the ntuser.dat or usrclass.dat file is defined as read-only, or the profile user lacks the appropriate permissions for these two .dat files.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:user-profiles, csstroubleshoot
---
# Error occurs during desktop setup and desktop location is unavailable when you log on to Windows for the first time

This article provides help to solve an issue where profile loading fails when the ntuser.dat or usrclass.dat file is defined as read-only, or the profile user lacks the appropriate permissions for these two .dat files.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3048895

## Symptoms  

After you install the update in [Vulnerability in Windows User Profile service could allow elevation of privilege: January 13, 2015 (MS15-003)](https://support.microsoft.com/help/3021674), you meet the following issues:

- Profiles don't load when users log on to a computer for the first time. Or, you log on to a computer where policy deletes the cached profile after a date interval when you log off.

    > [!NOTE]
    > Logons that use mandatory user profiles or Virtual Desktop Infrastructure (VDI) may also be affected.

- Profiles don't load when users log on by using cached user profiles.
- Services don't start because of profile load failures. Affected services include but aren't limited to the following:
  - Local Service
  - Network Service
  - MSSQL

When this issue occurs, related events are logged. See [the events that are logged in Event Viewer](#more-information).

Process Monitor may indicate that a **CreateFile** operation fails with an **ACCESS DENIED** result to the following path, depending on how file access is constrained:
**\<drive>**:\documents & settings\\\<username>\local settings\Application Data\Microsoft\Windows\UsrClasss.dat.

The screenshot of Process Monitor can be seen here:

:::image type="content" source="media/desktop-location-unavailable/process-monitor.png" alt-text="Process Monitor indicates that a CreateFile operation fails with an ACCESS DENIED result.":::

See [Details of the failure that are displayed in Process Monitor](#details-of-the-failure-that-are-displayed-in-process-monitor).

## Cause

Update 3021674 adds checks for access to the Ntuser.dat and the Usrclass.dat files.

## Resolution

To resolve this issue, follow these steps:  

1. Check whether the READ ONLY flag is set on the NTUSER.DAT or USERCLASS.DAT file for the profile that fails to load.

    New user profiles are derived from C:\users\default\ during first-time account logons. If profiles fail to load with signatures that match those that are described in the "Symptoms" section, check whether the Read-Only bit is enabled on the NTUSER.DAT and USRCLASS.DAT files in the profile directory for the users or service accounts in question.

    NTUSER.DAT in Windows Vista and later versions of Windows is located in C:\users\default\ntuser.dat. Earlier operating systems have other paths, such as C:\Documents and Settings\\\<username>\ntuser.dat.

    The USRCLASS.DAT file is typically located along a path like C:\Documents and Settings\< **user_name** >\Local Settings\Application Data\Microsoft\Windows\UsrClass.dat or C:\Users\< **user_name** >\AppData\Local\Microsoft\Windows.

    In Windows Explorer, right-click the NTUSER.DAT or USRCLASS file for the relevant default user or cached user profile. The **Read-only** check box should be cleared. If this check box is selected, it will cause profile load failures.

    :::image type="content" source="media/desktop-location-unavailable/clear-read-only-in-ntuser-properties.png" alt-text="Make sure the Read-only option is unselected in NTUSER.DAT Properties." border="false":::

2. Check the NTFS File System permissions setting on the NTUSER.DAT or USERCLASS.DAT file in the cached profile directory that fails to load.

In the following screenshot, the test user, CONTOSO/testUser, has full control over NTUSER.DAT (not shown) and USRCLASS.DAT. Everyone isn't listed in the ACL Editor group.

|NTFS File System ACLS on DAT files|Advanced NTFS File System ACLS on DAT files|
|---|---|
|:::image type="content" source="media/desktop-location-unavailable/ntfs-file-system-permissions-on-ntuser.png" alt-text="The permission of the test user that's shown in the Security tab of UsrClass.dat Properties." border="false":::<br/>|:::image type="content" source="media/desktop-location-unavailable/ntfs-file-system-permissions-on-usrclass.png" alt-text="The permission of the test user that's shown in the Advanced Security Settings for UsrClass.dat." border="false":::|

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

### Events that are logged in Event Viewer

|Log Name|Event sender|Event ID|Event message text|
|---|---|---|---|
|Application|Microsoft-Windows-User Profiles Service|1542| **Windows cannot load classes registry file.<br/>DETAIL - Unspecified error<br/>Die Klassenregistrierungsdatei kann nicht geladen werden.<br/>DETAIL - Unbekannter Fehler** |
|Application|Service Control Manager|7005| **The LoadUserProfile call failed with the following error:<br/>The system cannot find the file specified.** |
|Application|Service Control Manager|7024| **The SQL Server (MSSQLSERVER) service terminated with service-specific error 2148081668 (0x80092004).** |
|Application|Userenv|1500| **Windows cannot log you on because your profile cannot be loaded. Check that you are connected to the network, or that your network is functioning correctly. If this problem persists, contact your network administrator. DETAIL - The system cannot find the file specified.** |
|Application|Userenv|1502| **Windows cannot load the locally stored profile. Possible causes of this error include insufficient security rights or a corrupt local profile. If this problem persists, contact your network administrator.** |

### Details of the failure that are displayed in Process Monitor

ProMon detailsThe following message is displayed in Process Monitor:

> Desired Access: Generic Read/Write, Disposition: Open, Options: Synchronous IO Non-Alert, Non-Directory File, Attributes: H, ShareMode: Read, Write, AllocationSize: n/a, Impersonating: \<SID>  

The following screenshot shows the Process Monitor details:

:::image type="content" source="media/desktop-location-unavailable/process-monitor-details.png" alt-text="Details of the failure that are displayed in Process Monitor." border="false":::
