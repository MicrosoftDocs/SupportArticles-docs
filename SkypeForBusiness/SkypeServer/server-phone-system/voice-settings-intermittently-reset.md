---
title: Voice settings are intermittently reset
description: Describes an issue in which Voice Settings is intermittently reset to VoIP always in Skype for Business for iOS and Skype for Business for Android.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Server 2015
  - Skype for Business for iOS
  - Skype for Business for Android
ms.date: 03/31/2022
---

# Voice settings are intermittently reset in Skype for Business app

## Symptoms

Consider the following scenario: 
- You are enabled for Enterprise Voice.    
- You use the Skype for Business app on an iOS-based or Android-based mobile phone.    
- You set **Voice Settings** to **Cellular** or **VoIP over Wi-Fi only**.    
 
In this scenario, when you join a Skype for Business meeting, the **Voice Settings** value is intermittently reset to **VoIP always**. 

## Cause

The issue occurs because the user isn't recognized as enabled for Enterprise Voice under some conditions. 

## Resolution

To fix this issue, install the [July 2018 cumulative update 6.0.9319.534 for Skype for Business Server 2015, Web Components Server](https://support.microsoft.com/help/4340906).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
