---
title: What Print Previously Applied DOCS does
description: Describes what does the Print Previously Applied Documents option in the Select Payables Checks window do in Microsoft Dynamics GP.
ms.reviewer: theley, Cwaswick
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# What does the Print Previously Applied Documents option in the Select Payables Checks window do in Microsoft Dynamics GP?

This article describes what does the **Print Previously Applied Documents** option in the Select Payables Checks window do in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4466409

## Issue

What does the **Print Previously Applied Documents** option in the Select Payables Checks window do in Microsoft Dynamics GP?

## Information

The **Print Previously  Applied Documents** checkbox in the Select Payables Checks window does exactly what it says it does.  Having this checkbox marked will print all the apply records for all documents that were applied in-between checkruns.

In-between checkruns, when you apply documents to each other, an apply record is written to the PM Remittance (PM20100) table. This table serves as a holding tank, and will print that apply record on the next check remittance or check stub issued to that vendor. The records will sit in this table until the vendor has a check issued. Once the next check for this vendor has been printed, these records will drop out of this table and won't be printed again.

**COMMON QUESTIONS:**  
**Q1:** If I apply a credit memo to an invoice, and haven't paid the net remaining amount of the invoice yet, how can I get the apply record for the credit memo to print on the check remittance at the time I pay off this specific invoice?

A: If you apply the credit memo, this apply record will print on the vendor's next check remittance. whether or not you pay the amount remaining on the invoice. There's no correlation between the payment and the credit memo. So if you want the credit memo to be printed on the same check stub as the net amount of the invoice is paid off, you'll need to wait to apply the credit memo to the invoice until you're ready to pay off the invoice.  

**Q2:** Can I remove some of the apply records from the current check remittance?

A: Again, all applied records will print and the purpose is to let the vendor know that these were applied to each other. It's the design. But yes, after building the checkrun, you can select **Edit Check Batch** and unmark any invoices you don't want to pay. (however any credit memo's applied to these invoices will still print.)  Then select **Edit Check**, find the check, and select **Check Stub** and you can unmark any apply records (that is, for invoice or credit memo) you don't want to print, and mark any apply records you want to print.

> [!NOTE]
> These records will still drop out of the Remittance table, so won't print again at a later time, just because you unmarked them here.

**Q3:** I've the **Print Previously Applied Documents** checkbox marked, but the apply record to the credit memo isn't printing when I pay off this invoice.

A: If you applied the credit memo at a previous point in time and the vendor has since had a payment, the apply record would have printed on that earlier check remittance. It isn't held until you pay off the invoice. This option simply prints ALL apply records. (The credit memo and payment have no correlation to each other.) If the apply record for the credit memo was help, it would never print for invoices and credit memo's that are fully applied to each other....so GP prints them on the next check stub.

**Q4:** How can I get the apply record for the credit memo to print on the payment where I pay off the invoice?
A: You must wait to apply the credit memo until you're ready to pay off the invoice.
