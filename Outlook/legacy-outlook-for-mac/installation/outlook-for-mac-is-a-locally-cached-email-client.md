---
title: Outlook for Mac is a locally cached email client
description: We do not recommend changing the default location of your mail identity folder or its contents to an external hard disk or to a network location.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Install, Update, Activate, and Deploy
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tsimon, tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook for Mac is a locally cached email client

_Original KB number:_ &nbsp; 2800895

We do not recommend that you change the default location of your Profile folder for Microsoft Outlook 2016 for Mac, or your Identity folder for Microsoft Outlook for Mac 2011 to an external hard disk or to a network. Additionally, using a mail identity or profile that is located on an external hard disk or on a network is not supported in either version of Outlook for Mac.

## More information

Outlook 2016 for Mac caches your mail items in a profile in your home folder at the following location:

`~/Library/Group Containers/UBF8T346G9.Office/Outlook/Outlook 15 Profiles`

Outlook for Mac 2011 caches your mail items in an identity in your home folder at the following location:

`~/Documents/Microsoft User Data/Office 2011 Identities`

Like Microsoft Entourage for Mac 2008, Outlook 2016 for Mac and Outlook for Mac 2011 are intended to be purely locally cached mail clients. Changing the location or using a mail identity that is located on an external hard disk or a network is not supported.
