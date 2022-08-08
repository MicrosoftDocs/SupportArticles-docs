---
title: Microsoft Teams Rooms can't open PowerPoint presentations after disabling TLS 1.0 and TLS 1.1 in Skype for Business Server 2019 and Skype for Business Server 2015
description: Describes an issue in which Microsoft Teams Rooms displays an error message when opening PowerPoint presentations after disabling TLS 1.0 and TLS 1.1.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 117306
  - CSSTroubleshoot
ms.reviewer: nichburk
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 3/31/2022
---

# Microsoft Teams Rooms can't open PowerPoint presentations after disabling TLS 1.0 and TLS 1.1 in Skype for Business Server 2019 and Skype for Business Server 2015

## Symptoms

When another user shares a PowerPoint presentation, you receive this error message on the Microsoft Teams Rooms device:

> "We can't connect to the server for sharing right now."

## Cause

Microsoft Teams Rooms (formerly called Skype Room System v2) devices running versions 4.0.64.0 to 4.3.42.0 (inclusively) still use TLS 1.0 to send a Client Hello to the Front-End Web Conferencing Service. If TLS 1.0 and TLS 1.1 are disabled on the Skype for Business Server 2015 or 2019, the TLS handshake will fail.

## Resolution

Install the March 31, 2020 update for Microsoft Teams Rooms version 4.4.25.0.

## More information

- [Disable TLS 1.0/1.1 in Skype for Business Server 2015](/skypeforbusiness/manage/topology/disable-tls-1.0-1.1)
- [Disable TLS 1.0/1.1 in Skype for Business Server 2015: Part 1](https://techcommunity.microsoft.com/t5/skype-for-business-blog/disabling-tls-1-0-1-1-in-skype-for-business-server-2015-part-1/ba-p/621485)
- [Disable TLS 1.0/1.1 in Skype for Business Server 2015: Part 2](https://techcommunity.microsoft.com/t5/skype-for-business-blog/disabling-tls-1-0-1-1-in-skype-for-business-server-2015-8211/ba-p/621487)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
