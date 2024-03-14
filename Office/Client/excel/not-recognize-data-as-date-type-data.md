---
title: Excel does not recognize data as Date type data
description: Describes and provides a workaround for an issue in which data that is imported from a SQL Server data source is not recognized as the Date data type in an Excel 2013 workbook. This issue occurs when you use the SQL OLE DB Provider to import the data.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: jenl
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# Excel 2013 does not recognize data as Date type data after you import the data from a SQL Server data source to an Excel workbook

## Symptoms

Consider the following scenario:

- You use the Microsoft SQL OLE DB Provider to import data from a SQL Server data source to a Microsoft Excel 2013 workbook.   
- The SQL Server data source contains a Date type column.   
- You use the data to create a PivotTable in Excel 2013.   
- You try to insert a timeline into the PivotTable.   

In this scenario, you cannot select the cell range that contains the data in the Insert Timeline dialog box.

## Cause

This issue occurs because the SQL OLE DB Provider returns the String data type if the data source contains a Date, Time, or DateTime2 type column. In this situation, Excel 2013 cannot recognize the data as the Date type. 

## Workaround

To work around this issue, use one of the following methods: 

- Change the column type to DateTime in the SQL Server data source.   
- Use an Open Database Connectivity (ODBC) driver to import the data.   
