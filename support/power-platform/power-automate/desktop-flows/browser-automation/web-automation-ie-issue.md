---
title: Failed To Assume Control Of IE Error
description: Solves an error that occurs when you use Internet Explorer as the browser for automation.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 04/01/2025
---
# "Failed to assume control of IE" error during web automation with Internet Explorer

This article addresses an issue where users encounter a failure during web automation with Internet Explorer due to specific security settings.

## Symptoms

When you run a desktop flow in Power Automate that includes the [Launch new Internet Explorer](/power-automate/desktop-flows/actions-reference/webautomation#launchinternetexplorerbase) action, the automation fails at runtime and displays the following error message:

> Failed to assume control of IE

## Cause

This issue might occur because the security settings in Internet Explorer aren't configured properly. Specifically, the **Enable Protected Mode** setting might prevent the automation tool from controlling the browser.

## Resolution

1. Open Internet Explorer.
2. Go to **settings** > **Internet Options**.
3. Navigate to the **Security** tab.
4. Under the **Internet** section, clear the **Enable Protected Mode** checkbox.
5. Select **Apply** and then **OK** to save the changes.
6. Close and restart Internet Explorer.

For more information, see [Set up browsers in Power Automate](/power-automate/desktop-flows/install-browser-extensions#set-up-browsers).
