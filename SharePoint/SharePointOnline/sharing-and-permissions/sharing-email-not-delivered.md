---
title: Email notifications from sharing events aren't delivered to recipients
description: Resolves an issue that prevents delivery of sharing notifications that are triggered by sharing events in SharePoint, OneDrive, or Microsoft 365 apps, by task assignment in Planner, or by publishing news or comments in Viva Connections.
manager: dcscontentpm
ms.date: 10/30/2024
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Sharing, Permissions, and Authorization
  - CSSTroubleshoot
  - CI 1279
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
ms.reviewer: prbalusu, salarson
---

# Email notifications from sharing events aren't delivered to recipients

## Symptoms

In scenarios in which some of your actions trigger email notifications, the messages aren't delivered to the intended recipients.

Examples of such scenarios include situations in which you:

- Share documents or folders in Microsoft SharePoint
- Share files or folders in OneDrive
- Share documents or collaborate on files in Microsoft 365 apps
- Assign tasks in Microsoft Planner
- Publish news or comment on news items in Microsoft Viva Connections

## Cause

This issue is likely caused by one of the following conditions:

- Your user profile in Microsoft Entra ID has no value assigned to the **Email** property.
- Your email address is flagged as spam by the recipient's email provider.

## Resolution

Ask the recipients to check their Junk or Spam folder. If your email address is blocked by a spam filter, the recipients should [add your email address to the Safe Senders list](https://support.microsoft.com/office/add-recipients-of-my-email-messages-to-the-safe-senders-list-be1baea0-beab-4a30-b968-9004332336ce) to avoid the issue in future.

If the email notification isn't in the Junk or Spam folder, then your email address isn't specified in your user profile. Users who are assigned the User Administrator role in Microsoft Entra or the User admin role in Microsoft 365 have to assign a value to the **Email** property in your user profile by using one of the following methods.

### Method 1: Update from the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator) in Microsoft Entra.
1. Navigate to **Identity** > **Users** > **All users**.
1. Select the affected user.
1. Verify that the **User type** is set to **Member**.

   **Note**: If the **User type** property is set to **Guest**, select **Edit properties**, set **User type** to **Member**, and then select **Save**.
1. Select **Edit properties**, select the **Contact Information** tab, update the **Email** property to the correct email address, and then select **Save**.

### Method 2: Update from the Microsoft 365 admin center

1. Sign in to the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339) as a [User admin](/microsoft-365/admin/add-users/about-admin-roles?view=o365-worldwide#commonly-used-microsoft-365-admin-center-roles&preserve-view=true) in Microsoft 365.
1. Navigate to **Users** > **Active users**.
1. Select the affected user.
1. On the **Account** tab, under **Username and email**, select **Manage username and email**.
1. Under **Primary email address and username**, select the **Edit** icon, enter the correct username in **Username** field, select the correct domain from **Domains**, select **Done**, and then select **Save changes**.
