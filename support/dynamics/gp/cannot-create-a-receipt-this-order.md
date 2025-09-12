---
title: Cannot create a receipt for this order
description: Provides a solution to an error that occurs when creating Manufacturing Order Receipts in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# "You can't create a receipt for this manufacturing order. Another user or process is editing it." message when creating Manufacturing Order Receipts in Microsoft Dynamics GP

This article provides a solution to an error that occurs when creating Manufacturing Order Receipts in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4042883

## Symptom

If MRP gets interrupted, you may see error messages when creating Manufacturing Order Receipts for Manufacturing Orders, such as

> "You can't create a receipt for this Manufacturing order. Another user or process is editing it".

## Cause

This message can occur legitimately if one user is generating MRP using the MRP Regeneration window (Transactions - Manufacturing - MRP - Regeneration). However you may also get the error if someone ran MRP and it failed and data got hung up in the tables.

## Resolution

If no one is actually running an MRP Regeneration, use the following steps to clear the error so you can continue processing.

First check to see if there's a security record is hung up in the tables. Clearing the records may just fix the error.

1. MRP Security window (**Transactions** > **Manufacturing** > **MRP** > **Security**)
2. MRP Planned order Security (**Transactions** > **Manufacturing** > **MRP** > **MRP Planned Order Security**)

    If a record is **stuck** in the window and the user isn't actively regenerating MRP, remove the **stuck** row of information from the MRP Security windows.

    If there are no records in the security windows, you can run the following script in SQL Query Analyzer.

    ```sql
    delete tempdb..DEX_SESSION where session_id not in
    (select SQLSESID from DYNAMICS..ACTIVITY)
    
    delete tempdb..DEX_LOCK where session_id not in
    (select SQLSESID from DYNAMICS..ACTIVITY)
    ```

3. If the above suggestions don't fix the error, there are a couple of flags to look at in an MFG table that could be causing the error.

    Run the following select statement in a SQL Query against the company database:

    ```sql
    select * from mops0100
    ```

    Check the `REVAL_IN_PROCESS_I` and `RECONCILE_IN_PROCESS_I` columns in this table. If either or both are set to 1 instead of 0, that could causing the error. Verify that there are no users performing a revalue or reconcile before continuing to update the table.

    ```sql
    update mops0100 set REVAL_IN_PROCESS_I = 0
    update mops0100 set RECONCILE_IN_PROCESS_I = 0
    ```
