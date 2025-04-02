---
title: Cookies or pop-up blocker errors when accessing Power Automate embedded experiences
description: Resolves the cookies or pop-up blocker errors when accessing Power Automate in other apps.
ms.reviewer: hamenon, tapanm, rymacdow
ms.date: 08/05/2024
author: sbasi19
ms.author: ralinga
ms.custom: sap:Flow creation\Other flow creation issues
---
# Third-party cookies or pop-up blocker errors when accessing Power Automate embedded experiences

This article helps fix common configuration problems that prevent Power Automate from starting in embedded experiences within other apps or websites.

## Symptoms

When you access embedded instances of Power Automate, like within SharePoint, Power Apps, or through custom SDK integrations, you might receive a blank screen or have a screen that stays on the spinner.

## Cause

These issues occur because third-party cookies are blocked in the web browser.

## Resolution

Power Automate stores some data, such as user identity and preferences locally, using your browser's capabilities. Problems occur if the browser blocks the storage of such local data or third-party cookies set by Power Automate.

To solve the issues, go to the settings of the browser you're using, enable the third-party cookies, and make sure that the related sites aren't blocked for cookies.

#### Instructions for Microsoft Edge

- Option 1: Enable storage of third-party cookies and local data for all sites

    1. Select **Settings** > **Cookies and site permissions**.
    1. Expand **Manage and delete cookies and site data**.
    1. Ensure the **Block third-party cookies** setting is disabled.
    1. If present, remove the following sites from the site-specific cookie configuration under **Block** and **Clear on exit**:
        - `https://make.powerautomate.com`
        - `https://*.make.powerautomate.com`
        - `https://make.*.powerautomate.com`
        - `https://login.microsoftonline.com`

- Option 2: Create exceptions to allow storage of third-party cookies and local data for Power Automate and associated services

    > [!NOTE]
    > The following steps require your Edge browser version to be 87 or above.

    1. Select **Settings** > **Cookies and site permissions**.
    1. Expand **Manage and delete cookies and site data**.
    1. Select **Add** under **Allow** and add:
        - `[*.]powerautomate.com`
    1. Select **Clear browsing data on close**.
    1. Ensure **Cookies and other site data** is disabled. If you want to keep it enabled, select **Add** instead, and then add:
        - `[*.]powerautomate.com`

#### Instructions for Google Chrome

- Option 1: Enable storage of third-party cookies and local data for all sites

    1. Select **Settings** > **Privacy and security**.
    1. Expand **Cookies and other site data**.
    1. Make sure that **Block third-party cookies** or **Block all cookies** isn't selected.
    1. If present, remove the following sites from the site-specific cookie configuration under **Sites that can always use cookies** and **Always clear cookies when windows are closed**:
        - `https://make.powerautomate.com`
        - `https://*.make.powerautomate.com`
        - `https://make.*.powerautomate.com`
        - `https://login.microsoftonline.com`

- Option 2: Create exceptions to allow storage of third-party cookies and local data for Power Automate and associated services

    1. Select **Settings** > **Privacy and security**.
    1. Expand **Cookies and other site data**.
    1. Go to **Sites that can always use cookies**, select **Add**, and then add:
        - `[*.]powerautomate.com`
    1. Make sure you select the **Including third-party cookies on this site** option when adding the site.
