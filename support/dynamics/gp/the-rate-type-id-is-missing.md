---
title: The rate type ID is missing 
description: Provides a solution to an error that occurs when you print an edit list in General Ledger in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 10/7/2025
ms.custom: sap:Financial - General Ledger
---
# "The rate type ID is missing. The exchange table ID is missing." Error message when you print an edit list in General Ledger in Microsoft Dynamics GP.

This article provides a solution to an error that occurs when you print an edit list in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922872

## Symptoms

When you print an edit list for a purchase order return transaction, you receive the following error message:
> The rate type ID is missing.  
The exchange table ID is missing.This problem occurs when you use the originating currency and have Use rates without adding table marked in Multicurrency setup.
This can by found by going to Tools >> Setup >> Financial >> Multicurrency

## Cause

This problem occurs because more than one multicurrency rate type is selected for an exchange table identifier.
When you post a PO return the transaction doesn´t have a RATETPID,XCHGRATE, EXGTBLID in the POP10300, and when you try to post it in GL you receive the following error:
The Exchange Table ID is missing
The Exchange Rate is missing

And you cannot post the journal because the GL10000 table has RATETPID,XCHGRATE are blank.

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

Other options for the General Ledger batch:
1. If you see this error, in SQL, you can update the GL10000 table with the RATETPID,XCHGRATE, and EXGTBLID.
2. You could also just create a new GL batch an copy the transactions into the new batch which allows you to choose the information on entry.
3. Setup the Exchange rate to teh table so the problem does not exist, see steps above.

