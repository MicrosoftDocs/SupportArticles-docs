---
title: Cannot access shared calendar for hidden mailbox
description: Describes a scenario in which you can't access another user's calendar by using Outlook if that user's mailbox is hidden from the GAL. Provides workarounds.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alinastr, v-six
appliesto: 
  - Exchange Online
  - Windows 7 Starter N
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# You can't access a shared calendar by using Outlook for a hidden mailbox

_Original KB number:_ &nbsp; 3205457

## Symptoms

Consider the following scenario:

- User A has delegate permissions or editing permissions to the calendar of User B.
- You hide User B's mailbox from the global address list (GAL).

In this scenario, User A can't access User B's calendar by using Outlook.

## Status

This behavior is by design.

## Workaround

To work around this behavior, do one of the following:

- Use Outlook on the web to access the calendar.
- Grant User A Full Access permission to User B.

  > [!NOTE]
  > Automapping must be enabled or the account, or the account must be added as a secondary Exchange account.

- Implement GAL segmentation. For more information, see [Address book policies](/exchange/address-books/address-book-policies/address-book-policies).
- Add User A as a contact in the local address book. To do this, follow these steps:

  1. On the server that's running Exchange Server, reveal (unhide) the hidden account (for User B) in the GAL.
  2. On the delegate's computer (for User A), go to the address book, locate the account that was previously hidden, right-click the account, and then select **Add to Contacts**.
  3. Hide the account from the GAL on the server that's running Exchange Server.
  4. On the delegate's computer (for User A), do the following:

     1. Open the calendar, right-click **My Calendars**, point to **Add Calendar**, and then select **Open Shared Calendar**.
     2. Select **Name**.
     3. In the **Address Book** box, change the address book from the GAL to the user's local contacts.
     4. Select the contact that you added in step 2, and then select **OK**.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
