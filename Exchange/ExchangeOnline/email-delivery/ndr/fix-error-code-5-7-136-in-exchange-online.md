---
title: Fix NDR error 5.7.136 in Exchange Online
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
audience: Admin
ms.topic: troubleshooting
ms.localizationpriority: medium
f1.keywords:
- CSH
ms.custom: 
- Exchange Online
- CSSTroubleshoot
- CI 167832
search.appverid:
- BCS160
- MOE150
- MET150
ms.assetid: f171e842-9fdb-4e68-8f3d-53fcd9e43c62
description: Learn how to fix email issues for error code 5.7.136 in Exchange Online (the mail user recipient is configured to reject messages from external or unauthenticated senders).
---

# Fix NDR error "550 5.7.136" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 550 5.7.136 in a non-delivery report, also known as an NDR, bounce message, delivery status notification, or DSN. You'll see this automated notification when the recipient is a mail user that's configured to reject messages from external senders, that is, senders from outside the organization.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix this issue?](#i-got-this-bounce-message-how-do-i-fix-this-issue)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How do I fix this issue?](#im-an-email-admin-how-do-i-fix-this-issue)|

## I got this bounce message. How do I fix this issue?

Only an email admin in the recipient's organization can fix this issue. Contact the email admin and refer them to this information so they can try to resolve the issue for you.

## I'm an email admin. How do I fix this issue?

The two methods that will allow an external sender to send messages to the mail user in your organization are described in the following sections. These two methods can be implemented using the Classic EAC.

> [!NOTE]
> Currently, there is no support for the two methods in the New EAC.

To open the Classic EAC, click **Classic Exchange admin center** on the left pane of the home screen of the **New EAC**.

:::image type="content" source="media/fix-error-code-5-7-136-in-exchange-online/navigation-to-classic-eac.png" alt-text="The interface from which the user can go to Classic EAC.":::.

### Method 1: Allow all internal and external senders to send messages to this mail user

1. Go to **Recipients** \> **Contacts** > select the mail user from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::.

   :::image type="content" source="media/fix-error-code-5-7-136-in-exchange-online/contacts.png" alt-text="Screenshot of the contacts tab in which you can see mail users.":::

    The mail user properties dialog box opens.

2. Go to **Mailbox flow settings** and then click **View details** in the **Message Delivery Restrictions** section.

    The **Message delivery restrictions** dialog box opens.

3. Configure the following settings in the **Accept messages from** section:
   - Clear the check box for **Require that all senders are authenticated**.
   - Select **All senders**.

4. Click **OK**, and then click **Save**.

### Method 2: Use the mail user's allowed senders list

Instead of allowing all external senders to send messages to this mail user, you can use the mail user's allowed senders list to selectively allow messages from all internal senders and the specified external senders.

**Notes**:

- To add an external sender to a mail user's allowed senders list, you must first create a [mail contact](/exchange/recipients-in-exchange-online/manage-mail-contacts) or a [mail user](/exchange/recipients-in-exchange-online/manage-mail-users) to represent the external sender in your organization.

- To add everyone in your organization to a mail user's allowed sender's list, you can create a [distribution group](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups) or a [dynamic distribution group](/exchange/recipients-in-exchange-online/manage-dynamic-distribution-groups/manage-dynamic-distribution-groups) that contains everyone in your organization. After you create this group, you can add it to the mail user's allowed senders list.

- The mail user's allowed senders list is different from the organization's allowed senders list for anti-spam that you manage in the EAC at **Protection** \> **Spam filter**.

To configure the mail user's allowed senders list, open the Classic EAC do the following steps:

1. Go to **Recipients** \> **Contacts** > select the mail user from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::.

   :::image type="content" source="media/fix-error-code-5-7-136-in-exchange-online/contacts.png" alt-text="Screenshot of the contacts tab in which you can see mail users.":::

    The mail user properties dialog box opens.

2. Go to **Mailbox flow settings** and then click **View details** in the **Message Delivery Restrictions** section.

    The **Message delivery restrictions** dialog box opens.

3. Configure the following settings in the **Accept messages from** section:
   - Clear the check box for **Require that all senders are authenticated**.
   - Select **Only senders in the following list**, and then click **Add** :::image type="icon" source="media/add-icon.png":::. In the **Select Members** dialog box that opens, select the external senders and the "all internal users" group. 
   - Add the external senders and the "all internal users" group to the allowed senders list.
   - When you're finished, click **OK**.

     :::image type="content" source="media/fix-error-code-5-7-136-in-exchange-online/add-sender.png" alt-text="Screenshot of the message delivery restrictions dialog box in which you can add an allowed sender.":::

4. Click **OK**, and then click **Save**.

## Still need help with error code 550 5.7.136?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
