---
title: Can't find Viva Connections app in Teams mobile
description: Provides details about why users can't find the Viva Connections app on Teams mobile.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting
ms.service: viva
ms.subservice: viva-connections
localization_priority: Normal
ms.custom: 
  - CI 159609
  - CSSTroubleshoot
ms.reviewer: bpeterse
ms.date: 02/12/2022
search.appverid: 
- MET150
---

# Can't find Viva Connections app in Teams mobile

Your organization has added the custom line of business Viva Connections desktop app. Users can see the app in Microsoft Teams on their desktop but can't find the app in Teams on their mobile devices. This is because the custom line of business Viva Connections app is available only for Teams on the desktop.

You can check the details of the installed app in the Microsoft Teams admin center:

- Select [**Teams Apps** > **Manage Apps**](https://admin.teams.microsoft.com/policies/manage-apps).
- Search for the app, and then select it.

You should see information that resembles the following screenshot:

:::image type="content" source="media/cant-find-app-in-teams-mobile/custom-lob-app-version.png" alt-text="Screenshot of details for the custom line of business Viva Connections desktop app.":::

If your organization wants to use a Viva Connections app that is available for both the desktop and mobile environments for Teams, you can enable the first-party Viva Connections app in the Microsoft Teams admin center:

1. Use the steps in [this guide](/viva/connections/guide-to-setting-up-viva-connections#step-6-enable-the-viva-connections-app-in-the-microsoft-teams-admin-center) to set up the first-party Viva Connections app.
2. By default, the first-party Viva Connections app is blocked. Leave it set to **Blocked** and complete all the other requirements.
3. Toggle the **Status** option for the first-party Viva Connections app from **Blocked** to **Allowed**.
4. Delete and uninstall the custom line of business Viva Connections desktop app.

In the Microsoft Teams admin center, the details of the first-party Viva Connections app should resemble the following screenshot:

:::image type="content" source="media/cant-find-app-in-teams-mobile/first-party-app-version.png" alt-text="Screenshot of the details for the first-party Viva Connections app for Teams desktop and mobile.":::
