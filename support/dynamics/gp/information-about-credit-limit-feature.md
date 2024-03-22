---
title: Credit Limit feature used in Receivables Management and in National Accounts in Microsoft Dynamics GP
description: Information about the Credit Limit feature that is used in Receivables Management and in National Accounts in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# Information about the Credit Limit feature that is used in Receivables Management and in National Accounts in Microsoft Dynamics GP

This article introduces the Credit Limit feature that is used in Receivables Management and in National Accounts in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 953216

## Introduction

The Credit Limit feature is used in Receivables Management and in National Accounts in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains. The Credit Limit feature lets you have a specific amount of credit based on the rules that are set up in the Customer Maintenance Options window. After you specify an amount in the **Credit Limit** area in the Customer Maintenance Options window, you can click the expansion button to set the total balance and the balance for one or more aging periods.

This article describes where the transaction balances come from and what formulas are used.

## More information

Microsoft Dynamics GP examines the credit limit by comparing the current open transactions amount plus the entered transaction amounts to the credit limit settings. The credit limit settings are stored in the RM_Customer_MSTR table (RM00101). The current open transactions amount is stored in the RM_Customer_MSTR_SUM table (RM00103). The period balances are stored in the RM_Customer_MSTR_Period_SUM table (RM00104).

You can use the following Boolean expression to examine the credit limit of a specific customer.

('Customer Balance' + CurrentInvoiceDollarAmount {this is for your current document} + 'Unposted Sales Amount' + 'Unposted Other Sales Amount' + 'On Order Amount' - 'Unposted Cash Amount' - 'Unposted Other Cash Amount' - 'Deposits Received') > 'Credit Limit Amount' of table RM_Customer_MSTR

All the unspecified fields are stored in the RM_Customer_MSTR_SUM table. If this expression evaluates to true, the customer is over the credit limit.

> [!NOTE]
> National accounts may be used and may be set up to perform combined customer credit limit checks. In this case, the total amount of all child customers is compared to the credit limit amount of the parent customer to see whether the credit limit is exceeded.

The balances that are stored in the RM_Customer_MSTR_SUM table include the following transactions from the Sales series modules:

- Posted documents and unposted documents in Receivables Management in Microsoft Dynamics GP
- Posted invoices and unposted invoices in Invoicing in Microsoft Dynamics GP
- Posted orders, unposted orders, posted invoices, and unposted invoices in Sales Order Processing in Microsoft Dynamics GP

> [!NOTE]
> Sometimes, Microsoft Dynamics GP lets a customer exceed the credit limit because the open transactions that are already posted in the system are not considered. This behavior occurs because the information in the summary tables does not represent the information about the actual transactions.

If you run the Reconcile utility for the customers in question, the balances that are stored in the summary tables are corrected. Therefore, the credit limit check works correctly. To do this, follow these steps:

1. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Sales**, and then click **Reconcile**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Utilities** on the **Tools** menu, point to **Sales**, and then click **Reconcile**.

2. In the **Reconcile Receivables Amounts** window, click **Current Customer Information** in the **Reconcile** area, set the range of customers who should be reconciled in the **Range** area, and then click **Process**.

## References

For more information, see the topics about how to set up a customer credit limit in Help or in the user guides.
