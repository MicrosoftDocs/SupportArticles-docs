---
title: We can't sign you in due to browser blocks cookies
description: Provides a resolution to an issue that occurs when you try to sign in to Power Automate for desktop.
ms.reviewer: pefelesk
ms.date: 02/14/2023
ms.subservice: power-automate-desktop-flows
---

# "We can't sign you in" message occurs due to the browser blocks cookies

This article provides a resolution to an issue that prevents users from signing in to Power Automate for desktop.

## Symptoms

When you sign in to Power Automate for desktop, you receive the following message:

> We can't sign you in. Your browser is currently set to block cookies. You need to allow cookies to use this service.

## Resolution

This issue is related to [Microsoft Authentication Library (MSAL)](azure/active-directory/develop/msal-authentication-flows). To resolve this issue:

1. Go to **Control Panel** > **Internet Options** > **Security** > **Trusted Sites**.
1. Add the following URLs:

    - `login.microsoft.com`
    - `login.windows.net`
    - `login.microsoftonline.com`
    - `secure.aadcdn.microsoftonline-p.com`
