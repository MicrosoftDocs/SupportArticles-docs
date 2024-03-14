---
title: Return transaction document types
description: Discusses the four return transaction document types that are available in Purchase Order Processing.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# Information on the return transaction document types that are available in Purchase Order Processing in Microsoft Dynamics GP

This article describes the following return transaction document types that are available in Purchase Order Processing in Microsoft Dynamics GP:

- Return
- Return w/Credit
- Inventory
- Inventory w/Credit

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 936280

## Introduction

This article describes the conditions that have to be true for each return transaction document type to be used. This article also provides an example of each return transaction document type in Purchase Order Processing.

## Return transaction document types

The following return transaction document types are available in Purchase Order Processing.

### Return

A Return transaction document type is used if the following conditions are true:

- A shipment transaction has been posted for the purchase order.

- An invoice transaction hasn't been entered for the purchase order.
- The item in the purchase order hasn't yet been removed from inventory.

### Return w/Credit

A Return w/Credit transaction document type is used if the following conditions are true:

- A shipment transaction has been posted for the purchase order.

- An invoice transaction has been posted for the purchase order.

- The item in the purchase order hasn't yet been removed from inventory.

### Inventory

An Inventory transaction document type is used if the following conditions are true:

- A shipment transaction has been posted for the purchase order.

- An invoice transaction hasn't been entered for the purchase order.
- The item in the purchase order has been removed from inventory.

    > [!NOTE]
    > An Inventory transaction can also be used for items in drop-ship purchase orders that were returned by the customer. You can do it if the invoice transaction hasn't been matched to the purchase order.

### Inventory w/Credit

An Inventory w/Credit transaction document type is used if the following conditions are true:

- A shipment transaction has been posted for the purchase order.

- An invoice transaction has been posted for the purchase order.

- The item in the purchase order has been removed from inventory.

    > [!NOTE]
    > An Inventory w/Credit transaction can also be used for items on drop-ship purchase orders that were returned by the customer after the invoice transaction has been posted.

## Examples of return transaction document types

> [!NOTE]
> No cost variances are used in the following examples.

### Examples of Return

A user enters a purchase order for 10 units of an item. The last unit cost of the item from the vendor was $150 per unit. The vendor delivers a shipment that contains these 10 units. The invoice will arrive in three days. A user posts a shipment receipt transaction for 10 units of the item at $150 per unit. It increases the item quantity by 10 units in Inventory in Microsoft Dynamics GP. It also posts the following journal entries in the general ledger:

- Debit: Inventory $1,500
- Credit: Accrued Purchases $1,500

> [!NOTE]
>
> - The default account in the Item Account Maintenance window is the account that is used for the debit entry.
> - The default account in the Vendor Account Maintenance window is the account that is used for the credit entry.

One day after the arrival of the shipment, you're notified that 3 of the 10 units in the shipment must be returned to the vendor to be replaced. None of the units in the shipment have been sold.

You return the three units in the Returns Transaction Entry window by using the Return transaction document type. When you enter the transaction, you enter the transaction number of the original shipment in the **Receipt No.** field. In the **Quantity Returned** field, you enter **3**.

When you post the Return document, a transaction is created that has the following entries:

- Debit: Accrued Purchases ($ **dollar value** = **quantity returned** x **unit cost**)
- Credit: Inventory ($ **dollar value** = **quantity returned** x **unit cost**)

If the returned units will be replaced, enter a new line item in the original purchase order. In the **Quantity Ordered** field, you have to enter a value that is equal to the units that will be replaced.

### Examples of Return w/Credit

A user enters a purchase order for 10 units of an item. The last unit cost of the item from the vendor is $150 per unit. The vendor delivers a shipment that contains 10 units of the item. The invoice will arrive the next day. A user posts a shipment receipt transaction for 10 units of the item at $150.00 per unit. It increases the item quantity by 10 units in Inventory. It also posts the following journal entries in the general ledger:

- Debit: Inventory $1,500
- Credit: Accrued Purchases $1,500

