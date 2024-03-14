---
title: The rate type ID is missing 
description: Provides a solution to an error that occurs when you print an edit list in General Ledger in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# "The rate type ID is missing. The exchange table ID is missing." Error message when you print an edit list in General Ledger in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

This article provides a solution to an error that occurs when you print an edit list in General Ledger in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922872

## Symptoms

When you print an edit list for a purchase order return transaction, you receive the following error message:
> The rate type ID is missing.  
The exchange table ID is missing.This problem occurs when you use the originating currency.

This problem occurs in General Ledger in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.

## Cause

This problem occurs because more than one multicurrency rate type is selected for an exchange table identifier (ID).

## Resolution

To resolve this problem, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **Financial**, and then select **Rate Types**.
2. In the Select Multicurrency Rate Types window, select **Lookup** next to the **Exchange Table ID** field.
3. In the Exchange Tables window, select the exchange table ID that you want to use, and then select **Select**.
4. In the Select Multicurrency Rate Types window, make sure that there's only one rate type in the **Selected Rate Types** box.
5. If there's more than one rate type in the **Selected Rate Types** box, select the rate type that you don't want to use, and then select **Remove**.
6. Repeat step 5 until there's only one rate type in the **Selected Rate Types** box.
7. Select **Save**.
8. On the **Transactions** menu, point to **Financial**, and then select **General**.
9. In the Transaction Entry window, select the General Ledger transaction that generated the error message, and then select **Yes** when you're prompted to create the rate type ID.
10. Select **Save** to save the transaction.
11. Print the edit list again. The error message doesn't appear.
