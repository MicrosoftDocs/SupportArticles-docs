---
title: Error when you change a depreciation sensitive field in Fixed Assets in Microsoft Dynamics GP 
description: Describes a situation where you receive the error when you change a depreciation sensitive field in Fixed Assets in Microsoft Dynamics GP. Provides a solution.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 04/17/2025
ms.custom: sap:Financial - Fixed Assets
---
# Error when you change a depreciation sensitive field in Fixed Assets in Microsoft Dynamics GP: Recalc/Reset was unsuccessful. Return Code 99

This article provides a solution to an error that occurs when you change a depreciation sensitive field in Fixed Assets in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2607682

## Symptoms

When you change a depreciation sensitive field in Fixed Assets for Microsoft Dynamics GP, you receive the following error message:

> Recalc/Reset was unsuccessful. Return Code 99.

## Cause

This problem occurs when the quarters in Fixed Assets are out of sync.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, rebuild the FA Quarters using these steps:

> [!NOTE]
> If it is possible, you may want to test this in a test company created from a backup of your live data.

1. Click **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Fixed Assets**, and then click **Build Calendar**.  
2. Mark the **Synchronize Quarters to Fiscal Years** checkbox.
3. Click **Build**.
4. Try the change in the **Asset Book** window again.

If the error persists, re-create the FA Calendar and Quarters again by following the steps in KB article 874133:

[874133](https://support.microsoft.com/help/874133) How to rebuild the Fixed Assets calendar in Microsoft Dynamics GP

## More information

Review the quarter setup for the whole life of the asset to make sure there is not any missing.
