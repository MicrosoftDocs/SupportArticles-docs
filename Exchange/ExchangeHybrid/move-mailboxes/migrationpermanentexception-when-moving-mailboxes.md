---
title: MigrationPermanentException when moving mailbox
description: Discusses that you receive an error message receive when you try to move a mailbox that was originally created in Exchange Online to the on-premises organization in an Exchange hybrid deployment. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: hbohl, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# (MigrationPermanentException Cannot find a recipient that has mailbox GUID) error when moving mailboxes

_Original KB number:_ &nbsp; 2956029

## Symptoms

Assume that you have a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online. When you try to **offboard** or move a mailbox that was created in Exchange Online to the on-premises organization, you receive the following error message:

> Error: MigrationPermanentException: Cannot find a recipient that has mailbox GUID '\<GUID>'. --> Cannot find a recipient that has mailbox GUID '<‎GUID>'

## Cause

This behavior occurs because the value of the mailbox GUID isn't stamped on the associated mailbox in the on-premises organization.

> [!NOTE]
> The mailbox value is stored in the `ExchangeGUID` property (also known as the `msExchMailboxGUID` attribute).

This situation occurs because the value of the property isn't synced to the associated remote mailbox in the on-premises organization when a mailbox is created in Exchange Online.

To move a mailbox, the value of the `ExchangeGUID` property must be the same in the Exchange Online mailbox and in the associated on-premises remote mailbox.

## Resolution

Set the `ExchangeGUID` property on the associated on-premises remote mailbox before you move the mailbox to the on-premises organization. To do this, follow these steps:

1. Open the Exchange Management Shell on the on-premises server, and then run the following command to check whether the `ExchangeGUID` property of the on-premises remote mailbox is set:

    ```powershell
    Get-RemoteMailbox <alias of cloud mailbox to move> | Format-List ExchangeGUID
    ```

    > [!NOTE]
    > If the `ExchangeGUID` property returns all zeros, the value isn't stamped on the on-premises remote mailbox.

2. Open Windows PowerShell (don't use the Exchange Management Shell), and then connect to Exchange Online. For more info about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

3. Run the following command to retrieve the value of `ExchangeGUID` property of the mailbox that you want to move.

    ```powershell
    Get-Mailbox <MailboxName> | Format-List ExchangeGUID
    ```

4. Run the following command to set the value of the `ExchangeGUID` property on the on-premises remote mailbox to the value that you retrieved in step 3.

    ```powershell
    Set-RemoteMailbox <MailboxName> -ExchangeGUID <GUID>
    ```
    
    For example, if the ExchangeGUID is d5a0bd9b-4e95-49b5-9736-14fde1eec1e3, run the following command:
    
    ```powershell
    Set-RemoteMailbox <MailboxName> -ExchangeGUID "d5a0bd9b-4e95-49b5-9736-14fde1eec1e3"
    ```
    
5. Force directory synchronization.

## More information

To prevent this scenario from occurring, create the mailbox in the on-premises organization, and then move the mailbox to Exchange Online. This stamps the value of the `ExchangeGUID` property on the mailbox, and then syncs the value to Exchange Online. After you do this, you can return the mailbox to the on-premises organization.

For more information, see [Move mailboxes between on-premises and Exchange Online organizations in hybrid deployments](/exchange/hybrid-deployment/move-mailboxes).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