> [!NOTE]
>
> - The default account in the Item Account Maintenance window is the account that is used for the debit entry.
> - The default account in the Vendor Account Maintenance window is the account that is used for the credit entry.

When the invoice arrives, a user enters the invoice. Then, the user matches the invoice to the shipment in Purchase Order Processing. When the invoice is posted, the following journal entries are created in the general ledger:

- Debit: Accrued Purchases $1,500
- Credit: Accounts Payable $1,500

> [!NOTE]
>
> - The default account for the debit entry is the account from the shipment that the invoice matches.
> - The default account in the Vendor Account Maintenance window is the account that is used for the credit entry.

You're notified that all the units in the shipment were damaged. The units must be returned to the vendor to be replaced. None of the units in the shipment have been sold.

You return the 10 units of the item in the Returns Transaction Entry window by using the "Return w/Credit" transaction document type. When you enter the transaction, you enter the transaction number of the original shipment in the **Receipt No.** field. When you post the Return w/Credit document, a credit memo is created in Payables Management. Additionally, a transaction is created that has the following entries:

- Debit: Accounts Payable ($ **dollar value** = **quantity returned** x **unit cost**)
- Credit: Inventory ($ **dollar value** = **quantity returned** x **unit cost**)

In the Apply Payables Documents window, you apply the credit memo to the original invoice. When the returned units are replaced, you enter a new line item in the original purchase order. In the **Quantity Ordered** field, you've to enter a value that is equal to the units that will be replaced.

### Examples of Inventory

A user enters a purchase order for 10 units of an item. The last unit cost of the item from the vendor is $150 per unit. The vendor delivers a shipment of 10 units of the item. The invoice will arrive in three days. A user posts a shipment receipt transaction for 10 units at $150 per unit. It increases the item quantity by 10 units in Inventory. It also posts the following journal entries in the general ledger:

- Debit: Inventory $1,500
- Credit: Accrued Purchases $1,500

> [!NOTE]
>
> - The default account in the Item Account Maintenance window is the account that is used for the debit entry.
> - The default account in the Vendor Account Maintenance window is the account that is used for the credit entry.

The day after the shipment arrives, you sell the 10 units to a customer. An invoice that has the following entries is posted in the Sales Transaction Entry window:

- Debit: COGS $1,500
- Debit: Accounts Receivable $2,025
- Credit: Inventory $1,500
- Credit: Sales $2,025

The next day, you're notified that two units that you sold are defective. These units must be returned to the vendor. The original purchase order for this item hasn't been invoiced in Purchase Order Processing.

A user posts a return transaction in the Sales Transaction Entry window for the two defective units that have a unit cost of $150 and a unit price of $202.50. The posted transaction increases quantities in Inventory for this item. A general ledger transaction is created that has the following account entries:

- Debit: Inventory ($ **dollar value** = **quantity returned** x **unit cost**)
- Debit: Sales ($ **dollar value** = **quantity returned** x **unit price**)
- Credit: COGS ($ **dollar value** = **quantity returned** x **unit cost**)
- Credit: Accounts Receivable ($ **dollar value** = **quantity returned** x **unit price**)

