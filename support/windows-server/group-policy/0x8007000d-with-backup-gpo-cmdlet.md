---
title: 0x8007000D when you run the Backup-GPO PowerShell CmdLet in Windows Server Core edition
description: Describes an issue in which you receive error 0x8007000D when you run the Backup-GPO PowerShell CmdLet in Windows Server Core edition.
ms.date: 03/10/2021
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: herbertm
ms.prod-support-area-path: Group Policy management - GPMC or AGPM
ms.technology: windows-server-group-policy
---
# 0x8007000D when you run the Backup-GPO PowerShell CmdLet in Windows Server Core edition

On a Windows Server 2016 or Windows Server 2019 Core edition computer that has Group Policy Management Console (GPMC) feature installed, you can't use the `Backup-GPO` PowerShell CmdLet to back up a group policy that contains folder redirection settings.

## PowerShell output example

You receive the following result in the PowerShell window:

```powershell
Backup-GPO -Name FolderRedirection -Path C:\GPO\
Backup-GPO : The data is invalid. (Exception from HRESULT: 0x8007000D)
At line:1 char:1
+ Backup-GPO -Name FolderRedirection -Path C:\GPO\
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Backup-GPO], COMException
    + FullyQualifiedErrorId : System.Runtime.InteropServices.COMException,Microsoft.GroupPolicy.Commands.BackupGpoComm
   and
```

> [!Note]
> - The error code **0x8007000D** stands for **ERROR_INVALID_DATA**.
> - The issue does not occurs when you run this command on a Windows Server 2016 or Windows Server 2019 Desktop version.

## Cause

This issue is a known issue because some modules aren't present by default in Windows Server Core editions.

During backup processing, system checks settings related to the type of policy found. On Windows Server Core version, a library related to the Client-Side Extension (CSE) which is used for Folder Redirection policies isn't present, that leads to raise a COM Exception.
 
## How to work around this issue
 
Here are three workarounds for this issue.
 
- Run group policy backups on Desktop version of Windows Server 2016 or Windows Server 2019.
- Run group policy backups remotely from Windows 10 workstation with Remote Service Administration Tools (RSAT) installed for GPMC.
- Run the `wbadmin a systemstatebackup` command instead. This backup includes both Active Directory database and sysvol folder content.

## Reference

For more information on wbadmin syntax, see [wbadmin start systemstatebackup](https://docs.microsoft.com/windows-server/administration/windows-commands/wbadmin-start-systemstatebackup).
