---
title: Values on the Received/Not Invoiced report may not match the general ledger in Microsoft Dynamics GP
description: Information about why the values on the Received/Not Invoiced report may not match the general ledger in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.date: 03/13/2024
---
# Information about why the values on the Received/Not Invoiced report may not match the general ledger in Microsoft Dynamics GP

This article contains information about why the values on the Received/Not Invoiced report may not match the value of the accrued purchases account in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 951236

The following list contains reasons that the values on the Received/Not Invoiced report may not match the value of the accrued purchases account in General Ledger.

- Records appear on the Received/Not Invoiced report if the receipt of the goods is posted through transactions that are entered in the Receivings Transaction Entry window. The records are not displayed on the report after the invoice is matched to the receipt and then saved. An invoice does not have to be posted to print on the Received/Not Invoiced report. Therefore, the values on the Received/Not Invoiced report do not match the value of the accrued purchases account in the General Ledger as long as the Purchase Order Processing module contains unposted invoices.

- When transactions are entered directly in General Ledger for the accrued purchases account, these transactions do not print on the Received/Not Invoiced report.

- On Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 9.0, purchase order returns do not print by default on the Received/Not Invoiced Report. If you enter purchase order returns, contact Technical Support for the PO Returns chunk file. The PO Returns chunk file modifies the Received/Not Invoice report to include purchase-order returns. On Microsoft Dynamics GP 2010, the PO Returns chunk file is not needed as that functionality is built into the application. For more information about the PO Returns chunk file, visit Microsoft Dynamics Technical Support to enter a new support request.

- If unposted batches exist in General Ledger for the accrued purchases account, the value of the accrued purchases account does not match the Received/Not Invoiced report.

- The Received/Not Invoiced report does not exclude transactions by date. Make sure that you view all transactions for the accrued purchases account in General Ledger.
