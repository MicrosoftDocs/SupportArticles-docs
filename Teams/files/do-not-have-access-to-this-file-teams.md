---
title: Error (You don't have access to this file) when opening a file in Teams
description: Provides a resolution to an issue in which user can't open a file that is automatically stored in OneDrive in Teams.
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 10/30/2023
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft OneDrive for Business
  - Microsoft Teams
ms.custom: 
  - sap:Teams Files\Access File
  - CI 125301
  - CSSTroubleshoot
ms.reviewer: prbalusu
---

# Error when opening a file in Teams: You don't have access to this file

## Symptoms

In Microsoft Teams, you share a file with another user in a chat window. Then, the file is automatically stored on your OneDrive site. When the other user tries to open the file in Teams, the following error message is displayed:

> You don't have access to this file.

## Cause

This issue occurs because the **Limited-access user permission lockdown mode** feature is activated on your OneDrive site. This is a site collection feature that helps prevent anonymous users from accessing application pages that are mostly helpful on classic, publishing-based SharePoint sites. We recommend that you do not enable this feature on OneDrive sites.

## Resolution

To fix this issue, deactivate this feature in OneDrive.

1. Sign into your OneDrive site.
2. Select the **Setting** icon in the upper-right corner of the screen.
3. Select **OneDrive Settings** > **More Settings**.
4. Under **Features and storage**, select **Site Collection Features**.
5. Locate **Limited-access user permission lockdown mode**, and then select **Deactivate**.

For more information about **Limited-access user permission lockdown mode**, see [Enable or disable site collection features](https://support.microsoft.com/office/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04).

### Run a self-diagnostics tool

Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues with accessing files shared in Teams chat.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select **Run Tests** below, which will populate the diagnostic in the Microsoft 365 Admin Center.

> [!div class="nextstepaction"]
> [Run Tests: Unable to access files shared in Teams chat](https://aka.ms/TeamsSharedFilesInChat)

The diagnostic performs a large range of verifications.

### Need More Help?

Get help from the [Microsoft Community](https://answers.microsoft.com/) online community, search for more information on [Microsoft Support](https://support.microsoft.com/) or [Office Help and How To](https://office.microsoft.com/support/), or learn more about [Assisted Support](https://support.microsoft.com/contactus/) options.
