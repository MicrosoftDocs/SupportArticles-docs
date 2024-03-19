---
title: Sharing options are grayed out when sharing from SharePoint Online or OneDrive
ms.author: luche
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:SharePoint Admin Center\Sharing Policies
  - CSSTroubleshoot
  - CI 149684
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - SharePoint Online
description: Describes a resolution to an issue where sharing options are not available or greyed out when using SharePointOnline or OneDrive for Business.
---

# Sharing options are greyed out when sharing from SharePoint Online or OneDrive

## Symptoms

Sharing options are grayed out when attempting to share from SharePoint Online or OneDrive.

## Cause

This issue can occur if you do not have sharing settings enabled properly for the site or organization. This issue may also occur if the site collection feature **Limited-access user permission lockdown mode** is activated.

For example:

1. Select the file or folder you want to share, and then select **Share**.
2. Select the dropdown list to change the type of link. In the **Link settings** screen, you can change who is able to access the link and edit the item you're sharing.
3. If one of the sharing options is grayed out, your organization's administrators may have restricted it.
    > [!NOTE]
    > The **Anyone with the link** option might be greyed out if you attempt to share .aspx pages. Sharing .aspx pages is not supported.

      :::image type="content" source="media/sharing-options-grayed-out-when-sharing-from-sharepoint-online-or-onedrive/link-settings.png" alt-text="Screenshot of the Link settings screen with Anyone with the link option grayed out.":::

## Resolution

To resolve this issue, follow the steps below to ensure the proper sharing settings are enabled for your organization and site collection.

### Check the external sharing settings for your organization

1. Sign in to https://admin.microsoft.com as a global or SharePoint admin. (If you see a message that you don't have permission to access the page, you don't have Microsoft 365 administrator permissions in your organization.)<br/>

    > [!NOTE]
    > - If you have Microsoft 365 Germany, sign in at https://portal.office.de.
    > - If you have Microsoft 365 operated by 21Vianet (China), sign in at https://login.partner.microsoftonline.cn/. Then select the Admin tile to open the admin center.
2. In the left pane, under **Admin centers**, select **SharePoint**. (You might need to select **Show all** to see the list of admin centers.)<br/>

    > [!NOTE]
    > If the classic SharePoint admin center appears, select **Open it now** at the top of the page to open the new SharePoint admin center.

3. In the left pane of the new SharePoint admin center, under **Policies**, select **Sharing**.
4. Under **External sharing**, specify your sharing level for SharePoint and OneDrive.

### Check the external sharing settings for the site that you want to share from

**If you're sharing from a SharePoint site:**

1. In the [SharePoint admin center](https://admin.microsoft.com/sharepoint), in the left pane, select **Sites** > **Active sites**.
1. Select the site that you want to share from, and then select **Sharing**.
1. Make sure that either **New and existing guests** or **Anyone** is selected, and if you made changes, select **Save**.

Try sharing again.

**If you're sharing from OneDrive:**

1. In the [Microsoft 365 admin center](https://admin.microsoft.com), in the left pane under **Users**, select **Active users**.
1. Select the user, and then select the **OneDrive** tab.
1. Select **Manage external sharing**.
1. Make sure **Let people outside your organization access your site** is turned on, and **Allow sharing with anonymous guest links and authenticated users** or **Allow sharing to authenticated guest users with invitations** is selected.

Try sharing again.

### Limited-access user permission lockdown mode

If the site collection feature **Limited-access user permission lockdown mode** is activated, the end user will see both **Anyone** and **People in Microsoft** grayed out.

To resolve this issue, follow the steps below:

1. Go to **Site administration** > **Site settings**.
2. Select **Site collection features**.
3. Deactivate **Limited-access user permission lockdown mode**.

## More information

For more information on external sharing settings, see [Turn external Sharing on or Off](/sharepoint/turn-external-sharing-on-or-off).

For information on the various Sharing settings within M365, see [Microsoft 365 guest sharing settings reference](/Office365/Enterprise/microsoft-365-guest-settings).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
