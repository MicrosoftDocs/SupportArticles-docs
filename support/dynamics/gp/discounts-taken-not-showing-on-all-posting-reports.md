---
title: Discounts Taken not showing on all posting reports
description: When automatically applying credit memos during the checkrun to invoices with payment terms, the resulting posting journals may not reflect all the discounts that were taken. This issue occurs because of how the discounts follow the payment documents.
ms.reviewer: cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Discounts Taken not showing on all posting reports in Payables Management for Microsoft Dynamics GP

This article provides options to solve the issue that the discounts taken don't show on all posting reports in Payables Management for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2501363

## Symptoms

When automatically applying credit memos during the checkrun to invoices with payment terms, the resulting posting journals may not reflect all the discounts that were taken.

The most popular complaint is the GL Distribution Summary report misses the amount of the taken discounts on the invoice and was fully applied to a credit memo during the checkrun.

## Cause

This issue is caused by how the discounts that were taken were designed to follow the payment document. The apply process is handled separately from the checkrun process. Specifically, when credit memos are automatically applied to invoices during the checkrun, the discounts that were taken for payment terms on those invoices follow the fully applied credit memo and move to history. The discounts that were taken on the partially applied or other invoices follow the check. So, the resulting posting journals may have varying results, depending on whether that report shows the credit memo information in addition to the check information.

For example, consider this scenario:

> Payment terms: 2%  
Invoice #1 for $100 (Discount $2)  
Invoice #2 for $100 (Discount $2)  
Invoice #3 for $100 (Discount $2)  
Credit memo for $125 (Fully applied to Invoice #1 during the checkrun)  
Total Discounts Taken: $6 ($2 follows the credit memo, and $4 follows the check)  
Check = $169

The total discounts taken are $6, but some reports only show $4 for the discounts that follow the check. The discounts that follow the fully applied credit memo don't display on all the reports as follows:

> Computer Checks Posting Journal - Shows all discounts: $6  
Distribution Breakdown Register  - Only shows discounts that follow the check: $4  
GL Distribution Summary - Only shows discounts that follow the check: $4  
General Posting Journal (GL) - Shows all discounts: $6

## Resolution

The options are listed below:

Option 1 - If you're balancing the checkrun to what posted to GL, the easy workaround is to use the General posting Journal or Computer Checks Posting Journal instead. Don't use the GL Distribution Summary report to balance to GL. Since the amount of all the discounts taken automatically during the checkrun aren't reflected on the report (Or the user can just notice that the report will be short by the amount in the Additional Distributions section as reflected on the Computer Checks Posting Journal.)

Option 2 - Manually apply the credit memo's to the invoices beforehand using the Apply Payables Document window. The discounts taken will be booked at the time they're applied, and will also follow the credit memo. However, this keeps it outside of the checkrun. Turn off the option to automatically apply credit memo's during the checkrun.
