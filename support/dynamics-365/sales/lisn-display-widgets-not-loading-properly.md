---
title: LinkedIn Sales Navigator display widgets don't load properly
description: Resolves issues where display widgets show the LinkedIn Sales Navigator subscription not found error or don't load in different web browsers.
author: udaykirang
ms.author: udag
ms.reviewer: sagarwwal
ms.date: 10/18/2024
ms.custom: sap:LinkedIn Sales Navigator\LinkedIn Sales Navigator integration errors
---
# LinkedIn Sales Navigator display widgets don't load properly

This article helps you resolve issues related to LinkedIn Sales Navigator display widgets not loading properly in different web browsers.

## Symptoms

When you try to sign in to [LinkedIn Sales Navigator](/dynamics365/linkedin/integrate-sales-navigator), the display widgets show the following error:

> LinkedIn Sales Navigator subscription not found. You need a LinkedIn Sales Navigator Team contract in order to gain access.  

:::image type="content" source="media/lisn-display-widgets-not-loading-properly/display-widget-subscription-not-found-error.png" alt-text="Screenshot of the subscription not found error in display widgets.":::

Or, the display widgets don't load in different browsers.

:::image type="content" source="media/lisn-display-widgets-not-loading-properly/display-widget-not-loading-error.png" alt-text="Screenshot showing display widgets don't load in a web browser.":::

## Cause

This issue occurs because tracking protection is enabled in the browser.

## Resolution

To resolve the issue, disable tracking protection in your web browser ([Microsoft Edge](#microsoft-edge), [Mozilla Firefox](#mozilla-firefox), [Google Chrome](#google-chrome), or [Apple Safari](#apple-safari)).

### Microsoft Edge

1. In Microsoft Edge, select **Settings and more** in the upper-right corner and go to **Settings**.
1. From the site map, go to **Privacy, search, and services**.
1. In the **Tracking prevention** section, select **Balanced** and turn off the **Always use "Strict" tracking prevention when browsing InPrivate** option.  

    :::image type="content" source="media/lisn-display-widgets-not-loading-properly/edge-select-browser-settings.png" alt-text="Screenshot showing configuring the tracking prevention section in Microsoft Edge.":::

### Mozilla Firefox

1. In Mozilla Firefox, open your organization.
1. Select the shield icon before the address bar to view enhanced tracking protection details.
1. Turn off the **Enhanced tracking protection is ON for the site** option and refresh the browser.  

    :::image type="content" source="media/lisn-display-widgets-not-loading-properly/firefox-select-browser-settings.png" alt-text="Screenshot showing configuring the tracking prevention section in Firefox.":::

1. Refresh the page to ensure the display widgets load as expected.

### Google Chrome

If browsing in incognito mode, turn off the **Block third-party cookies** option to ensure the display widgets load as expected.

:::image type="content" source="media/lisn-display-widgets-not-loading-properly/chrome-select-browser-settings.png" alt-text="Screenshot showing configuring tracking prevention in Chrome.":::

### Apple Safari

1. In Apple Safari, open your organization.
1. Go to **Preferences** and confirm the following configurations:

    - Ensure LinkedIn and your Dynamics 365 organization aren't listed in **Content Blockers**. For more information, see [Change Websites preferences in Safari on Mac](https://support.apple.com/en-in/guide/safari/ibrwe2159f50/16.0/mac/11.0).
    - [Allow pop-up windows for your Dynamics 365 organization](https://support.apple.com/en-sg/guide/safari/sfri40696/mac).
    - Ensure the **Prevent cross-site tracking** and **Block all Cookies** options aren't selected in the **Privacy** tab.  

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]