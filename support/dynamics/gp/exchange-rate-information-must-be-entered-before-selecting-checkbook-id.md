---
title: Exchange rate information must be entered before selecting a Checkbook ID error in Cash Flow Management 
description: Describes a problem where you receive the error - Exchange rate information must be entered before selecting a Checkbook ID in Cash Flow Management in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Miscellaneous
---
# "Exchange rate information must be entered before selecting a Checkbook ID" error in Cash Flow Management in Microsoft Dynamics GP

This article provides a resolution for the **Exchange rate information must be entered before selecting a Checkbook ID** error in Cash Flow Management.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 970223

## Symptoms

You receive the following error message in Cash Flow Management in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0:

> Exchange rate information must be entered before selecting a Checkbook ID.

This behavior occurs even though Multicurrency Management is not registered.

## Cause

This problem occurs because a currency ID is required in the Checkbook Maintenance window. To select a checkbook on the forecast ID, a currency ID must be mapped to the checkbook ID. If you are not registered for Multicurrency Management, then you must update the **CURNCYID** field by using a SQL script to update the Checkbook Setup (CM00100) table.

## Resolution

To resolve this problem, follow these steps:

1. On the **Cards** menu, point to **Financial**, and then select **Checkbook**. Verify that each checkbook ID has a currency ID assigned. If the **Currency ID** field is unavailable, update the currency ID by using SQL scripts.

2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    - Method 1: For SQL Server Desktop Engine

      If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    - Method 2: For SQL Server 2000

      If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    - Method 3: For SQL Server 2005

      If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

    - Method 4: For SQL Server 2008

      If you are using SQL Server 2008, start SQL Management Studio. to do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

3. Run the following statement against the company database:

    ```sql
    Select * from CM00100
    ```

4. In the results, review the **CURNCYID** field for each checkbook. If the **CURNCYID** field is blank, run the following script against the company database:

    ```sql
    update CM00100 set CURNCYID = '**XXXX**' where CHEKBKID = '**YYYY**'
    ```

    > [!NOTE]
    > Replace the placeholder **XXXX** with the appropriate currency ID. Replace the placeholder **YYYY** with the appropriate checkbook ID.

    To review the available currency ID values, run the following script:

    ```sql
    select * from Dynamics..MC40200
    ```
