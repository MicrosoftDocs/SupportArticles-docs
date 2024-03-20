---
title: Error when creating new Book ID in Book Class Setup window in Fixed Assets
description: When you try to set up a new Book ID in the Book Class, Setup window, you get an error. This article provides a solution to this issue.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# Error (Duplicate Record) in the Book Class Setup window in Fixed Assets for Microsoft Dynamics GP

This article provides a solution to an error that occurs when you create a new Book ID in the Book Class Setup window in Fixed Assets for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2498756

## Symptoms

When you try to create a new Book ID in the Book Class Setup window in Fixed Assets, you receive the following message:

> Duplicate Record.  
Message Number: 30900117  
Situation: Another user has created a record with the same ID since you started this form.  
Solution: Examine this record to ensure you have the correct ID and re-apply any required changes.

## Cause

This message is usually caused by a stuck record or an incorrect index value.

## Resolution

Usually clearing out the Fixed Asset Index Master (FAINDEX) and/or the FA Activity Master (FA01500) tables will resolve this issue. Use these steps to clear the tables and they will automatically repopulate themselves going forward.

1. Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.
2. Have all users exit GP so no users are keying in Fixed Assets.
3. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    - Method 1: For SQL Server Desktop Engine

        If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, click **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then click **Support Administrator Console**.

    - Method 2: For SQL Server 2000

        If you are using SQL Server 2000, start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

    - Method 3: For SQL Server 2005

        If you are using SQL Server 2005, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

    - Method 4: For SQL Server 2008

        If you are using SQL Server 2008, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.

4. In a query window in SQL Server Management Studio, run these scripts against the company database:

    ```sql
    Delete FAINDEX
    Delete FA01500
    ```

5. Test again.
