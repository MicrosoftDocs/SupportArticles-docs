---
title: How to void a transaction for an Australian company
description: Describes how to void a transaction for an Australian company in Microsoft Dynamics GP 9.0, Microsoft Business Solutions - Great Plains 8.0, and Microsoft Business Solutions - Great Plains 7.5.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# How to void a transaction for an Australian company in Microsoft Dynamics GP

This article describes how to void a transaction for an Australian company in the following products:

- Microsoft Dynamics GP 9.0
- Microsoft Business Solutions - Great Plains 8.0
- Microsoft Business Solutions - Great Plains 7.5

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933936

If a transaction was already reported to the Australian Taxation Office (ATO) agency by using a Business Activity Statement (BAS) form, any changes that you make to the transaction must appear in a new document. This is true so that you maintain an audit trail. If you want to void this transaction, you must use a debit memo or a credit memo to adjust the account in Receivables Management or in Payables Management in Microsoft Dynamics GP. If you void a reported transaction, the transaction is removed from the BAS form. However, the values in the current BAS reporting period are not adjusted.

To make sure that reported transactions cannot be modified, close the tax periods that were already reported to the ATO agency. New transactions cannot be added to a closed tax period. Additionally, existing transactions cannot be voided in a closed tax period. Therefore, if you reprocess and then reprint the BAS form, the values on the form are unchanged.

To verify that a tax period is closed, follow these steps:

1. On the **Tools** menu, point to **Setup**, and then point to **Company**.
2. Select **Tax Periods**.

If a transaction was not reported to the ATO agency, you can use the Void function to void the transaction. In this situation, the transaction does not appear on the BAS form.
