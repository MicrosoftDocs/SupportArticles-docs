---
title: We can't sign you in Power Automate for desktop due to the browser blocking cookies
description: Provides a resolution for the issue that occurs when you try to sign in to Power Automate for desktop.
ms.reviewer: pefelesk, nimoutzo, dipapa, iomavrid
ms.date: 02/14/2023
ms.subservice: power-automate-desktop-flows
---
# "We can't sign you in" message occurs due to the browser blocking cookies

This article provides a resolution for the issue that prevents users from signing in to Power Automate for desktop.

## Symptoms

When you sign in to Power Automate for desktop, you receive the following message:

> We can't sign you in. Your browser is currently set to block cookies. You need to allow cookies to use this service.

## Cause

This issue is related to [Microsoft Authentication Library (MSAL)](/azure/active-directory/develop/msal-authentication-flows).

## Resolution

To resolve this issue:

1. Go to **Control Panel** > **Internet Options** > **Security** > **Trusted Sites**.
1. Add the following URLs:

    - `login.microsoft.com`
    - `login.windows.net`
    - `login.microsoftonline.com`
    - `secure.aadcdn.microsoftonline-p.com`
