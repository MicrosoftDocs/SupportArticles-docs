---
title: MigrationPermanentException when moving primary mailbox
description: Describes a MigrationPermanentException error that's returned when you try to use the Exchange admin center to move a primary mailbox from the on-premises environment to Exchange Online. Provides a resolution.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: lenarudz
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
---
# You must specify the PrimaryOnly parameter error when moving a primary mailbox to Exchange Online in a hybrid deployment

_Original KB number:_ &nbsp; 3160413

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Office 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Office 365 Hybrid Configuration wizard for Exchange 2010](https://blogs.technet.com/b/exchange/archive/2016/02/17/office-365-hybrid-configuration-wizard-for-exchange-2010.aspx).

## Symptoms

You have a hybrid deployment of on-premises Exchange Server and Exchange Online in Office 365 in which primary mailboxes are located in the on-premises environment and archive mailboxes are located in Exchange Online. When you try to move only a primary mailbox from the on-premises environment to Exchange Online by using the Exchange admin center in Office 365, you receive the following error message.

> Error: MigrationPermanentException: You must specify the PrimaryOnly parameter

## Cause

The Exchange admin center doesn't have the option to move only a primary mailbox. To do this, you must use the `New-MoveRequest` cmdlet.

## Resolution

To move only a primary mailbox, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following command:

    ```powershell
    New-MoveRequest -Identity <user@contoso.com> -RemoteCredential (Get-Credential) -Remote -RemoteHostName 'on-premises mrsproxy url' -BatchName <Name of Batch> -PrimaryOnly -TargetDeliveryDomain <mail.onmicrosoft.com domain>
    ```

    > [!NOTE]
    > When you're prompted for credentials, enter your on-premises Exchange credentials.

For more information about the `New-MoveRequest` cmdlet, see [New-MoveRequest](/powershell/module/exchange/new-moverequest?view=exchange-ps&preserve-view=true).

## More information

You can also use the `New-MigrationBatch` cmdlet together with the `-PrimaryOnly` parameter to move only a primary mailbox. For more information, about this cmdlet, see [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch?view=exchange-ps&preserve-view=true).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
