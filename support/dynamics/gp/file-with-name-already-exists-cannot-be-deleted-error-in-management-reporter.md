---
title: A file with the name already exists and can't be deleted error when exporting report to Excel
description: Describes an error message that you receive in Management Reporter when you generate a report to Excel. Provides a resolution.
ms.reviewer: theley, gbyer, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "A file with the name already exists and can't be deleted" error in Management Reporter when exporting a report to Excel

This article provides a resolution for the issue that you receive the **A file with the name already exists and can't be deleted** error message in Microsoft Management Reporter when exporting a report to Excel.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2591014

## Symptoms

When you create a report to Microsoft Excel, you receive the following error message:

> A file with the name S:\server\folder\file.xlsx already exists and can't be deleted

## Cause

You must use a UNC path instead of a mapped drive.

## Resolution

In the report, select the **Output and Distribution** tab, and enter the UNC path of the location where you want the Excel Workbook to be created in the **Output path**  field.
