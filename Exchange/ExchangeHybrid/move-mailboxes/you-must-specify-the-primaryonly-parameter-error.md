---
title: MigrationPermanentException when moving primary mailbox
description: Describes a MigrationPermanentException error that's returned when you try to use the Exchange admin center to move a primary mailbox from the on-premises environment to Exchange Online. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: lenarudz, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 3/31/2022
---

# "You must specify the PrimaryOnly parameter" or "You must specify the ArchiveDomain parameter" error when moving a primary mailbox to or from Exchange Online in a hybrid deployment

# Errors about missing parameters when moving only a primary mailbox either to or from Exchange Online"
# Missing parameter errors when moving only a primary mailbox either to or from Exchange Online

_Original KB number:_ &nbsp; 3160413

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://blogs.technet.com/b/exchange/archive/2016/02/17/office-365-hybrid-configuration-wizard-for-exchange-2010.aspx).

## Onboard only a primary mailbox from Exchange on-premises to Exchange Online

You have a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365. Your primary mailboxes are located in the on-premises environment and archive mailboxes are located in Exchange Online. When you try to move only a primary mailbox from the on-premises environment to Exchange Online by using the Exchange admin center (EAC) in Microsoft 365, you receive the following error message.

> Error: MigrationPermanentException
>
> ErrorSummary: You must specify the PrimaryOnly parameter

### Cause

The EAC doesn't provide the option to move only a primary mailbox from an on-premises environment to Exchange Online. To do this, you must use the `New-MoveRequest` cmdlet.

### Resolution

To move only a primary mailbox, use the [New-MoveRequest](/powershell/module/exchange/new-moverequest?view=exchange-ps&preserve-view=true) cmdlet. Follow these steps:

1. Run the following command to connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```PowerShell
   Connect-ExchangeOnline
   ```

2. Run the following command to initiate a mailbox migration from the on-premises environment to Exchange Online:

   ```powershell
   New-MoveRequest -Identity <mailbox ID> -RemoteCredential (Get-Credential) -Remote -RemoteHostName 'on-premises MRS proxy URL' -BatchName <Name of Batch> -PrimaryOnly -TargetDeliveryDomain <mail.onmicrosoft.com domain>
    ```
   
   **Note**: When you're prompted for credentials, enter your credentials for on-premises Exchange.


## Offboard only a primary mailbox from Exchange Online to Exchange on-premises 

You have a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365 where the primary mailboxes and archive mailboxes are hosted in Exchange Online. When you try to offboard only a primary mailbox from Exchange Online to the on-premises environment by using the EAC in Microsoft 365, you receive the following error message.

> Error: ParameterValueRequiredPermanentException
>
> ErrorSummary: You must specify the ArchiveDomain parameter

### Cause

The EAC doesn't have the option to move only a primary mailbox from Exchange Online to an on-premises environment.

### Resolution

To move only a primary mailbox, use the [New-MoveRequest](/powershell/module/exchange/new-moverequest?view=exchange-ps&preserve-view=true) cmdlet. Follow these steps:

1. Run the following command to connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```PowerShell
   Connect-ExchangeOnline
   ```

2. Run the following command:

   ```powershell
   New-MoveRequest  -Identity <mailbox ID> -Outbound -RemoteTargetDatabase "on-premises mailbox database" -RemoteHostName  'on-premises MRS proxy URL' -BatchName <Name of Batch> -PrimaryOnly -ArchiveDomain <mail.onmicrosoft.com domain> -TargetDeliveryDomain <on-premises domain> -RemoteCredential (Get-Credential)
   ```

## More information

You can also use the `New-MigrationBatch` cmdlet together with the `-PrimaryOnly` parameter to move only a primary mailbox. For more information, about this cmdlet, see [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch?view=exchange-ps&preserve-view=true).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
