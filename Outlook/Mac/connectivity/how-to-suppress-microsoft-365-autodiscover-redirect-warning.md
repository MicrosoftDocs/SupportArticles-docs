---
title: How to suppress Microsoft 365 AutoDiscover redirect warning
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
  - Outlook 2016 for Mac
  - Exchange Online
search.appverid: MET150
ms.date: 01/30/2024
---
# How to suppress the Microsoft 365 `AutoDiscover` redirect warning in Outlook 2016 for Mac

_Original KB number:_ &nbsp; 3206915

## Symptoms

When Microsoft Outlook 2016 for Mac connects to a Microsoft 365 account, `Autodiscover` is redirected from HTTP to HTTPS, and you may receive a warning message that resembles the following example:

> Outlook was redirected to the server `Autodiscover-s.outlook.com` to get new settings for your account `user@domain.com`. Do you want to allow this server to configure your settings?  
> `https://autodiscover-s.outlook.com/autodiscover/autodiscover.xml`  
> Click Allow only if you fully trust the source, or if your Exchange administrator instructs you to.

When this warning message occurs, you may select **Always use my response for this server**, and then select **Allow** in order not to be asked about this specific server again for this Outlook 2016 for Mac profile.

You or administrators may want to suppress the initial warning message. This article contains information about how to do so.

## Resolution

Install the December 13, 2016 update for Outlook 2016 for Mac (version 15.29.0) or a later update, and then follow the steps to configure the Outlook 2016 for Mac Autodiscover redirect warning behavior when you connect to Microsoft 365.

For information about this update or to download the Outlook update package, see:

- [Release notes for Office 2016 for Mac](/officeupdates/release-notes-office-for-mac)
- [Outlook update package](https://officecdn.microsoft.com/pr/c1297a47-86c4-4c1f-97fa-950631f94777/officemac/microsoft_outlook_15.29.16120900_updater.pkg)

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
