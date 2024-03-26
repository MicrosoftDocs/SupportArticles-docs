---
title: Exchange Online calendar isn't displayed in SharePoint Online
description: The ability to use the calendar overlay in a SharePoint Online or SharePoint Server calendar that's retrieved from Exchange Online isn't supported.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Lists and Libraries\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# The "HTTP request is unauthorized" error in a SharePoint Online or SharePoint Server calendar after you configure a calendar overlay to Exchange Online

## Problem

Consider the following scenario:

- You have a calendar overlay in Microsoft SharePoint Online or SharePoint Server.
- You configure the calendar overlay to do the following:
  - Retrieve a calendar from Microsoft Exchange Online
  - Display the calendar within the SharePoint Online or SharePoint Server calendar

In this scenario, information from the Exchange Online calendar isn't displayed in SharePoint Online or SharePoint Server. Additionally, you receive the following error message, which is displayed above the calendar:

**The HTTP request is unauthorized with client authentication scheme 'Ntlm'. The authentication header received from the server was 'Basic Realm=""'.**

## Solution

This issue occurs because the ability to use the calendar overlay in a SharePoint Online or SharePoint Server calendar that is retrieved from Exchange Online isn't supported.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
