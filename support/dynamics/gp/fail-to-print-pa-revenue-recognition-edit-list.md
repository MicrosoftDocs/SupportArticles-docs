---
title: Errors when you print PA Revenue Recognition Edit List
description: Provides a solution to errors that occurs when you print the "PA Revenue Recognition Edit List" in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# Errors when you print the "PA Revenue Recognition Edit List" in Microsoft Dynamics GP: "Total Revenues Earned is incorrect" and "Total Recognized Project Revenues is incorrect"

This article provides a solution to errors that occurs when you print the "PA Revenue Recognition Edit List" in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 926399

## Symptoms

When you print the "PA Revenue Recognition Edit List" in Microsoft Dynamics GP, you receive the following error messages.

- Error message 1

    > Total Revenues Earned is incorrect
- Error message 2

    > Total Recognized Project Revenues is incorrect

## Cause

This problem occurs because a cost category ID is listed two times in the budget for the project for which you are receiving the error messages.

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Determine whether the cost category ID is listed two times in the budget for the project. To do this, follow these steps:

    1. On the **Cards** menu, point to **Project**, and then click **Project**.
    2. In the Project Maintenance window, select the project, and then click **Budget**.
    3. In the Budget Maintenance window, determine whether a cost category ID is listed two times in the budget. The duplicate cost category IDs in the Budget Maintenance window have a sequence number of 0 in the **Seq** column. If a cost category ID has a sequence number of 0, a duplicate record exists for this project cost category combination in the PA Budget Master table (PA01301).

2. If a cost category ID is listed two times in the budget, run the following statement in SQL Query Analyzer or in SQL Server Management Studio. To do this, follow these steps:

    1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **SQL Query Analyzer**. If you are using SQL Server 2005, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

    2. Run the following select statement against the company database.

        ```sql
        select PALineItemSeq, * from PA01301 where PAPROJNUMBER='<Project_number>' and PACOSTCATID='<Cost_category_ID>'
        ```

        > [!NOTE]
        > The *\<Project_number>* placeholder is a placeholder for the actual project number for which you receive the error messages. The *\<Cost_category_ID>* placeholder is a placeholder for the actual cost category ID that is listed two times in the Budget Maintenance window for this project. You will see two records in the PA01301 table for the project cost category combination. However, you should only have one record in this table for the project cost category combination. The corrupted record will have a sequence number of 0 in the **PALineItemSeq** column.

3. Delete the corrupted record from the table. To do this, run the following statement against the company database.

    ```sql
    Delete * from PA01301 where DEX_ROW_ID = <Number>
    ```

    > [!NOTE]
    > The *\<Number>* placeholder is a placeholder for the number in the **DEX_ROW_ID** column of the corrupted record that you want to remove.
