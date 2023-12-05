---
title: Troubleshoot startup or sign-in issues for Power Apps
description: Provides resolutions for the common configuration issues that prevent Power Apps from starting.
author: amchern
ms.author: amchern
ms.reviewer: tapanm, mkaur, alaug
ms.custom: canvas
ms.date: 11/30/2023
search.audienceType: 
  - maker
search.app: 
  - PowerApps
---
# Troubleshooting startup or sign-in issues for Power Apps

This article helps you resolve some of the common issues that may occur when starting up or signing in to [Power Apps](https://make.powerapps.com).

## Common errors

The following are some common errors that may appear when you start up or sign in to Power Apps.

- You're prompted to sign in every time an app is embedded in another client such as SharePoint and Microsoft Teams.

  > The Power Apps open experience starts and halts until you sign-in

- Error message related to cookie settings.

    > Hmmm... Something went wrong.  
    > thirdPartyCookiesBlocked  
    > Please enable third party-cookies and site data in your browser settings. If you are using Chrome's Incognito mode, you can uncheck the 'Block third-party cookies' option on the Incognito landing page.  
    > Try again

- "Sign in required" message when signing in to Power Apps, especially in InPrivate or incognito mode.

    > Sign in required  
    > Please select sign in to continue.  
    > Session ID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    >
    > AADSTS50058: A silent sign-in request was sent but no user is signed in. The cookies used to represent the user's session were not sent in the request to Microsoft Entra ID. This can happen if the user is using Internet Explorer or Edge, and the web app sending the silent sign-in request is in different IE security zone than the Microsoft Entra endpoint (login.microsoftonline.com).  
    > Trace ID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  
    > Correlation ID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  
    > Timestamp: xxxx-xx-xx xx:xx:xxZ

- "Hmmm … We couldn't sign you in" message.

    :::image type="content" source="media/troubleshooting-startup-issues/we-could-not-sign-you-in-error.png" alt-text="Screenshot that shows a We couldn't sign you in error message.":::

- "WebAuthoring abnormal termination" message.

    > WebAuthoring abnormal termination.
    >
    > Client date/time: \<Client Time>Thh:mm:ss.sssZ  
    > Version: 2.0.602  
    > Session ID: xxxx-xxxxx-xxxxxxx--xxxxxxxx  
    > description: {"error":{"detail":{"exception":{}},"colno":0,"filename":"<`https://paaeuscdn.azureedge.net/v2.0.602.0/studio/openSource/modified/winjs/js/base.js?v=39de0f2edf1`>...",  
    > "lineno":0,"message":"Script error","initErrorEvent":"[function]","bubbles":false,"cancelBubble":false,"cancelable":false,"currentTarget":"[window]", "defaultPrevented":true,  
    > "eventPhase":2,"isTrusted":true,"srcElement":"[window]","target":"[window]","timeStamp":1490711965955,"type":"error","initEvent":"[function]","preventDefault":"  [function]",  
    > "stopImmediatePropagation":"[function]","stopPropagation":"[function]","AT_TARGET":2,"BUBBLING_PHASE":3,"CAPTURING_PHASE":1},"errorLine":0,"errorCharacter":0,  
    > "errorUrl":"<`https://paaeuscdn.azureedge.net/v2.0.602.0/studio/openSource/modified/winjs/js/base.js?v=39de0f2edf1`>... error","setPromise":"[function]","exception":{}}  
    > stack: null  
    > errorNumber: 0  
    > errorMessage: Script error

- UserInterventionNeeded_CookiesBlocked
- UserInterventionNeeded_StorageBlocked
- UserInterventionNeeded_NavigateToAadTimeout
- UserInterventionNeeded_NavigateToAadDenied
- UserInterventionNeeded_StorageLost
- AadError

## Resolution

Try the following steps to resolve the issue:

1. [Enable third-party cookies and local data in your browser or app](#enable-storage-of-third-party-cookies-and-local-data-in-your-browser-or-app).
2. Cached data can sometimes prevent you from signing in. [Clear your browser's cache](#clear-your-browser-cache) and cookies and try again.
3. Try signing in with a different browser. For a list of supported browsers, see [system requirements](/power-apps/limits-and-config#supported-browsers-for-running-power-apps).
4. Check your network connection to make sure it's stable.
5. If you're getting Microsoft Entra errors, they're usually related to user authentication and authorization. The error page might contain additional information that can help diagnose and fix the problem. To resolve Microsoft Entra errors, you might need assistance from your IT department.

## Enable storage of third-party cookies and local data in your browser or app

Power Apps stores some data locally, such as user identity and preferences, leveraging your browser's capabilities. Problems occur if the browser blocks the storage of such local data, or third-party cookies set by Power Apps.

Most browsers allow settings to reflect the changes immediately. You may also need to close all the browser windows and reopen them instead.

To enable this setting for the Power Apps and Dynamics 365 mobile apps for iOS, you need to work through the iOS settings linked to the app rather than through the browser settings for iOS.

These instructions are shown on the following tabs.

### [Microsoft Edge](#tab/microsoft-edge)

- Option 1: Enable storage of third-party cookies and local data for all sites

    1. Select **Settings** > **Cookies and site permissions**.
    1. Expand **Cookies and data stored**.
    1. Ensure the **Block third-party cookies** setting is disabled.
    1. If present, remove the following sites from the site-specific cookie configuration under **Block** and **Clear on exit**:
        - `https://create.powerapps.com`
        - `https://*.create.powerapps.com`
        - `https://make.*.powerapps.com`
        - `https://make.powerapps.com`
        - `https://login.microsoftonline.com`
        - `https://apps.*.powerapps.com`
        - `https://apps.powerapps.com`
        - (Only for sovereign clouds) [US Government version URLs](/power-platform/admin/powerapps-us-government#power-apps-us-government-service-urls).

- Option 2: Create exceptions to allow the storage of third-party cookies and local data for Power Apps and associated services

    > [!NOTE]
    > The following steps require your Edge browser version to be 87 or above.

    1. Select **Settings** > **Cookies and site permissions**.
    1. Expand **Cookies and data stored**.
    1. Select **Add** under **Allow** and add:
        - `[*.]powerapps.com`
    1. Select **Clear browsing data on close**.
    1. Ensure **Cookies and other site data** is disabled. If you want to keep it enabled, select **Add** instead, and then add:
        - `[*.]powerapps.com`

### [Google Chrome](#tab/google-chrome)

- Option 1: Enable storage of third-party cookies and local data for all sites

    1. Select **Settings** > **Privacy and security**.
    1. Expand **Cookies and other site data**.
    1. Make sure that **Block third-party cookies** or **Block all cookies** isn't selected.
    1. If present, remove the following sites from the site-specific cookie configuration under **Sites that can always use cookies** and **Always clear cookies when windows are closed**:
        - `https://create.powerapps.com`
        - `https://*.create.powerapps.com`
        - `https://make.*.powerapps.com`
        - `https://make.powerapps.com`
        - `https://login.microsoftonline.com`
        - `https://apps.*.powerapps.com`
        - `https://apps.powerapps.com`
        - (Only for sovereign clouds) [US Government version URLs](/power-platform/admin/powerapps-us-government#power-apps-us-government-service-urls).

- Option 2: Create exceptions to allow storage of third-party cookies and local data for Power Apps and associated services

    1. Select **Settings** > **Privacy and security**.
    1. Expand **Cookies and other site data**.
    1. Go to **Sites that can always use cookies**, select **Add**, and then add:
        - `[*.]powerapps.com`
    1. Make sure you select the **Including third-party cookies on this site** option when adding the site.

### [Safari (iOS)](#tab/safari-ios)

1. In Safari app, select **Safari** > **Preferences** > **Privacy**.
1. Ensure **Block all cookies** isn't selected.
1. Ensure **Prevent cross-site tracking** isn't selected.

### [iOS Settings](#tab/ios-settings)

- Instructions for Dynamics 365 for phones or Dynamics 365 for tablets app on iOS

  1. On iOS, select **Settings**.
  1. Scroll down to **Dynamics 365**.
  1. Toggle on **Allow Cross-Website Tracking**.

- Instructions for Power Apps app on iOS

  1. On iOS, select **Settings**.
  1. Scroll down to **Power Apps**.
  1. Toggle on **Allow Cross-Website Tracking**.

- Instructions for Microsoft Edge on iOS

  1. On iOS, select **Settings**.
  1. Scroll down to **Edge**.
  1. Toggle on **Allow Cross-Website Tracking**.

### [Mozilla Firefox](#tab/mozilla-firefox)

To allow apps to use cookies when they're embedded in another client, such as SharePoint, follow these steps:

1. Navigate to **Settings** and select **Privacy & security**.
2. Look for **Enhanced Tracking Protection** and select **Manage Exceptions**.
3. Add the URL of the website where the apps are embedded. For example, if the apps are embedded in SharePoint, you need to add the SharePoint URL to the exceptions list. This will allow the embedded apps to use cookies.

---

## Clear your browser cache

The browser cache is stored on your device's hard drive. When you visit a website, your browser downloads certain information that allows it to load faster when you revisit the same website in the future. Some Power Apps features use the browser cache to provide a faster user experience. In some cases, you may want to clear your browser cache. Here are the instructions for different browsers:

- [Microsoft Edge](https://www.microsoft.com/en-US/microsoft-365-life-hacks/privacy-and-safety/how-to-clear-cache)
- [Google Chrome](https://support.google.com/accounts/answer/32050?hl=en&co=GENIE.Platform%3DDesktop)
- [Safari on Mac](https://support.apple.com/guide/safari/manage-cookies-and-website-data-sfri11471/16.0/mac/11.0)

## Next steps

If your issue isn't listed in this article, you can [search for more support resources](https://powerapps.microsoft.com/support) or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support). For more information, see [Get Help + Support](/power-platform/admin/get-help-support).
