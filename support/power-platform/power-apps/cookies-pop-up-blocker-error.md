---
title: Cookies or pop-up blocker errors when using Unified Interface apps
description: Describes issues in which you receive errors about cookies or pop-up blockers when using Unified Interface apps.
ms.reviewer: rashb
ms.topic: troubleshooting
ms.date: 10/19/2021
author: simonxjx
ms.author: v-six
---
# Third-party cookies or pop-up blocker errors when using Unified Interface apps

_Applies to:_ &nbsp; Power Apps

## Symptoms

When you use Unified Interface apps, you receive one of the following error messages about cookies and pop-up blockers:

- > Something has gone wrong. Check technical details for more details.  
  > Technical Details  
  > Session Id: \<Session ID\>  
  > Activity Id: \<Activity ID\>  
  > Timestamp: \<Date Time\> GMT-0700 (Pacific Daylight Time)  
  > {"errorInfo":{"code":"UserInterventionNeeded_CookiesBlocked", "localized Message":"Power Apps requires cookies to be enabled. Please enable them in your browser.","timestamp":\<Time Stamp\>,"description":"Power Apps requires cookies to be enabled. Please enable them in your browser."}}
  > No stack available.

    :::image type="content" source="media/cookies-pop-up-blocker-error/power-apps-requires-cookies.png" alt-text="Screenshot that shows the error message about the cookies.":::

- > A \<Server Name\> window was unable to open, and may have been blocked by a pop-up blocker. Please add this \<Server Name\> server to the list of sites your pop-up blocker allows to open new windows.

    :::image type="content" source="media/cookies-pop-up-blocker-error/pop-up-blocker-error.png" alt-text="Screenshot that shows the error message about the pop-up blocker.":::

## Cause

These issues occur because third-party cookies are blocked in the web browser.

## Resolution

To check the web browser settings, go to the following website: ([WhatIsMyBrowser](https://www.whatismybrowser.com/)). Then, enable third-party cookies, and make sure that the related sites are not blocked for cookies.

### Enable storage of third-party cookies and local data for Microsoft Edge

1. Select **Settings** > **Cookies and site permissions**.
1. Expand **Manage and delete cookies and site data**.
1. Make sure that the **Block third-party cookies** setting is disabled.
1. If you find the following sites in the site-specific cookie configurations under **Block** and **Clear on exit**, remove them from the list:
    - `https://create.powerapps.com`
    - `https://*.create.powerapps.com`
    - `https://make.*.powerapps.com`
    - `https://make.powerapps.com`
    - `https://login.microsoftonline.com`
    - `https://apps.*.powerapps.com`
    - `https://apps.powerapps.com`

### Enable storage of third-party cookies and local data for Google Chrome

1. Select **Settings** > **Privacy and security**.
1. Expand **Cookies and other site data**.
1. Make sure that **Block third-party cookies** or **Block all cookies** isn't selected.
1. If you find the following sites in the site-specific cookie configuration under **Sites that can always use cookies** and **Always clear cookies when windows are closed**, remove them from the lists:
    - `https://create.powerapps.com`
    - `https://*.create.powerapps.com`
    - `https://make.*.powerapps.com`
    - `https://make.powerapps.com`
    - `https://login.microsoftonline.com`
    - `https://apps.*.powerapps.com`
    - `https://apps.powerapps.com`

For instructions for other web browsers and iOS devices, see [troubleshooting startup issues for Power Apps](/powerapps/troubleshooting-startup-issues#enable-storage-of-third-party-cookies-and-local-data-in-your-browser-or-app).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
