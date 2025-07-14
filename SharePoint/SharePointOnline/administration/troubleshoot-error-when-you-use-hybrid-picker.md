---
title: Error when you use the SharePoint Hybrid Picker
description: Describes an issue when you use the SharePoint Hybrid Picker.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Permissions\Permission Groups
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 08/13/2024
---

# Error when you use the SharePoint Hybrid Picker

## Symptoms

When you use the SharePoint Hybrid Picker, you receive the following error message during the Hybrid solution configuring phase:

> Value cannot be null. Parameter name: My site URL or team site URL from Discovery Service is null or empty.

## Cause

The issue occurs when users don't have permissions to create sites and the administrator doesn't have a OneDrive for Business site provisioned for their account.

## Resolution

To resolve this error, grant permissions to the **Everyone except external users** group so that users can create personal sites in Microsoft 365, and then browse to the OneDrive for Business page as the administrator. Follow these steps:

1. Sign in to your tenant as a SharePoint administrator, and browse to the SharePoint admin center.

2. Select **User profiles**, and then select **Manage User Permissions**.

3. Add the **Everyone except external users** group to the **Permissions** dialog box if it isn't listed.

4. Verify that the **Create Personal Site (required for personal storage, newsfeed, and followed content)** permission is selected for the **Everyone except external users** group, and then select **OK**.

5. Browse to https://*your_domain*-my.sharepoint.com to provision the OneDrive for Business account for the administrator account.

   **NOTE** Replace "your_domain" with the domain that you use for your organization.

6. Run the Hybrid Picker again.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
