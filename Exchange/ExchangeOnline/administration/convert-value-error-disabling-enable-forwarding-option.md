---
title: Can't disable the Enable Forwarding option
description: Provides a workaround for a problem that occurs when you clear the Enable Forwarding check box in the Exchange Admin Center to disable mail forwarding for a Microsoft 365 user's mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-mosha, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Cannot convert value when you disable the Enable Forwarding option for a Microsoft 365 user

_Original KB number:_ &nbsp; 2872435

## Problem

You try to disable the **Enable Forwarding** option for a Microsoft 365 user's mailbox to disable mail forwarding. To do this, you click to clear the **Enable Forwarding** check box in the Exchange Admin Center. However, the check box is not cleared, and you receive the following error message:

> Cannot convert value "to type "System.Boolean". Boolean parameters accept only Boolean values and numbers, such as $True, $False, 1 or 0.

## Workaround

To work around this problem, use Windows PowerShell to disable forwarding for the user's mailbox. To do this, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, go to [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Type the following command, and then press Enter:

    ```powershell
    Set-Mailbox -Identity <User ID> -DeliveryToMailboxAndForward $False -ForwardingAddress $Null
    ```

## Status

We're working to address this issue and will post more information in this article when that information becomes available.

## More information

For more information about how to set up mail forwarding, go to [Configure Mail Forwarding for a Mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/configure-email-forwarding).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
