---
title: Enhancements made to the calculation of Average Cost
description: Describes how to calculate average cost in Microsoft Dynamics GP. Also discusses some new enhancements in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# Enhancements made to the calculation of Average Cost in Microsoft Dynamics GP

This article discusses the following points:

- Different processes that occur when you upgrade to Microsoft Dynamics GP.
- The scenarios in which General Ledger adjusting transactions are generated and in which cost adjustments are made.
- The calculation of average cost and some new enhancements that are made to the calculation of average cost in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 923960

## Upgrading to Microsoft Dynamics GP

### Processes that occur when you upgrade

During the upgrade process, Microsoft Dynamics GP sets the values of the following fields in the IV10200 table:

- **Valuation Method** (VCTNMTHD)
- **Quantity On Hand** (QTYONHND)
- **Adjusted Cost** (ADJUNITCOST)

Purchase receipts that are entered before you upgrade to Microsoft Dynamics GP do not have the required data to automatically generate General Ledger transactions or to recalculate average costs. Therefore, the following processes occur when you upgrade:

- For each item that has a FIFO Perpetual or a LIFO Perpetual valuation method, Microsoft Dynamics GP identifies the latest unsold receipt that is in the IV10200 table. Microsoft Dynamics GP sets the following values in the IV10200 table:

  - **Valuation Method**: **1** for FIFO Perpetual, or **2** for LIFO Perpetual
  - **Quantity On Hand**: the overall on-hand quantity across all sites for the item
  - **Adjusted Cost**: the unit cost of the latest unsold receipt for the item
  
  > [!NOTE]
  > During this process, the values that are in the **Location Code** field and in the **Quantity Type** field are ignored.

- For each item that has a periodic valuation method, Microsoft Dynamics GP identifies the latest unsold receipt in the IV10200 table. Microsoft Dynamics GP sets the following values in the IV10200 table:

  - **Valuation Method**: **4** for a FIFO Periodic valuation method, or **5** for LIFO Periodic valuation method
  - **Quantity On Hand**: the overall on-hand quantity across all sites for the item
  - **Adjusted Cost**: the value that is in the **Current Cost** field in the Item Maintenance window
  
  > [!NOTE]
  > During this process, the values that are in the **Location Code** field and in the **Quantity Type** field are ignored.

- For each item that has an Average Perpetual valuation method, Microsoft Dynamics GP identifies the latest unsold receipt that is in the IV10200 table. Microsoft Dynamics GP sets the following values in the IV10200 table:
  - **Valuation Method**: **3**
  - **Quantity On Hand**: the overall on-hand quantity across all sites for the item
  - **Adjusted Cost**: the value that is in the **Current Cost** field in the Item Maintenance window
  
  > [!NOTE]
  > During this process, the values that are in the **Location Code** field and in the **Quantity Type** field are ignored.

- For all purchase receipts that are not updated by actions that are mentioned previously in this section, Microsoft Dynamics GP sets the **Valuation Method** field to zero. The zero value indicates that the receipt was posted in a version of Microsoft Dynamics GP before version 9.0.
- Consider any record that is stamped by using one of the methods that are mentioned previously in this section. If any of these records has a **Quantity Sold** field that is greater than zero, the conversion also creates a Quantity Sold detail record in the IV10201 table. This record shows the same amount as the **Quantity Sold** field for the receipt.

### Effects on inventory items by certain valuation methods

The following information applies to customers who have inventory items that have a valuation method of Average Perpetual, of LIFO Perpetual, or of FIFO Perpetual:

- Microsoft Dynamics GP automatically generates adjustments in the General Ledger if an item was sold or was consumed from inventory and if the cost was then changed. In earlier versions before version 9.0, Microsoft Dynamics GP generated a report that instructed you to manually enter the adjustments to the Inventory account and to the Cost of Goods Sold (COGS) account. This action was designed to correct the accounts that are used by the transactions that sold or that consumed the items. In Microsoft Dynamics GP, these adjustments are now automatically generated.

  Microsoft Dynamics GP saves additional Quantity Sold transaction detail in the IV10201 table. This additional data lets Microsoft Dynamics GP generate the adjusting transactions. Microsoft Dynamics GP generates the General Posting Journal report for the adjusting transactions for those Quantity Sold transactions that are posted after you upgrade to Microsoft Dynamics GP. The cost variance journal still displays a message for items that do not have details for the **Quantity Sold** field value. This message suggests that you make a cost adjustment for transactions in the General Ledger.

- An adjustment amount is made for the difference between the original cost and the newly determined cost of the posted transaction.

