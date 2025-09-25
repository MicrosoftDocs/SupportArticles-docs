---
title: Suppress the Microsoft 365 AutoDiscover redirect warning in Outlook for Mac
description: Describes an issue in which you receive an error message when Microsoft Outlook 2016 for Mac connects to a Microsoft 365 account. This article contains information about how to suppress Microsoft 365 AutoDiscover redirect warning.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Connectivity
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - New Outlook for Mac
  - Legacy Outlook for Mac
  - Exchange Online
search.appverid: MET150
ms.date: 05/21/2025
---
# Suppress the Microsoft 365 AutoDiscover redirect warning in Outlook for Mac

_Original KB number:_ &nbsp; 3206915

## Symptoms

When Microsoft Outlook for Mac connects to a Microsoft 365 account, the Autodiscover service is redirected from HTTP to HTTPS, and you might receive a warning message that resembles the following example:

> Outlook was redirected to the server `Autodiscover-s.outlook.com` to get new settings for your account `user@domain.com`. Do you want to allow this server to configure your settings?  
> `https://autodiscover-s.outlook.com/autodiscover/autodiscover.xml`  
> Click Allow only if you fully trust the source, or if your Exchange administrator instructs you to.

When this warning message displays, you can select **Always use my response for this server**, and then select **Allow** to not be asked about this specific server again for the current Outlook for Mac profile.

## Resolution

If you want to suppress the initial warning message, use the following steps.

1. Quit Outlook if it's running.
2. Open **Terminal** using one of the following methods:

   - With **Finder** as the selected application, on the **Go** menu select **Utilities**, and then double-click **Terminal**.
   - In Spotlight Search, type *Terminal*, and then double-click **Terminal** from the search results.

3. Enter the following command in the **Terminal** window, and then press Enter.

    ```console
    defaults write com.microsoft.Outlook TrustO365AutodiscoverRedirect -bool true
    ```

4. On the **Terminal** menu, select **Quit Terminal**.

## More information

The `TrustO365AutodiscoverRedirect` preference can be configured to use the following values:

|Boolean Setting value|Description|
|---|---|
|true|Don't prompt for trusted Microsoft 365 endpoints. Outlook defines what URLs are trusted and it isn't configurable.|
|false|Outlook uses the default behavior that is to prompt when `Autodiscover` Redirects occur.|
|if value isn't present|Outlook uses the default behavior that is to prompt when `Autodiscover` Redirects occur.|
