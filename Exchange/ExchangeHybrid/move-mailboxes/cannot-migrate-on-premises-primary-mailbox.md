---
title: Can't migrate on-premises primary mailbox with cloud-based archive to Exchange Online
description: Fixes an error that occurs when migrating an on-premises mailbox using New-MigrationBatch or New-MoveRequest cmdlet with PrimaryOnly switch.
audience: ITPro
ms.topic: troubleshooting
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 158689
ms.reviewer: haembab, meerak, ninob, v-chazhang
search.appverid: MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
---

# Can't migrate on-premises primary mailbox with cloud-based archive to Exchange Online

## Symptoms

In an Exchange hybrid deployment, you have an on-premises Microsoft Exchange Server primary mailbox, and a cloud-based archive mailbox in Exchange Online. You try to migrate the on-premises primary mailbox to Exchange Online by using the [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch) or the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet together with the `PrimaryOnly` switch. In this scenario, you receive the following error message:

> The archive database is not explicitly set on the mailbox. Hence a primary only move cannot be allowed for this user.

## Cause

This error is triggered by a validation check in Exchange Online for the move request. The error might occur because you have dual archive mailboxes (an on-premises archive mailbox and a cloud-based archive mailbox), and they share the same value for the `ArchiveGuid` parameter. This situation isn't supported. Therefore, the migration fails and generates the error to avoid losing archive data in the affected on-premises primary mailbox.

**Note**: The only supported split-archive scenario is an on-premises primary mailbox and an archive mailbox in Exchange Online.

## Resolution

To fix this issue, follow these steps:

1. Check the `ArchiveGuid` property value of both the on-premises and cloud-based archive mailboxes:

    - For the on-premises archive mailbox, [open the Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell), and then run the following [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlet:

        ```powershell
        Get-Mailbox -Identity <name of affected mailbox> | FL *archive*
        ```

    - For the cloud-based archive mailbox, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), and then run the following [Get-MailUser](/powershell/module/exchange/get-mailuser) cmdlet:

        ```powershell
        Get-MailUser -Identity <name of affected mailbox> | FL *archive*
        ```

    If both archive mailboxes have the same `ArchiveGuid` property value, go to Step 2. Otherwise, [create a support request](/microsoft-365/business-video/get-help-support).

1. Back up and export the on-premises archive mailbox to a .pst file:

    1. Open the [Exchange admin center](https://admin.exchange.microsoft.com).

    1. Select **recipients** > **mailboxes** > **More options** (:::image type="icon" source="media/onboarding-remote-move-migration-fails/eac-more-options-icon.png" :::) > **Export to a PST file**.

    1. On the **Export to a .pst file** page, select the source mailbox, and then select **Export only the contents of this mailbox's archive** > **Next**.

    1. Specify the path to export the .pst file, and then select **Next** > **Finish**.

    For more information, see [create mailbox export requests](/exchange/recipients/mailbox-import-and-export/export-procedures#create-mailbox-export-requests).

1. Add the domain of the cloud-based archive mailbox to the `ArchiveDomain` property of the affected on-premises primary mailbox:

    1. [Open the Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell), and run the [Set-ADUser](/powershell/module/activedirectory/set-aduser) cmdlet:

        ```powershell
        Set-ADUser -Identity <name of affected mailbox> -Add @{msExchArchiveaddress="<domain name of cloud archive>"}
        ```

    1. Run the `Get-Mailbox` cmdlet to verify that the `ArchiveDomain` value is set successfully:

        ```powershell
        Get-Mailbox -Identity <name of affected mailbox> | FL *archive*
        ```

1. To migrate the on-premises primary mailbox to Exchange Online, use the `New-MigrationBatch` or the `New-MoveRequest` cmdlet together with the `PrimaryOnly` switch.
