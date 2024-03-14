---
title: You must be viewing by Functional or Originating currency to print a document error
description: When you try to print a historical Sales Order Processing invoice in Microsoft Dynamics GP, you may receive an error message that states you must be viewing by Functional or Originating currency to print a document.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# "You must be viewing by Functional or Originating currency to print a document" error when printing a historical Sales Order Processing invoice

This article provides a resolution for the issue that you can't print a historical Sales Order Processing invoice in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 854925

> [!IMPORTANT]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Symptoms

When you try to print a historical Sales Order Processing invoice in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> You must be viewing by Functional or Originating currency to print a document.This problem occurs if you do not have Multicurrency registered.

## CAUSE

This problem occurs because the `VIEWTYPE` values that are set for the Sales Document Inquiry window or the RM Transaction Inquiry window are incorrect. This information is stored in the Multicurrency User Preference table (MC40500).

## Resolution

To resolve this problem, update table MC40500. To do this, follow these steps:

1. Follow the appropriate step:

    - If you are using Microsoft SQL Server 7.0 or Microsoft SQL Server 2000, run the statement in SQL Query Analyzer. To open SQL Query Analyzer, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    - If you are using Microsoft SQL Server Desktop Engine, run the statement in the Support Administrator Console. To open the Support Administrator Console, select **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.

        > [!NOTE]
        > The Support Administrator Console requires a separate installation. If you do not have the program installed, you can install it by using the Microsoft Dynamics GP installation CD.

    - If you are using Microsoft SQL Server 2005, run the statement in SQL Server Management Studio. To open SQL Server select Studio, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**. To run a script, select **New Query**.

2. Make sure that all users exit Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains.

3. Run the following query against your company database, and then note the value in the `DEX_ROW_ID` column.

   ```sql
   SELECT DEX_ROW_ID, * FROM MC40500 WHERE TRXSOURC IN (SOP_Document_Inquiry, RM_Transaction_Inquiry)
   ```

4. Run the following `UPDATE` script.

    ```sql
    UPDATE MC40500 SET VIEWTYPE = 3 WHERE DEX_ROW_ID = <X>
    ```

    > [!NOTE]
    > Replace \<X> with the value in the `DEX_ROW_ID` column that you noted in step 3.

5. Repeat this `UPDATE` script for all the records that you want to update.
