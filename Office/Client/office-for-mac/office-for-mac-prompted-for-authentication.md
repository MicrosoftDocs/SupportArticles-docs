---
title: Office 2016 for Mac 16.x prompts you for authentication
description: Describes an issue in which Office 2016 for Mac version 16.9.0 and later versions prompt you for authentication when you open a URL in Excel, Word, or PowerPoint.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Office Home & Business 2016 for Mac
  - Office Home & Student 2016 for Mac
ms.date: 03/31/2022
---

# Office 2016 for Mac 16.x prompts you for authentication when you open a URL

## Symptoms

After you install or upgrade to Microsoft Office 2016 for Mac version 16.9 and later versions, you experience one of the following issues in Microsoft Excel, Microsoft Word, or Microsoft PowerPoint: 
 
- You are prompted for authentication.    
- The Office application stops responding.    
- Certain Office features are missing because the relevant online service can't be accessed.    
 
**Note** These issues occur when you use a proxy server in your environment. 

## Cause

This problem occurs because of one or more of the following situations: 
 
- An Office file contains an embedded URL that triggers a SafeLink check. SafeLink is run to verify that it's safe to open the target content before it's handed to the local browser.    
- Office tries to connect to an online endpoint for an Office service.    
 
Office 2016 for Mac 16.9 and later versions use a new user agent string in the HTTP request that starts with "Microsoft Office".
 
When the user agent is blocked by the proxy server, you experience the issues that are mentioned in the "Symptoms" section. 

## Resolution

To fix this issue, add **Microsoft Office** to the exception list of the proxy server.
