---
title: Can't use Send to OneNote add-in to save items from Outlook for iOS
description: Describes an issue in which you can't use the Send to OneNote button to save items from Outlook for iOS to OneNote.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data protection and Security\
  - Outlook for iOS and Android
  - CSSTroubleshoot
  - CI 154609
ms.reviewer: meerak, mhaque, subhbasu, v-chazhang
appliesto: 
  - Outlook for iOS
  - OneNote for iPhone
search.appverid: MET150
ms.date: 01/30/2024
---

# "You cannot access this right now" error when saving items from Outlook for iOS to OneNote

On an Intune-managed iOS device, when you use the **Send to OneNote** add-in to save items from Microsoft Outlook for iOS to OneNote, you receive the following error message:

> You cannot access this right now

This error occurs because the add-in can't complete device authentication to satisfy the requirements of conditional access. Because the add-in uses the new Office add-in platform that is HTML and JavaScript-based, authentication doesn't work if conditional policies are used. Therefore, [WebView](https://developer.apple.com/documentation/webkit/webview) between Outlook and OneNote fails.

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
