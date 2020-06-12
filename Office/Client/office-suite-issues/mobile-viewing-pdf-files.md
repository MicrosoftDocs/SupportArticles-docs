---
title: Mobile viewing PDF files with Office Web Apps
description: Office Online Server is not available for Office Online Server.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Office Online Server
---

# Mobile viewing PDF files with Office Web Apps

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you open a PDF file on a mobile device by using Microsoft SharePoint and Office Web Apps or Office Online Server, the mobile browser displays the following error message:

**Viewing .PDF files has been disabled in Microsoft Word Mobile viewer.**

## Cause

This problem occurs because PDF viewing on mobile browsers is not supported in Office Web Apps or Office Online Server.

## More information

The "MobileView" action was removed from the available Web Application Open Platform Interface Protocol (WOPI) actions for the WordPDF application. Also this feature is not available for Office Online Server.
