---
title: App titles have an x in the lower-right corner
description: Provides a solution to an issue in which the titles for Windows 8 and Windows 8.1 apps have an x in the lower-right corner.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:desktop-shell, csstroubleshoot
---
# Windows 8 and Windows 8.1 app titles have an "x" in the lower-right corner

This article provides a solution to an issue where the titles for Windows 8 and Windows 8.1 apps have an "x" in the lower-right corner.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2832072

## Symptoms

After you boot your computer to the Windows 8 or Windows 8.1 Start screen, you may find that some or all of the Windows 8 and 8.1 app titles have an "x" in the lower-right corner. When you click one of the app titles to start the app, you receive the following message:

> This app can't open  
>
> Check the Microsoft Store for more info about \<*AppName*>.  
Go to the Store

## Cause

This behavior may be caused by an error that occurred when an app package was first installed or injected into the Windows 8 or Windows 8.1 image. Or, it may be caused by out-of-date software.

## Resolution

This issue may be resolved by just waiting several minutes, as the issue may be fixed by Windows.

If the issue is not resolved after several minutes, first try checking for Windows updates, as updating Windows may fix the problem. To check for updates, follow these steps:

1. Open Windows Update by swiping in from the right edge of the screen (or, if you're using a mouse, point to the lower-right corner of the screen and move up the mouse pointer), tapping or clicking **Settings**, tapping or clicking **Change PC settings**, and then tapping or clicking **Update and recovery**.
2. Tap or click **Check now**, and then wait while Windows searches for the latest updates for your computer.
3. If updates are found, tap or click **Install updates**.
4. Read and accept the license terms, and then tap or click **Finish** if the update requires it.

If updating Windows does not work, you may be able to resolve this issue by either installing a new app from the Microsoft Store or by reinstalling or updating existing apps. Doing this may update or fix a dependency that multiple apps rely on.

If this does not resolve the issue, you may have to contact the original equipment manufacturer (OEM) that you purchased the computer from. Or, contact Microsoft Support.

## More information

If you are the individual or engineer who creates the Windows image, you may want to closely monitor the injection of app packages to look for errors or messages that indicate that there was a failure.

This issue may also occur after you perform a refresh of the system by using the push-button reset features.
