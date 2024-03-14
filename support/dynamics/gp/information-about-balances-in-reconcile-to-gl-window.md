---
title: Information about the balances in Reconcile to GL window
description: Provides information about the balances (RM, PM, and Bank Rec) in the Reconcile to GL window in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# Information about the balances in the Reconcile to GL window in Microsoft Dynamics GP

This article contains information about the Beginning and Ending Balances in the **Reconcile to GL** window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 3191232

## More information

The Reconcile to GL window was designed to display functional currencies only.

Payables Management and Receivables Management - The balances calculated in the *Reconcile to GL* window and spreadsheet are designed to be simple calculations from the *distribution* tables in the subledger and aren't the true balances. The true AR/AP balances are calculated in the HATB reports, which is a much more complex calculation. This *Reconcile to GL* spreadsheet wasn't intended to be used a Financial report. It was designed to be used as an *aid* to help find differences so you can reconcile the HATB report to the GL account balance. So, we recommend ignoring the totals and instead, focus on the **unmatched transaction** section to help find transactions to research that may help explain any differences between your HATB report balance and your GL account balance. For more information, see Q1 and Q2 at the bottom of [Information about differences when you reconcile General Ledger to Payables Management or to Receivables Management in Microsoft Dynamics GP](https://support.microsoft.com/topic/information-about-differences-when-you-reconcile-general-ledger-to-payables-management-or-to-receivables-management-in-microsoft-dynamics-gp-cbb2dacf-86e0-367b-86b9-99fa65347104).

### Bank reconciliation

- If your checkbook is in the functional currency, the Ending Balance should display the *Current Checkbook balance* (adjusted back to your To date in your Date Range by the transactions in the CM20200 table). The Beginning Balance should then adjust by the transactions in the CM20200 table back to the From date of your Date Range to arrive at a Beginning Balance to display for the Subledger.
- If your checkbook is in an *originating* currency, the beginning and ending balances in this window will omit the beginning balance amount since a functional currency equivalent of the beginning balance isn't stored. The Ending Balance column will display the net activity for the month (from the CM20200 table), but *you'll be off by the amount of your beginning balance, if your checkbook is in a non-functional currency*. In the meantime, you can manually add the beginning balance to the spreadsheet, and/or use the **unmatched** section to help find differences to research.
