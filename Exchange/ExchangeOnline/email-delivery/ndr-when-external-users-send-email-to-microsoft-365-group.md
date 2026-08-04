---
title: 550 5.7.193 when external users send email to Microsoft 365 group
description: Provides a resolution for an issue in which external senders receive NDR 550 5.7.193 when they send an email message to a Microsoft 365 group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 183937
ms.reviewer: batre, meerak, v-trisshores, arindamt
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 07/31/2026
ai-usage: ai-assisted
---

# NDR 550 5.7.193 when external users send email to a Microsoft 365 group

## Summary

External senders receive NDR 550 5.7.193 when they send an email message to a Microsoft 365 group that doesn't allow messages from external senders or when the sender isn't a member of the group. This article describes how group owners and administrators can resolve the issue by either adding the external sender as a guest member of the group or configuring the group to accept email from external senders by using Outlook, the Exchange admin center, or Exchange Online PowerShell.

## Symptoms

An external sender receives the following nondelivery report (NDR) when they send an email message to a group in Microsoft 365 Groups:

> The group \<group name\> isn't set up to receive messages from \<sender name\>.  
> More Info for Email Admins  
> Status code: 550 5.7.193  
> 550 5.7.193 UnifiedGroupAgent; Delivery failed because the sender isn't a group member  
> or external senders aren't permitted to send to this group.

## Cause

The Microsoft 365 group isn't configured to accept email messages from external senders or the sender isn't a member of the group.

## Resolution

To configure a group in Microsoft 365 Groups to accept email messages from external senders, use either of the following methods. The method that you choose depends on whether you're an administrator or the group owner.

### Method for group owner

### Method 1: Add the external sender as a member of the group as a guest user

To allow a specific external sender to send email to the Microsoft 365 group, follow these steps:

1. Open the [Microsoft Outlook Groups hub](https://outlook.office.com/people/group/owner).

1. Select the group and then select **Edit** from the menu bar to open the **Edit group** dialog box.

1. Select the **Members** tab and then select **Add members**.

:::image type="content" source="media/ndr-when-external-users-send-email-to-microsoft-365-group/add-member-1.png" alt-text="Screenshot of the Members tab showing the All members list with the Add members button highlighted.":::

1. Manually type the email address of the external sender and select **Add**. This action adds the external sender as a guest member of the group. Select **Close**. 

:::image type="content" source="media/ndr-when-external-users-send-email-to-microsoft-365-group/add-member-2.png" alt-text="Screenshot of the Add members dialog box showing the email address of the external sender typed manually.":::

1. After you add the external sender, they appear as a member of the group under the **Members** tab.

:::image type="content" source="media/ndr-when-external-users-send-email-to-microsoft-365-group/member-tab.png" alt-text="Screenshot of the Members tab showing the external sender listed as a member of the group.":::

1. Wait for the change to take effect. After that, the group accepts emails from this external sender.

### Method 2: Enable people outside the organization to email the group

To allow all external senders to send email to the Microsoft 365 group, follow these steps:

1. Open the [Microsoft Outlook Groups hub](https://outlook.office.com/people/group/owner).

1. Select the group and then select **Edit** from the menu bar to open the **Edit group** dialog box.

1. In the **Edit group** dialog box, select **Let people outside the organization email the groups**.

:::image type="content" source="media/ndr-when-external-users-send-email-to-microsoft-365-group/external-email-setting.png" alt-text="Screenshot of the Edit group dialog box showing the option that lets people outside the organization email the group.":::**.

1. Select **Save**.

### Method for administrator

### Method 1: Add the external sender as a member of the group as a guest user

1. If the external sender isn't already a guest user, go to [https://admin.cloud.microsoft/?#/GuestUsers](https://admin.cloud.microsoft/?#/GuestUsers) and add the external sender as guest user. Follow the steps in [Invite an external guest user](/entra/external-id/b2b-quickstart-add-guest-users-portal#invite-an-external-guest-user).

1. Once you add the guest user, open Exchange admin center and go to **Recipients** > **Groups**. Select the relevant group to open the group details pane.

1. Go to the **Members** tab and click on **View all and manage members**.

1. Select **Add members**, select the external guest user, and then select **Add**. After you add the guest user, close the group page.

1. Wait for the change to take effect. After that, emails from this external sender are allowed to the group. 

### Method 2: Allow all external senders to email the group

1. Open Exchange admin center and go to **Recipients** > **Groups**. Select the group you want to manage to open the group details pane.

1. In the details pane, select **Settings**.

1. On the **Settings** tab, select **Allow external senders to email this group**.
:::image type="content" source="media/ndr-when-external-users-send-email-to-microsoft-365-group/allow-external-sender.png" alt-text="Screenshot of the Settings tab showing the Allow external senders to email this group option.":::

1. Select **Save**.

#### PowerShell

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) by running the following command:

   ```PowerShell
   Connect-ExchangeOnline
   ```

1. Configure the group to receive mail from unauthenticated (external) senders by running the following command:

   ```PowerShell
   Set-UnifiedGroup -Identity <group name or SMTP address> -RequireSenderAuthenticationEnabled $False
   ```
