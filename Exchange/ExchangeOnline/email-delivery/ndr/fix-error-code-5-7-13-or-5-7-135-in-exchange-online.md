---
title: Fix NDR error 5.7.13 or 5.7.135 in Exchange Online
ms.date: 08/10/2026
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six, v-kccross
audience: Admin
ms.topic: troubleshooting
f1.keywords:
- CSH
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
  - CI 12713
search.appverid:
- BCS160
- MOE150
- MET150
ms.assetid: fc1ea7e0-3680-4778-ad96-4328c60d517c
description: Learn how to fix email issues for error code 550 5.7.13 or 5.7.135 in Exchange Online (the public folder recipient is configured to reject messages from external or unauthenticated senders).
---

# Fix NDR error "550 5.7.13" or "550 5.7.135" in Exchange Online

This topic describes what you can do if you see error code 550 5.7.13 or 550 5.7.135 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN). You'll see this automated notification when the recipient is a public folder that's configured to reject messages from external senders (senders from outside the organization).

## I got this bounce message. How do I fix this issue?

Only an email admin in the recipient's organization can fix this issue. Contact the email admin and refer them to this information so they can try to resolve the issue for you.

## I'm an email admin. How do I fix this issue?

The two methods that will allow the external sender to send messages to the public folder in your organization are described in the following sections.

To open the Exchange admin center (EAC), see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).

### Method 1: Allow all internal and external senders to send messages to this public folder

#### In New EAC

1. Navigate to **Public folders** \> **Public folders**.

1. Choose a public folder from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::. The public folder properties screen appears.

    :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/editing-a-public-folder.png" alt-text="The screen on which the details of a public folder can be edited.":::

1. Click **Mail flow settings**.

1. Under **Message delivery Restrictions** \> **Accept messages from**, perform the following tasks:

    - Clear the check box for **Require that all senders are authenticated**.

    - Select **All senders**.

    :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/allow-all-senders-public-folder.png" alt-text="The screen on which the user can configure all external senders to send messages to the public folder.":::

1. Click **Save**.

#### In Classic EAC

1. In the Classic EAC, go to **Public folders** \> **Public folders** \> select the public folder from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::.

   :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/public-folder.png" alt-text="Screenshot of the public folder lists." border="false":::

1. In the public folder properties dialog box that opens, go to **Mail flow settings**, and configure the following settings in the **Accept messages from** section:

    - Clear the check box for **Require that all senders are authenticated**.

    - Select **All senders**.

   :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/delivery-restrictions.png" alt-text="Screenshot of the mail flow settings page. The Require that all senders are authenticated check box is cleared.":::

1. Click **Save**.

### Method 2: Use the public folder's allowed senders list

Instead of allowing all external senders to send messages to this public folder, you can use the public folder's allowed senders list to selectively allow messages from all internal senders and the specified external senders.

**Notes**:

- To add an external sender to a public folder's allowed senders list, you must first create a [mail contact](/exchange/recipients-in-exchange-online/manage-mail-contacts) or a [mail user](/exchange/recipients-in-exchange-online/manage-mail-users) to represent the external sender in your organization.

- To add everyone in your organization to a public folder's allowed sender's list, you can create a [distribution group](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups) or a [dynamic distribution group](/exchange/recipients-in-exchange-online/manage-dynamic-distribution-groups/manage-dynamic-distribution-groups) that contains everyone in your organization. After you create this group, you can add it to the public folder's allowed senders list.

- The public folder's allowed senders list is different from the organization's allowed senders list for anti-spam that you manage in the EAC at **Protection** \> **Spam filter**.

To configure the public folder's allowed senders list, open the EAC do the following steps:

#### In New EAC

1. Navigate to **Public folders** \> **Public folders**.

1. Choose a public folder from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::. The public folder properties screen appears.

    :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/editing-a-public-folder.png" alt-text="The screen on which the details of a public folder can be edited.":::

1. Under **Message delivery Restrictions** \> **Accept messages from**, perform the following tasks:

    - Clear the check box for **Require that all senders are authenticated**.
    - Select **Only senders in the following list**, and then click **+**.

        :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/configuring-specific-senders-to-public-folders-new-eac.png" alt-text="Screenshot of the New EAC page on which the user can configure restriction on senders.":::

        The **Select members** screen appears.

    - Check the check boxes of the specific external senders and the all-internal-users group you want to add to the senders list.
    - Click **add**.

        :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/adding-specific-senders-to-public-folders-new-eac.png" alt-text="The screen on which the specific senders can be added.":::

    - When you're finished, click **OK**.

1. Click **Save**.

#### In Classic EAC

1. In the Classic EAC, go to **Public folders** \> **Public folders** \> select the public folder from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::.

   :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/public-folder.png" alt-text="Screenshot of the public folder lists." border="false":::

1. In the public folder properties dialog box that opens, go to **Mail flow settings**, and configure the following settings in the **Accept messages from** section:

   - Clear the check box for **Require that all senders are authenticated**.

   - Select **Only senders in the following list**, and then click **Add** :::image type="icon" source="media/add-icon.png":::. In the **Select Members** dialog box that opens, select the external senders and the "all internal users" group.
   - Add the external senders and the "all internal users" group to the allowed senders list.
   - When you're finished, click **OK**.

     :::image type="content" source="media/fix-error-code-5-7-13-or-5-7-135-in-exchange-online/accept-messages-from.png" alt-text="Screenshot of the custom allowed sender list for a public folder." border="false":::

1. Click **Save**.