You return the two defective units in the Returns Transaction Entry window by using the Inventory transaction document type. You enter the document number of the sales return in the **Receipt Number** field. You change the inventory account of this purchasing return to the inventory account that was used in the sales return. Next, you change the accrued purchases account of this purchasing return to the accrued purchases account. (It's the accrued purchases account that was used in the shipment receipt that originally brought the units into the company.)

When you post the Inventory document, a transaction is created that has the following entries:

- Debit: Accrued Purchases ($ **dollar value** = **quantity returned** x **unit cost**)
- Credit: Inventory ($ **dollar value** = **quantity returned** x **unit cost**)

If the returned units will be replaced, enter a new line item in the original purchase order. In the **Quantity Ordered** field, you enter a value that is equal to the units that will be replaced.

When you view the purchase order for the 10 units, the **Quantity Received** field displays 10 units. The **Quantity Invoiced** field displays eight units. The purchase order line displays a status of **Received**. For the replacement line item, the **Quantity Received** field displays two units. The **Quantity Invoiced** field displays two units. The purchase order replacement line displays a status of **Closed**. Then, you select **Process**.

When the purchase order status is "Closed," an Edit PO journal entry (EDTPO) is created that reverses the general ledger effect of the original shipment for the units that were received but that weren't invoiced. In this example, the EDTPO journal contains the following entries:

- Debit: Accrued Purchases $300
- Credit: Inventory $300

> [!NOTE]
>
> - The default account from the original shipment is the account that is used for this debit entry.
> - The default account from the item account card is the account that is used for this credit entry.

Because the Accrued Purchases account has already been reversed by using the Inventory return document in Purchase Order Processing, delete the Edit PO journal entry in the general ledger.

### Examples of Inventory w/Credit

A user enters a purchase order for 10 units of an item. The last unit cost of the item from the vendor is $150 per unit. The vendor delivers a shipment that contains these 10 units. A user posts a shipment transaction for 10 units of the item at $150 per unit. It increases the item quantity by 10 units in Inventory. Also, it posts the following journal entry in the general ledger:

- Debit: Inventory $1500
- Credit: Accrued Purchases $1500

> [!NOTE]
>
> - The default account for the item account card is the account that is used for this debit entry.
> - The default account for the vendor account card is the account that is used for this credit entry.

The day after the shipment arrives, you sell the 10 units to a customer. An invoice that has the following distributions is posted in the Sales Transaction Entry window:

- Debit: COGS $1500
- Debit: Accounts Receivable $2160
- Credit: Inventory $1500
- Credit: Sales $2160

Two days after the items are delivered to the customer, you post an invoice for the 10 units in Purchase Order Processing. A general ledger journal entry that has the following distributions is created:

- Debit: Accrued Purchases $1500
- Credit: Accounts Payable $1500

> [!NOTE]
>
> - The default account for the shipment that the invoice matched is the account that is used for this debit entry.
> - The default account for the vendor account card is the account that is used for this credit entry.

The next day, you're notified that 2 of the units that you sold are defective. These units must be returned to the vendor. You post a return transaction in the Sales Transaction Entry window for the two defective units. In the return transaction, the units have a unit cost of $150 and a unit price of $216.00. The posted transaction increases the quantities in Inventory for this item. A general ledger transaction that has the following account distributions is created:

- Debit: Inventory ($ **dollar value** = **quantity returned** x **unit cost**)
- Debit: Sales ($ **dollar value** = **quantity returned** x **unit cost**)
- Credit: COGS ($ **dollar value** = **quantity returned** x **unit cost**)
- Credit: Accounts Receivable ($ **dollar value** = **quantity returned** x **unit cost**)

You return the two defective units of the item in the Returns Transaction Entry window by using the "Inventory w/Credit" transaction type. You enter the sales return document number in the **Receipt Number** field. You change the inventory account to the account to which you posted the original transaction in the sales return transaction. You change the pay account to the accounts payable account to which you posted the purchasing shipment transaction.

When you post the transaction, a credit memo is created in Payables Management. Also, a general ledger transaction that has the following distributions is created:

- Debit: Accounts Payable ($ **dollar value** = **quantity returned** x **unit cost**)

- Credit: Inventory ($ **dollar value** = **quantity returned** x **unit cost**)

In the Apply Payables Documents window, you apply the return voucher to the original invoice. If the returned units will be replaced, you've to enter a new line item in the original purchase order.

After you return the item, the PO status is now closed. If you've to add the line items again, you can change the PO status. To do it, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Edit Purchase Orders**.

2. In the **PO Number** field, enter the purchase order number.
3. In the **Purchase Order Status** list, select **Change Order**.

    > [!NOTE]
    > If a purchase order is on hold, you cannot change its status to Received, Closed, or Canceled unless you remove the hold. If a purchase order has sales commitments, you can't change its status to Received, Closed, or Canceled.
4. Select **Process** to process the changes.

After you follow these steps, you can select the PO in the Purchase Order Entry window to add the line item and then create a shipment receipt for the PO. In the **Quantity Ordered** field, you have to enter a value that is equal to the units that will be replaced.
