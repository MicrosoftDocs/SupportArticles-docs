---
title: DataExportTransientException error during public folder migration
description: Provides a resolution for a DataExportTransientException time-out error that occurs when you try to migrate on-premises public folders to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 185151
ms.reviewer: papires, batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: 
  - MET150
ms.date: 01/29/2024
---

# DataExportTransientException error during public folder migration

## Symptoms

You try to migrate a batch of on-premises public folders to Microsoft Exchange Online. However, not all public folders successfully migrate. Additionally, the migration log shows one or more time-out error messages that resemble the following message:

```output
FailureType: "DataExportTransientException"
Message: "MapiFxProxyTransientException: MapiFxProxyTransientException: The data export was canceled
due to a timeout. The destination didn't respond in time…"
DataContext: "Folder: type Generic, wkf None, entryId [len=46, data=
00000000696B95D9245A174B9BE940B86930B9BC01005B7769EBC1C00E438E951DAC68D3FD86000035D08E1E0000], …"
```

The issue occurs regardless of whether you start the batch migration in the Exchange admin center (EAC) or by using [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

## Cause

The issue occurs if one or more public folders in the migration batch are corrupted.

## Resolution

To fix the issue, follow these steps:

1. Determine which public folders in the migration batch failed because of the issue:

   1. Export the migration request statistics for the batch to an XML file. Run the following cmdlets in Exchange Online PowerShell:

      ```powershell
      Get-PublicFolderMailboxMigrationRequest -Status Failed | Get-PublicFolderMailboxMigrationRequestStatistics -IncludeReport -DiagnosticInfo "verbose,showtimeslots" | Export-Clixml migrationStats.xml
      ```

   2. Search the XML file for all instances of the error message. Run the following cmdlets in Exchange Online PowerShell to search and save the results to a text file:

      ```powershell
      $report=Import-Clixml migrationStats.xml
      $report.report.failures | where {$.FailureType -eq 'DataExportTransientException'} | Select-Object -ExpandProperty DataContext > "text file path"
      ```

   3. Get the value of the **DataContext** \> **entryId** \> **data** subfield in each error message. Each value is a public folder entry ID. For example, the entry ID of the public folder in the error message that's shown in the "Symptoms" section is as follows:  
      `00000000696B95D9245A174B9BE940B86930B9BC01005B7769EBC1C00E438E951DAC68D3FD86000035D08E1E0000`.

   4. For each entry ID that you found in step 1c, get the corresponding on-premises public folder name. Run the following PowerShell cmdlet in the Exchange Management Shell (EMS) for on-premises Exchange Server:

      ```powershell
      Get-PublicFolder \ -Recurse | where {$_.EntryId -eq <public folder entry ID>}
      ```

      Make a list of the public folder names and entry IDs. The listed public folders are corrupted.

2. [Export the data](https://support.microsoft.com/office/export-emails-contacts-and-calendar-items-to-outlook-using-a-pst-file-14252b52-3075-4e9b-be4e-ff9ef1068f91) from the corrupted public folders. For each corrupted public folder, follow these steps.

   > [!NOTE]
   > This step must be completed by someone who has sufficient [permissions](/powershell/module/exchange/add-publicfolderclientpermission#parameters) to access the public folder and export the .pst file. Typically, that's an owner of the public folder.

   1. Open the Outlook client.
   2. Select **File** \> **Open & Export** \> **Import/Export** \> **Export to a file**, and then select **Next**.
   3. Select **Outlook Data File (.pst)**, and then select **Next**.
   4. Select the public folder and include subfolders.
   5. Select the path of the exported .pst file, and then select **Finish**.

3. [Remove](/powershell/module/exchange/remove-publicfolder) the corrupted public folders from all servers in your on-premises organization. Run the following PowerShell cmdlet in the EMS for each corrupted public folder:

   ```powershell
   Remove-PublicFolder -Identity <public folder entry ID>
   ```

   After you remove each corrupted public folder, rerun the cmdlet to verify that the public folder no longer exists. The command output should show the error message, "The operation couldn't be performed because \<public folder ID\> couldn't be found."

4. Purge the corrupted public folders from the NON_IPM_SUBTREE. For each corrupted public folder, follow these steps:

   1. Verify that the public folder exists in the NON_IPM_SUBTREE. Run the following PowerShell cmdlet in the EMS:

      ```powershell
      Get-PublicFolder -Recurse \NON_IPM_SUBTREE | ? name -like "<public folder name>"
      ```

   2. Remove the public folder from the NON_IPM_SUBTREE. Run the following PowerShell cmdlet in the EMS:

      ```powershell
      Get-PublicFolder -Recurse \NON_IPM_SUBTREE | ? name -like "<public folder name>" | Remove-PublicFolder
      ```

5. Resume the batch migration. Run the following PowerShell cmdlet in the EMS:

   ```powershell
   Start-MigrationBatch -Identity <batch name>
   ```

   Wait for the batch migration status to display as **Synced**.

6. Complete the batch migration. Run the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

   > [!NOTE]
   > Make sure that the migration batch status displays as **Synced** before you complete the batch migration.

   ```powershell
   Complete-MigrationBatch -Identity <batch name>
   ```

   Wait for the batch migration to finish.

7. [Create a new public folder](/exchange/collaboration-exo/public-folders/create-public-folder) in Exchange Online for each backup .pst file that you created in step 2. Use the same name as the .pst file.

8. [Import](https://support.microsoft.com/office/import-email-contacts-and-calendar-from-an-outlook-pst-file-431a8e9a-f99f-4d5f-ae48-ded54b3440ac) each backup .pst file into the corresponding new public folder.

   > [!NOTE]
   > This step must be completed by someone who has sufficient permissions to access the public folder and export the .pst file. Typically, that's an owner of the public folder.
