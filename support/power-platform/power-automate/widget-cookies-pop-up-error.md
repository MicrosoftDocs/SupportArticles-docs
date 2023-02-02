---
title: Cookies or pop-up blocker errors when accessing Power Automate embedded experienes
description: Resolves the cookies or pop-up blockers errors when accessing Power Automate in other apps
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 02/01/2022
author: Harysh-Menon
ms.author: hamenon-ms
---
# Third-party cookies or pop-up blocker errors when accessing Power Automate embedded experiences

This article helps fix common configuration problems that prevent Power Automate from starting in embedded experiences within other apps or websites.


## Symptoms

When you access embedded instances of Power Automate, like within SharePoint, Power Apps or through custom SDK integrations, you may receive a blank screen or have a screen that stays on the spinner. 

## Cause

These issues occur because third-party cookies are blocked in the web browser.

## Resolution

Power Automate stores some data such as user identity and preferences locally leveraging your browsers capabilities. Problems occur if the browser blocks storage of such local data, or third-party cookies set by Power Automate.

To check what browser you are using and the browser settings, go to [WhatIsMyBrowser](https://www.whatismybrowser.com/). Then, enable third-party cookies, and make sure that the related sites are not blocked for cookies. 
 
 ### Instructions for Microsoft Edge

- Option 1: Enable storage of third-party cookies and local data for all sites

    1. Select **Settings** > **Cookies and site permissions**.
    1. Expand **Cookies and site data**.
    1. Ensure the setting **Block third-party cookies** is disabled.
    1. If present, remove the following sites from the site-specific cookie configuration under **Block**, and **Clear on exit**:
        - `https://make.powerautomate.com`
        - `https://*.make.powerautomate.com`
        - `https://make.*.powerautomate.com`
        - `https://login.microsoftonline.com`

- Option 2: Create exceptions to allow storage of third-party cookies and local data for Power Automate and associated services

    > [!NOTE]
    > The following steps require your Edge browser version to be **87 or above**.

    1. Select **Settings** > **Cookies and site permissions**.
    1. Expand **Cookies and site data**.
    1. Select **Add** under **Allow** and add:
        - `[*.]powerautomate.com`
    1. Select **Clear browsing data on close**.
    1. Ensure **Cookies and other site data** is disabled. If you want to keep it enabled, select **Add** instead, and add:
        - `[*.]powerautomate.com`

### Instructions for Google Chrome

- Option 1: Enable storage of third-party cookies and local data for all sites

    1. Select **Settings** > **Privacy and security**.
    1. Expand **Cookies and other site data**.
    1. Make sure that **Block third-party cookies** or **Block all cookies** isn't selected.
    1. If present, remove the following sites from the site-specific cookie configuration under **Sites that can always use cookies**, and **Always clear cookies when windows are closed**:
        - `https://make.powerautomate.com`
        - `https://*.make.powerautomate.com`
        - `https://make.*.powerautomate.com`
        - `https://login.microsoftonline.com`


- Option 2: Create exceptions to allow storage of third-party cookies and local data for Power Apps and associated services

    1. Select **Settings** > **Privacy and security**.
    1. Expand **Cookies and other site data**.
    1. Use **Add** for **Sites that can always use cookies** and add:
        - `[*.]powerautomate.com`
    1. Ensure that you check the **Including third-party cookies on this site** option when adding the site.
