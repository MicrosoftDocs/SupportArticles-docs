---
title: Budgets do not save when you add new accounts to budget
description: Describes a problem where budgets do not save when you add new accounts to the budget in Analytical Accounting in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley, kfrankha, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Analytical Accounting
---
# Budgets do not save when adding new accounts to the budget in Analytical Accounting in Microsoft Dynamics GP

This article provides a resolution for the issue that budgets do not save when you add new accounts to the budget in Analytical Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 946300

## Symptoms

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

When you select **Save** after you make changes at the account level in the Analytical Accounting Budget Maintenance window, the amounts do not save. This behavior is true when you add new accounts to the budget.

## Cause

This problem occurs when an invalid record exists in the Budget Tree View Work table (AAG00906).

## Resolution

1. Verify that no users are editing an Analytical Accounting budget.

2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    Method 1: For SQL Server Desktop Engine

    If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    Method 2: For SQL Server 2000

    If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    Method 3: For SQL Server 2005

    If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

3. Run the following statement against the company database to delete the records in the AAG00906 table:

    ```sql
    DELETE AAG00906
    ```

    > [!NOTE]
    > The AAG00906 table will be rebuilt as users work in the Analytical Accounting Budget Maintenance window again.
