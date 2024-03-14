---
title: Closing of Purchase Orders does not always generate a journal entry backing out Accrued Purchases
description: Provides a solution to an issue where the Closing of Purchase Orders does not always generate a journal entry backing out Accrued Purchases in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# The Closing of Purchase Orders does not always generate a journal entry backing out Accrued Purchases in Microsoft Dynamics GP

This article provides a solution to an issue where the Closing of Purchase Orders does not always generate a journal entry backing out Accrued Purchases in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2021543

## Symptoms

Closing a Purchase Order only creates journal entries in General Ledger some of the time. Or to address why Purchase Orders that are fully received, but not invoiced, and then changed to 'closed' status drop off the "Received But Not Invoiced" report.

## Cause

The activity against the Purchase Order will determine what entries, if any, get posted.

## Resolution

Review the Purchase Order Processing Document Inquiry window to determine if there have been any invoice receipts posted against the Purchase order. If there haven't been any invoice receipts posted and the Quantity Invoiced is 0, the system is designed to not update the General Ledger with adjusting entries. If the PO was closed before Invoicing and you need to make adjustments to the Accrued Purchases and Inventory accounts, you will need to create a manual adjustment in the General Ledger. If the invoice quantity is greater than 0, the system will update the Accrued Purchases and Inventory accounts automatically via a General Ledger entry.

## More information

There are two different scenarios that can occur when closing a Purchase order under Transactions | Purchasing | Edit Purchase Orders. Here is an example based on one line item.

**PO information**:

Document Number: PO00044  
Vendor: ABC  
1 line item for quantity of 10 @ $120 unit cost = $1200 Extended Cost  

### Scenario 1: Receive all quantities on the line, partially invoice them, and close the PO

1. Receive all the items on the PO (Transactions | Purchasing | Receivings Transaction Entry - Type: Shipment)

    _Gender Ledger Adjustment:_  

    | Account Type| Debit| Credit |
    |---|---|---|
    |Inventory|$1200| |
    |Accrued Purchases||$1200|

    > [!NOTE]
    > Posting a Shipment document for an inventory item creates a new line in the Inventory Purchase Receipts Work table (IV10200) for a quantity of 10 at a cost of $120 a piece.

2. Invoice PO00044 for a Quantity of 8 in the Purchasing Invoice Entry window (Transactions | Purchasing | Enter/Match Invoices)

    Gender Ledger Adjustment:  

    | Account Type| Debit| Credit |
    |---|---|---|
    | Accrued Purchases|$960.00| |
    | Accounts Payable||$960.00|

    > [!NOTE]
    > This creates a payables invoice in Payables Management for $960.

3. Close the PO in the Edit PO transaction window (Transactions > Purchasing > Edit Purchase Orders).

Two things occur in this scenario when closing the PO:

1. The accrued purchases account is reversed out for the remaining balance associated with the lines being closed. This is because you will no longer be invoicing the items in Purchase Order Processing. The system assumes the purchase order is being closed for a reason and the company will never need to pay the vendor for the two remaining items received on the shipment receipt. Essentially, you are receiving more, but paying less.  Closing the PO will also remove the purchase order from the "Received Not Invoiced" report which is typically used to tie accrued purchases to the General Ledger.

    _Gender Ledger Adjustment:_  

    | Account Type| Debit| Credit |
    |---|---|---|
    | Accrued Purchases|$240 (2*$120)| |
    | Inventory|| $240|

2. The purchase receipt cost in the IV10200 that was originally for $120 will now be updated to $96. The system is revaluing the layer because the purchase order was received at a quantity of 10, but only 8 needed to be paid for, therefore the cost of the item per unit is less. The IV10200 table gets updated automatically and the calculation to determine the cost of the layer is as follows:

    Calculation: Total Extended Invoice Cost (from the last invoice matched to the shipment receipt) / Quantity Shipped. ($960/10 = $96 each)

    > [!NOTE]
    > Transactions that get posted automatically to the General Ledger for closing the PO will have a Source Document of EDTPO. When zooming back on the Source Document link in the Detail Inquiry window in General Ledger (Inquiry | Financial | Detail) a message will display: "Transaction history does not exist for this transaction." This is working as designed because no transaction history is kept in the Purchase Order Processing tables for this action.

    To determine what PO caused the GL transaction, run the following query in SQL against your company database.

    ```sql
    SELECT ORDTRNUM, ORMSTRID, * FROM GL20000 WHERE JRNENTRY = 'XX'
    ```

    > [!NOTE]
    > Replace XX in the above query with the correct journal entry number.

     The ORDTRNUM field will show the PO number that was closed.

     The ORMSTRID field will show the vendor from the PO.

    If these fields are not populated, then to capture that information going forward perform the following steps:

    1. Exit Microsoft Dynamics GP.
    2. In the Microsoft Dynamics GP code folder, open the Data folder and edit the Dex.ini file.
    3. Add the following line to the Dex.ini file.

        REVALJEINDETAIL=TRUE
    4. Save the Dex.ini file.
    5. Perform these same steps on each workstation that would perform posting against inventory items.  

### Scenario 2: Receive all quantities on the line and close the PO

1. Receive all the items on the PO (Transactions | Purchasing | Receivings Transaction Entry - Type: Shipment)

    Gender Ledger Adjustment:

    | Account Type|  Debit| Credit |
    |---|---|---|
    |Inventory|$1200||
    |Accrued Purchases||$1200|

2. Close the PO in the Edit PO transaction window (Transactions | Purchasing | Edit Purchase Orders)

    Results of closing without Invoicing:

    When you close a PO the system doesn't know what the intentions are of the user so it does not do anything other than close.

Here are some examples of questions Microsoft Dynamics GP doesn't know the answer to and why it does not update General Ledger:

- Did the user mean to close the PO?
- Did the user want the system to update the cost of the item?
- Did the user already record an Invoice in Payables Management and adjust out the Accrued Purchases?

In this scenario, a balance will remain in the accrued purchases account in General Ledger.  This situation should flag accounting when trying to tie the accrued purchases from the Received Not Invoiced report to the General Ledger account.  As long as there is a balance in the General Ledger for Accrued Purchases it's a way to identify something happened.  

The reason why we do not use the same process for both scenarios is as follows:

If Microsoft Dynamics GP chose to update the IV10200 when the PO was not invoiced, then the cost of the item would go from $120 to $0 (Extended Invoice Cost (from the last invoice matched to the shipment receipt) / Quantity Shipped) ($0.00/10 = $0.00). Since items typically have a cost, we do not want to make this adjustment.

We also do not want to make the assumption that you have not already created an invoice in Payables Management and reversed the accrued purchases account; therefore, we do not make this adjustment. Leaving the balance in the account is also a good control check on the status of your purchase orders when you go to reconcile to GL.
