---
title: Exchange public folder migration stops at 95 percent
description: Works around an issue in which an Exchange public folder migration stops at 95 percent because it can’t sync mail-enabled public folders.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Public Folder Configuration
  - Exchange Server
  - CI 112320
  - CSSTroubleshoot
  - CI 9823
  - CI 11994
ms.reviewer: batre
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Online
search.appverid: MET150
ms.date: 06/05/2026
---

# "There are [xx] Public Folders that could not be mail-enabled" error and Exchange public folder migration stops at 95 percent

## Summary

Public folder migration to Exchange Online can stop at 95 percent if the service doesn't synchronize mail-enabled public folders from on-premises. This issue occurs if some public folders are marked incorrectly as mail-enabled even though their corresponding mail-enabled objects are missing. Because these orphaned attributes remain, Exchange treats the folders as mail-enabled, and fails the synchronization step. To resolve the issue, use the `ValidateMailPublicFolders` script or PowerShell to fix affected mail-enabled public folders.

## Symptoms

When you migrate public folders from Microsoft Exchange Server to Exchange Online, the process stops at 95 percent.

Additionally, you encounter an error when you run the following command to review the migration report:

```powershell
Get-PublicFolderMailboxMigrationRequest |Get-PublicFolderMailboxMigrationRequestStatistics -IncludeReport
```

In this situation, you receive the following error message:

```asciidoc
Name                                                              StatusDetail TargetMailbox PercentComplete
----                                                              ------------ ------------- ---------------
PublicFolderMailboxMigrationfb3cdd37-ecf4-4d33-xxxx -fcec86xxxxxx FailedOther  MigP1         95
```

:::image type="content" source="media/public-folder-migration-fails/command-error.png" alt-text="Screenshot of the error message in the migration report.":::

If you then run the following command, you receive the following error details:

```powershell
$p=Get-PublicFolderMailboxMigrationRequest -Status Failed | Get-PublicFolderMailboxMigrationRequestStatistics -IncludeReport;$p[0].report.failures[-1].Message
```

**Error details:**

```asciidoc
FailureType            : FailedToMailEnablePublicFoldersException
Message                : Error: There are 32 Public Folders that could not be mail-enabled. Please, check the migration report starting at date/time for additional details. This may indicate that mail public folder objects in Exchange Online are out of sync with your Exchange deployment. You may need to rerun the script Sync-MailPublicFolders.ps1 on your source Exchange server to update mail-enabled public folder objects in Exchange Online Active Directory.
```

In the error details, the migration request shows that it doesn't synchronize mail-enabled public folders from on-premises.

However, all on-premises mail-enabled public folders are synchronized to Exchange Online. The error repeats even if you run the ".\Sync-MailPublicFolders.ps1" script multiple times.

Also, if you run the `Get-MailPublicFolder` command on-premises, the output doesn't show any mail-enabled public folders, and the migration request continues to fail and generate the error.

## Cause

If a public folder is mail-enabled, it has the `MailEnabled` property set to **True**. The `Disable-MailPublicFolder` command changes this property to **False** and removes corresponding entries from the Microsoft Exchange System Objects (MESO) container.

If the `Disable-MailPublicFolder` command doesn't complete the cleanup correctly, it might leave behind the `MailEnabled` property as **True**. However, it removes the objects from MESO container.

In this scenario, the `Get-MailPublicFolder` command doesn't list the folders that are described in the error message as mail-enabled public folders. However, these folders are still considered to be mail enabled. This situation causes the migration failure.

## Workaround

To work around this issue, use either of the following methods.

### Method 1: Use a script to detect issues that affect on-premises mail-enabled public folders

1. Download and run the [ValidateMailPublicFolders](https://aka.ms/ValidateMEPF) script on Exchange Server on-premises.

   The script reports orphaned mail-enabled public folders and mail-enabled public folders that are found under the NON_IPM_Subtree folder. It also suggests that you use a command to fix the issue:

1. Run the command that's suggested by the script.
1. Fix the issues that are reported by the script, and then run the script again to make sure that no issue is reported for mail-enabled public folders.

### Method 2: Use commands to detect issues that affect on-premises mail-enabled public folders

1. List the public folders that still have the `MailEnabled` property set to **True**. To list the folders, run the following command:

   ```powershell
   $pf=Get-PublicFolder \ -recurse -ResultSize Unlimited | ? { $_.MailEnabled }; ForEach ($i in $pf) {$mesoObj = Get-MailPublicFolder $i.identity; if ($mesoObj -eq $null) {$i }}
   ```

   > [!NOTE]
   > If you see error messages in the command output in addition to the error that states that the public folder isn't a mail-enabled public folder, you can safely ignore those messages.

1. To disable the mail-enabled public folders, run the following command:

   ```powershell
   $pf=Get-PublicFolder \ -recurse -ResultSize Unlimited | ? { $_.MailEnabled }; ForEach ($i in $pf) {$mesoObj = Get-MailPublicFolder $i.identity; if ($mesoObj -eq $null) { Disable-MailPublicFolder $i -confirm:$False} }
   ```

1. Resume the failed migration batch in Exchange Online.
