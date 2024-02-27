---
title: CDO 1.2.1 is not supported with Outlook 2010 and later versions
description: Collaboration Data Objects (CDO) 1.2.1 is not supported with Outlook 2010 and later versions.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Collaboration Data Objects (CDO) 1.2.1 is not supported with Outlook 2010 and later versions

## Summary

Although the Collaboration Data Objects (CDO) 1.2.1 object library could be used with Microsoft Outlook 2010 and later versions, we don't recommend or support this in any way.

> [!IMPORTANT]
> This article applies to using CDO 1.2.1 client-side together with Outlook 2010 and later versions. It does not apply to using CDO 1.2.1 that installs the MAPI subsystem and that is designed for use on a computer without Outlook.

## More information

Collaboration Data Objects (CDO) 1.2.1 is a client library that provides a thin wrapper over Extended MAPI functionality. This library is typically used to add email messaging functionality to custom programs. This library allows those programs to perform functions such as sending email through MAPI, working with calendars, and accessing various data in Microsoft Outlook or in Microsoft Exchange.

Microsoft Outlook 2010 and later versions include many architectural changes to the client-side MAPI subsystem. Of particular concern are scenarios in which Outlook is configured to use multiple Exchange accounts. Also, CDO 1.2.1 is a 32-bit client library and will not operate with 64-bit versions of Outlook. Given all these factors, CDO 1.2.1 isn't supported for use with Outlook 2010 or later versions, and we don't recommend its use with Outlook 2010 and later versions.

Programs that use CDO should be redesigned to use other Application Programming Interfaces (APIs) instead of CDO. Starting with Outlook 2007, the Outlook object model was greatly expanded to provide functionality that was previously available only by using CDO 1.2.1. The Outlook 2010 and later versions object model includes some new features to expand on this more. For example, the Outlook object model has new functionality to operate correctly with multiple Exchange accounts. The Outlook object model also works for both 32-bit and 64-bit versions of Outlook. Developers should use the Outlook 2010 and later object model instead of CDO 1.2.1. Also, developers can still use Extended MAPI (which requires unmanaged C++) in some scenarios where CDO was required. However, if it's possible, we generally recommend that the Outlook object model is used instead of Extended MAPI.

Microsoft product support can help developer customers migrate custom programs from using CDO 1.2.1 to using other APIs. However, Microsoft will not provide support for any scenarios in which CDO 1.2.1 is used with Outlook 2010 or Outlook 2013.
