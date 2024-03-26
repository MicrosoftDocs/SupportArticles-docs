---
title: PivotTable operation failed when click a slicer in Excel Online
description: You get an error message stating PivotTable Operation Failed when trying to click a slicer in an Excel Online PowerPivot workbook.
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
ms.reviewer: randring
appliesto: 
  - Excel Online
ms.date: 03/31/2022
---

# "PivotTable Operation Failed" when you click a slicer in an Excel Online PowerPivot workbook

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

## Symptoms

When you try to click a slicer in an Excel Online PowerPivot workbook, you receive an error message that resembles the following:

**PivotTable Operation Failed**
**An error occurred while working on the Data Model in the workbook. Please try again.**

:::image type="content" source="media/excel-online-pivottable-operation-failed/error-message.png" alt-text="Screenshot of the error message, showing PivotTable Operation Failed.":::

## Cause

This issue may occur if the cube is displayed as being "Unprocessed." In this case, the automatic recalculation in PowerPivot fails.

## Resolution

To resolve this issue, manually recalculate the workbook (in PowerPivot) inside the Excel client application. To do this, follow these steps:

1. Open the workbook, and then select **Power Pivot** > **Manage** > **Design**.
1. Select **Calculation Options**, and then select **Manual Calculation Mode** to enable **Calculate Now** command.
1. Select **Calculate Now**.

   :::image type="content" source="media/excel-online-pivottable-operation-failed/calculation-option.png" alt-text="Screenshot to select the Manual Calculation Mode option to enable the Calculate Now command." border="false":::
   
1. After you manually recalculate, select **Automatic Calculation Mode**, save the file, and then test the result.

> [!NOTE]
> This method may not always resolve this error. However, if you do experience this error at some point, you should try this method.