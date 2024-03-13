---
title: Error when using Lockbox in Microsoft Dynamics GP
description: Fixes a problem that occurs in Microsoft Dynamics GP 10.0 and GP 2010 when you click Reset Customer ID or double-click a payment in the Lockbox Transactions window.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/13/2024
---
# Error message when using Lockbox in Microsoft Dynamics GP: "This module isn't registered. To register this module, contact your Microsoft Dynamics GP Representative"

This article provides a solution to an error that occurs when you click **Reset Customer ID** or when you double-click a payment in the **Lockbox Transactions** window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 977080

## Symptoms

When you click **Reset Customer ID** or when you double-click a payment in the **Lockbox Transactions** window in Microsoft Dynamics GP 10.0 and GP 2010, you receive the following error message:

> This module isn't registered. To register this module, contact your Microsoft Dynamics GP Representative.

This problem occurs even if the customer is registered for the Lockbox module.

> [!NOTE]
> This problem does not occur in Microsoft Dynamics GP 9.0.

## Cause

This problem occurs because the Module ID's Master (SY05100) table lists an incorrect ID for Lockbox Processing in Microsoft Dynamics GP 10.0 and GP 2010. The module ID for Lockbox Processing is 93. However, the listed module ID is 21. A module ID of 21 corresponds to the Purchase Order Processing module. In this situation, the error message occurs because Purchase Order Processing is not registered.

## Resolution

To resolve this problem, change the module ID value in the SY05100 table to 93. To do this, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods, depending on the program that you are using.

    - Method 1: For SQL Server Desktop Engine

        If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, click **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then click **Support Administrator Console**.

    - Method 2: For SQL Server 2000

        If you are using SQL Server 2000, start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

    - Method 3: For SQL Server 2005

        If you are using SQL Server 2005, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

    - Method 4: For SQL Server 2008

        If you are using SQL Server 2008, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.

2. Click **New Query**.
3. In the database list, click **Dynamics**.
4. Run the following script in the Dynamics database:

    ```sql
    UPDATE SY05100 SET MODULEID = 93 WHERE HLPFRMID = 1326
    ```

## More information

This issue happens in Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010.

### Steps to reproduce this problem

- Method 1

    On the **Transactions** menu, point to **Sales** and click on **Lockbox**. The error message may appear.

- Method 2

    1. In Microsoft Dynamics GP, click **Transaction**, point to **Sales**, and then click **Lockbox Entry**.
    2. In the **Lockbox ID** box, enter a lockbox identifier (ID).
    3. In the **Checkbook ID** box, enter a checkbook ID.
    4. In the **Lockbox Import File** box, enter the path of the lockbox file that you want to process.
    5. In the **Batch ID** field, enter a batch ID. Then, add and save the new batch.
    6. Click **Transactions**.
    7. Select a payment, and then click **Reset Customer ID**. (Or click on a payment in the **Lockbox Transactions** window.)
