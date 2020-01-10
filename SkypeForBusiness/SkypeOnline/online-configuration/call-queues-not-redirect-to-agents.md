---
title: Calls to call queues are not redirected to agents in Office 365
description: Describes how to fix an issue in which the calls to the call queues are not redirected to agents.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Calls to call queues are not redirected to agents in Office 365

## Symptoms

Calls to the call queues are not redirected to agents in Microsoft Office 365.  

## Cause

This is a known issue. 

## Resolution

To resolve this issue, follow these steps: 
 
1. Sign in to the Office 365 portal.    
2. Locate **Skype admin center** -> **Organization** -> **External Communications**.     
3. Under **external access**, select **On only for allowed domains**.    
4. Add the tenant domain name to the **blocked or allowed domains** list.    
