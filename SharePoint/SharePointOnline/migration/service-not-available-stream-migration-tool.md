---
title: Stream migration tool returns Service not available
description: Describes an issue in which you receive a Service is not available error message when you start the Stream migration tool.
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
ms.date: 12/17/2023
---

# "Service is not available" error when you use the Stream migration tool

## Symptoms

When you start the [Stream migration tool](/stream/streamnew/step-by-step-guide) from the Stream admin center or SharePoint admin center, you receive the following error message:

> Service is not available. Please contact support.  

This error message indicates that the Stream connector isn't successfully connected.

## Cause

This error occurs if your tenant blocks the connection to the required endpoint or if a network connection problem occurs.

## Resolution

To fix the error, follow these steps:

1. Make sure that the following URLs are included in your tenant [allow list](https://security.microsoft.com/tenantAllowBlockList):

   - `https://api.mover.io`
   - `https://api.microsoftstream.com/`

2. If the issue persists, [check your network connection status](https://support.microsoft.com/windows/check-your-network-connection-status-efb4fb41-f751-567a-f60f-aac9114659a5).
