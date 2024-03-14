---
title: This transaction is edited by another user
description: Provides a solution to an error that occurs when you select an existing purchase order in the Purchase Order Entry window.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# "This transaction is being edited by another user" Error message when you select an existing purchase order in Purchase Order Processing in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you select an existing purchase order in the Purchase Order Entry window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859601

## Symptoms

When you select an existing purchase order in the Purchase Order Entry window, you receive the following error message:

> This transaction is being edited by another user.

This problem occurs in Purchase Order Processing in Microsoft Dynamics GP.

## Resolution

To resolve this problem, follow these steps:

1. Have all users exit Microsoft Dynamics GP.
2. Back up Microsoft Dynamics GP, and then back up all the Microsoft Dynamics GP databases.
3. Start SQL Query Analyzer, and then run the following command against the DYNAMICS database.

    ```sql
    DELETE SY00800
    DELETE SY00801
    DELETE ACTIVITY
    ```

4. Start SQL Query Analyzer, and then run the following command against the tempdb database.

    ```sql
    DELETE DEX_LOCK
    DELETE DEX_SESSION
    ```

5. Start Microsoft Dynamics GP, and then select the purchase order.
