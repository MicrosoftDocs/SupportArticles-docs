---
title: Blocked a frame with origin when using Unified Interface apps
description: Works around the Blocked a frame with origin error when you use Unified Interface apps in Google Chrome or Android.
ms.reviewer: xianc
ms.custom: sap:Running model-driven app forms
ms.date: 08/09/2021
author: xianc0908
ms.author: xianc
---
# "Blocked a frame with origin" error using Unified Interface apps

_Applies to:_ &nbsp; Power Apps

## Symptoms

When you use Unified Interface apps in the Google Chrome browser or Google Android, you receive the following error message:

> Blocked a frame with origin "`https://<Site Name>.dynamics.com`" from accessing a cross-origin frame.

## Cause

It's a known issue that occurs in older versions of the Chrome browser and Chrome WebView.

## Workaround

To work around this issue, [update the Chrome browser](https://support.google.com/chrome/answer/95414).

### Get a Chrome update on the computer

Typically, updates are installed in the background when you close and reopen a web browser. You can also manually check for an update for Chrome:

1. On your computer, open Chrome.
1. At the top right, select **More**.
1. Select **Help** > **About Google Chrome**.
1. To apply any available updates, select **Relaunch**.

The current version number is shown beneath the "Google Chrome" heading. Chrome will check for updates when you're on this page.

### Get a Chrome update in Android

Chrome should automatically update your Android-based device based on your Play Store settings. You can check whether a newer version is available:

1. On your Android phone or tablet, open the Play Store app.
1. At the top right, tap the profile icon.
1. Tap **Manage apps & device**.
1. Under **Updates available**, locate **Chrome**.
1. Next to **Chrome**, tap **Update**.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
