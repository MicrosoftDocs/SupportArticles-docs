---
title: Can't refresh or filter PivotTable in SharePoint
description: Provides a workaround for an issue in which you receive an error message from a SharePoint site. This issue occurs when you refresh a PivotTable in a workbook that's created in Excel 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: Jenl
appliesto: 
  - Excel 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# Cannot locate a server to load the workbook Data Model when you refresh a PivotTable in an Excel 2013 workbook

_Original KB number:_ &nbsp; 2769345

## Symptoms

Assume that you use an Analysis Services source to create a PivotTable in Microsoft Excel 2013. You upload the Excel Workbook to a Microsoft SharePoint site. When you try to either refresh the PivotTable or filter the data in the PivotTable, you receive the following error message:

> We cannot locate a server to load the workbook Data Model.

## Cause

This issue occurs because the Analysis Services instance has not been configured in the Central Administration site.

## Workaround

To work around this issue, configure the Excel Services service application on the SharePoint server. To do this, follow these steps:

1. In the **Application Management** section of the Central Administration home page, click **Manage service applications**.
2. On the Manage Service Applications page, click the Excel Services service application that you want to configure.
3. On the Manage Excel Services page, click **Data Model**.
4. Click **Add Server**.
5. In the **Server Name** box, type the name of the Analysis Services instance that you want to add.
6. Click **OK**.
