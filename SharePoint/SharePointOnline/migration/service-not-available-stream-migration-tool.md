---
title: Stream migration tool returns Service not available
description: Describes an issue in which you receive the Service is not available error when you start the Stream migration tool.
author: helenclu
ms.author: luche
ms.reviewer: prbalusu, salarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
- CSSTroubleshoot
- CI172876
appliesto: 
  - SharePoint Online
ms.date: 3/10/2023
---

# Error "Service is not available" when you use the Stream migration tool

## Symptoms

When you start the [Stream migration tool](/stream/streamnew/step-by-step-guide) from the Stream admin center or SharePoint admin center, you receive the following error message:

> Service is not available. Please contact support.  

This error message indicates that the Stream connector isn't successfully connected.

## Cause

This error occurs if your tenant blocks connection to the required endpoint or there's a network connection problem.

## Resolution

To fix the issue, follow these steps:

1. Make sure that the following URLs are included in your tenant's [allowlist](https://security.microsoft.com/tenantAllowBlockList):

   - [https://api.mover.io](https://api.mover.io)
   - [https://api.microsoftstream.com/](https://api.microsoftstream.com/)

2. If the issue persists, [check your network connection status](https://support.microsoft.com/windows/check-your-network-connection-status-efb4fb41-f751-567a-f60f-aac9114659a5).  
