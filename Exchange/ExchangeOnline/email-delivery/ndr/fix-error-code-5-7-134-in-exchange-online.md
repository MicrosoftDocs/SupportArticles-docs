---
title: Fix NDR error 5.7.134 in Exchange Online
ms.date: 07/24/2026
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six, arindamt
audience: Admin
ms.topic: troubleshooting
f1.keywords:
- CSH
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
search.appverid:
- BCS160
- MOE150
- MET150
description: Learn how to fix email issues for error code 5.7.134 in Exchange Online (the mailbox recipient is configured to reject messages from external or unauthenticated senders).
ai-usage: ai-assisted
---

# Fix NDR error "550 5.7.134" in Exchange Online

## Summary

This article explains how to troubleshoot Exchange Online NDR 550 5.7.134, which occurs when a mailbox is configured to reject messages from external or unauthenticated senders. As a result, messages sent from outside the organization are blocked and returned to the sender with a non-delivery report. The article describes how administrators can resolve the issue by either allowing all external senders to send messages to the mailbox or by configuring the mailbox's allowed senders list to permit specific external senders while continuing to restrict all others.

The rest of this article describes what you can do if you see error code 550 5.7.134 in a non-delivery report also known as an NDR, bounce message, delivery status notification, or DSN. You see this automated notification when the recipient is a mailbox that's configured to reject messages from external senders (senders from outside the organization).

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix this issue?](#i-got-this-bounce-message-how-do-i-fix-this-issue)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How do I fix this issue?](#im-an-email-admin-how-do-i-fix-this-issue)|

### I got this bounce message. How do I fix this issue?

Only an email admin in the recipient's organization can fix this issue. Contact the email admin and refer them to this information so they can try to resolve the issue for you.

## I'm an email admin. How do I fix this issue?

The following sections describe two methods that allow an external sender to send messages to the mailbox in your organization.

To open the Exchange admin center (EAC), see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).

### Method 1: Allow all internal and external senders to send messages to this mailbox

1. In Exchange admin center, select **Recipients** and then select **Mailboxes**.

1. Select a user mailbox from the list. The user mailbox properties screen appears.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/mailbox-properties.png" alt-text="The screen displaying the properties of the chosen user mailbox.":::

1. Select **Manage message delivery restriction**.
  
1. In the **Manage message delivery restriction** pane, under **Accept messages from**, clear the check box for **Require senders to be authenticated**.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/settings-message-delivery-restrictions.png" alt-text="The screen on which the user can define settings for message delivery restrictions.":::

1. Select **Save**.

### Method 2: Use the mailbox's allowed senders list

Instead of allowing all external senders to send messages to this mailbox, use the mailbox's allowed senders list to selectively allow messages from all internal senders and the specified external senders.

- To add an external sender to a mailbox's allowed senders list, first create a [mail contact](/exchange/recipients-in-exchange-online/manage-mail-contacts) or a [mail user](/exchange/recipients-in-exchange-online/manage-mail-users) to represent the external sender in your organization.
- To add everyone in your organization to a mailbox's allowed senders list, create a [distribution group](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups) or a [dynamic distribution group](/exchange/recipients-in-exchange-online/manage-dynamic-distribution-groups/manage-dynamic-distribution-groups) that contains everyone in your organization. After you create this group, add it to the mailbox's allowed senders list.
- The mailbox's allowed senders list is different from the organization's allowed senders list for anti-spam that you manage in the EAC at **Protection** \> **Spam filter**.

To configure the mailbox's allowed senders list, complete the following steps:

1. Open EAC and select **Recipients** and then select **Mailboxes**.

1. Select a user mailbox from the list. The user mailbox properties screen appears.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/mailbox-properties.png" alt-text="The screen displaying the properties of the chosen user mailbox.":::

1. In the **Manage message delivery restriction** pane, under **Accept messages from**:

   - Clear the check box for **Require senders to be authenticated**.

   - Select **Selected senders**.

     :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/mdr-screen-select-senders.png" alt-text="The Message delivery restrictions screen on which specific people are configured as senders.":::

   - Select **+ Add sender**. The **Accept messages from** screen appears.

     :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/accept-messages-from-screen.png" alt-text="The screen displaying the Accept Messages From pane.":::

   - Check the check boxes of the internal-senders group and the specific external users you want to add.

   - Select **Confirm**.

     :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/configuring-accept-messages-from-settings.png" alt-text="The screen on which the senders of email messages are set.":::

    The **Message delivery restrictions** screen reappears.

1. Select **Save**.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/mdr-screen-after-adding-sender.png" alt-text="The screen on which the added senders are saved into the group.":::

## Still need help with error code 550 5.7.134?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
