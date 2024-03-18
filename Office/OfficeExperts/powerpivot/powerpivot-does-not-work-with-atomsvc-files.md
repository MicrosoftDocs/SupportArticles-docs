---
title: PowerPivot does not work with .atomsvc files
description: Describes a known issue in which PowerPivot doesn't work with .atomsvc files.
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
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# PowerPivot does not work with .atomsvc files

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

When you try to create a PowerPivot data model in a Microsoft Excel workbook by getting data from an .atomsvc file, or when you refresh a PowerPivot workbook that has an .atomsvc file in it, you receive the following error:

> The payload kind 'BinaryValue' of the given data feed is not supported.  
> Failed to connect to the server. Reason: The payload kind 'BinaryValue' of the given data feed is not supported.

This is a known issue.

## Workaround

An .atomsvc file is a file that contains a pointer to the real data source, such as a SQL Server Reporting Services (SSRS) report or a SharePoint list. To resolve this issue, use a URL to an actual data source instead of creating a PowerPivot data model with the .atomsvc file as the data source.

The URL for a SharePoint list:

http://sharepointserver/_vti_bin/ListData.svc/HTMLList

The URL for an SSRS report:

http://sharepointserver/_vti_bin/ReportServer?http://sharepointserver/Shared Documents/EMEA1.rdl&rs:Command=Render&rs:Format=ATOM&rc:ItemPath=Tablix1

For more information about the ReportServer API, see [URL Access Parameter Reference](https://msdn.microsoft.com/library/ms152835.aspx).
