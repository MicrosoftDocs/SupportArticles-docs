---
title: Can't migrate on-premises mailbox with cloud-based archive to Exchange Online
description: Fixes an error when you migrate an on-premises primary mailbox with a cloud-based archive mailbox to Exchange Online.
author: v-charloz
audience: ITPro
ms.service: exchange-online
ms.topic: troubleshooting
ms.author: v-chazhang
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
- CI 158689
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Can't migrate on-premises mailbox with cloud-based archive to Exchange Online

## Symptoms

You have an on-premises primary mailbox with a cloud-based archive mailbox in Exchange Online. When you try to migrate the on-premises mailbox to Exchange Online by using the [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch) cmdlet or the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet that has the `PrimaryOnly` switch used, the migration fails with the following error message:

> The archive database is not explicitly set on the mailbox. Hence a primary only move cannot be allowed for this user.

## Cause

This issue occurs because the affected mailbox has the same `ArchiveGuid` property on both on-premises archive and cloud-based archive. This error is raised by a validation check on Exchange Online for the move request to avoid losing archive data for the affected user object.

## Resolution

To fix this issue, follow these steps:

**Note**: The only supported archive split scenario is a primary mailbox in the on-premises Exchange organization and an archive mailbox in Exchange Online.

1. Run the following cmdlets to retrieve the `ArchiveGuid` property:

    - For the on-premises mailbox:
        ```powershell
        Get-Mailbox <on-premises user mailbox> | FL *archive*
        ```
    - For the mail-enabled user on the cloud:
        ```powershell
        Get-MailUser <cloud mail user> | FL *archive*
        ```
1. Check if the `ArchiveGUID` property in the on-premises Exchange organization matches the one in Exchange Online.
    - If yes, continue Step 3.
    - If no, create a support request to Microsoft for further investigation.
1. [Backup the on-premises archive mailbox and export to a .pst file](/exchange/recipients/mailbox-import-and-export/export-procedures#create-mailbox-export-requests).
1. Run the following cmdlet to add the `ArchiveDomain` parameter back on the affected mailbox by the Exchange Management Shell:
    ```powershell
    Set-ADUser <on-premises user mailbox> -Add @{msExchArchiveaddress="contoso.mail.onmicrosoft.com"}
    ```
1. Run the following cmdlet to validate that the `ArchiveDomain` parameter is added properly across the affected mailbox:
    ```powershell
    Get-Mailbox <on-premises user mailbox> | FL *archive*
    ```
1. Migrate the affected mailbox to Exchange Online by using the `New-MigrationBatch` cmdlet or the `New-MoveRequest` cmdlet.
