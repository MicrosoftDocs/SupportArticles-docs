---
title: Cookies or pop-up blocker errors when accessing Unified Interface apps
description: Resolves the cookies or pop-up blockers errors when accessing Unified Interface apps.
ms.reviewer: rashb
ms.topic: troubleshooting
ms.date: 10/19/2021
ms.author: rashb
---
# Third-party cookies or pop-up blocker errors when accessing Unified Interface apps in a web browser

_Applies to:_ &nbsp; Power Apps

## Symptoms

When you access Unified Interface apps in a web browser, you receive one of the following error messages about cookies and pop-up blockers:

- > Something has gone wrong. Check technical details for more details.  
  > Technical Details  
  > Session Id: \<Session ID\>  
  > Activity Id: \<Activity ID\>  
  > Timestamp: \<Date Time\> GMT-0700 (Pacific Daylight Time)  
  > {"errorInfo":{"code":"UserInterventionNeeded_CookiesBlocked", "localizedMessage":"Power Apps requires cookies to be enabled. Please enable them in your browser.","timestamp":\<Time Stamp\>,"description":"Power Apps requires cookies to be enabled. Please enable them in your browser."}}
  > No stack available.

- > A \<Server Name\> window was unable to open, and may have been blocked by a pop-up blocker. Please add this \<Server Name\> server to the list of sites your pop-up blocker allows to open new windows.

## Cause

These issues occur because third-party cookies are blocked in the web browser.

## Resolution

To check what browser you are using and the browser settings, go to [WhatIsMyBrowser](https://www.whatismybrowser.com/). Then, enable third-party cookies, and make sure that the related sites are not blocked for cookies. For instructions for web browsers and iOS devices, see [troubleshooting startup issues for Power Apps](/powerapps/troubleshooting-startup-issues#enable-storage-of-third-party-cookies-and-local-data-in-your-browser-or-app).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