The following actions can cause Microsoft Dynamics GP to generate adjusting transactions in the General Ledger for Average Perpetual, for LIFO Perpetual, or for FIFO Perpetual items:

- The Inventory Adjust Costs window is used to change the unit cost of a purchase receipt. Microsoft Dynamics GP calculates the cost difference to determine the required amount of adjustment for a transaction.
- Users select to revalue inventory when they post a purchasing invoice in which the invoice cost differs from the shipment cost.
- A purchase order line item is changed to a status of **Closed** if the following conditions are true for the purchase order:
  - The **Quantity Shipped** field value is greater than the **Quantity Invoiced** field value.
  - The **Quantity Invoiced field amount** is not zero.
- A Purchase Order Return transaction is posted.
- A purchase receipt is inserted into an existing purchase receipt stack when the posting date comes before the date of an existing purchase receipt.

The following scenarios cause cost adjustments to be generated:

- You post a Purchase Order Shipment transaction that has the following values:
  - **Quantity Shipped**: 100
  - **Unit Cost**: $1.00
- You post a sales invoice that has the following values:
  - **Quantity Shipped**: 10
  - **Unit Cost**: $1.00
  - **Quantity Invoiced**: $10
- You receive a Purchase Order Invoice transaction for the shipment that was posted by using a unit cost of $2 each. You revalue the inventory by using one of the following methods:
  - You debit the Inventory account for the $100 revalue.
  - You debit the Accrued Purchases account for $100, and then you credit the Accounts Payable account for $200.
  - You credit the Inventory account for the $10 that was removed after the original receipt was posted. To balance this invoice, you must debit the COGS account for $10.

## General Ledger posting information

### General Ledger posting transactions that are automatically generated

The following conditions are true for the General Ledger posting transactions that are automatically generated:

- Microsoft Dynamics GP uses the posting preferences that are entered for the series in which the transaction originated. The program uses an Origin entry type of **General Entry**.
- The posting report destination is selected by using the Posting Setup window in which the **Series** field is set to **Financial** and the **Report** field is set to **General Posting Journal**.
- When you post a document by using transaction-level posting, Microsoft Dynamics GP follows the existing rules. The program posts to the General Ledger instead of through the General Ledger.
- Microsoft Dynamics GP always posts in summary.
- After Microsoft Dynamics GP successfully creates General Ledger transactions, these transactions are added to a General Ledger batch that has the following attributes:
  - **Batch ID**: system-generated
  - **Origin**: **General Entry**
  - **Comment**: **Cost Adjustment**
  - **Frequency**: **Single Use**
  - Microsoft Dynamics GP honors the "post to" and the "post through" options of the series in which the transaction originated.
  - When you post a batch from a module, Microsoft Dynamics GP creates one journal entry for every document in that batch that causes a General Ledger adjustment to be generated. Examples of such modules are Sales Order Processing and Inventory. There may be several accounts that are posting in summary.

    > [!NOTE]
    > Depending on the option that you select in the Posting Setup window, Microsoft Dynamics GP takes different actions for a general entry batch that has the attributes that are mentioned in this bullet item. If you select the **Create New** option, the program creates a new batch if the entry still exists in the General Ledger. If you select the **Append** option, the program adds the transactions to the existing batch. One exception occurs when the transactions originate from the Inventory Adjust Costs window. In this case, Microsoft Dynamics GP always creates a new batch.
  - Consider the following examples of how Microsoft Dynamics GP honors the "post to" and the "post through" options for cost change transactions:
    - In Sales Order Processing, a back-dated return document creates a cost change journal entry. This cost change journal entry will honor the "post to" and "post through" options for the Sales Transaction Entry origin of the Sales series.
    - In Purchase Order Processing, a back-dated shipment receipt creates a cost change journal entry. This cost change journal entry will honor the "post to" and "post through" options for the Receivings Transaction Entry origin of the Purchasing series.
    - In Inventory, a back-dated increase adjustment creates a cost change journal entry. This cost change journal entry will honor the "post to" and "post through" options for the Transaction Entry origin of the Inventory Series.
- Consider the following values for an item:
  - Purchase Price Variance account
  - Inventory account
  - Inventory Offset account
  - Inventory Variance account
  
  When Microsoft Dynamics GP must obtain these values, the following process occurs:

  - Microsoft Dynamics GP first tries to obtain the account from the Item Account Maintenance window.
  - If the account is blank in the Item Account Maintenance window, Microsoft Dynamics GP tries to obtain the account from the Posting Accounts Setup window. In this window, the **Display** field is set to **Inventory**.
  - If Microsoft Dynamics GP cannot obtain the required account during the previously mentioned steps, the account will be blank.
