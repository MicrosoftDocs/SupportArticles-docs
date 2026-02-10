---
title: Resolve Rate Type ID and Exchange Rate Errors in Dynamics GP
description: Resolve missing exchange rate errors in Dynamics GP. This guide helps you fix "The Exchange Table ID is missing" and post transactions successfully.
ms.reviewer: theley, v-shaywood
ms.date: 02/10/2026
ms.custom: sap:Financial - General Ledger
---
# "The Exchange Table ID is missing. The Exchange Rate is missing." error message when you print an edit list in General Ledger in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you print an edit list in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922872

## Symptoms

When you print an edit list for a purchase order return transaction, you receive the following error message:

> The Exchange Table ID is missing  
> The Exchange Rate is missing

Additionally, you can't post the associated journal because the `RATETPID` and `XCHGRATE` values are blank in the `GL10000` table.

## Cause

This problem occurs under the following conditions:

- More than one multicurrency rate type is selected for an exchange table identifier.
- You post a purchase order return and the `RATETPID`, `XCHGRATE`, and `EXGTBLID` properties are missing from the transaction's `POP10300`.

> [!NOTE]
> You can find the multicurrency setup by going to **Tools** > **Setup** > **Financial** > **Multicurrency**.

## Resolution

To resolve this problem, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **Financial**, and then select **Rate Types**.
1. In the Select Multicurrency Rate Types window, select **Lookup** next to the **Exchange Table ID** field.
1. In the Exchange Tables window, select the exchange table ID that you want to use, and then select **Select**.
1. In the Select Multicurrency Rate Types window, make sure that there's only one rate type in the **Selected Rate Types** box.
1. If there's more than one rate type in the **Selected Rate Types** box, select the rate type that you don't want to use, and then select **Remove**.
1. Repeat the previous step until there's only one rate type in the **Selected Rate Types** box.
1. Select **Save**.
1. On the **Transactions** menu, point to **Financial**, and then select **General**.
1. In the Transaction Entry window, select the General Ledger transaction that generated the error message, and then select **Yes** when you're prompted to create the rate type ID.
1. Select **Save** to save the transaction.
1. Print the edit list again. The error message doesn't appear.

### Alternatives for General Ledger batches

Use the following methods as alternatives to the previous steps when working with a General Ledger batch:

- Use SQL to update the `GL10000` table to add the `RATETPID`, `XCHGRATE`, and `EXGTBLID` values.
- Create a new GL batch and copy the transactions into the new batch. This method allows you to choose the information on entry.
