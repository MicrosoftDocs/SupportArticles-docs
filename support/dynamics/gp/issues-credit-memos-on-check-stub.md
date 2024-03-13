---
title: Issues with Credit Memos on Check Stub
description: Discusses different issues for how credit memo's display on the check stub or remittance in Payables Management for Microsoft Dynamics GP.
ms.reviewer: cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Display issues with Credit Memos on Check Stub/Remittance in Payables Management for Microsoft Dynamics GP

This article discusses different issues for how credit memo's display on the check stub or remittance in Payables Management for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2581840

## Symptoms

How the credit memos display on the check stub or remittance in Payables Management can be confusing to a Microsoft Dynamics GP user or to a vendor. This article discusses several issues with how credit memos can display on the remittance.

## Cause

How credit memo's display on the remittance can be driven by the options set in Microsoft Dynamics GP.

## Resolution

1. Credit memos are displayed in the **Amount** column on the remittance. Why are they not displayed in the **Net** Column on the remittance?

    The amount of the credit memo in the payrun is listed in the **Amount** column. If this amount of the credit memo has been fully applied, it won't be listed in the **Net** column. Instead, it will be reduced from the amount of the invoice that it was applied to. Only the invoice will list a net amount if there are dollars left on the invoice to be paid after the credit memo was applied.

2. How do you know which credit memo is applied to which invoice?

    If you would like the credit memos that were applied to the invoices to be listed immediately below the invoice that it was applied to on the remittance, then you can set the Applied Order option for the remittance. To do it, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Purchasing**,  and then select **Payables**. Set the List Documents on Remittance to Applied Order.

3. Why are credit memos getting automatically applied in the checkrun?

    In the Select Payables Checks window, there's an option at the bottom for Automatically Apply Existing Unapplied. If you mark the option for Credit Memos, then the system will automatically reduce the amount of the check by the amounts of unapplied credit memos for the vendor. Unmark this option if you don't want the system to automatically apply credits and you want to apply the credits manually instead.

4. Why don't credit memos that I've applied since the last pay run show up on the remittance?

    To have documents print on the next check stub that were applied to each other since the last check for the vendor was issued, you can mark the Print Previously Applied Documents option in the Select Payables Checks window during the next checkrun. The system does track apply records in the Remittance (PM20100) table for documents applied to each other in between checkruns to be printed on the next check issued to the vendor.

    You can set the Print Previously Applied Documents option to stay marked by default by going to Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Purchasing**, and then select **Payables**. In the Payables Management Setup window, mark the checkbox for Print Previously Applied Documents on Remittance, and then select **OK**.

5. Why is the amount in the Amount column on the remittance not the original amount of the credit memo?

    It has to do with the way that applies records are stored for the credit memos and the options you have set. The amount listed for the credit memo should be the amount of the credit memo that is being applied in the specific checkrun.

    If you've the **List Documents on Remittance** set to **Applied order** (as in step 2), then the **Amount** column on the remittance will display the applied amount of the credit memo in the **Amount** column that is applied to the invoice listed immediately above it. For example, if a $300 credit memo has $100 of it applied to one invoice and $200 applied to a different invoice, then the credit memo number will be listed immediately below each invoice on the remittance, in the amounts of $100 and $200 respectively.

    If you have the **List Documents on Remittance** set to **All Documents**, then the amount of the credit memo will be listed in the **Amount** column that is being used in this checkrun. Using the example, above the **Amount** column will list $300 for the credit memo with the net amount showing as $0.00 since it has been applied to other invoices on the remittance.
