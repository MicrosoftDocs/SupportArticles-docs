---
title: Error 0x8007000D when you run the Backup-GPO PowerShell CmdLet in Windows Server Core edition
description: Describes an issue in which you receive error 0x8007000D when you run the Backup-GPO PowerShell CmdLet in Windows Server Core edition.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: herbertm
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# Error 0x8007000D when running the Backup-GPO PowerShell CmdLet in Windows Server Core edition

On a computer that is running Windows Server 2016 or Windows Server 2019 Core edition and has the Group Policy Management Console (GPMC) feature installed, you can't use the `Backup-GPO` PowerShell CmdLet to back up a group policy that contains folder redirection settings.

_Applies to:_ &nbsp; Windows Server 2016 Core edition, Windows Server 2019 Core edition

## PowerShell output example

This result appears in the PowerShell window:

```powershell
PS C:\> Backup-GPO -Name FolderRedirection -Path <path>

Backup-GPO : The data is invalid. (Exception from HRESULT: 0x8007000D)
At line:1 char:1
+ Backup-GPO -Name FolderRedirection -Path <path>
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Backup-GPO], COMException
    + FullyQualifiedErrorId : System.Runtime.InteropServices.COMException,Microsoft.GroupPolicy.Commands.BackupGpoComm
   and
```

> [!Note]
>
> - The error code **0x8007000D** stands for **ERROR_INVALID_DATA**.
> - The issue doesn't occurs when you run this command on a Windows Server 2016 or Windows Server 2019 Desktop version.

## Cause

This issue is a known issue. Some modules aren't present by default in Windows Server Core editions.

During the backup process, the system checks settings related to the type of policy found. On Windows Server Core version, a Client-Side Extension (CSE) related library used for Folder Redirection policies isn't present. This causes a COM Exception.

## How to work around this issue

Here are three workarounds:

- Run group policy backups on Desktop version of Windows Server 2016 or Windows Server 2019.
- Run group policy backups remotely from Windows 10 workstation with Remote Service Administration Tools (RSAT) installed for GPMC.
- Run the `wbadmin` application with the `systemstatebackup` option instead. This backup includes both Active Directory database and sysvol folder content.

## Reference

For more information on wbadmin syntax, see [wbadmin start systemstatebackup](/windows-server/administration/windows-commands/wbadmin-start-systemstatebackup).
