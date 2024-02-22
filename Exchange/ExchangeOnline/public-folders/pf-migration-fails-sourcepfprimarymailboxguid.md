---
title: Incorrect SourcePFPrimaryMailboxGuid causes failed public folder migration
description: Fixes an issue in which you get an EndpointNotFoundTransientException error when you run a public folder migration batch job.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 151235
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre
appliesto: 
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans
search.appverid: MET150
ms.date: 01/24/2024
---
# EndpointNotFoundTransientException error in a public folder migration

## Symptoms

When you run a public folder migration batch from Microsoft Exchange Server to Exchange Online, you experience the "EndpointNotFoundTransientException" error and receive the following error messages:

- There was no endpoint listening at `https://mail.<Domain Name>.com/EWS/mrsproxy.svc` that could accept the message.
- The remote server returned an error: (404) Not Found.

Here's an example of the "EndpointNotFoundTransientException" error message.

:::image type="content" source="media/pf-migration-fails-sourcepfprimarymailboxguid/pf-migration.png" alt-text="Screenshot of the detailed errors for EndpointNotFoundTransientException.":::

However, when you test migration server availability for the public folder endpoint by running the following cmdlet, the result is successful:

```powershell
Test-MigrationServerAvailability -Endpoint <PublicFolderMigrationEndPoint>
```

Here's an example of the cmdlet and the output.

:::image type="content" source="media/pf-migration-fails-sourcepfprimarymailboxguid/endpoint.png" alt-text="Screenshot of cmdlet and output for endpoint.":::

## Cause

This issue occurs if you create the migration batch by specifying the `SourcePFPrimaryMailboxGuid` parameter of Exchange Online instead of Exchange Server.

To verify that the migration batch uses incorrect `SourcePFPrimaryMailboxGuid`, you can run the cmdlets in the following steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).  

1. Identify the value of the `SourcePFPrimaryMailboxGuid` parameter that's specified on the migration batch by running the following cmdlet:

   ```powershell
   (Get-MigrationBatch | ?{$_.MigrationType.ToString() -eq "PublicFolder"}).SourcePFPrimaryMailboxGuid
   ```

   Here's an example of the cmdlet and the output.

   :::image type="content" source="media/pf-migration-fails-sourcepfprimarymailboxguid/exo-guid.png" alt-text="Screenshot of an example of cmdlet for GUID.":::

1. Verify that the GUID provided is from Exchange Online by running the following cmdlet:

   ```powershell
   Get-Mailbox -PublicFolder <GUID>
   ```

   **Note:** Replace \<*GUID*> with the value that you get from the cmdlet in step 2.

   If the public folder mailbox is successfully listed from Exchange Online, you can verify that the migration batch is not correctly created. Here's an example of the cmdlet and the output.

   :::image type="content" source="media/pf-migration-fails-sourcepfprimarymailboxguid/confirm-guid.png" alt-text="Screenshot of checking if it's Exchange Online GUID.":::

## Resolution

To resolve this issue, re-create the migration batch by specifying the `SourcePFPrimaryMailboxGuid` of the public folder mailbox on the Exchange on-premises server. Here's how to re-create the migration batch:

1. [Open Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell) on the Exchange on-premises server.

1. Get the public folder mailbox GUID from Exchange Server by running the following cmdlet:

   ```powershell
   (Get-OrganizationConfig).RootPublicFolderMailbox.HierarchyMailboxGuid.GUID
   ```

   Here's an example of the cmdlet and the output.

   :::image type="content" source="media/pf-migration-fails-sourcepfprimarymailboxguid/on-premises-guid.png" alt-text="Screenshot of getting on-premises Exchange GUID.":::

1. Re-create the migration batch in Exchange Online by following these steps:

    1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

    1. Remove the existing public folder migration batch by running the following cmdlet:

       ```powershell
       Get-MigrationBatch | ?{$_.MigrationType.ToString() -eq "PublicFolder"} | Remove-MigrationBatch
       ```

       **Note:** It might take 10 to 15 minutes for the migration batch to be removed.

    1. Make sure that the migration batch is removed by running the following cmdlet:

       ```powershell
       Get-MigrationBatch | ?{$_.MigrationType.ToString() -eq "PublicFolder"}
       ```

    1. Create a new public folder migration batch by running the following cmdlet:

       ```powershell
       [byte[]]$bytes = Get-Content -Encoding Byte <folder_mapping.csv>
       New-MigrationBatch -Name PublicFolderMigration -CSVData $bytes -SourceEndpoint <PublicFolderMigrationEndPoint> -SourcePfPrimaryMailboxGuid <GUID from step 2> -AutoStart -NotificationEmails <email addresses for migration notifications>
       ```

For more information about public folder migrations, see [Use batch migration to migrate Exchange Server public folders to Exchange Online](/exchange/collaboration/public-folders/migrate-to-exchange-online).  
