---
title: Error occurs after printing an edit list
description: Provides a solution to an error that occurs after you try to print an edit list in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# Unhandled Database Exception: A save operation on table 'PM_Transaction_WORK' caused a sharing error EXCEPTION_CLASS_DB DB_ERR_LOCKED

This article provides a solution to an error that occurs after you try to print an edit list in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856971

## Symptoms

After you try to print an edit list in Payables Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> Unhandled database exception: A save operation on table 'PM_Transaction_WORK' caused a sharing error EXCEPTION_CLASS_DB DB_ERR_LOCKED

## Resolution

To resolve this problem, follow these steps:

1. Have all users sign out of Microsoft Dynamics GP or sign out of Microsoft Business Solutions - Great Plains.
2. Start Microsoft SQL Query Analyzer.
3. Select the TempDB database. Then, run the following statements.

    ```sql
    DELETE DEX_LOCK
    DELETE DEX_SESSION
    ```

4. Select the DYNAMICS database. Then, run the following statement to delete any stuck users.

    ```sql
    DELETE ACTIVITY
    ```
