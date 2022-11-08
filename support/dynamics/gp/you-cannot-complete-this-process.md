---
title: You cannot complete this process
description: Provides a solution to an error that occurs when you do the inventory reconcile procedure in the Reconcile Inventory Quantities window in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "You cannot complete this process while transactions are being edited" Error message displays when you do the inventory reconcile procedure in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you do the inventory reconcile procedure in the Reconcile Inventory Quantities window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852159

## Symptoms

When you do the inventory reconcile procedure in the Reconcile Inventory Quantities window in Microsoft Dynamics GP, you receive the following error message:

> You cannot complete this process while transactions are being edited.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1

Remove the stuck activity by using Microsoft SQL Server. To do it, follow these steps:

1. Open a query tool to run the statement. To select the appropriate tool, use the following guidelines:
   - If you're using Microsoft SQL Server 7.0 or Microsoft SQL Server 2000, run the statement in SQL Query Analyzer. To open Query Analyzer, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - If you're using Microsoft SQL Server 2000 Desktop Engine (also known as MSDE), run the statement in Support Administrator Console. To open Support Administrator Console, select **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.

        > [!NOTE]
        > The Support Administrator Console requires a separate installation. If you do not have the program installed, you can install it by using the Microsoft Dynamics GP installation CD.

   - If you're using Microsoft SQL Server 2005 or Microsoft SQL Server 2008, run the statement in Microsoft SQL Server Management Studio. To open Management Studio, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** (or to **Microsoft SQL Server 2008**), and then select **SQL Server Management Studio**. To run a script, select **New Query**.

   - If you're using Microsoft SQL Server 2005 Express or Microsoft SQL Server 2008 Express, run the statement in Microsoft SQL Server Management Studio Express. To open Management Studio Express, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** (or to **Microsoft SQL Server 2008**), and then select **SQL Server Management Studio Express**. To run a script, select **New Query**.

2. To run the script, follow these steps:

    1. Have all users sign out from Microsoft Dynamics GP.
    2. View the contents of the following tables to verify that all users are logged off:
         - DYNAMICS..ACTIVITY
         - DYNAMICS..SY00800
         - DYNAMICS..SY00801
         - TEMPDB..DEX_LOCK
         - TEMPDB..DEX_SESSION

         To do it, run the following script.

        ```sql
        SELECT * FROM DYNAMICS..ACTIVITY
        SELECT * FROM DYNAMICS..SY00800 
        SELECT * FROM DYNAMICS..SY00801 
        
        SELECT * FROM TEMPDB..DEX_LOCK 
        SELECT * FROM TEMPDB..DEX_SESSION
        ```

        > [!NOTE]
        > When all users are signed off from Microsoft Dynamics GP, these tables don't contain any records.

3. If results are returned, clear the stuck records by using any of the following scripts, as appropriate:

     - DELETE DYNAMICS..ACTIVITY
     - DELETE DYNAMICS..SY00800
     - DELETE DYNAMICS..SY00801
     - DELETE TEMPDB..DEX_LOCK
     - DELETE TEMPDB..DEX_SESSION

### Method 2

Run the automated solution to clear the Batch Activity Table or to remove users who are locked in the Activity tables. (For more information, see Cannot Post Batch and/or Clear Inactive Sessions in the SYSTEM MANAGER module.)

To obtain automated solutions, visit the following Microsoft Web site:

- [Partners](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem)
