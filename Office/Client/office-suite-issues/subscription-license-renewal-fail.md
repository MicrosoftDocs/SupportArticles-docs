---
title: Microsoft 365 subscription automatic license renewal fails
description: The intention of this article is to identify an issue where the O365 subscription renewal fails.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Microsoft 365 Apps
  - Microsoft 365 Family
ms.date: 05/29/2025
---

# Microsoft 365 subscription automatic license renewal fails when sppcext.dll is missing

## Symptoms

When Microsoft 365 paid subscription tries to renew, the license fails and eventually displays a red bar stating that the subscription is unlicensed.

```adoc
Message 1:Couldn't Verify Subscription

We couldn't verify your Office 365 subscription, so most features of <application> have been disabled. Please make sure your're connected to the internet and restart your application.
```

:::image type="content" source="media/subscription-license-renewal-fail/product-information.png" alt-text="Screenshot shows the message of Couldn't Verify Subscription.":::

```adoc
Message 2: Application (Unlicensed Product)
```
:::image type="content" source="media/subscription-license-renewal-fail/red-bar.png" alt-text="Screenshot shows the message of Application Unlicensed Product." border="false":::

## Cause

A component of the Windows SPP Service is missing from the computer.  

## Resolution

Run the System File Checker to repair any missing files. Follow the steps in the following article.

[Use the System File Checker tool to repair missing or corrupted system files](https://support.microsoft.com/help/929833)
