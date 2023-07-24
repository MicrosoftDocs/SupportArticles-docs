---
title: Windows Update repeatedly offers the same update
description: Describes how to troubleshoot the problem where you are repeatedly offered the same update in Windows Update or Microsoft Update.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-client-deployment
---
# Windows Update or Microsoft Update repeatedly offers the same update

This article describes how to troubleshoot a problem where you are repeatedly offered the same update in Windows Update or Microsoft Update.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 910339

## Cause

This may happen if the update isn't installed correctly the first time, or if your Windows Update settings can't detect the update.

## Resolution

If you keep seeing the same update being offered for installation, try to install the update later.

You may also want to check your update history to see whether there are any error messages. Then, you can search for any errors that you find by going to the [Microsoft Support](https://support.microsoft.com).

To check your update history, follow these steps.

- For Windows 8

    1. Swipe in from the right side to view the charms, tap or click **Search**, and then type *View Update History*.
    2. Tap or click **Settings**, and then select **View update history**.
    3. Tap or click **Status** to sort by status, and then look for any updates that have a status of **Failed**.
    4. Tap-and-hold or right-click an update that has a status of **Failed**, and then select **View Details**. The window that opens displays the error code for that update.

- For Windows 7, Windows Vista, and Windows XP

    1. Start Windows Update. To do this, click **Start**, type *Update* in the search box, and then, in the list of results, click **Windows Update**.
    2. In the navigation pane, click **View update history**.
    3. Click **Status** to sort by status, and then look for any updates that have a status of **Failed**.
    4. Right-click an update that has a status of **Failed**, and then select **View Details**. The window that opens displays the error code for that update. If this problem persists, post this issue to the [Microsoft Communities](https://answers.microsoft.com/?auth=1).

    You can also check the [telephone number to contact Microsoft Support](https://support.microsoft.com/contactus/) for help. Charges may apply.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
