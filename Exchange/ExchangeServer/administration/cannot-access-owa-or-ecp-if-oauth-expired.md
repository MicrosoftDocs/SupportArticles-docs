---
title: Can't access Outlook on the web or the EAC with expired OAuth certificate
description: Fixes an issue in which you can't sign in to Outlook on the web or the EAC if the Exchange Server Open Authentication (OAuth) certificate is expired.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OAuth Configuration
  - CI 9842
  - CI 9823
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jashinba, mhaque, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 04/03/2026
---

# Can't sign in to Outlook on the web or the EAC if the Exchange Server OAuth certificate is expired

_Original KB number:_ &nbsp; 2617816

## Summary

This article discusses an error that occurs when signing in to Outlook on the web or the Exchange Admin Center (EAC) in Exchange Server. This issue occurs if the Exchange Server Open Authentication (OAuth) certificate is expired, not present, or incorrectly configured. To fix this issue, install the recommended update.

## Symptoms

When you sign in to Outlook on the web or the EAC in Exchange Server, the web browser freezes or reports that the redirect limit was reached. Event 1003 is also logged in the event viewer as shown in the following example:

> Event ID: 1003  
Source: MSExchange Front End HTTPS Proxy  
[Owa] An internal server error occurred. The unhandled exception was: System.NullReferenceException: Object reference not set to an instance of an object.  
   at Microsoft.Exchange.HttpProxy.FbaModule.ParseCadataCookies(HttpApplication httpApplication)

## Cause

This issue occurs if the OAuth certificate is expired, not present, or incorrectly configured.

## Resolution

To fix this issue, install the appropriate update:

- [Cumulative Update 12 for Exchange Server 2019](https://support.microsoft.com/help/5011156) or a [later cumulative update](/Exchange/new-features/build-numbers-and-release-dates) for Exchange Server 2019

- [Cumulative Update 23 for Exchange Server 2016](https://support.microsoft.com/help/5011155) or a [later cumulative update](/Exchange/new-features/build-numbers-and-release-dates) for Exchange Server 2016
