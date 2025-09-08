---
title: Cannot modify the oData connections in a PowerPivot workbook
description: Describes an issue in which you receive error message Some properties cannot be changed because the connection was modified using the PowerPivot add-in. When you try to modify the oData connections in a Microsoft Excel 2103 PowerPivot workbook.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Data\
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: lauraho
appliesto: 
  - Excel 2013
ms.date: 05/26/2025
---

# Cannot modify the oData connections in an Excel 2013 PowerPivot workbook

## Symptoms

When you try to modify the oData connections in a Microsoft Excel 2103 PowerPivot workbook, you receive the following error message:

> Some properties cannot be changed because this connection was modified using the PowerPivot Add-In.

:::image type="content" source="media/cannot-modify-odata-connection/error-message.png" alt-text="Screenshot of the error message after modifying the oData connections." border="false":::

## Cause

This is a limitation in PowerPivot for Excel.

## Workaround

To work around this issue, follow these steps:

1. You click the **PowerPivot** Tab.   
2. You click **Home**, click **Get External Data**, and then click **Existing Connections**.   
3. You select the connection, and then select **Edit**.   
4. You change the Data Feed Url or click **Advanced**, and then edit it.   
5. You save the changes and then refresh the workbook.
