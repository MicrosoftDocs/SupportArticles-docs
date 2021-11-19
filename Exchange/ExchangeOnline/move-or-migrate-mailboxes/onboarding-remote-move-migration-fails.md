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
ms.reviewer: haembab; meerak; ninob
search.appverid: MET150
appliesto:
- Exchange Online
---

# Can't migrate on-premises mailbox with cloud-based archive to Exchange Online

When you try to migrate an on-premises primary mailbox with a cloud-based archive mailbox to Exchange Online, you receive the following error message:

> The archive database is not explicitly set on the mailbox. Hence a primary only move cannot be allowed for this user.

The migration still fails even if you use the [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch) cmdlet or the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet with the `PrimaryOnly` switch.

This issue typically occurs because the on-premises primary mailbox also has an on-premises archive mailbox, and the archive GUID (`ArchiveGuid`) of the on-premises archive mailbox is also used by the cloud-based archive mailbox, which isn't a valid state. To avoid losing data of the on-premises archive mailbox, the validation check fails for the migration.

To fix this issue, follow these steps:

## Step 1: Verify the archive GUID of on-premises and cloud-based archive mailboxes is same

In the on-premises Exchange Server environment and Exchange Online, follow these steps:

- Run the following [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlet to get the `ArchiveGuid` value for the on-premises archive mailbox by using the Exchange Management Shell.

    ```powershell
    Get-Mailbox -Identity "<user@contoso.com>" | FL *archive*
    ```

- Run the following [Get-MailUser](/powershell/module/exchange/get-mailuser) cmdlet to get the `ArchiveGuid` value for the cloud-based archive mailbox by using Exchange Online PowerShell.

    ```powershell
    Get-MailUser -Identity "<user@contoso.com>" | FL *archive*
    ```

If the `ArchiveGuid` value of the two archive mailboxes is same, proceed to the next step. If not, create a support request.

## Step 2: Back up the on-premises archive mailbox

To back up and export the on-premises archive mailbox to a PST file, follow these steps in Exchange admin center. For more information, see [create mailbox export requests](/exchange/recipients/mailbox-import-and-export/export-procedures#create-mailbox-export-requests).

1. In the Exchange admin center, select **recipients** > **mailboxes** > **More options** > **Export to a PST file**.
1. On the **Export to a .pst file** page, select the source mailbox, and then select **Export only the contents of this mailbox's archive** > **Next**.
1. Type the file name of the target .pst file, and then select **Next** > **Finish**.

## Step 3: Specify the domain of the cloud-based archive mailbox for the on-premises primary mailbox

In the on-premises Exchange Server environment, follow these steps:

1. Run the following [Set-ADUser](/powershell/module/activedirectory/set-aduser) cmdlet to add the `ArchiveDomain` value to the on-premises primary mailbox by using the Exchange Management Shell:

    ```powershell
    Set-ADUser -Identity "<user@contoso.com>" -Add @{msExchArchiveaddress="<contoso.mail.onmicrosoft.com>"}
    ```

1. Run the following `Get-Mailbox` cmdlet to verify the `ArchiveDomain` value is added successfully.

    ```powershell
    Get-Mailbox -Identity "<user@contoso.com>" | FL *archive*
    ```

If the `ArchiveDomain` value is added successfully, use the `New-MigrationBatch` cmdlet or the `New-MoveRequest` cmdlet with the `PrimaryOnly` switch to migrate the on-premises primary mailbox again.
