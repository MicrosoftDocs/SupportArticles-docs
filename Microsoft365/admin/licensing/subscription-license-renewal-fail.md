---
title: Office 365 subscription automatic license renewal fails
description: The intention of this article is to identify an issue where the O365 subscription renewal fails.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: Office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Office 365 ProPlus
- Office 365 Business
- Office 365 Home
---

# Office 365 subscription automatic license renewal fails when sppcext.dll is missing

## Symptoms

When O365 paid subscription tries to renew, the license fails and eventually displays a red bar stating that the subscription is unlicensed.

```adoc
Message 1:Couldn't Verify Subscription

We couldn't verify your Office 365 subscription, so most features of <application> have been disabled. Please make sure your're connected to the internet and restart your application.
```

![error-message](./media/subscription-license-renewal-fail/error-message.jpg)

```adoc
Message 2: Application (Unlicensed Product)
```
![red bar](./media/subscription-license-renewal-fail/red-bar.png)

## Cause

A component of the Windows SPP Service is missing from the computer.  

## Resolution

Run the System File Checker to repair any missing files. Follow the steps in the following article.

[Use the System File Checker tool to repair missing or corrupted system files](https://support.microsoft.com/help/929833)
