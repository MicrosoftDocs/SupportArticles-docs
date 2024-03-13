---
title: Remove and delete an EFT batch
description: Describes how to delete an EFT batch before you create an EFT file for the bank.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to remove and then delete an EFT batch that was voided in Microsoft Dynamics GP

This article describes how to remove and then delete an EFT batch that was voided in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 894693

## Introduction

This article describes how to do the following tasks before you generate an Electronic Funds Transfer (EFT) file:

- How to remove an EFT batch that was voided in the Payables Management module in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
- How to delete the EFT batch that was voided from the EFT Payables Management tables in Microsoft SQL Server.

## More information

> [!NOTE]
> Before you follow the instructions in this article, make sure that you've a complete backup copy of the database that you can restore if a problem occurs.

### Microsoft Dynamics GP 10.0

To remove and then delete the EFT batch that was voided, you must remove the batch from the CM20202 and CM20203 tables by using SQL Query Analyzer. To do it, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    - Method 1: For SQL Server Desktop Engine

        If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    - Method 2: For SQL Server 2000

        If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    - Method 3: For SQL Server 2005

        If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.  

2. In the Query pane, enter the following SELECT statements. Make a note of the numeric value of the DEX_ROW_ID column that is returned by the query.

    ```sql
    SELECT * FROM CM20202 
    SELECT * FROM CM20203 
    ```

    > [!NOTE]
    > Verify that the returned results contain the batch ID of the batch that you want to delete.
3. Press F5 to run these statements.
4. Type the following DELETE statements.

    ```sql
    DELETE CM20203 where BACHNUMB = 'XXX'
    DELETE CM20202 where BACHNUMB = 'XXX'
    ```

    > [!NOTE]
    > In these statements, replace **nnn** with the batch ID of the batch that you want to delete.

### Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

To remove and then delete the EFT batch that was voided, you must remove the batch from the ME234602 table and from the ME234603 table by using SQL Query Analyzer. To do it, follow these steps.

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    - Method 1: For SQL Server Desktop Engine

        If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    - Method 2: For SQL Server 2000

        If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    - Method 3: For SQL Server 2005

        If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.  

2. In the **Query** pane, enter the following SELECT statements. Make a note of the numeric value of the DEX_ROW_ID column that is returned by the query.

    ```sql
    SELECT DEX_ROW_ID, * FROM ME234602 WHERE BACHNUMB = 'nnn'
    SELECT DEX_ROW_ID, * FROM ME234603 WHERE BACHNUMB = 'nnn'
    ```

    > [!NOTE]
    > In this statement, replace **nnn** with the batch ID of the batch that you want to delete.
3. Press F5 to run these statements.
4. Verify that the SELECT statements returned the appropriate batch.
5. Type the following DELETE statements.

    ```sql
    DELETE ME234602 WHERE DEX_ROW_ID = 'nn'
    DELETE ME234603 WHERE DEX_ROW_ID = 'nn'
    ```

    > [!NOTE]
    > In these statements, replace **nn** with the numeric value of the DEX_ROW_ID column for the batch that you want to delete.
6. Press F5 to run these statements.

After you follow these steps, this batch isn't available for file generation in the EFT for Payables Management module.