- Site substitution is applied when Microsoft Dynamics GP obtains an account for the item.
- A General Ledger transaction is saved to the General Ledger batch and that account is blank if the following conditions are true:
  - Microsoft Dynamics GP tries to create a General Ledger transaction by using accounts from a Quantity Sold detail transaction.
  - One or more of those accounts is no longer valid or no longer exists.
- If at least one transaction has a blank posting account, Microsoft Dynamics GP does not post the batch even if the **Post to General Ledger** check box is selected in the Posting Setup window for the Inventory series. You must enter an account number so that the batch can be posted.
- When you post, Microsoft Dynamics GP checks the posting accounts to verify that they are active. If an account is inactive, Microsoft Dynamics GP posts to the Inventory module and then creates a General Ledger batch for that transaction.

### Items that use the Average Perpetual valuation method

The following conditions are true for items that use the Average Perpetual valuation method:

- The current (average) cost is automatically recalculated after these additional actions:
  - The user chooses to revalue the inventory when the user posts a purchase order invoice for which the invoice cost differs from the shipment cost.
  - The user uses the Inventory Adjust Costs window to edit the cost of a purchase receipt record.
  - The user changes the status of a purchase order line item to **Closed** if the **Quantity Shipped** field value for the line item is greater than the **Quantity Invoiced** field value, and if the **Quantity Invoiced** field value is not zero.
  - The user posts a Purchase Order Return transaction.
  - The user inserts a purchase receipt into an existing purchase receipt stack.
- The recalculation of the average (current) cost of an item and adjustments to the **Quantity Sold** value of an Average Perpetual, a LIFO Perpetual, or a FIFO Perpetual item occur only when you adjust a purchase receipt that was posted after you upgrade to Microsoft Dynamics GP. Because Microsoft Dynamics GP does not store the necessary data before you upgrade to Microsoft Dynamics GP, you cannot recalculate the average cost or post adjusted transactions for the older purchase receipts.
- Microsoft Dynamics GP performs the following actions if the unit cost of an existing purchase receipt for an average cost item is updated:
  - Microsoft Dynamics GP first recalculates the new adjusted cost for the updated receipt record by using the following formula:
  
    {(Previous Receipt's Quantity On Hand x Previous Receipt's Adjusted Unit Cost) + [(Receipt Quantity - Quantity Returned) x Receipt Unit Cost]} ÷ [Previous Receipt's Quantity On Hand + (Receipt's Quantity On Hand - Quantity Returned)]

     > [!NOTE]
     >
     > - If the **Previous Receipt's Quantity On Hand** value is negative, Microsoft Dynamics GP uses zero for that value in the formula.
     > - The **Receipt's Quantity On Hand** value is date-specific and is the total amount for all sites. For a purchase receipt, the **Receipt's Quantity On Hand** value reflects the total on-hand quantity after that receipt was posted. That is, the **Receipt's Quantity On Hand** value includes the quantity for that receipt.
     > - If the **Quantity Returned** value is subtracted from the **Quantity Received** value when you post a PO Return transaction, Microsoft Dynamics GP increases the purchase receipt's **Quantity Sold** value instead of reducing the **Quantity Received** value. Therefore, to obtain a true **Quantity Received** value, Microsoft Dynamics GP must examine the new Quantity Sold details table for PO Return transactions and subtract the **Quantity Returned** value from the **Quantity Received** value.

  - If there is a purchase receipt that is dated later than the adjusted purchase receipt, Microsoft Dynamics GP recalculates the current (average) cost for that next purchase receipt to calculate the new adjusted cost for that next receipt record. This process continues for each subsequent purchase receipt. This process continues through the stack to determine the adjusted cost as of the user date. This new value becomes the current cost. As the process continues for each subsequent purchase receipt, Microsoft Dynamics GP updates the adjusted cost for each purchase receipt. Additionally, Microsoft Dynamics GP updates the adjusted cost value for each Quantity Sold transaction that is dated later than an adjusted purchase receipt and earlier than the next receipt. This action is based on the receipt date. This action also uses the adjusted cost from the previous purchase receipt.

    > [!NOTE]
    > When a purchase receipt is recorded, Microsoft Dynamics GP populates the **Inventory On Hand Quantity** value for a purchase receipt by using a value that is equal to the sum of the following equation:  
    (Inventory On Hand Quantity for the previous receipt) + (Qty Received for the previous receipt) - (Qty Sold transactions that occurred after that purchase receipt was recorded but before the next purchase receipt, based on date)  
    The following example assumes that the following conditions are true:
    >
    > - The starting on-hand quantity is zero
    > - There have been no Purchase Order Return transactions

    |Transaction Type|Inventory On Hand Qty|Qty Received|Qty Sold|Unit Cost|Adjusted Cost|
    |---|---|---|---|---|---|
    |Receipt #1|100|100||$1.00|$1.00|
    |Receipt #2|125|100||$1.50|$1.25|
    |Sale #1|||50|$1.25|$1.25|
    |Sale #2|||25|$1.25|$1.25|
    |Receipt #3|200|100||$1.20|$1.23|
    |Sale #3|||25|$1.23|$1.23|
    |Receipt #4|250|100||$1.30|$1.25|
    |Sale #4|||50|$1.25|$1.25|

    The calculation for Receipt #1 uses the following formula:[(0 x $0.00) + (100 x $1.00)] ÷ [0 + (100 - 0)] = $1.00

    The calculation for Receipt #3 uses the following formula:[(125 x $1.25) + (100 x $1.20)] ÷ [125 + (100 - 0)] = $1.227

    > [!NOTE]
    > The sum of this calculation is rounded to $1.23.

