---
title: Hybrid pane isn't redirected to Microsoft 365 portal
description: Fixes a disabled cookies error that's triggered when you click hybrid in the Exchange Admin Center on an on-premises server in an Exchange hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-mosha, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# 412 Cookies Are Disabled when you click hybrid in the Exchange admin center

_Original KB number:_ &nbsp; 2888500

## Problem

You are running a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365. When you click **hybrid** in the left navigation pane of the Exchange admin center on the on-premises Exchange 2013 server, you aren't redirected to the Microsoft 365 portal as expected. Instead, you receive an error message that resembles the following:

> 412  
> Cookies Are Disabled :(  
>
> Please make sure that you enabled cookies in your browser settings and that your Exchange Administration Center domain has been added to trusted sites or local intranet zones. Learn more.

## Cause

This issue may occur for one or more of the following reasons:

- Your computer's system date is set too far in the future.
- The cookie file is damaged.
- The option to allow cookies is disabled in the web browser.

## Solution

To resolve this issue, follow these steps:

1. Make sure that the computer's system date and time are set correctly.
2. Clear cookies from the web browser. The steps for doing this vary, depending on the browser that you're using. If you're using Internet Explorer, see [How to delete cookie files in Internet Explorer](https://support.microsoft.com/help/278835).
3. Enable the option to accept cookies. The steps for doing this vary, depending on the browser that you're using. To do this in Internet Explorer, follow these steps:
  
   1. On the **Tools** menu, select **Internet options**, and then select the **Privacy** tab.
   2. Under **Settings**, move the slider to the level that's appropriate for you, and then click **OK**.

   > [!NOTE]
   > Blocking cookies might prevent some pages from being displayed correctly.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
