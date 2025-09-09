---
title: Mobile viewing PDF files with Office Web Apps
description: Office Online Server is not available for Office Online Server.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Web Server Integration (SharePoint & Non-SharePoint)
  - Open
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 06/06/2024
---

# Mobile viewing PDF files with Office Web Apps

## Symptoms

When you open a PDF file on a mobile device by using Microsoft SharePoint and Office Web Apps or Office Online Server, the mobile browser displays the following error message:

**Viewing .PDF files has been disabled in Microsoft Word Mobile viewer.**

## Cause

This problem occurs because PDF viewing on mobile browsers is not supported in Office Web Apps or Office Online Server.

## More information

The "MobileView" action was removed from the available Web Application Open Platform Interface Protocol (WOPI) actions for the WordPDF application. Also this feature is not available for Office Online Server.