- When the unit cost of an existing purchase receipt is updated, Microsoft Dynamics GP recalculates the adjusted cost of the purchase receipt by using the following values in the average cost calculation formula:

  - Saved **Inventory On Hand Quantity** values
  - **Adjusted Cost** values of the previous receipt
  - Saved **Quantity Received** values
  - New **Unit Cost** values
  
  An example of a situation in which an existing purchase receipt is updated is the following situation:

  - You revalue inventory for a purchase price variance in a purchase order invoice.
  - The invoice is for a material variance or for a landed cost variance.
  
  If there is a receipt record that is dated later than the updated receipt, Microsoft Dynamics GP recalculates the adjusted cost for the receipt record by using the steps and the average cost calculation formula that are mentioned earlier in this section. Microsoft Dynamics GP updates the **Current Cost** field in the Item Maintenance window by using the new adjusted cost for the final purchase receipt record. Additionally in this example, changes that are made by the adjusted cost are shown in the following table.

  > [!NOTE]
  > This table assumes that the following conditions are true:
  >
  > - You post a purchase order invoice for Receipt #3 at a unit cost of $1.28.
  > - You choose to revalue the inventory.
  > - The shipment was previously posted at a unit cost of $1.20.

    When these conditions are true, Microsoft Dynamics GP updates the unit cost on the receipt stack to be $1.28. The program then recalculates the adjusted cost for each subsequent receipt by starting at that receipt record.

  |Transaction Type|Inventory On Hand Qty|Qty Received|Qty Sold|Unit Cost|Adjusted Cost|
  |---|---|---|---|---|---|
  |Receipt #1|100|100||$1.00|$1.00|
  |Receipt #2|125|100||$1.50|$1.25|
  |Sale #1|||50|$1.25|$1.25|
  |Sale #2|||25|$1.25|$1.25|
  |Receipt #3|200|100||$1.28|$1.26|
  |Sale #3|||25|$1.23|$1.26|
  |Receipt #4|250|100||$1.30|$1.27|
  |Sale #4|||50|$1.25| |

  The calculation for Receipt #3 uses the following formula:[(125 x $1.25) + (100 x $1.28)] ÷ [125 + (100 - 0)] = $1.263

  > [!NOTE]
  > The sum of this calculation is rounded to $1.26.

  The calculation for Receipt #4 uses the following formula:[(200 * $1.26) + (100 * $1.30)] ÷ [200 + (100 - 0)] = $1.273

  > [!NOTE]
  > The sum of this calculation is rounded to $1.27.

  - Microsoft Dynamics GP generates some adjusting transactions for the Quantity Sold detail transactions that are updated based on the adjusted cost of the purchase receipt. The adjusting transactions use the account numbers that were used for the original transaction and that are stored in the IV10201 table.

- The following changes apply if you create and you post an inventory transfer of an average cost item:

  - Transfers from the **On Hand** quantity type to any other quantity type use the current cost of the item.
  - Transfers from quantity types other than **On Hand** use the FIFO cost instead of the current cost of the item. If you create the transfer, the unit cost of the item uses the current cost value. However, when the transfer is posted, Microsoft Dynamics GP obtains the FIFO cost from the purchase receipt stack.
  - If the unit cost of the transaction differs from the current cost of an item, Microsoft Dynamics GP recalculates the current (average) cost of the item after an inventory transfer to the **On Hand** quantity type.
