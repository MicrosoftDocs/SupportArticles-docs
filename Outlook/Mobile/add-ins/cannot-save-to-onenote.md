---
title: Can't use Save to OneNote add-in to save items from Outlook for iOS
description: Describes an issue where you can't use the Save to OneNote button to save items from Outlook for iOS to OneNote.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Outlook for iOS and Android
- CSSTroubleshoot
- CI 154609
ms.reviewer: meerak; mhaque; subhbasu
appliesto:
- Outlook for iOS
- OneNote for iPhone
search.appverid: MET150
---

# "You cannot access this right now" error when saving items from Outlook for iOS to OneNote

On an Intune-managed iOS device, when you use the **Save to OneNote** Agave add-in to save items from Microsoft Outlook for iOS to OneNote, you receive the following error message:

> You cannot access this right now

This error occurs because the add-in isn't able to complete device authentication to satisfy the requirements of conditional access. Because the add-in uses Agave, authentication doesn't work when conditional policies are in place. Consequently, [WebView](https://developer.apple.com/documentation/webkit/webview) between Outlook and OneNote breaks.

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
