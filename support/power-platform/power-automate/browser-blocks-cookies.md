---
title: We can't sign you in - browser blocks cookies
description: Provides a resolution to an issue that prevent users from signing in to Power Automate for desktop.
ms.reviewer: pefelesk
ms.date: 02/10/2023
ms.subservice: power-automate-desktop-flows
---

# We can't sign you in - browser blocks cookies

This article provides a resolution to an issue prevent users from signing in to Power Automate for desktop.

## Symptoms

During sign in, Power Automate for desktop displays the following message:

**We can't sign you in. Your browser is currently set to block cookies. You need to allow cookies to use this service.**

## Resolution

This is issue is related to MSAL. To resolve it:

1. Go to **Control Panel** > **Internet Options** > **Security** > **Trusted Sites**.

1. Add the following URLs:

    - login.microsoft.com
    - login.windows.net
    - login.microsoftonline.com
    - secure.aadcdn.microsoftonline-p.com
