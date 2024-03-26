---
title: Error 12029 We cannot connect you to this meeting in Skype for Business 2016 or 2015
description: Discusses a problem in which you receive an 12029 error message and you cannot connect to a meeting in Skype for Business 2016 or 2015.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2016
  - Skype for Business 2015
ms.date: 03/31/2022
---

# Error 12029: "We couldn't connect you to this meeting" in Skype for Business 2016 or 2015

## Symptoms

A Microsoft Skype for Business 2016 or 2015 session that's running on Windows 7 fails to join a Federated meeting with a partner who is running Skype for Business Server on-premises. 

When this problem occurs, you receive the following error message:

**We couldn't connect you to this meeting because of a network problem. Please try again. If the problem continues, contact your support team.**     

If you select **Show Details**, the message window shows error code **12029**. 

> [!NOTE]
> This problem affects both the MSI and C2R versions of Skype for Business 2016 and Skype for Business 2015 

## Cause

This problem occurs because Windows 7 is not configured to support the TLS 1.2 protocol, and the Federated partner disabled support for TLS 1.0 and 1.1 in their on-premises environment.  

Error "12029" is a WinHTTP error code that indicates that a socket connection failed because encrypted communication could not be established. 

## Resolution

To resolve this problem, enable TLS 1.2 support on Windows 7. To do this, follow the guidance in the following Knowledge Base article, and then, restart the computer: 

[Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/help/3140245) 

> [!NOTE]
> To resolve the problem, you must also make sure that the Skype for Business installation meets the minimum version requirements, as specified in the following Skype for Business Blog article: 

[Preparing for TLS 1.0/1.1 Deprecation - O365 Skype for Business](https://techcommunity.microsoft.com/t5/Skype-for-Business-Blog/Preparing-for-TLS-1-0-1-1-Deprecation-O365-Skype-for-Business/ba-p/222247)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
