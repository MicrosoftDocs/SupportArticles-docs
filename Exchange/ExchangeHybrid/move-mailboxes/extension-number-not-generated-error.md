---
title: Extension number can‎'t be generated
description: Fixes an issue that triggers a MigrationPermanentException error if the mailbox that you're trying to move from the on-premises environment to Exchange Online in Microsoft 365 is missing a primary Exchange Unified Messaging address.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: sgorania, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Extension number can‎'t be generated for the user when moving a mailbox from on-premises to Microsoft 365
  
_Original KB number:_ &nbsp; 3142072

## Problem

When you try to on-board or move a mailbox from an on-premises Exchange Server environment to Exchange Online in Microsoft 365 in a hybrid deployment, the operation fails during the validation stage. You receive the following error message:

> MigrationPermanentException:  
> Mailbox '\<UserName>' in the source forest is currently enabled for Unified Messaging but it can‎'t be enabled for Unified Messaging in the target forest for the following reason: An extension number can‎'t be generated for the user. To configure an extension number, use the `-Extensions` parameter with one or more valid extension numbers. Please fix the problem or disable the mailbox for Unified Messaging before you try the operation again.

## Cause

This issue occurs if the mailbox is missing a primary Exchange Unified Messaging (EUM) address.

The `New-MoveRequest` cmdlet that's used in the mailbox move procedure performs some validation actions. One of these actions is to check whether the source mailbox is enabled for Unified Messaging. To confirm that this is the issue that you're experiencing, check whether the source on-premises mailbox has a proxy address that contains an EUM (uppercase letters) prefix. To do this, follow these steps:

1. Open the Exchange Management Shell, and then run the following commands:

    ```powershell
    Get-mailbox user@contoso.com |select -expand EMailAddresses
    ```

    ```powershell
    Get-UMMailbox user@contoso.com |fl
    ```

2. Examine the output. If the mailbox is Session Initiation Protocol (SIP)-enabled, the mailbox should have a primary EUM (uppercase letters) proxy address and a secondary eum (lowercase letters) proxy address. If the primary EUM address is missing, you've confirmed that this is the issue that you're experiencing.

## Solution

Manually add the primary EUM address. For example, if the mailbox is SIP-enabled, it should have two entries that look like this:

EUM:firstname.surname@\<domain>.com;phone-context=DialPlanName.global.loc  
eum:\<phone extension>;phone-context=DialPlanName.global.loc

For more information about how to add an EUM address, see [Manage user mailboxes](/Exchange/recipients/user-mailboxes/user-mailboxes).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
