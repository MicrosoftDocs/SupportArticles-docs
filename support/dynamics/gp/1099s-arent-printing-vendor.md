---
title: 1099s aren't printing for Vendor
description: This article contains answers why 1099s may not print for a vendor and other frequently asked questions about 1099s in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/16/2024
---
# 1099s aren't printing for Vendor (and other FAQ about 1099s) in Payables Managements for Microsoft Dynamics GP

This article provides a solution to an issue where 1099s aren't printing for Vendor in Payables Managements for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2735868

## Symptoms

This article contains information on why 1099 forms may not print for a vendor (and other frequently asked questions about 1099s) in Payables Management in Microsoft Dynamics GP.

## Cause

See various reasons listed below.

## Resolution

A 1099 may not print for a vendor for the following reasons:

- The vendor isn't set up to be a 1099 vendor.

    To check it, select the **Cards** menu, point to **Purchasing** and select **Vendor**. Enter a Vendor ID and select the **Options** button. In the *Vendor Maintenance Options* window, make sure a Tax Type and 1099 Box are selected. (Selecting or changing these options will only take effect going forward and won't update any past history.)

- Make sure the correct 1099 Type is selected in the *Print 1099* window as the vendor is set up for.

    Navigate to **Tools** on the Microsoft Dynamics GP menu, point to **Routines**, point to **Purchasing** and select **Print 1099**. Verify the 1099 Year and 1099 Type selected is the same as the vendor is set up for.

- Check to make sure the vendor has exceeded the minimum amounts in the 1099 Setup window.

    The vendor must meet established minimum amounts in order for a 1099 to print. To check what the minimum amounts are for each 1099 Type and 1099 Box, navigate to **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **Purchasing** and select **Payables**. In the *Payables Management Setup* window, select the **1099 Setup** button.

    For example, in order for a Tax Type of Miscellaneous and 1099 Box number of 7, the vendor must have at least $600.00 of payments made in the calendar year (that were marked as 1099able). If the vendor has less than $600.00, then the 1099 form won't print for this vendor.

- Invoices are still in open status and not paid. The 1099 amounts will be reported in the year according to the paid date/apply date of the payments applied to the invoices.

- The vendor was set up as 1099able after the invoices were paid.

- Verify the 1099 amount field on the invoice is populated. If the vendor is set up to be 1099able, the 1099 Amount field in the Payables Transaction Entry window should automatically populate. However, the user may be editing the 1099 Amount field to $0.00 before posting the invoice.

    To check older invoices, select **Inquiry**, point to **Purchasing** and select **Transaction By Vendor**. Enter the Vendor ID and make sure History is included. Select the historical invoice in question and select the Document Number link to zoom back and view the 1099 Amount field on the invoice. (If the transaction originated in POP, when you drill back, you'll see a 1099 Amount field in the Receivings Transaction Inquiry Zoom window. The field could have been zeroed at time of posting by a user.

## Frequently Asked Questions

Q1: How are 1099 values updated?

A1:  The 1099 Details are updated according to when an invoice is paid out/applied. Consider the example below:

Scenario 1 - Invoice Date is 11/27/2024; Payment Date is 12/11/2024 - This invoice will be included in the 1099 for year 2024.

Scenario 2 - Invoice Date is 11/27/2023; Payment Date is 1/11/2024 - This invoice will be included in the 1099 for year 2024.

Scenario 3 - Invoice Date is 5/1/2024 and hasn't yet been paid out - This invoice won't appear on a 1099 until it's paid out.

> [!NOTE]
> The Historical Aged Trial Balance (HATB) Report will remove the invoice off the report based on the document date of the check that is applied to the invoice.

Q2: How do you update 1099 amounts for vendors that weren't setup as 1099 vendors or that where switched half way through the year?

A2: You can update vendors to be 1099able using any of the following methods:

- **Method 1**: Manually update the *1099 Details* window. Select **Cards**, point to **Purchasing** and select **1099 Details**. Any changes made to this window will update the 1099 that is to be printed. (If a reconcile is done, your edits to this 1099 window will be lost.)
- **Method 2**: Use the 1099 Modifier that is included in Professional Services Tools Library (PSTL). This method will update all invoices entered for the calendar year if the vendor wasn't* previously marked as 1099able.
- **Method 3**: Update 1099 Information window - Navigate to **Tools**, point to **Utilities**, point to **Purchasing** and select **Update 1099 Information**.

For Microsoft Dynamics GP 2013 and later, if you mark **Vendor and 1099 Transaction** radio button, you'll also have the option for **Not a 1099 Vendor** in the TO and FROM pick lists, which will allow for additional functionality to modify a vendor as 1099able retroactively for the year, or to unmark a vendor that shouldn't have been marked as 1099able for the year. This new functionality will change the 1099 status on the vendor going forward, and update the 1099 information with all the 1099 documents amounts for the year, and vice versa.

- **Method 4**: In Microsoft Dynamics GP, there are two new features that allow you to edit 1099 information per Transaction or per Vendor.

  - Edit 1099 Transaction Information - Select **Transactions**, point to **Purchasing**, and select **Edit 1099 Transaction Information**. Only 1099 vendors are displayed in this window. The transaction information (with a 1099 amount) for the vendor selected will be displayed. For debit type documents (invoices), you can edit the Tax Type, Box Number, and 1099 Amount on open and history transactions. For credit type documents (credit memos, returns), you can only edit the Tax Type and 1099 Amount. Documents are displayed in the functional currency. Select the **Process** button to save the changes keyed, and print the *PM Update 1099 Trx Information Audit* report that lists the changes made.

  - Update 1099 Information per vendor - As already discussed in Method 3 above, in Microsoft Dynamics GP, by using the option for Not a 1099 Vendor in the TO and FROM fields as appropriate, you can mark a vendor (and transactions) as 1099able for the year that wasn't previously marked as 1099able, or remove the 1099 information for a vendor that was marked as 1099able in error for the year.

Q3: What documents will update 1099 amounts?

A3: Below is how 1099 amounts are updated per document type:

1. The invoice has a 1099 Amount and has been posted, and applied to Credit Memo that doesn't have 1099 Amount. When you go to the 1099 details window, you'll see the 1099 amount.

2. The invoice has a 1099 Amount and has been posted and applied to a return that doesn't have a 1099 amount. When you go to the 1099 details window, you'll see the 1099 amount.

3. The invoice has a 1099 Amount and has been posted and applied to a computer check or manual check. When you go to the 1099 details window, you'll see the 1099 amount.

4. Voiding a check and causing the invoice to go back into open, the 1099 details window will be reduced by the amount of the check that was voided.

Q4: What documents won't update the 1099 amount?

A4: The scenarios won't update the 1099 amount:

1. The invoice has a 1099 Amount and has been posted and applied to a Credit Memo that also has a 1099 Amount. When you go to the 1099 details window, you won't see the 1099 amount because they netted each other out.

2. The invoice has a 1099 Amount and has been posted and applied to Credit Memo that also has a 1099 amount. When you go to the 1099 details window, you won't see the 1099 amount because they netted each other out.

3. Voiding an open invoice won't affect the 1099 Amount.

4. An invoice with a 1099 amount that is either saved or posted, but not applied.

5. If the 1099 amount on the invoice was manually cleared by the user at the time the user entered the invoice, it won't update the 1099 information since the 1099 Amount field is 0.00.

6. If a credit memo is keyed with a 1099 Amount and not yet applied.

Q5: If I run a reconcile, what 1099 data will be changed?

A5: If you run a reconcile, these fields will be corrected:

- Changes made to the 1099 Details window (or the PM00202 table to the TEN99ALIF) will be corrected according to the detail records when doing a summary reconcile.

- Changes made to the Payables Summary window (or the PM00204 to the TEN99AMNT) will be corrected according to the detail records when doing a summary reconcile.

- Changes made to the PM30300 (TEN99MNT) will cause the 1099 details to change when doing a calendar reconcile.

- If a Credit Memo was entered with a 1099 Amount, it won't show in the 1099 Details window. If the record was supposed to show in the window update PM30300 set Credit1099Amount and run the calendar reconcile. (Be sure to see if the document it was applied to also has a 1099 amount, as they may have netted each other out.)

## More information

Make sure to update to the latest service pack for the version of Microsoft Dynamics GP you're using, to make sure you get any updates that have been made.
