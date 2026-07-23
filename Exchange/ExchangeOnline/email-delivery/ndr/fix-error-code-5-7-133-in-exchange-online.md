---
title: Fix NDR error 5.7.133 in Exchange Online
ms.date: 07/23/2026
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: arindamt
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
ms.assetid: 991abc19-7756-438f-abcb-39f69b80f284
description: Learn how to fix email issues for error code 5.7.133 in Exchange Online.
---

# Fix NDR error "550 5.7.133" in Exchange Online

## Summary

This article describes what you can do if you see error code 550 5.7.133 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN). You'll see this automated notification when the recipient is a group that's configured to reject messages from external senders who are from outside the organization.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix this issue?](#i-got-this-bounce-message-how-do-i-fix-this-issue)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm the group owner or email admin. How do I fix this issue?](#im-the-group-owner-or-email-admin-how-do-i-fix-this-issue)|

## I got this bounce message. How do I fix this issue?

Only the group owner or an email admin in the recipient's organization can fix this issue. Contact the group owner or email admin and refer them to this information so they can try to resolve the issue for you.

## I'm the group owner or email admin. How do I fix this issue?

The two methods that will allow an external sender to send messages to the distribution group in your organization are described in the following sections.

To open the Exchange admin center (EAC), see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).

### Method 1: Allow all internal and external senders to send messages to this group

1. Open the [Exchange admin center (EAC)](/exchange/exchange-admin-center).
2. Go to **Recipients** \> **Groups**.
3. Select a group from the list and click it. The group properties screen appears.

   :::image type="content" source="media/fix-error-code-5-7-133-in-exchange-online/group-properties.png" alt-text="The screen displaying the properties of the chosen group.":::

4. Click the **Settings** tab.

   :::image type="content" source="media/fix-error-code-5-7-133-in-exchange-online/group-screen.png" alt-text="The screen on which group details are displayed.":::

5. Under **Delivery management**, click **Edit delivery management**. The **Delivery management** screen appears. 
6. Under **Sender options**, choose **Allow messages from people inside and outside my organization**.
 
   :::image type="content" source="media/fix-error-code-5-7-133-in-exchange-online/adding-all-senders-to-group.png" alt-text="The screen on which all the senders are added to the senders group.":::

7. Click **Save changes**.

### Method 2: Use the group's allowed senders list

Instead of allowing all external senders to send messages to this group, you can use the group's allowed senders list to selectively allow messages from all internal senders and the specified external senders.

**Notes**:

- To add an external sender to a group's allowed senders list, you must first create a [mail contact](/exchange/recipients-in-exchange-online/manage-mail-contacts) or a [mail user](/exchange/recipients-in-exchange-online/manage-mail-users) to represent the external sender in your organization.

- To add everyone in your organization to a group's allowed sender's list, you can create a [distribution group](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups) or a [dynamic distribution group](/exchange/recipients-in-exchange-online/manage-dynamic-distribution-groups/manage-dynamic-distribution-groups) that contains everyone in your organization. After you create this group, you can add it to the group's allowed senders list.

- The group's allowed senders list is different from the organization's allowed senders list for anti-spam that you manage in the EAC at **Protection** \> **Spam filter**.

To configure the group's allowed senders list, perform the following steps:

1. Open the [Exchange admin center (EAC)](/exchange/exchange-admin-center).
2. Go to **Recipients** \> **Groups**.
3. Select a group from the list and click it. The group properties screen appears.

   :::image type="content" source="media/fix-error-code-5-7-133-in-exchange-online/group-properties.png" alt-text="The screen displaying the properties of the chosen group.":::

4. Click the **Settings** tab.
5. Under **Delivery management**, click **Edit delivery management**. The **Delivery management** screen appears.
6. Under **Sender options**, choose **Allow messages from people inside and outside my organization**.
7. Under **Specified senders**, click inside the text box. The list of senders (internal and external) is displayed.

   :::image type="content" source="media/fix-error-code-5-7-133-in-exchange-online/list-of-senders.png" alt-text="The screen that lists the internal and external senders who can be added to the senders list.":::

8. Choose the senders you want to add to the senders list, and click **Save changes**.

   :::image type="content" source="media/fix-error-code-5-7-133-in-exchange-online/choosing-profile-of-a-sender.png" alt-text="The screen on which a chosen sender is added to the senders group.":::

## Still need help with error code 550 5.7.133?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)

[Create and manage distribution groups in Exchange Online](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups).
