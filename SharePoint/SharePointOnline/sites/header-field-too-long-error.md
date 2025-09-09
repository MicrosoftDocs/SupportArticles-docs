---
title: SharePoint site returns Header Field Too Long error
description: Fixes an issue in which you can't access a SharePoint site because a request header field is too long.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Reliability, Perf, and Throttling\503 Error (Waiting Room)
  - CSSTroubleshoot
  - CI 168187
ms.reviewer: hisakam
appliesto: 
  - SharePoint Online
search.appverid: MET150
ms.date: 12/17/2023
---
# "Header Field Too Long" error when accessing a SharePoint Online site  

## Symptoms  

When you try to access a SharePoint Online site, you receive the following error message:  

> Bad Request - Header Field Too Long  
> HTTP Error 400. A request header field is too long.  

This error indicates that the size of the HTTP request header that was sent from the browser is too large.  

## Cause  

This issue might occur if you try to access a SharePoint Online site many times in a short period before you complete the sign-in. This adds too many cookies to the request. This, in turn, causes the HTTP request header to become too large.  

## Resolution  

To resolve this issue, [delete cookies in Microsoft Edge](https://support.microsoft.com/microsoft-edge/delete-cookies-in-microsoft-edge-63947406-40ac-c3b8-57b9-2a946a29ae09). If you use third-party browsers, check their support sites for instructions to delete cookies.
