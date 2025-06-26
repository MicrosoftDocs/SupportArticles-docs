---
title: Fix NDR error 5.7.12 in Exchange Online
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
ms.assetid: 08793285-463d-4198-9626-60794835a3b5
description: Learn how to fix email issues for error code 5.7.12 in Exchange Online (the recipient rejects messages from external or unauthenticated senders).
---

# Fix NDR error "550 5.7.12" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see status code 550 5.7.12 or 5.7.12 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN). You'll see this automated notification when the recipient is configured to reject messages that are sent from outside of its organization.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How do I fix this issue?](#im-an-email-admin-how-do-i-fix-this-issue)|

## I got this bounce message. How do I fix it?

 Only an email admin in the recipient's organization can fix this issue. Contact the email admin and refer them to this information so they can try to resolve the issue for you.

## I'm an email admin. How do I fix this issue?

The two methods that will allow an external sender to send messages to the recipient in your organization are described in the following sections.

To open the Exchange admin center (EAC), see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).

### Method 1: Allow all internal and external senders to send messages to this recipient

Open the EAC and use one of the following procedures based on the recipient type.

#### User mailboxes

##### New EAC

1. Go to **Recipients** \> **Mailboxes**.

2. Select a mailbox from the list and click it. The mailbox properties screen appears.

3. Under **Mail flow settings**, click **Manage mail flow settings**. The **Manage mail flow settings** screen appears.

4. In the **Message delivery restriction** pane, click **Edit**. The **Message delivery restrictions** screen appears.

5. Clear the check box for **Require senders to be authenticated** in the **Accept messages from** section.

6. Click **Save**.

##### Classic EAC**

1. Go to **Recipients** \> **Mailboxes**.

2. Select the mailbox from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::. The mailbox properties screen appears.

3. Go to **Mailbox features** \> **Message Delivery Restrictions** \> and then click **View details**. The **message delivery restrictions** screen appears.

4. Clear the check box for **Require that all senders are authenticated** in the **Accept messages from** section.

5. Click **OK**, and then click **Save**.

#### Groups (distribution groups, mail-enabled security groups, and dynamic distribution groups)

##### Groups in the new EAC

1. Go to **Recipients** \> **Groups**.

2. Select the group from the list and click it. The group properties screen appears.

3. Click the **Settings** tab. The group settings screen appears.

4. Under the **Delivery management** pane, click **Edit delivery management**. The **Delivery management** screen appears.

5. Choose the radio button for **Allow messages from people inside and outside my organization**.

6. Click **Save changes**.

##### Groups in the classic EAC

1. Go to **Recipients** \> **Groups** \> select the group from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::. The group properties screen appears.

2. On the left pane, click **Delivery management**.

3. Click the radio button for **Senders inside and outside of my organization**.

4. Click **Save**.

#### Mail users

> [!IMPORTANT]
> Currently, editing mail flow settings for a mail user is available only in the Classic EAC.

1. Go to **Recipients** \> **Contacts**.

2. Select the mail user from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::. The mail user properties screen appears.

3. Go to **Mailbox flow settings** \> **Message Delivery Restrictions** and click **View details**. The **Message delivery restrictions** screen appears.

4. Clear the check box for **Require that all senders are authenticated** in the **Accept messages from** section.

5. Click **OK**, and then click **Save**.

#### Shared mailboxes

##### Shared mailboxes in the new EAC

1. Go to **Recipients** \> **Mailboxes**.

2. Select a shared mailbox from the list and click it. The mailbox properties screen appears.

3. Under **Mail flow settings**, click **Manage mail flow settings**. The **Manage mail flow settings** screen appears.

4. In the **Message delivery restriction** pane, click **Edit**. The **message delivery restrictions** screen appears.

5. Clear the check box for **Require senders to be authenticated** in the **Accept messages from** section.

6. Click **Save**.

##### Shared mailboxes in the classic EAC

1. Go to **Recipients** \> **Mailboxes**.

2. Select a shared mailbox from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::. The shared mailbox properties screen appears.

3. Go to **Mailbox features** \> **Message Delivery Restrictions** \> and then click **View details**. The **Message delivery restrictions** screen appears.

4. Clear the check box for **Require that all senders are authenticated** in the **Accept messages from** section.

5. Click **OK**, and then click **Save**.

### Method 2: Use the recipient's allowed senders list

Instead of allowing all external senders to send messages to this recipient, you can use the recipient's allowed senders list to selectively allow messages from all internal senders and the specified external senders.

**Notes**:

- To add an external sender to a recipient's allowed senders list, you must first create a [mail contact](/exchange/recipients-in-exchange-online/manage-mail-contacts) or a [mail user](/exchange/recipients-in-exchange-online/manage-mail-users) to represent the external sender in your organization.

- To add everyone in your organization to a recipient's allowed sender's list, you can create a [distribution group](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups) or a [dynamic distribution group](/exchange/recipients-in-exchange-online/manage-dynamic-distribution-groups/manage-dynamic-distribution-groups) that contains everyone in your organization. After you create this group, you can add it to the recipient's allowed senders list.

- The recipient's allowed senders list is different from the organization's allowed senders list for anti-spam that you manage in the EAC at **Protection** \> **Spam filter**.

To configure the recipient's allowed senders list, open the EAC and use one of the following procedures based on the recipient type.

#### User mailboxes

##### New EAC

1. Go to **Recipients** \> **Mailboxes**.

2. Select a user mailbox from the list and click it. The mailbox properties screen appears.

3. Under **Mail flow settings**, click **Manage mail flow settings**. The **Manage mail flow settings** screen appears.

4. In the **Message delivery restriction** pane, click **Edit**. The **Message delivery restrictions** screen appears.

5. Configure the following settings under the **Accept messages from** section:
   - Clear the check box for **Require senders to be authenticated**.
   - Choose the radio button for **Selected senders**.
   - Click **+ Add sender**.

     :::image type="content" source="media/fix-error-code-5-7-12-in-exchange-online/specifying-senders.png" alt-text="Screenshot of the Message delivery restrictions window. The Add sender button is highlighted.":::

   - In the **Accept messages from** screen, select the external senders and the "all internal users" group.
   - Add the external senders and the "all internal users" group to the list of the allowed senders of the recipient.

     :::image type="content" source="media/fix-error-code-5-7-12-in-exchange-online/confirming-the-specified-users.png" alt-text="Screenshot of the Accept messages from window on which the specific senders are chosen.":::

6. When you're finished, click **Confirm**.

7. Click **Save**.

##### Classic EAC

1. Go to **Recipients** \> **Mailboxes**.

2. Select the mailbox from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::. The mailbox properties screen appears.

3. Go to **Mailbox features** \> **Message Delivery Restrictions** \> and then click **View details**. The **message delivery restrictions** screen appears.

4. Configure the following settings in the **Accept messages from** section:
   - Clear the check box for **Require that all senders are authenticated**.
   - Select **Only senders in the following list**, and then click **Add** :::image type="icon" source="media/add-icon.png":::. In the **Select Members** dialog box that opens, select external senders and the "all internal users" group. 
   - Add the external senders and the "all internal users" group to the list of the allowed senders of the recipient.
   - When you're finished, click **OK**.

     :::image type="content" source="media/fix-error-code-5-7-12-in-exchange-online/message-delivery-restrictions.png" alt-text="Screenshot of the message delivery restrictions window on which the specific senders are highlighted.":::

5. Click **OK**, and then click **Save**.

## Still need help with error code 550 5.7.12?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
