---
title: You'll need a new app to open this ms-visio when you open Visio files in SharePoint
description: Describes an issue that occurs when you try to open a Visio file in SharePoint Server or SharePoint Online.
author: helenclu
ms.author: luche
ms.reviewer: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:spsexperts
  - CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint Server
  - SharePoint Online
ms.date: 12/17/2023
---

# "You'll need a new app to open this ms-visio" when you open Visio files

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

Assume that you have Microsoft Office 2016 installed, and Microsoft Office Visio is not installed. When you try to open a Visio file in SharePoint Server or SharePoint Online, the file does not open in the Microsoft 2016 Viewer tool that is included in Microsoft Office 2016. Additionally, you receive the following message:

> You'll need a new app to open this ms-visio.

## Workaround

To work around this issue, use either of the following methods:
- Change the default experience for a list or document library from **Classic experience** to **New experience**.
- On the **Advanced Settings** page, change the **Default open behavior for browser-enabled documents** setting from **Open in the client application** to **Open in the browser**.

For more information, see the following websites:
- [Switch the default experience for lists or document libraries from new or classic](https://support.office.com/en-us/article/Switch-the-default-for-document-libraries-from-new-or-classic-66dac24b-4177-4775-bf50-3d267318caa9)
- [Differences between the new and classic experiences for lists and libraries](https://support.office.com/en-us/article/Differences-between-the-new-document-library-experience-and-classic-mode-30e1aab0-a5cc-4363-b7f2-09e2ae07d4dc)
