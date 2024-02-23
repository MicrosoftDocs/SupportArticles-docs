---
title: Errors about missing parameters when moving only a primary mailbox either to or from Exchange Online
description: Provides resolutions for errors about missing parameters when you use the EAC to onboard or offboard a primary mailbox in a hybrid Exchange environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: lenarudz, v-six, tonymathew 
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---

# Errors about missing parameters when moving only a primary mailbox either to or from Exchange Online

_Original KB number:_ &nbsp; 3160413

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
   New-MoveRequest -Identity <mailbox ID> -RemoteCredential (Get-Credential) -Remote -RemoteHostName <on-premises MRS proxy URL> -BatchName <name of batch> -PrimaryOnly -TargetDeliveryDomain <mail.onmicrosoft.com domain>
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
   New-MoveRequest  -Identity <mailbox ID> -Outbound -RemoteTargetDatabase <on-premises mailbox database> -RemoteHostName  <on-premises MRS proxy URL> -BatchName <name of batch> -PrimaryOnly -ArchiveDomain <mail.onmicrosoft.com domain> -TargetDeliveryDomain <on-premises domain> -RemoteCredential (Get-Credential)
   ```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
