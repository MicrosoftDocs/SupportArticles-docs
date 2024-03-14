---
title: Unable to run a report in an Access 2010 Web database
description: Access Services reports are not enabled when running a report in an Access 2010 Web database.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server
ms.date: 12/17/2023
---

# "Access Services reports are not enabled" error when you run a report in an Access 2010 Web database

## Problem

When you try to run a report in a Microsoft Access 2010 Web database, you receive the following error message:

**Access Services reports are not enabled. To view the report, open the report in the Access client.**

## Solution

To work around this issue, create reports by using a client installation of Microsoft Access by following these steps:

1. Browse to the Access 2010 Web database site.
2. Within the Access 2010 Web database, on the top of the page, click **Options**, and then click **Open in Access**.
3. The Access 2010 Web database opens in a local copy of Microsoft Access. You can create client reports in the local copy of the Access 2010 Web database.

## More information

This issue occurs because SQL Server Reporting Services (SSRS) is currently not enabled for SharePoint Online. SSRS makes it possible to run Access Services reports.

The client reports are located in an .accdb file on the local client. On a local intranet, you can share the folder where the .accdb file is stored so that multiple users can view the reports. You can also right-click a client report and export it to several formats for distribution.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
