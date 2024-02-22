---
title: Proxy address number exceeds the current limit
description: Fixes an issue that triggers an error when you try to add or remove email addresses from an Exchange Online user whose number of proxy addresses exceeds the current limit.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: ninob, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Too many proxy addresses when you add or remove email addresses from an Exchange Online recipient

_Original KB number:_ &nbsp; 3196424

## Problem

When you try to add or remove email addresses from an Exchange Online recipient in the Exchange admin center, you receive the following error message, where \<X> represents a number that's greater than 300:

> There are too many proxy addresses: \<X>, and maximum supported number of recipient proxy addresses is 300

Additionally, when you view the properties of the recipient in the Exchange admin center, you may see the following message, where \<X> represents a number that's greater than 300:

> Warning
>
> The object \<Name of Recipient> has been corrupted or isn't compatible with Microsoft support requirements, and it's in an inconsistent state. The following validation errors happened:
>
> There are too many proxy addresses: \<X>, and maximum supported number of recipient proxy addresses is 300.

## Cause

The number of proxy addresses on the recipient is more than the current limit.

The current limit is set to a maximum of 300 email addresses per object. This limit is documented in [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

## Solution

The error messages described in the Problem section are cosmetic only. In other words, email messages that are sent to and received from affected recipients will continue to work as they did before the new limit was set. Therefore, administrators don't have to take any action, as recipients shouldn't be in a broken state.

To reduce the number of email addresses for recipients who exceed the limit, do one of the following tasks:

- In the Exchange admin center, select multiple email addresses, and then remove them from the recipient in a single operation (before you click **Save**). Saving the changes will work if the resulting number of email addresses for the recipient is less than the current limit.

- If you want to keep the list of email addresses that you're removing from the recipient, follow these steps:

  1. Export the list of addresses that's currently assigned to the recipient by using a preferred method.
  
  2. Use a tool such as Microsoft Excel to determine the list of addresses that you want to remove from the recipient.
  
  3. Pass the list to the `Set-Mailbox` cmdlet as a single operation. If removal is performed as a single operation, and the resulting number of email addresses is under the limit, the update should be successful. If administrators have recipient objects that require more email addresses, consider creating more shared mailboxes and then adding email addresses to the shared mailboxes. Then, configure the shared mailbox to forward all email that's sent to it to the user's mailbox so that users can monitor their received messages.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
