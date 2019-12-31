---
title: Exchange public folder migration stops at 95%
description: Describes an issue in which an Exchange public folder migration stops at 95% because it has failed at syncing mail-enabled public folders from on-premises and provides a workaround.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: article
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- CI 112320
- CSSTroubleshoot
ms.reviewer: batre
appliesto:
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Service Pack 3
- Exchange Server 2010 Standard
- Exchange Online via Office 365 E Plans
- Exchange Online via Office 365 P Plans
search.appverid: MET150
---

# Exchange public folder migration stops at 95% with error "There are [xx] Public Folders that could not be mail-enabled"

## Symptoms

When you migrate public folders from Microsoft Exchange Server 2010 to Exchange Online, the process stops at 95%.

Additionally, when you run the following command to review the migration report:

```powershell
Get-PublicFolderMailboxMigrationRequest |Get-PublicFolderMailboxMigrationRequestStatistics -IncludeReport
```

You see the following error:

```asciidoc
Name                                                              StatusDetail TargetMailbox PercentComplete
----                                                              ------------ ------------- ---------------
PublicFolderMailboxMigrationfb3cdd37-ecf4-4d33-xxxx -fcec86xxxxxx FailedOther  MigP1         95
```

![Error in the migration report](./media/public-folder-migration-fails/command-error.png)

Then, you run the following command and receive the error details:

```powershell
$p=Get-PublicFolderMailboxMigrationRequest -Status Failed | Get-PublicFolderMailboxMigrationRequestStatistics -IncludeReport;$p[0].report.failures[-1].Message
```

**Error details:**

```asciidoc
FailureType            : FailedToMailEnablePublicFoldersException
Message                : Error: There are 32 Public Folders that could not be mail-enabled. Please, check the migration report starting at date/time for additional details. This may indicate that mail public folder objects in Exchange Online are out of sync with your Exchange deployment. You may need to rerun the script Sync-MailPublicFolders.ps1 on your source Exchange server to update mail-enabled public folder objects in Exchange Online Active Directory.
```

From the error details, the migration request shows that it has failed at syncing mail-enabled public folders from on-premises.

However, all on-premises mail-enabled public folders are synced to Exchange Online. The error will repeat even if you have run the script ".\Sync-MailPublicFolders.ps1" multiple times.

Also, if you run the **Get-MailPublicFolder** command on-premises, it doesn't show any mail-enabled public folders, and the migration request continues to fail with the error.

## Cause

If a public folder is mail-enabled, it will have the **MailEnabled** property set to **True**. The **Disable-MailPublicFolder** command changes this property to **False** and removes corresponding entries from the Microsoft Exchange System Objects (MESO) container.

If the **Disable-MailPublicFolder** command doesn't complete the cleanup correctly, it may leave behind the **MailEnabled** property as **True**. But it will remove the objects from MESO container.

In such scenario, the **Get-MailPublicFolder** command won't list the folders described in the error message as mail-enabled public folders. However, these folders are still considered mail enabled. This causes the migration failure.

## Workaround

To work around this issue, follow these steps:

1. List the public folders that still have the **MailEnabled** property set to **True**. To do this, run the following command:

   > [!NOTE]
   > If you see errors in the output command in addition to the error that says the public folder isn't a mail-enabled public folder, ignore the errors.

   ```powershell
   $pf=Get-PublicFolder \ -recurse -ResultSize Unlimited | ? { $_.MailEnabled }; ForEach ($i in $pf) {$mesoObj = Get-MailPublicFolder $i.identity; if ($mesoObj -eq $null) {$i }}
   ```

2. Run the following command to disable the mail-enabled public folders:

   ```powershell
   $pf=Get-PublicFolder \ -recurse -ResultSize Unlimited | ? { $_.MailEnabled }; ForEach ($i in $pf) {$mesoObj = Get-MailPublicFolder $i.identity; if ($mesoObj -eq $null) { Disable-MailPublicFolder $i -confirm:$False} }
   ``` 

3. Resume the failed migration batch in Exchange Online.