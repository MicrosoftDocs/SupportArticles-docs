---
title: LinkedIn Sales Navigator display widgets don't load properly
description: Resolves the LinkedIn Sales Navigator subscription not found error or display widgets don't load in different web browsers in Microsoft Dynamics 365 Sales.
author: udaykirang
ms.author: udag
ms.reviewer: sagarwwal
ms.date: 10/15/2024
ms.custom: sap:LinkedIn Sales Navigator\LinkedIn Sales Navigator integration errors
---
# LinkedIn Sales Navigator display widgets don't load properly

This article resolves issues related to LinkedIn Sales Navigator display widgets not loading properly in different web browsers in Microsoft Dynamics 365 Sales.

## Symptoms

When you try to sign in to [LinkedIn Sales Navigator](/dynamics365/linkedin/integrate-sales-navigator), the display widgets show the following error.

> LinkedIn Sales Navigator subscription not found. You need a LinkedIn Sales Navigator Team contract in order to gain access.  

:::image type="content" source="media/lisn-display-widgets-not-loading-properly/display-widget-subscription-not-found-error.png" alt-text="Screenshot of display widgets show subscription not found error." lightbox="media/lisn-display-widgets-not-loading-properly/display-widget-subscription-not-found-error.png":::

Or, the display widgets don't load in different browsers.

:::image type="content" source="media/lisn-display-widgets-not-loading-properly/display-widget-not-loading-error.png" alt-text="Screenshot of display widgets don't load in the web browser.":::

## Cause

This issue occurs because the tracking protection is enabled in the browser.

## Resolution

To resolve the issue, disable the tracking protection in your web browser ([Microsoft Edge](#microsoft-edge), [Mozilla FireFox](#mozilla-firefox), [Google Chrome](#google-chrome), and [Apple Safari](#apple-safari)).

#### Microsoft Edge

1. In Microsoft Edge, select **Settings and more** in the upper-right corner and go to **Settings**.
1. From the site map, go to **Privacy, search, and services**.
1. In the **Tracking prevention** section, select **Balanced** and disable the **Always use "Strict" tracking prevention when browsing InPrivate** option.  

    :::image type="content" source="media/lisn-display-widgets-not-loading-properly/edge-select-browser-settings.png" alt-text="Screenshot of configuring track prevention section in edge.":::

#### Mozilla FireFox

1. In Mozilla FireFox, open your organization.
1. Select the shield icon before the address bar to view enhanced tracking protection details.
1. Disable the **Enhanced tracking protection is ON for the site** option and refresh the browser.  

    :::image type="content" source="media/lisn-display-widgets-not-loading-properly/firefox-select-browser-settings.png" alt-text="Screenshot of configuring track prevention section in firefox.":::

1. Refresh the page to ensure the display widgets load as expected.

#### Google Chrome

If browsing in Incognito mode, disable the **Block third-party cookies** option to ensure the display widgets load as expected.

:::image type="content" source="media/lisn-display-widgets-not-loading-properly/chrome-select-browser-settings.png" alt-text="Screenshot of configuring track prevention section in chrome.":::

#### Apple Safari

1. In Apple Safari, open your organization.
1. Go to **Preferences** and check the following configurations:

    - Ensure LinkedIn and your Dynamics 365 organization aren't listed in the **Content Blockers**. For more information, see [Change Websites preferences in Safari on Mac](https://support.apple.com/en-in/guide/safari/ibrwe2159f50/16.0/mac/11.0).
    - [Allow pop-up windows for your Dynamics 365 organization](https://support.apple.com/en-sg/guide/safari/sfri40696/mac).
    - Ensure the **Prevent cross-site tracking** and **Block all Cookies** options aren't selected in the **Privacy** tab.  
