---
title: YTD Depreciation field value in the Asset Book window isn't set to zero for the new fiscal year in Fixed Asset Management in Microsoft Dynamics GP
description: Fixes an issue where YTD Depreciation field in the Asset Book window isn't set to zero for the new fiscal year in Fixed Asset Management in Microsoft Dynamics GP.
ms.reviewer: theley, dbader
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# The value in the "YTD Depreciation" field in the Asset Book window isn't set to zero for the new fiscal year in Fixed Asset Management in Microsoft Dynamics GP

This article provides a solution for an issue where the value in the "YTD Depreciation" field in the Asset Book window isn't set to zero for the new fiscal year.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 895051

## Symptoms

In Fixed Asset Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, the value in the **YTD Depreciation** field in the Asset Book window isn't set to zero for the new fiscal year.

## Cause

This problem occurs if you manually increment the value in the **Current Fiscal Year** field in the Book Setup window. We don't recommend that you manually increment the value in the **Current Fiscal Year** field. Instead, let the **Asset Year End** process increment the value in the **Current Fiscal Year** field.

## Resolution

To resolve this problem, restore a backup of the company database that was made before you manually incremented the value in the **Current Fiscal Year** field. So the Fixed Asset year can be closed correctly.

If you don't have a backup to restore, contact your Partner or Technical Support for more information about how to correct the data. It may be considered a billable service through MBS Professional Services.

To prevent this problem in the future, close the year in Fixed Asset Management by using the **Asset Year End** process. The **Asset Year End** process sets the value in the **YTD Depreciation** field to zero. To open the Asset Year End window, follow one of these steps:

- In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines** > **Fixed Assets**, and then click **Year End**.
- In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Fixed Assets**, and then click **Year End**.

## More information

For more information about the year-end closing procedures for Fixed Asset Management, click the following article number to view the article in the Microsoft Knowledge Base:

[865653](https://support.microsoft.com/help/865653) The year-end closing procedures for the Fixed Asset Management module in Microsoft Dynamics GP
