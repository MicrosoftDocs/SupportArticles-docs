---
title: Unclosed quotation mark
description: Provides a solution to an error that occurs when you run the Historical Aged Trial Balance report for Payables Management.
ms.reviewer: kenhub, cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Unclosed quotation mark after the character string" Error message when running the Historical Aged Trial Balance for Payables Management in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you run the Historical Aged Trial Balance report for Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2580792

## Symptoms

When you run the Historical Aged Trial Balance report for Payables Management, you receive one of the following error messages:

Error Message 1

> [Microsoft][ODBC SQL Server Driver][SQL Server]Line 1 : Incorrect syntax near 'XXXXX'.[Microsoft][ODBC SQL Server Driver][SQL Server]Unclosed quotation mark before the character string ' and DocumentType=5'.

Error Message 2

> [Microsoft][SQL Native Client][SQL Server]incorrect syntax near 'S'[Microsoft][SQL Native Client][SQL Server] Unclosed quotation mark after the character string 'and DocumentType = 6"

It's followed by the following message:

> The stored proc pmHistoricalAgedTrialBalance returned the following results: DBMS: 105, Microsoft Dynamics GP: 0

## Cause

These errors are caused by a known issue in Microsoft Dynamics GP where a credit memo or manual payment document is entered with an apostrophe in the **Voucher Number** field.

## Resolution

Use one of the following methods to resolve this issue:

### Resolution 1

1. Use SmartList to identify the credit memo or manual payment document(s) where the **Voucher Number** field contains an apostrophe.

2. Void and reenter the credit memo or manual payment without an apostrophe in the **Voucher Number** field.

### Resolution 2

If Resolution 1 isn't feasible, open a support case for further assistance to locate the problem document.

> [!NOTE]
> Locating the problem document may be a billable consulting expense to you. To reach Customer Service, telephone 888-477-7877.

## More information

To prevent this issue from happening in the future, you can lock the **Voucher Number**  field to prevent users from modifying the voucher number. To do it, following these steps:

1. Select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Purchasing**, and then select **Payables**.

2. Unmark the Override Voucher Number at Transaction Entry option, and then select **OK**.
