---
title: Description of the fiscal year-end closing process
description: Describes the fiscal year-end closing process in General Ledger, in Payables Management, and in Receivables Management in Microsoft Dynamics GP.
ms.reviewer: theley, jakelaux, Lmuelle
ms.date: 03/13/2024
---
# Description of the fiscal year-end closing process in General Ledger, Payables Management, and Receivables Management

This article describes the fiscal year-end closing process in the following modules in Microsoft Dynamics GP:

- General Ledger
- Payables Management
- Receivables Management

> [!NOTE]
> Review this article before you perform any procedures that are described in this article.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850151

> [!IMPORTANT]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To perform the fiscal year-end closing process, follow these steps.

> [!NOTE]
> You must perform the fiscal year-end procedures in Payables Management and in Receivables Management before you perform the year-end closing procedures in General Ledger.

1. Perform the year-end closing procedures for one of the following modules:

    - Payables Management
    - Receivables Management

    For more information about how to perform the year-end closing procedures for both modules, see:

    - [Year-end closing procedures for the Payables Management module in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-year-end-closing-procedures-for-the-payables-management-module-in-microsoft-dynamics-gp-259ad6ce-f78c-b7fd-cd99-415e3f3caee5)
    - [Year-end closing procedures for Receivables Management in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-year-end-closing-procedures-for-receivables-management-in-microsoft-dynamics-gp-a98e2398-200f-cfbf-3a59-aa5df7092fab)

2. Perform the fiscal year-end procedures in the module for which you performed the year-end closing procedures in step 1.
3. Repeat steps 1 and 2 for the other module.
4. Perform the year-end closing procedures for General Ledger.

    For more information about how to perform the year-end closing procedures for General Ledger, see:

    [Year-end closing procedures for General Ledger in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-year-end-closing-procedures-for-general-ledger-in-microsoft-dynamics-gp-4447f7bb-7143-60e2-882a-c7ae86f5792e)

    > [!NOTE]
    > There is no separate year-end closing process for Analytical Accounting. The dimensions in Analytical Accounting must be properly marked for the balances to be automatically consolidated when the year-end process for General Ledger is performed for Dynamics GP 10.0, Service Pack 2 and greater versions. Refer to the [Year-end closing procedures for General Ledger in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-year-end-closing-procedures-for-general-ledger-in-microsoft-dynamics-gp-4447f7bb-7143-60e2-882a-c7ae86f5792e) for additional information.

5. Perform the fiscal year-end procedures in General Ledger.

The fiscal year-end procedures in Payables Management and in Receivables Management transfer the year-to-date balances. These balances are transferred to last year's balances for the vendors and for the customers.

> [!NOTE]
> The 1099 amounts and the finance charges are not transferred when you perform the fiscal year-end procedures. The 1099 amounts and the finance charges are transferred during the calendar year-end close.

Before you post transactions to the next fiscal year, make sure that you complete the fiscal year-end closing procedures for Payables Management and for Receivables Management. If you post transactions to the next fiscal year before you close these modules, the yearly summary amounts of the customer and of the vendor will display incorrect information. All the information that was posted from both fiscal years will be transferred. This information will be transferred to the fields that are used for the last year. Additionally, the fields that are used for the year-to-date value will display a value of **$0.00**.

If you do not close the fiscal year in Payables Management or in Receivables Management before you post the transactions to the next fiscal year, the following windows will display incorrect information:

- The Customer Summary window
  To open the Customer Summary window, point to **Sales** on the **Cards** menu, point to **Summary**, and then select **Customer Summary**.
- The Vendor Yearly Summary window
  To open the Vendor Yearly Summary window, point to **Purchasing** on the **Cards** menu, point to **Summary**, and then select **Yearly**.
- The Customer Yearly Summary Inquiry window
  To open the Customer Yearly Summary Inquiry window, point to **Sales** on the **Inquiry** menu, and then select **Yearly Summary**.
- The Vendor Yearly Summary Inquiry window
  To open the Vendor Yearly Summary Inquiry window, point to **Purchasing** on the **Inquiry** menu, and then select **Vendor Yearly**.

> [!NOTE]
> All the other windows will display correct information.

When you perform the year-end closing procedures in General Ledger, the following processes are performed:

1. Amounts are transferred from the Open Year table to the Transactions History table and to the Account History table.
2. The general ledger balances are reconciled and summarized.
3. Amounts in the open-year *Profit and Loss* account are transferred to the Retained Earnings account.
4. The amounts in all the *Profit and Loss* accounts are zeroed.
5. The amounts in the Balance Sheet account are summarized. Then, the balances are brought to the new fiscal year as Balance Brought Forward (BBF) entries.
6. Inactive GL accounts with no current year history are removed.
7. If Analytical Accounting is installed, the records are also moved to history for this module for the dimensions that you marked to be included in year-end.
8. The Year-End Closing report is printed.

> [!NOTE]
>
> - You can post transactions to the next fiscal year without closing the previous fiscal year in General Ledger.
> - Beginning balances on the balance sheet display **$0.00**. And, the trial balance for the next fiscal year displays **$0.00**. Additionally, the value is not updated until you close the previous fiscal year.
