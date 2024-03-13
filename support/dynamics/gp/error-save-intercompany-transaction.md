---
title: Can't save an intercompany transaction in Payables Management or in General Ledger 
description: Describes error At least one distribution amount for a company does not match the corresponding company when you save an intercompany transaction in Payables Management or in General Ledger.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "At least one distribution amount for a company does not match the corresponding company" error when you save an intercompany transaction in Payables Management or in General Ledger

This article helps resolve an error that occurs when you save an intercompany transaction in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872118

## Symptoms

When you save an intercompany transaction in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> At least one distribution amount for a company does not match the corresponding company. Do you want to continue?

This problem occurs in Payables Management and in General Ledger.

## Cause

This problem occurs if the **Enter Corresponding Company ID** check box is selected.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1

When you receive the error message, click **OK**, and then post the transaction. The error message won't prevent you from posting the transaction.

### Method 2

If you use Enterprise Reporting, follow these steps:

1. Take one of the following actions:
    - For intercompany transactions that are entered in the General Ledger module, point to **Financial** on the **Transactions** menu, and then click **Transaction Entry**.
    - For intercompany transactions that are entered in the Payables Management module, point to **Purchasing** on the **Transactions** menu, click **Transaction Entry** > **Distributions**.
2. Click the down arrow, and then enter a value in the **Corresp. Co. ID.** field.

### Method 3

If you don't use Enterprise Reporting, follow these steps:

1. Take one of the following actions:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup** > **System**, and then click **Intercompany**.
    - In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Setup** on the **Tools** menu, point to **System**, and then click **Intercompany**.
1. Click to clear the **Enter Corresponding Company ID** check box.
1. Click **Save**.

## More information

> [!NOTE]
>
> - Make sure that a functional currency is assigned to the originating company and to the destination company.
> - If the company is not registered for multicurrency, all companies must have the same functional currency assigned.
> - If the company is registered for multicurrency, and if the intercompany transaction is a multicurrency transaction, see the following article in the Microsoft Knowledge Base:
>
> [917720](https://support.microsoft.com/help/917720) Description of the process that you must complete before you post multicurrency intercompany transactions in Microsoft Dynamics GP
