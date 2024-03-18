---
title: Error accessing Viva Connections app from Teams desktop client
description: Provides resolution for error message received when accessing the Viva Connections app from the Teams desktop client.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
localization_priority: Normal
ms.custom: 
  - CI 159609
  - CSSTroubleshoot
ms.reviewer: bpeterse
ms.date: 04/12/2022
search.appverid: 
- MET150
---

# Error accessing Viva Connections app from Teams desktop client

## Symptoms

Your organization has followed the steps to set up and start Viva Connections. However, when you try to access the Viva Connections app from the Microsoft Teams desktop client, you receive the following error message:

> Something went wrong. We couldn't sign you in. If the error persists, contact your system administrator and provide error code CAA20004.

When you select Additional problem information in the error message, you see the following details:

> AADSTS650057: Invalid resource. The client has requested access to a resource which is not listed in the requested permissions in the client's application registration.

:::image type="content" source="media/error-accessing-app-from-teams-desktop/error-accessing-app.png" alt-text="Screenshot of error message with additional information.":::

**Note:** This issue occurs only when you access the Viva Connections app from the Teams desktop client. You won't see this error if you access the Viva Connections app from the Teams web client.

## Cause

This error occurs if a SharePoint Framework (SPFx) web part is added to Viva Connections. Because of the web part addition, the **SharePoint Online Client Extensibility Web Application Principal** object that's available under **Microsoft Entra ID** > **App Registrations** isn't configured correctly to trust the Teams desktop client.

## Resolution

To resolve this issue, navigate to the API Access page from the SharePoint admin center:

1. Sign in to the **SharePoint admin center** by using Global admin credentials.
1. Select **Advanced** > **API access**.

If you don't see the **API acess** option, use the following steps:

1. Sign in to the **SharePoint admin center** by using Global admin credentials.
1. Select **More features**.
1. Select the **Open** button under **Apps**.
1. Select **API access**.
