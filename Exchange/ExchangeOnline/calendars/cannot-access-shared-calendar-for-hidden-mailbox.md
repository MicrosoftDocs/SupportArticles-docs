---
title: Can't Access a Shared Calendar for a Hidden Mailbox
description: Provides workarounds for a scenario in which a user can't access another user's calendar by using classic Outlook if that user's mailbox is hidden from the GAL.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap: Calendaring
  - Exchange Online
  - Exchange Server
  - CSSTroubleshoot
  - CI 6152
ms.reviewer: ldinino, mhaque, gbratton, meerak, v-shorestris
appliesto:
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Outlook for Windows
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 06/17/2025
---

# Can't access a shared calendar for a hidden mailbox

_Original KB number:_ &nbsp; 3205457

## Symptoms

Consider the following scenario:

1. User A has delegate permissions or editing permissions on User B's calendar.

2. User B's mailbox is hidden from the Global Address List (GAL).

In this scenario, User A can't access User B's calendar by using classic Outlook for Windows.

## Cause

This issue occurs because classic Outlook relies on the GAL to resolve user information. If a mailbox is hidden, Outlook's MAPI-based address book and calendar-sharing features can't locate user B's mailbox to open the calendar. This is a known limitation of how classic Outlook resolves mailboxes in Microsoft Exchange environments.

## Workaround

To work around this limitation, use one of the following methods.

### Method 1

User A can use Outlook on the web or new Outlook for Windows to access User B's calendar.

### Method 2

> [!WARNING]
> This method grants User A: **Full Access** permission to User B's entire mailbox, including mail, contacts, and private calendar items.

Follow these steps:

1. Grant **Full Access** permission on User B's mailbox to User A. For more information, see [Manage permissions for recipients in Exchange Online](/exchange/recipients-in-exchange-online/manage-permissions-for-recipients) and [Accessing other people's mailboxes](/exchange/troubleshoot/user-and-shared-mailboxes/how-to-access-other-mailboxes).

2. If [automapping](/powershell/module/exchange/add-mailboxpermission#-automapping) is disabled or doesn't add User B's mailbox to User A's Outlook profile, manually add User B's mailbox as an [additional account](/microsoft-365-apps/outlook/profiles-and-accounts/add-shared-mailbox-as-additional-account) in User A's profile.

### Method 3

> [!NOTE]
> Because of the considerable administrative overhead and planning that's required, consider this method only if this issue is common in your organization.

Implement [GAL segmentation](/exchange/address-books/address-book-policies/address-book-policies).

### Method 4

> [!NOTE]
> - This method works only for Outlook Version 2408 Build 17932.20300 and later versions.
> - This method requires that the **Turn on Shared Calendar Improvements** option is selected in User A's account settings in Outlook.
> - This method offers a simple, secure way for User A to add the calendar. However, unlike Method 5, this method doesn't make User B easier to find for other actions, such as sending email messages.

Instruct User A to follow these steps:

1. Open their calendar, right-click **My Calendars**, and then select **Add Calendar** \> **Open Shared Calendar.**

2. In the field provided, enter User B's primary SMTP address, and then select **OK**.

### Method 5

> [!NOTE]
> - This method works only for Outlook Version 2408 Build 17932.20300 and later versions.
> - This method requires that the **Turn on Shared Calendar Improvements** option is selected in User A's account settings in Outlook.
> - This method adds User B as a contact in User A's address book to make sure that User B is easily discoverable for other actions in Outlook. However, unlike Method 4, this method requires admin involvement.

To add User B's display name to the list of available calendars in User A's Outlook client, add User B as a contact in User A's personal address book. To do this, follow these steps:

1. In the Exchange Admin Center (EAC), unhide User B's mailbox in the GAL.

   > [!WARNING]
   > User B's mailbox will be visible to all users who can access the GAL until Step 3 is completed.

2. Instruct User A to find User B in their Outlook address book, right-click that entry, and then select **Add to Contacts**.

3. In the EAC, hide User B's mailbox from the GAL. For information about how to hide mailboxes, see [Manage address lists in Exchange Online](/exchange/address-books/address-lists/manage-address-lists) and [Procedures for address lists in Exchange Server](/exchange/email-addresses-and-address-books/address-lists/address-list-procedures).

4. Instruct User A to follow these steps:

   Open their calendar, right-click **My Calendars**, and then select **Add Calendar** \> **Open Shared Calendar**.

   a. Select **Name**.

   b. In the **Address Book** box, select User A's local contacts instead of the GAL.

   c. Select the contact for User B that was added in step 2, and then select **OK**.
