---
title: Error (We can't get the activity log) when accessing the Microsoft Teams admin center
description: Describes an issue in which you are not able to access Microsoft Teams admin center. Provides a solution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 121035
  - CSSTroubleshoot
ms.reviewer: scapero
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 3/31/2022
---

# Error when accessing the Microsoft Teams admin center: We can't get the activity log

## Symptoms

As a Microsoft Teams administrator, you can't access the Microsoft Teams admin center at [https://admin.microsoft.com](https://admin.microsoft.com) with third-party cookies disabled in the browser. You receive this error:

> We can't get the activity log

## Cause

This behavior is by design. Authentication and authorization won't work as intended if the third-party cookies are disabled in the browser.

This is the recommended path that relies on browser session cookies during Microsoft Azure Active Directory authentication or authorization.

## Resolution

Enable third-party cookies from browser settings:

1. Open Edge browser.
2. Go to **Settings** > **Site permissions** > **Cookies and site data**
3. Set **Block third-party cookies** to **Disable**.

    :::image type="content" source="media\cannot-access-admin-center\disable-cookie.png" alt-text="Screenshot that shows the Block third-party cookies settings.":::

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
