---
title: GPMC or Import-GPO cmdlet fails to restore a GPO from backup
description: Helps fix the issue in which you fail to restore a Group Policy Object (GPO) from backup by using the Group Policy Management Console (GPMC) or the Import-GPO cmdlet.
ms.date: 01/05/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
ms.technology: windows-server-group-policy
---
# GPMC or Import-GPO cmdlet fails to restore a GPO from backup

This article helps fix the issue in which you fail to restore a Group Policy Object (GPO) from backup by using the Group Policy Management Console (GPMC) or the `Import-GPO` cmdlet.

When you use the wizard by selecting **Restore from Backup** in GPMC or the [Import-GPO](/powershell/module/grouppolicy/import-gpo) cmdlet to restore a GPO from backup, you receive the following error message:

> The process cannot access the file because it is being used by another process.

## The GPO file is being accessed by some other process

This issue occurs when the wizard in GPMC or the `Import-GPO` cmdlet tries to acquire an exclusive handle to some file of the GPO in SYSVOL share, but that file is being accessed by some other process. For example, a remote user is refreshing group policies.

The [Process Monitor](/sysinternals/downloads/procmon) log shows that the caller (*mmc.exe* or *powershell.exe*) receives the **SHARING VIOLATION** result when trying to get a handle to some file of that GPO in SYSVOL share.

Here's an example about the *Registry.pol* file:

:::image type="content" source="media/gpmc-import-gpo-fails-restore-gpo-backup/sharing-violation.png" alt-text="Screenshot of the Event Properties window showing the SHARING VIOLATION result and the None ShareMode.":::

In this request, **ShareMode** is **None** indicates this handle should be exclusive. That means, the handle can't coexist with any existing handle to the same file, and no additional handle is allowed to the same file before this exclusive handle is closed.

The exclusive handle is necessary in this scenario, because each file of the GPO in SYSVOL share will be replaced by the corresponding file from backup. Failure on any file will cause the restore operation to fail.

For more information about the share mode, see:

- [CreateFileA function (fileapi.h)](/windows/win32/api/fileapi/nf-fileapi-createfilea)
- [Creating and Opening Files](/windows/win32/fileio/creating-and-opening-files)

## Specify a different target domain controller (DC)

By default, the target DC used by GPMC or the `Import-GPO` cmdlet is the primary domain controller (PDC) Flexible Single Master Operation (FSMO) role of the domain. This behavior is by design.

To work around this issue, specify a different DC with no or little user access.

In GPMC, expand **Domains** in the console tree, right-click the domain and select **Change Domain Controller**.

For the `Import-GPO` cmdlet, use the `-Server` parameter. For example:

```Powershell
Import-GPO -BackupGpoName TestGPO1 -TargetName TestGPO1 -Path C:\GOPBackup\ -Server ContosoDC2
```
