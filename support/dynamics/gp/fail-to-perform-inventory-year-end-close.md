---
title: Error when you perform the Inventory year-end close in Microsoft Dynamics GP
description: Describes a problem that occurs if you have locked tables in the tempdb database or in the DYNAMICS database. Provides steps to resolve this problem.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# Error when you perform the Inventory year-end close in Microsoft Dynamics GP: "You cannot complete this process while invoices are being posted"

This article provides a solution to an error that occurs when you perform the year-end close in Inventory Control.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865739

## Symptoms

When you perform the year-end close in Inventory Control in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> You cannot complete this process while invoices are being posted.

## Cause

This problem occurs if a record is locked in the DEX_LOCK table or in the DEX_SESSION table in the tempdb database, or in the ACTIVITY table, in the SY00800 table, or in the SY00801 table in the DYNAMICS database.

## Resolution

To resolve this problem, delete the locked records from the tables. To do this, follow these steps:

1. Make sure that all users exit Microsoft Dynamics GP.
2. Make a complete backup of the DYNAMICS database and of the company databases.
3. Start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.
4. Log on as the sa user.
5. Click the tempdb database in the database list.
6. Run the following statement.

    ```sql
    delete DEX_LOCK
    delete DEX_SESSION
    ```

7. Click the DYNAMICS database in the database list.
8. Run the following statement.

    ```sql
    delete ACTIVITY
    delete SY00800
    delete SY00801
    ```
