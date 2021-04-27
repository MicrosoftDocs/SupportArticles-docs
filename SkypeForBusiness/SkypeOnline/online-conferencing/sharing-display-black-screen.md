---
title: Share your desktop displays a black screen in Skype for Business
description: When you use the "Share your desktop" feature after you switch to a second monitor in Windows 7, a Skype for Business user sees only a black screen, not the shared desktop. A workaround is provided.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-swei
appliesto:
- Skype for Business Online
- Windows 7 Professional
- Windows 7 Enterprise
- Windows 7 Home Premium
---

# "Share your desktop" displays a black screen in Skype for Business

## Problem 

Consider the following scenario: 

- On a Windows 7-based computer, you click **Share your desktop**, and then share your primary monitor.   
- While the primary monitor is still being shared, you click **Share your desktop**, and then share a secondary monitor.  
 
In this scenario, a Skype for Business (formerly Lync) user sees only a black screen instead of the shared desktop. 

## Resolution

- To fix this issue in Skype for Business 2016 MSI, install the [January 3, 2017, update for Skype for Business 2016 (KB3128049)](https://support.microsoft.com/help/3128049) or a later update.   
- To fix this issue in Skype for Business 2016 C2R, update the program to build 16.0.7369.2090 or a later build.

## Workaround 

To work around this issue, switch to a secondary monitor. To do this, follow these steps: 

1. Click **Stop Sharing** on the primary monitor.   
2. Click **Share your desktop**, and then select a secondary monitor.    

## More information

This is a known issue in Skype for Business. Microsoft is working to resolve this issue.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).