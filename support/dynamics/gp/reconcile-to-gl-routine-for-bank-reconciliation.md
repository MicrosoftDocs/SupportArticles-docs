---
title: Reconcile to GL routine for bank reconciliation
description: Provides more information about the Reconcile to GL routine for Bank Reconciliation in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Bank Reconciliation
---
# Reconcile to GL routine for Bank Reconciliation in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 5003901

## Information about the Reconcile to GL routine for Bank Reconciliation

- The Reconcile to GL window is designed to display in the FUNCTIONAL currency only.
- FUNCTIONAL CURRENCY: If your checkbook is in the functional currency ID, then the balances on the Reconcile to GL spreadsheet should be correct:

  - The "Beginning balance" for Bank Reconciliation is calculated by starting with the Current Checkbook balance, and adds/subtracts out the transactions in the CM20200 Bank rec table back to the "FROM" date or start date of the date range entered.

  - The "Ending balance" for Bank Reconciliation is calculated by starting with the Current Checkbook balance, and adds/subtracts out the transactions in the CM20200 Bank rec table back to the "TO" date or end date of the date range entered.

  - If either the Beginning balance or Ending balance for Bank Reconciliation is incorrect, likely the Current Checkbook balance is incorrect due to a recent posting interruption. (So any posting interruptions in-between the time you last reconciled the checkbook and TODAY could play a role, since the calculation starts with the checkbook balance as of TODAY.)

- ORIGINATING CURRENCY: The Reconcile to GL spreadsheet wasn't designed to be used for checkbooks in an originating currency. (But can work if you didn't have a beginning balance on the checkbook and haven't revalued the currency ID in GL.)
- If your checkbook is in an originating currency ID, both the Bank Reconciliation side and the GL side will display in the FUNCTIONAL amounts.
- If you entered a beginning balance in an originating currency on the checkbook at the time you created the checkbook, it isn't stored anywhere in the functional amount, so will be omitted from the Reconcile to GL spreadsheet, since it only displays functional amounts. The beginning and ending balances displayed for Bank Reconciliation won't include any amount from the beginning balance entered on the checkbook. You would have to manually update the beginning balance on the spreadsheet to include the amount of the beginning balance used on the checkbook if you wanted the amount to be correct. Otherwise, you can just ignore the beginning and ending balances, if your checkbook is in an originating currency ID) and just utilize the "Unmatched Transactions" section to help find differences to research.
- If you've processed any Revaluation in GL for the originating currency ID, the gain/loss entries will also be displayed on the GL side only of the spreadsheet. These aren't listed on the Bank Reconciliation side, thus causing a difference between the two sides. Revaluation only books gains/losses to the GL cash account in the functional currency and doesn't flow back to Bank Reconciliation. So if you have revaluated GL at all for this currency ID, then the Reconcile to GL tool wouldn't be recommended to use, as the GL side will include revalued amounts, and the Bank Reconciliation side doesn't.

## References

- [Information about differences when you reconcile General Ledger to Payables Management or to Receivables Management in Microsoft Dynamics GP](https://support.microsoft.com/topic/information-about-differences-when-you-reconcile-general-ledger-to-payables-management-or-to-receivables-management-in-microsoft-dynamics-gp-cbb2dacf-86e0-367b-86b9-99fa65347104).
- [Information about the balances in the Reconcile to GL window in Microsoft Dynamics GP](information-about-balances-in-reconcile-to-gl-window.md)
