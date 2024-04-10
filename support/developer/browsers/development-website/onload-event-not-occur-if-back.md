---
title: Onload event not occurring if go back to page
description: Describes methods to work around an issue in which the Onload event does not occur when clicking the Back button to return to a previous page in Internet Explorer 11.
ms.date: 03/23/2020
---
# Onload event does not occur when clicking the Back button to a previous page in Internet Explorer 11

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the methods to help you solve the issue that the `Onload` event does not occur when clicking the **Back** button to go back to a page in Internet Explorer 11.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 3011939

## Symptoms

When you click the **Back** button in Internet Explorer 11 to go back to a previous page, the `Onload` event of the page may not occur.

## Cause

This issue occurs because the back navigation caching restores the contents from memory instead of reloading or reconstructing the page.

## Resolution Method 1: Use the onpageshow event

Use the `onpageshow` event instead of the `Onload` event. `Onpageshow` events occur when you click the **Back** button.

## Resolution Method 2: Disable the back navigation caching

Prevent the web pages from meeting any of these conditions, so that back navigation caching does not occur:

- The page is in the Internet zone.
- The page is served by using the HTTP protocol (HTTPS pages are not cached for security reasons).
- The page has no `beforeunload` event handlers defined.
- All load and `pageshow` events are complete.
- The page does not contain any of the following items:
  - Pending indexedDB transactions.
  - Open or active web socket connections.
  - Running web workers.
  - Microsoft ActiveX controls.
- The F12 Developer tools window is not open.

## More information

For more information, see [back navigation caching](/previous-versions/windows/internet-explorer/ie-developer/dev-guides/dn265017(v=vs.85)).
