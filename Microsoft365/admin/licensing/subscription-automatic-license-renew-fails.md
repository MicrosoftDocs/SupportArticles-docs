---
title: Microsoft 365 subscription automatic license renewal fails when heartbeatcache in wrong location
description: The intention of this article is to identify reasons why paid subscriptions are not auto renewing as expected.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 03/31/2022
---

# Microsoft 365 subscription automatic license renewal fails when heartbeatcache is in wrong location

## Symptoms

When O365 paid subscription tries to renew, the license fails and eventually displays a red bar stating that the subscription is unlicensed.

Message 1: Couldn't Verify Subscription

We couldn't verify your Microsoft 365 subscription, so most features of \<application\> have been disabled. Please make sure you're connected to the internet and restart your application.

:::image type="content" source="media/subscription-automatic-license-renew-fails/product-info.png" alt-text="Screenshot shows the message of Couldn't Verify Subscription.":::

Message 2: Application (Unlicensed Product)

:::image type="content" source="media/subscription-automatic-license-renew-fails/unlicensed-product.png" alt-text="Screenshot shows the message of Application Unlicensed Product." border="false":::

## Cause

The HeartbeatCache.xml file is located in the wrong folder.

## Resolution

To resolve this issue, delete the heartbeatcache.xml file using the following steps.

1. Exit all Office applications.

2. Browse to "C:\Program Files\Microsoft Office 15\root\vfs\Common AppData\microsoft\office\Heartbeat\"

3. Delete the HeartbeatCache.xml file

4. Launch one of the Office Applications and the file will be automatically placed the expected native folder location.
