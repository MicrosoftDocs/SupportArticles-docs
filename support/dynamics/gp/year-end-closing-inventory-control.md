---
title: Year-End Closing in Inventory Control
description: Describes how to close the year and how to prepare your inventory records for the new fiscal year in Inventory Control in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# Year-End Closing procedures in Inventory Control in Microsoft Dynamics GP

This article discusses how to close the year and how to prepare your inventory records for the new fiscal year in Inventory Control in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872713

## Inventory year-end closing procedures

Follow these steps to close the year and to prepare your inventory records for the new fiscal year. Closing a year transfers all summarized current-year quantity (cost and sales amounts) to transaction history for the items for which you have been keeping a summarized Sales History. The Quantity Sold field for each item is set to zero. These steps also update the amount in each item's Beginning Quantity field to the Quantity on Hand field at each site.

### More resources

- Refer to the [Inventory Year-End Closing Tips](#inventory-year-end-closing-tips)
- Refer to the [Inventory Year-End Questions and Answers](#inventory-year-end-frequently-asked-questions)

## Summary steps

1. [Post all transactions for the year.](#step-1-post-all-transactions-for-the-year)
1. [Reconcile inventory quantities.](#step-2-reconcile-inventory-quantities)
1. [Complete a physical inventory count, and then post any adjustments.](#step-3-complete-a-physical-inventory-count-and-then-post-any-adjustments)
1. [Print additional reports.](#step-4-print-additional-reports)
1. [Make a backup.](#step-5-make-a-backup)
1. [Close the year.](#step-6-close-the-year)
1. [Close the fiscal periods for the Inventory series (optional).](#step-7-close-the-fiscal-periods-for-the-inventory-series-optional)
1. [Make a final backup.](#step-8-make-a-final-backup)

### Step 1: Post all transactions for the year

Make sure that all Invoicing transactions, Sales Order Processing transactions, and Inventory transactions for the current year have been entered and then posted before you close the year. It's true so that historical information is accurate for the year you're closing, and year-to-date amounts are accurately stated for the new year. If you want to enter future-period transactions before closing the year, create a new batch that has new transactions. However, don't post the batch until after the year has been closed.

### Step 2: Reconcile inventory quantities

Reconcile quantities for all items by using the Reconcile Inventory Quantities window to make sure that your Inventory Control data hasn't become damaged during the year. To open the Reconcile Inventory Quantities window, follow this step:

- In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Inventory**, and then select **Reconcile**.

If any differences are found during the reconcile process, the quantities will be adjusted. If adjustments are made, they'll be reflected on the Reconcile Report. Additionally, any serial numbers and lot numbers that were added for the adjusted items are included. If you want to change these serial numbers and lot numbers, you can use the Item Transaction Entry window. Enter decrease adjustment transactions to remove the existing serial numbers and the existing lot numbers. Then, enter increase adjustment transactions to enter the correct serial numbers and the correct lot numbers. To open the Item Transaction Entry window, point to **Inventory** on the **Transactions** menu, and then select **Transaction Entry**.

### Step 3: Complete a physical inventory count, and then post any adjustments

1. Use the Stock Calendar Maintenance window to set up and then maintain information about when stock counts can be performed and about which days will be counted when the system calculates suggested dates for the next stock count for a specific item-site combination. To open the Stock Calendar Maintenance window, follow this step:
    - In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Inventory**, and then select **Stock Calendar**.
2. The Stock Count Cycle Assignment window can be used if you want to assign one stock count frequency to many items. To open the Stock Count Cycle Assignment window, point to **Inventory** on the **Cards** menu, and then select **Count Cycle Assignment**.
3. Create a Stock Count Schedule. A Stock Count Schedule is a list of the specific items at a specific site that will be counted during a specific count. When you start a stock count schedule, the quantity on hand for each line in the stock count schedule is captured. Later, the actual count number quantities will be compared to the captured values to create default variance transactions. Stock Count Forms can be printed during this process. To open the Stock Count Schedule window, point to **Inventory** on the **Transactions** menu, and then select **Stock Count Schedule**.
4. Use the Stock Count Entry window to enter information about the results of your stock counts. When you process a stock count, variance transactions are created. If the **Autopost Stock Count Variances** check box is selected, the transactions will also be posted. To open the Stock Count Entry window, point to **Inventory** on the **Transactions** menu, and then select **Stock Count Entry**. Instead of following step 3, you can manually create your adjusting entries. To do it, print a Physical Inventory Checklist by using the Inventory Activity Reports window, and then do a physical count of your Inventory Items to verify that quantity on hand amounts are accurate for all Items. To open the Inventory Activity Reports window, point to **Inventory** on the **Reports** menu, and then select **Activity**.

If there are any differences, enter the necessary adjustments in the Item Transaction Entry window, and then post the transactions. To open the Item Transaction Entry window, point to **Inventory** on the **Transactions** menu, and then select **Transaction Entry**.

### Step 4: Print additional reports

Print any additional reports that you'll need for planning or for your permanent records. The suggested reports are as follows:

- Stock Status Report
- Purchase Receipts Report
- Turnover Report
- Transaction History Report
- Serial Number List
- Lot Number List

To access the Reports palette, point to **Inventory** on the **Reports** menu. Use selections from the Inventory Reports palette to print these reports. If you plan to remove sold purchase receipts during the year-end closing process, we recommend that you print the Purchase Receipts Report to review the receipts that will be removed.

### Step 5: Make a backup

**Make a backup of all company data!**  
It's true so that you'll be able to recover quickly should a power fluctuation or other problem occur during the year-end closing procedure.

### Step 6: Close the year

To do it, select **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Inventory** and select **Year-End Close**.

Closing a year, does the following tasks:

- Transfers all summarized current-year quantity (cost and sales amounts) to transaction history for the Items for which you have been keeping summarized sales history.
- Updates the amount in the item's Beginning Quantity field to the Quantity on Hand field at each site. Certain reports, such as the Turnover Report, use the amount in the Beginning Quantity field for report calculations.
- Zeros the Quantity Sold field in Item Quantities Maintenance window for each site.
- Removes purchase receipts and cost change history for items that have been sold.
- Removes any discontinued items from the Item records that have been sold.
- Removes any lot attributes from the records of lot numbered items if they have been sold.
- Updates the standard cost of each item to the current cost if you use either the FIFO periodic method or the LIFO periodic valuation method.
- Uses the Inventory Year-End Closing window to close the year.

The following options are available:

- Remove: Discontinued Items

    If you select the **Discontinued Items** check box, all discontinued Items that have a zero balance (that is, no quantity) will be removed from all IV tables during the year-end closing process. Items can be designated as discontinued by using the Item Maintenance window. Discontinued Items that have a quantity on hand of zero (except for kit components) and have no unposted transactions will be removed from the Inventory module. If you use the Service Call Management module, determine whether any discontinued items exist on any unposted service documents. If discontinued items exist on any unposted service documents, the documents must be posted before you continue. The Sales Order Processing report, the Invoicing report, or the Purchase Order Processing report and inquiries will still be able to display information about these discontinued items. However, you'll be unable to do a lookup on the Item Number because it has been removed from the Item Master table. If you want to print a report or inquire on the discontinued Item, you must include the item within the Item Number range.

    > [!NOTE]
    > If you select this option, you will remove the discontinued items. Additionally, you will remove all inventory history for the items. You will be unable to drill back on the inventory history for these items.

- Remove: Sold Receipts and Cost Change History before [date]

    If you select the **Sold Receipts** check box, all sold receipts whose quantity received amounts and quantity sold amounts are equal will be removed. (Records will be removed from the IV10200 that are marked as sold [RCPTSOLD=1], and the corresponding records from the IV10201 [linked by IV10201.RCTSEQNM = IV10200.SRCRCTSEQNM].) It's an optional step, and it may not be a procedure that is performed every year-end. These values may help when items are returned through Invoicing. So you may not want to remove the purchase receipts from the file.  

    In Microsoft Dynamics GP, remove: Sold Receipts and Cost Change History Prior To. Select the **Sold Receipts and Cost Change History Prior To** check box to remove all sold purchase receipts and historical cost changes for items that use Average Perpetual, Last In, First Out (LIFO) Perpetual, or the First In, First Out (FIFO) Periodic valuation method, and then you enter a date. The sold receipts, quantity sold details, and historical cost changes with dates that come before the date that you entered will be removed.

- Remove: Sold Lot Attributes

    If you select the **Sold Lot Attributes** check box, values for sold lot numbers will be removed. For example, you can remove the value red for the lot attribute Color if you have sold all lot numbered items that have been assigned the value red.

- Update: Item's Standard Cost

    If you select the **Item's Standard Cost** check box, the Standard Cost for any items that have been assigned the FIFO periodic valuation method or the LIFO periodic valuation method will be adjusted automatically to reflect each item's current cost or the amount you most recently paid for the item. If you're registered for the Manufacturing module, you'll be unable to select the **Item's Standard Cost** check box.

    > [!NOTE]
    > When you select to update an item's standard cost during the Inventory Year-End Closing process for Standard Cost Items, you must have the *Standard Cost Revaluation Account* populated in one of the two locations listed below in order for the Year-End Close process to complete. If you don't have the account populated the Exception Report will print with the list of items that need to be populated before you'll be able to process the year-end closing.

    1. **Cards > Inventory > Item > Account** (for each periodic item)
    1. **Microsoft Dynamics GP > Tools > Setup > Posting > Posting Accounts > Inventory series**.

When you've selected all the options that you want, select **Process** to start the year-end closing process. When the year is being closed, you'll be unable to post, reconcile quantities, change valuation methods, or change decimal places for items.

### Step 7: Close the fiscal periods for the Inventory series (optional)

You can use the Fiscal Periods Setup window to close fiscal periods that are still open for the year. To open the Fiscal Periods Setup window, follow this step:

- In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**. It keeps transactions from accidentally being posted to the wrong period or year.

Make sure that you've posted all transactions for the period and year for all modules before closing fiscal periods. If you later have to post transactions to a fiscal period you've already closed, you must return to the Fiscal Periods Setup window to reopen the period before you can post the transaction.

### Step 8: Make a final backup

Make a final backup of the company data files and keep it in safe, permanent storage. It gives you a permanent record of the company's financial position at the time that you closed the year.

## Inventory year-end closing tips

- The year-end close must be done before any transactions for the new year have been posted.
- You've the option to select the **Discontinued Items** check box, the **Sold Receipts** check box, or the **Sold Lot Attributes** check box. If you select these check boxes, all items, sold receipts, and sold lot attributes that have a zero balance will be removed during the year-end closing process.
- If you select the **Update Item's Standard Cost** check box, the standard cost for any items that have been assigned the FIFO periodic valuation method or the LIFO periodic valuation method will be adjusted automatically to reflect each item's current cost. The current cost is the amount that you most recently paid for the Item.
- There's no Year End Closing report for Inventory.

## Inventory year-end frequently asked questions

**Q1: How is the average cost of an item updated throughout the year and during the year-end closing process when you use the Average Perpetual valuation method?**  

A1: If you're using the Average Perpetual valuation method, all receipts for each item will be averaged to determine the average cost. The year-end closing process doesn't change the average cost. However, it will remove the purchase receipts that have been sold. The next time that a receipt is entered, the average cost will be revalued with the receipts that remain in the Inventory Purchase Receipts file.

> [!NOTE]
> Enhancements were made to the calculation of the average cost in Microsoft Dynamics GP  9.0 that would still apply. For more information about the calculation of average costs, see [Enhancements made to the calculation of Average Cost in Microsoft Dynamics GP](https://support.microsoft.com/help/923960)

**Q2: Can the Inventory Year-End Closing window be used throughout the year to update the standard cost of items if you use the Periodic valuation method?**  

A2: We don't recommend this because the Beginning Quantity field is updated during the year-end closing process. It would make that field incorrect on reports such as the Turnover report. In addition, all summary sales history information would be incorrectly moved to the following year.

**Q3: What is the effect of doing a late inventory year-end close in Great Plains?**  

A3: Year-end closing for this module is optional.

In summary, the fields that are updated during year-end closing are used in reports for quantity summaries. If these fields are not important, you may decide not to run year-end closing.

The inventory year-end close moves the summary history information from the current year to last year (as seen under Cards/Inventory/History), and zeroes out the current year information.

We recommended that you close the inventory module before you post sales and purchase transactions in the new year because, if you do it, the item's history numbers won't be accurate (as seen under Cards/Inventory/History.) Also, the Inventory Turnover Report may not be accurate, because the item's beginning quantities for the year won't be accurate. To illustrate, say you sold 100 items in 2019. Then, you sold 10 additional items in 2020. You posted both these inventory transactions in 2020 before doing 2019 year-end close for inventory, so you'll have a quantity sold of 110 in 2020. After the 2019-year end close is performed, you'll have a value of 0 instead of 10 for your 2020 (Current Year) Sales Quantity and 110 showing for your 2019 (Last Year) Sales Quantity.

The summary windows in inventory with the specific views of calendar or fiscal year are date-sensitive. The inventory year end close process isn't date-sensitive.
