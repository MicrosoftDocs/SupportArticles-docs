---
title: Can't unapply a payment when you transfer payment to history tables in Receivables Management in Microsoft Dynamics GP
description: Describes a problem that occurs in which you cannot unapply a payment that is in the history tables. You must remove the payment and the applied documents from the history tables or use the Transaction Unapply tool. Workarounds are provided.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# You cannot unapply a payment when you transfer the payment to the history tables in Receivables Management in Microsoft Dynamics GP

This article provides workarounds for an issue where you can't unapply a payment when you transfer the payment to the history tables in Receivables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 853678

## Symptoms

When you transfer a payment to the history tables in Receivables Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you cannot unapply the payment.

To work around this problem, use one of the following methods.

## Workaround 1: Remove the payment and the applied documents from the history tables

1. Use the **Remove Receivables Transaction History** window to remove the payment and applied documents. To do this, use one of the following methods:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Sales**, and then click **Remove Transaction History**.

   - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Utilities** on the **Tools** menu, point to **Sales**, and then click **Remove Transaction History**.

2. Reenter the payment and the applied documents in the **Receivables Transaction Entry** window and in the **Cash Receipts Entry** window. To open the **Receivables Transaction Entry** window, point to **Sales** on the **Transactions** menu, and then click **Transaction Entry**. To open the **Cash Receipts Entry** window, point to **Sales** on the **Transactions** menu, and then click **Cash Receipts**.

> [!NOTE]
> If you do not want the transactions to update General Ledger, delete the batch that is created in General Ledger. Or, post reversing transactions.

## Workaround 2: Use the Transaction Unapply tool

You can use the Transaction Unapply tool in the Professional Services Tools Library (PSTL) to unapply documents in the history tables. The Transaction Unapply tool automatically moves the records back to the open tables. Then, you can reapply the records as needed.

For more information about the Professional Services Tools Library, use one of the following options:

- Customers:

    For more information about PSTL, contact your partner of record. If you do not have a partner of record, visit the following web site to identify a partner: [Microsoft Pinpoint](https://pinpoint.microsoft.com/home)

- Partners:

    For more information about PSTL, visit this [web site](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem).
