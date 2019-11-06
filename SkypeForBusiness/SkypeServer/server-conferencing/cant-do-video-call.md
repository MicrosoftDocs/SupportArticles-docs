---
title: Video calls not working with Logitech Brio Webcam
description: You cannot start a Skype for Business video call with a Logitech Brio Webcam with firmware update (version 2.0.12).
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: Ermink, Dougand
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business 2015
- Skype for Business 2016
- Lync 2010
---

# Skype for Business video calls not working with Logitech Brio Webcam

## Symptoms

The firmware update of Logitech Brio Webcam (version**2.0.12**) introduces an additional video steam to enable Windows Hello face authentication. However, you cannot start a Skype for Business video call in a Logitech Brio Webcam because of the additional stream.

**Third-party information disclaimer** 

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.  

## More information

The issue is expected to be fixed by a March 2018 update for Skype for Business on-premises clients (Microsoft Installer [.msi]-based editions). The fix is expected to be in build **16.0.9001.2080** (and later builds) for Click-to-Run editions (see [Determining your Office version](https://blogs.technet.microsoft.com/office_integration__sharepoint/2016/06/23/determining-your-office-version-msi-vs-c2r/)).
