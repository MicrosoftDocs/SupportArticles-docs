---
title: Void Payables check with credit documents
description: Describes how to void a Payables check with credit documents applied in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Voiding a Payables check with credit documents applied in Microsoft Dynamics GP

This article describes how to void a Payables check with credit documents applied in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4058555

## Question

In Microsoft Dynamics GP 2013 RTM, a new feature was introduced to void a payables check and credit documents would be unapplied. Will all credit documents be unapplied?

## Answer

When the payment is voided, the invoices that were paid by that check will return to open status, and will also automatically unapply any credit memo's or returns that were also applied to that same invoice. The credit document will be unapplied if:

- the credit document is a credit memo or return type.
- the credit document was previously applied to the invoice or automatically applied during the select checks process.
- The payment is a computer check or manual payment.

> [!NOTE]
> If the credit document is partially applied across multiple invoices, only the portion of the credit document that is directly linked to the voided payment will be unapplied.
>
> Only credit documents applies to the SAME INVOICE that is also paid by the computer check or manual check will be unapplied. The system won't un-apply all credit documents that were automatically applied during the checkrun process, and have no amount paid by the check that is being voided.

See below scenarios:

**Example 1:**

ACETRAVE001 has a $25 credit memo that was previously applied to a $500 invoice. The net remaining invoice amount is $475.  However, there's another credit memo for $75 for this vendor that hasn't yet been applied.

During the Select Checks process, the credit memo's are set to be automatically applied.

Check #20063 is printed and posted for a net amount of $400. The check remittance lists the following ones:

Invoice  $500.00  
Credit memo ($25.00)  
Credit memo ($75.00)  
Net amount paid:  $400.00  

Result: When check #20063 is voided, the invoice goes back to open status with an unapplied amount of $500.00. Both credit memo's were unapplied and also returned to open status.  The credit memos and invoice are no longer linked to each other.  The user can:

- Void the invoice without affecting the credit memo.
- Void the credit memo without affecting the invoice.
- Reapply the credit memo to a different invoice (or same invoice)
- Apply a different credit document to the invoice, without reusing the credit memo.

**Example 2:**

ACETRAVE001 has two unapplied credit memos for $25 and $100 each.  They have three open invoices for $25, $75 and $50.

During the Select Checks process, the credit memo's are set to be automatically applied.

- The credit memo for $25 was applied to the invoice for $25
- The credit memo for $100 was split, with $75 applied to the invoice for $75 and $25 applied to the invoice for $50
- The invoices for $25 and $75 were fully applied to credit memos
- The invoice for $50 was partially applied to a credit memo for $25 and $25 is still remaining

Check #20064 is printed and posted for a net amount of $25.00.  The check remittance lists the following ones:

Invoice  $25.00  
Invoice  $75.00  
Invoice  $50.00  
Credit memo ($25.00)  
Credit memo ($100.00)  
Net amount paid:  $25.00  

When check #20064 is voided, only the documents directly applied to the voided payment are affected. So the invoice for $50 is returned to open status with an unapplied amount of $50. The credit memo for $100 is returned to open status, with an unapplied amount of $25

> [!NOTE]
> The invoice for $25, invoice for $75, and credit memo for $25 remain in history, as they were not directly linked to the voided payment.  Also, the credit memo for $100 only had the $25 return to open status as that is the only amount that was associated with the invoice that was directly applied to the voided payment.

In summary, the void process will return the invoice to open that the payment was paying for, and unapply any credit documents that are also applied to that invoice. It won't unapply any other invoices/credit documents that were fully applied to each other during the auto apply process done by the checkrun and don't have any apply records directly linked to the voided payment.

## More information

- Watch [video](https://community.dynamics.com/blogs/post/?postid=251b4f6e-312d-4815-95e1-c390e70a25e2) clips for all the new features introduced in Microsoft Dynamics GP 2013
