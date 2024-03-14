---
title: Another User is Printing or Calculating 1099s error when printing Print 1099s
description: Error message - Another User is Printing or Calculating 1099s occurs when you print the Print 1099s report in Microsoft Dynamics GP Payables Management
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Another User is Printing or Calculating 1099s" error when you print the Print 1099s report in Microsoft Dynamics GP Payables Management

This article provides a resolution for the issue that you can't print the Print 1099s report in Microsoft Dynamics GP Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859915

## Symptoms

When you try to print the Print 1099s report in Microsoft Dynamics GP, you may receive the following error message:

> Another user is printing or calculating 1099s.This issue occurs even though there is no one else logged in Microsoft Dynamics GP.

## Cause

This issue may occur if records are stuck in the following tables:

- In the DYNAMICS database: ACTIVITY, SY00800, SY00801
- In the TEMPDB database: DEX_LOCK, DEX_SESSION

## Resolution

> [!NOTE]
> The following steps will require you to run update scripts through the Microsoft SQL Server query tool. We recommend that you create a backup of your data before you follow these steps.

1. Have all users exit Microsoft Dynamics GP.

2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    Method 1: For SQL Server Desktop Engine

    If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    Method 2: For SQL Server 2000

    If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    Method 3: For SQL Server 2005

    If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

3. Run the following scripts in the query window:

    ```sql
    DELETE DYNAMICS..ACTIVITY DELETE DYNAMICS..SY00800 DELETE DYNAMICS..SY00801 DELETE TEMPDB..DEX_LOCK DELETE TEMPDB..DEX_SESSION
    ```

4. Sign in to Microsoft Dynamics GP, and then print the Print 1099s report.
