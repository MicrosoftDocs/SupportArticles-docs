---
title: You cannot complete this process
description: Provides a solution to an error that occurs when you do the inventory reconcile procedure in the Reconcile Inventory Quantities window in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# "You cannot complete this process while transactions are being edited" Error message displays when you do the inventory reconcile procedure in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you do the inventory reconcile procedure in the Reconcile Inventory Quantities window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852159

## Symptoms

When you do the inventory reconcile procedure in the Reconcile Inventory Quantities window in Microsoft Dynamics GP, you receive the following error message:

> You cannot complete this process while transactions are being edited.

## Resolution

To solve this issue, remove the stuck activity by using Microsoft SQL Server.

1. Run the statement in Microsoft SQL Server Management Studio.

   To open SQL Server Management Studio, select **Start**, point to **Programs** > **Microsoft SQL Server**, and then select **SQL Server Management Studio**.

2. Have all users sign out from Microsoft Dynamics GP.
3. View the contents of the following tables to verify that all users are logged off:

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

4. If results are returned, clear the stuck records by using any of the following scripts, as appropriate:

     - DELETE DYNAMICS..ACTIVITY
     - DELETE DYNAMICS..SY00800
     - DELETE DYNAMICS..SY00801
     - DELETE TEMPDB..DEX_LOCK
     - DELETE TEMPDB..DEX_SESSION
