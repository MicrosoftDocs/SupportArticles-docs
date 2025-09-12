---
title: Fix NDR error 5.7.134 in Exchange Online
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
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
ms.assetid: 033fcaaf-7916-47ae-b2cd-2a63456bb812
description: Learn how to fix email issues for error code 5.7.134 in Exchange Online (the mailbox recipient is configured to reject messages from external or unauthenticated senders).
---

# Fix NDR error "550 5.7.134" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 550 5.7.134 in a non-delivery report also known as an NDR, bounce message, delivery status notification, or DSN). You'll see this automated notification when the recipient is a mailbox that's configured to reject messages from external senders (senders from outside the organization).

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix this issue?](#i-got-this-bounce-message-how-do-i-fix-this-issue)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How do I fix this issue?](#im-an-email-admin-how-do-i-fix-this-issue)|

### I got this bounce message. How do I fix this issue?

Only an email admin in the recipient's organization can fix this issue. Contact the email admin and refer them to this information so they can try to resolve the issue for you.

## I'm an email admin. How do I fix this issue?

The two methods that will allow an external sender to send messages to the mailbox in your organization are described in the following sections.

To open the New Exchange admin center (EAC), see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).

To open the Classic EAC, click **Classic Exchange admin center** on the left pane of the **Exchange admin center** (New) home screen, as shown in the image below.

 :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/navigation-to-classic-eac.png" alt-text="The screen on the New EAC from which you can switch to Classic EAC.":::

### Method 1: Allow all internal and external senders to send messages to this mailbox

#### New EAC

1. Go to **Recipients** \> **Mailboxes**.

2. Select a user mailbox from the list and click it. The user mailbox properties screen appears.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/user-mailboxes-properties.png" alt-text="The screen displaying the properties of the chosen user mailbox.":::

3. Under **Mail flow settings**, click **Manage mail flow settings**. The **Manage mail flow settings** screen appears.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/manage-mail-flow-settings-screen.png" alt-text="The Manage mail flow settings screen.":::

4. In the **Message delivery restriction** pane, click **Edit**. The **Message delivery restrictions** screen appears.

5. Under **Accept messages from**, clear the check box for **Require senders to be authenticated**.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/settings-message-delivery-restrictions.png" alt-text="The screen on which the user can define settings for message delivery restrictions.":::

6. Click **Save**.

#### Classic EAC

1. In the Classic EAC, go to **Recipients** \> **Mailboxes** > select the mailbox from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/mailbox.png" alt-text="Screenshot of the mailbox tab in which you can find mailboxes in Exchange admin center.":::

2. In the mailbox properties dialog box that opens, go to **Mailbox features** \> **Message Delivery Restrictions** \> and then click **View details**.

3. In the **Message delivery restrictions** dialog box that opens, clear the check box for **Require that all senders are authenticated** in the **Accept messages from** section.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/message-delivery-restrictions.png" alt-text="Screenshot of the message delivery restrictions dialog box.":::

4. Click **OK**, and then click **Save**.

### Method 2: Use the mailbox's allowed senders list

Instead of allowing all external senders to send messages to this mailbox, you can use the mailbox's allowed senders list to selectively allow messages from all internal senders and the specified external senders.

**Notes**:

- To add an external sender to a mailbox's allowed senders list, you must first create a [mail contact](/exchange/recipients-in-exchange-online/manage-mail-contacts) or a [mail user](/exchange/recipients-in-exchange-online/manage-mail-users) to represent the external sender in your organization.
- To add everyone in your organization to a mailbox's allowed sender's list, you can create a [distribution group](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups) or a [dynamic distribution group](/exchange/recipients-in-exchange-online/manage-dynamic-distribution-groups/manage-dynamic-distribution-groups) that contains everyone in your organization. After you create this group, you can add it to the mailbox's allowed senders list.
- The mailbox's allowed senders list is different from the organization's allowed senders list for anti-spam that you manage in the EAC at **Protection** \> **Spam filter**.

To configure the mailbox's allowed senders list, do the following steps:

#### New EAC

1. Go to **Recipients** \> **Mailboxes**.

2. Select a user mailbox from the list and click it. The user mailbox properties screen appears.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/user-mailboxes-properties.png" alt-text="The screen displaying the properties of the chosen user mailbox.":::

3. Under **Mail flow settings**, click **Manage mail flow settings**. The **Manage mail flow settings** screen appears.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/manage-mail-flow-settings-screen.png" alt-text="The Manage Mail Flow Settings screen.":::

4. In the **Message delivery restriction** pane, click **Edit**. The **Message delivery restrictions** screen appears.

5. Under **Accept messages from**:

   - Clear the check box for **Require senders to be authenticated**.

   - Select **Selected senders**.

     :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/mdr-screen-select-senders.png" alt-text="The Message delivery restrictions screen on which specific people are configured as senders.":::

   - Click **+ Add sender**. The **Accept messages from** screen appears.

     :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/accept-messages-from-screen.png" alt-text="The screen displaying the Accept Messages From pane.":::

   - Check the check boxes of the internal-senders group and the specific external users you want to add.

   - Click **Confirm**.

     :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/configuring-accept-messages-from-settings.png" alt-text="The screen on which the senders of email messages are set.":::

    The **Message delivery restrictions** screen reappears.

6. Click **Save**.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/mdr-screen-after-adding-sender.png" alt-text="The screen on which the added senders are saved into the group.":::

#### Classic EAC

1. In the Classic EAC, go to **Recipients** \> **Mailboxes** > select the mailbox from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::.

   :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/mailbox.png" alt-text="Screenshot of the mailbox tab in which you can find mailboxes in Exchange admin center.":::

2. In the mailbox properties dialog box that opens, go to **Mailbox features** \> **Message Delivery Restrictions** \> and then click **View details**.

3. In the **Message delivery restrictions** dialog box that opens, configure the following settings in the **Accept messages from** section:
   - Clear the check box for **Require that all senders are authenticated**.
   - Select **Only senders in the following list**, and then click **Add** :::image type="icon" source="media/add-icon.png":::. In the **Select Members** dialog box that opens, select the external senders and the "all internal users" group.
   - Add the external senders and the "all internal users" group.
   - When you're finished, click **OK**.

     :::image type="content" source="media/fix-error-code-5-7-134-in-exchange-online/add-sender.png" alt-text="Screenshot of the message delivery restrictions page in which you can configure settings.":::

4. Click **OK**, and then click **Save**.

## Still need help with error code 550 5.7.134?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
