---
title: Can't migrate on-premises primary mailbox with cloud-based archive to Exchange Online
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

# Can't migrate on-premises primary mailbox with cloud-based archive to Exchange Online

## Symptoms

In an Exchange hybrid deployment, you have an on-premises primary mailbox, and a cloud-based archive mailbox in Exchange Online. You try to migrate the on-premises primary mailbox to Exchange Online by using the [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch) or the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet with the `PrimaryOnly` switch. In this scenario, you receive the following error message:

> The archive database is not explicitly set on the mailbox. Hence a primary only move cannot be allowed for this user.

## Cause

This issue occurs because you also have an on-premises archive mailbox, and this mailbox uses the same archive GUID (`ArchiveGuid`) as the cloud-based archive mailbox. It's an invalid configuration, so the validation check during the migration returns this error.

**Note**: The only supported archive split scenario is an on-premises primary mailbox and an archive mailbox in Exchange Online.

## Resolution

To fix this issue, follow these steps:

**Step 1**: Check the `ArchiveGuid` property value of the on-premises and cloud-based archive mailboxes:

- For the on-premises archive mailbox, [open the Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell) and run the following [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlet to get the `ArchiveGuid` property value:

    ```powershell
    Get-Mailbox -Identity john@contoso.com | FL *archive*
    ```

- For the cloud-based archive mailbox, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) and run the following [Get-MailUser](/powershell/module/exchange/get-mailuser) cmdlet to get the `ArchiveGuid` property value:

    ```powershell
    Get-MailUser -Identity John | FL *archive*
    ```

If the two archive mailboxes have the same `ArchiveGuid` property value, go to Step 2. Otherwise, [create a support request](/microsoft-365/business-video/get-help-support).

**Step 2**: Back up and export the on-premises archive mailbox to a .pst file in the [Exchange admin center](https://admin.exchange.microsoft.com). For more information, see [create mailbox export requests](/exchange/recipients/mailbox-import-and-export/export-procedures#create-mailbox-export-requests).

1. In the Exchange admin center, select **recipients** > **mailboxes** > **More options**:::image type="icon" source="media/onboarding-remote-move-migration-fails/eac_moreoptions-icon.png" border="false"::: > **Export to a PST file**.
1. On the **Export to a .pst file** page, select the source mailbox, and then select **Export only the contents of this mailbox's archive** > **Next**.
1. Specify the path to export the .pst file, and then select **Next** > **Finish**.

**Step 3**: Add the `ArchiveDomain` value to the on-premises primary mailbox.

1. [Open the Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell) and run the following [Set-ADUser](/powershell/module/activedirectory/set-aduser) cmdlet to add the `ArchiveDomain` value to the on-premises primary mailbox:

    ```powershell
    Set-ADUser -Identity John -Add @{msExchArchiveaddress="contoso.mail.onmicrosoft.com"}
    ```

1. Run the following `Get-Mailbox` cmdlet to verify the `ArchiveDomain` value is added successfully:

    ```powershell
    Get-Mailbox -Identity john@contoso.com | FL *archive*
    ```

**Step 4**: Use the `New-MigrationBatch` or the `New-MoveRequest` cmdlet with the `PrimaryOnly` switch to migrate the on-premises primary mailbox again.
