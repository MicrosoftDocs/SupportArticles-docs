---
title: The following connection failed to refresh in Excel 2013
description: Provides a workaround for an issue in which you receive an error message when you upload a pivot table to a WAC server and then update the data connection or change the PivotTable fields. This issue occurs when the pivot table references external data in Excel 2013.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# "The following connection failed to refresh" error in an Excel 2013 workbook on a WAC server

## Symptoms

Consider the following scenario:

- You create a pivot table that references external data in a workbook in Microsoft Excel 2013.   
- You upload the workbook to a Web Application Companions (WAC) server.   
- You update the data connection or change the PivotTable fields.   

In this scenario, you receive the following error message:

```adoc
A data connection is set to always use connection file and {0:ExcelWebApp} does not support external connection files. The following connection failed to refresh:

Data connection
```

## Cause

This issue occurs because the WAC server does not support the Office Data Connection (ODC) file that stores the data connection information.

## Workaround

To work around this issue, follow these steps:

1. Open the workbook in an Excel client application.   
2. Select the data connection that is listed in the error message, and then click **Properties** under the **Data** tab.   
3. Clear the **Always use connection file** check box under the **Definition** tab.   
4. Republish the workbook to the WAC server.   
