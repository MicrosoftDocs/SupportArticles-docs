---
title: GPMC or Import-GPO cmdlet fails to restore a GPO from backup
description: Helps fix an issue where you can't restore a Group Policy Object (GPO) from the backup using the Group Policy Management Console (GPMC) or the Import-GPO cmdlet.
ms.date: 01/09/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna, jaml, dennhu
ms.custom: sap:Group Policy\Group Policy management (GPMC or GPedit), csstroubleshoot
---
# GPMC or Import-GPO cmdlet fails to restore a GPO from backup

This article helps fix an issue in which you fail to restore a Group Policy Object (GPO) from the backup by using the Group Policy Management Console (GPMC) or the `Import-GPO` cmdlet.

When you try to import or restore a GPO with one of the following options:

- The wizard by selecting **Restore from Backup** in GPMC
- The wizard by selecting **Import Settings** in GPMC
- The [Import-GPO](/powershell/module/grouppolicy/import-gpo) cmdlet from the backup

You may receive the following error message:

> The process cannot access the file because it is being used by another process.

## The GPO file is being accessed by another process

This issue occurs when the wizard in GPMC or the `Import-GPO` cmdlet tries to acquire an exclusive handle to some file of the GPO in the SYSVOL share, but that file is being accessed by another process. For example, a remote user is refreshing group policies.

The [Process Monitor](/sysinternals/downloads/procmon) log shows that the caller (*mmc.exe* or *powershell.exe*) receives the **SHARING VIOLATION** result when trying to get a handle to some file of that GPO in the SYSVOL share.

Here's an example of a *Registry.pol* file:

:::image type="content" source="media/gpmc-import-gpo-fails-restore-gpo-backup/sharing-violation.png" alt-text="Screenshot of the Event Properties window showing the SHARING VIOLATION result and the None ShareMode.":::

In this request, **ShareMode** is **None**, indicating this handle should be exclusive. That means the handle can't coexist with any existing handle to the same file, and no other handle to the same file is allowed before this exclusive handle is closed.

The exclusive handle is necessary in this scenario because each file of the GPO in the SYSVOL share will be replaced by the corresponding file from the backup. Failure of any file will cause the restore operation to fail.

For more information about the share mode, see:

- [CreateFileA function (fileapi.h)](/windows/win32/api/fileapi/nf-fileapi-createfilea)
- [Creating and Opening Files](/windows/win32/fileio/creating-and-opening-files)

## Specify a different target domain controller (DC)

By default, the target DC used by GPMC or the `Import-GPO` cmdlet is the primary domain controller (PDC) Flexible Single Master Operation (FSMO) role of the domain. This behavior is by design.

To work around this issue, specify a different DC with no or little user access.

In GPMC, expand **Domains** in the console tree, right-click the domain, and select **Change Domain Controller**.

For the `Import-GPO` cmdlet, use the `-Server` parameter. For example:

```Powershell
Import-GPO -BackupGpoName TestGPO1 -TargetName TestGPO1 -Path C:\GOPBackup\ -Server ContosoDC2
```
