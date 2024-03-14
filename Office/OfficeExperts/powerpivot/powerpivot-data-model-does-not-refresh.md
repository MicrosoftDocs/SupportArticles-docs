---
title: PowerPivot data model does not refresh for the SQL Server authentication
description: Describes an issue in which PowerPivot data model doesn't refresh when the SQL Server authentication and Save Password are used.
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

# PowerPivot data model does not refresh when the SQL Server authentication and "Save Password" are used

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

The Power Pivot add-in for Excel is used to create a PowerPivot model by using SQL Server as a data source and the user manually uses the Excel connections screen to have the password saved.

When the Power Pivot add-in is used to change the model, for example, changing some query text, the PowerPivot model will does not refresh.

## Cause

The model command text becomes unsynchronized with what Excel has for the command text. This is a known issue.

## Workaround

To work around this issue, use Windows authentication to the SQL database and don't save the password to a database. Storing a login ID and password to a database is exceptionally not secure because when the workbook is passed around, the password is visible to anyone who opens the workbook.

If you must use SQL authentication, follow these steps if you have SharePoint and PowerPivot for SharePoint:

1. Create the workbook with Excel the same as before, but never check "Save Password". You will be prompted whenever the password is needed.
1. Upload the file to a SharePoint PowerPivot Gallery document library.
1. In the Gallery, click the "Manage Data Refresh" button.
1. Configure a schedule to refresh the data. You can put the SQL Server username and password in the schedule. These values are never readable by users.
1. Have users use the workbook.

The previous method is vastly superior to saving the password in the workbook.  The password won't be visible to anyone, only the workbook author can know the password. The data is only refreshed one time per day or whatever interval is set in the schedule. This is a large performance gain. Without scheduled data refresh, the data refresh processes might be done by every user who opens the workbook multiple times. With scheduled data refresh, it only happens one time per time period.
