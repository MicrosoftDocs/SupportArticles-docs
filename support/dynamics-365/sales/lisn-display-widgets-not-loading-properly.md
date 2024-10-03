---
title: LinkedIn Sales Navigator display widgets are not loading properly
description: Learn how to troubleshoot and resolve issues related to LinkedIn Sales Navigator display widgets not loading properly in different web browsers.
author: udaykirang
ms.author: udag
ms.reviewer: udag
ms.topic: troubleshooting
ms.collection: 
ms.date: 10/03/2024
ms.custom: bap-template 
---

# LinkedIn Sales Navigator display widgets are not loading properly

This article helps you troubleshoot and resolve issues related to LinkedIn Sales Navigator display widgets not loading properly in different web browsers.

## Symptoms

When I try to sign in to LinkedIn Sales Navigator, errors are displayed. These errors occur due to the enablement of track protection in the browser. The following are the errors:

- Display widgets are showing the error&mdash;*LinkedIn Sales Navigator subscription not found. You need a LinkedIn Sales Navigator Team contract in order to gain access*.  

    :::image type="content" source="media/linkedin/display-widget-subscription-not-found-error.png" alt-text="Screenshot of display widgets show subscription not found error.":::

-OR-  

- Display widgets are not loading on different browsers. The error is displayed as shown in the following sample image:  

    :::image type="content" source="media/linkedin/display-widget-not-loading-error.png" alt-text="Screenshot of display widgets are not loading.":::

## Resolution

To resolve this issue, you must disable the track protection in the browser ([Microsoft Edge](#microsoft-edge), [Mozilla FireFox](#mozilla-firefox), [Google Chrome](#google-chrome), and [Apple Safari](#apple-safari)). 

**Microsoft Edge**:<a name='microsoft-edge'></a>  

1. Open the Microsoft Edge browser.  
1. Select the **More options** icon on the top-right and go to **Settings**.  
1. From the site map, go to **Privacy, search, and services**.  
1. In the **Tracking Prevention** section, select **Balanced** and disable the **Always use “Strict” tracking prevention when browsing InPrivate** option.  

    :::image type="content" source="media/linkedin/edge-select-browser-settings.png" alt-text="Screenshot of configuring track prevention section in edge.":::

**Mozilla FireFox**:<a name='mozilla-firefox'></a>  

1. Open the Mozilla FireFox browse and open your organization.  
1. Before the address bar, select the shield icon and the Enhanced tracking protection details appears.  
1. Disable the **Enhanced tracking protection is ON for the site** option and refresh the browser.  

    :::image type="content" source="media/linkedin/firefox-select-browser-settings.png" alt-text="Screenshot of configuring track prevention section in firefox.":::

1. Refresh the page and the display widgets start loading as expected.

**Google Chrome**:<a name='google-chrome'></a>  

In the Chrome browser, the display widgets loading issue could occur in Incognito/Private mode.  
While browsing the org in Incognito/Private mode, disable the **Block third-party cookies** option. The display widgets load as expected.  

:::image type="content" source="media/linkedin/chrome-select-browser-settings.png" alt-text="Screenshot of configuring track prevention section in chrome.":::

**Apple Safari**:<a name='apple-safari'></a>

1. Open the Apple Safari browse and open your organization.
1. Go to **Preferences** and configure the following options:

    - LinkedIn and your Dynamics 365 organization is not present in the block list of **Content Blockers**.  
    - Your Dynamics 365 organization allows pop-up windows.  
    - In **Privacy** tab, the **Prevent cross-site tracking** and **Block all Cookies** options are not selected.  
