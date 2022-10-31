---
title: SharePoint site returns "Header Field Too Long" error
description: Fixes an issue in which you can't access a SharePoint site with the "Header Field Too Long" error message.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 168187
ms.reviewer: hisakam
appliesto: 
  - SharePoint Online
search.appverid: MET150
ms.date: 10/31/2022
---
# "Header Field Too Long" error when accessing a SharePoint Online site  

## Symptoms  

When you try to access a SharePoint Online site, you receive the following error message:  

> Bad Request - Header Field Too Long  
> HTTP Error 400. A request header field is too long.  

**Note:** This error indicates that the size of the HTTP request header sent from the browser is too large.  

## Cause  

This issue may occur when you try to access a SharePoint Online site many times in a short period of time before you complete the sign-in. In this case, there are too many cookies in the request, causing the HTTP request header to become too large.  

## Resolution  

To resolve this issue, [delete cookies in Microsoft Edge](https://support.microsoft.com/microsoft-edge/delete-cookies-in-microsoft-edge-63947406-40ac-c3b8-57b9-2a946a29ae09). If you use third-party browsers, check their support sites for instructions to delete cookies.
