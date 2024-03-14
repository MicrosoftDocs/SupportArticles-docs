---
title: Unexpected GLTRX Batch appears in Financial Batch Entry
description: Unexpected GLTRX Batch appears under Financial Batch Entry in Microsoft Dynamics GP. This article provides a solution to this issue.
ms.topic: troubleshooting
ms.reviewer: theley, AEckman
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# An unexpected GLTRX Batch appears in Financial Batch Entry in Microsoft Dynamics GP

This article provides a solution to an issue where an unexpected GLTRX Batch appears in Financial Batch Entry in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2448193

## Symptoms

In Microsoft Dynamics GP the Batch ID begins with 'GLTRX', but the batch did not originate in General Ledger.

A GLTRX Batch has been system generated and it is unknown why it appears.  

Once the batch is posted if you try to zoom back on the **Source Document** you receive the following message:

> Transaction history does not exist for this transaction.

## Cause

This functionality change began with Microsoft Dynamics GP 9.0.

## Resolution

These batches are system generated indicating an adjustment was needed in General Ledger to correct the amounts. Under normal circumstances, these GLTRX cost adjustment batches should be posted through GL.

## Automatic Cost adjustments in General Ledger

Starting on Microsoft Dynamics GP 9.0 the system will automatically generate General Ledger adjustments when an item is sold or consumed from inventory and the cost of the item's receipt layer is subsequently changed. Each of these General Ledger adjustments will have a reference number assigned.

For more information about cost changes, click the following article numbers to view the article in the Microsoft Knowledge Base: [939912](https://support.microsoft.com/help/939912) Information about the calculation of Inventory item costs and the maintenance of these costs in Inventory in Microsoft Dynamics GP

[4094695](https://community.dynamics.com/blogs/post/?postid=8d612be9-be06-41c4-b72b-3fdbaf1831fa) How to find what Receipt Layer was affected by the Cost Adjustment

## What do the reference numbers indicate?

The reference numbers can be broken down into two different sections. Both sections have a role in indicating what function was responsible for removing the items from inventory and what function was responsible for changing the cost.

1. Section 1 or Prefix- Indicates what function consumed or removed the item from Inventory

    The following is a list of the prefixes you would see in the Reference field of a transaction in a cost adjustment (GLTRX) batch and a description of why that prefix would be used. The Reference field can be found in the Transaction Entry, Detail Inquiry, and Journal Entry Inquiry windows.

    - *BOM* - This comes from a Bill of Materials transaction. For example if a BOM Assembly transaction consumed an item from inventory and the cost was later changed due to a POP purchase price variance (PPV) or an average cost ripple, you would see this reference.

    - *INV* - This comes from an Invoice transaction created from the Invoicing module.  For example, if an Invoice transaction (in Invoicing) consumed an item from inventory and the cost was later changed due to a Purchase Order Processing PPV or an average cost ripple you would see this reference.

    - *IVT* - This comes from an Inventory Transfer Transaction. For example if an item was consumed via the Item Transfer and the costs were later changed due to a PPV or an average cost ripple you would see this reference.

    - *IVA* - This comes from an Inventory Adjustment transaction. For example if a decrease Inventory Adjustment transaction consumed an item from inventory and the cost was later changed due to a PPV on an invoice match or an average cost ripple you would see this reference.

    - *IVV* - This comes from an Inventory Variance transaction. For example if a decrease Inventory Variance transaction consumed an item from inventory and the cost was later changed due to a PPV on an invoice match or an average cost ripple you would see this reference.

    - *SALES* - This comes from a Sales Order Processing Invoice transaction. For example if a Sales Invoice consumed an item from inventory and the cost was later changed due to a PPV on an invoice match or an average cost ripple you would see this reference.

    - *PRTN* - This comes from a Purchase Order Processing return transaction where doing the return changes the cost of the item.

    - *MCTE* - This comes from a Manufacturing Component Transaction. For example if an item was issued (consumed) in the Component Transaction Entry window and the cost was later changed due to a PPV or an average cost ripple you would see this reference.

    - *MRCT* - This comes from a Manufacturing Receipt Transaction. For example if an item was backflushed and consumed in the Manufacturing Receipt Entry window and the cost was later changed due to a PPV or an average cost ripple you would see this reference.

    - *MCLS* -This comes from Closing a Manufacturing order via the Close process or during a Quick MO (quick MOs are automatically closed).  For example if a user closes an MO and there are items that are set to backflush (consumed) and the cost was later changed due to a PPV or an average cost ripple you would see this reference.

    - *STCK* - This comes from Item Stock Count Variance transaction. For example if a Stock count adjustment consumed an item from inventory and the cost was later changed due to a PPV or an average cost ripple, you would see this reference.

    - *FSSC* - This comes from selling a Part on a Service Call.For example, an Item was Received into Inventory at one cost and the cost was later changed due to an Invoice Match you would see this reference.

    - *FSRMA* - This comes from an RMA. For example, you have a quantity of an item at one cost.  You create a Credit RMA and receive the item in. You then Scrap the item (which removes the one already in your inventory) and later the cost of that item changed due to an Invoice Match you would see this reference.

    - *FSRTV* - This comes from an RTV.  For example, you create a Credit RTV. You Ship an item at one cost and the cost was later changed due to an Invoice Match you would see this reference.

    - *FSWO* - This comes from using a Part on a Depot Work Order. For example, you create a WO and Use an item from the Parts Information window at one cost and the cost was later changed due to an Invoice Match you would see this reference.

    - *PA* - This comes from a Project Accounting transaction. For example if a PA Inventory Transfer consumed an item from inventory and the cost was later changed due to a PPV on an invoice match or an average cost ripple, you would see this reference.

    - *POP* -- This comes from a Purchase Order Processing shipment receipt. For example if an item was consumed through an override in any module and later the shipment was brought in at a different cost than it was when it was consumed (overrode), you would see this reference

    - *RECON* - You would see this reference if the outflow being revalued was created by the Inventory Reconcile Utility. One reason IV Reconcile would need to create an outflow record is if there are not enough quantities in the IV10201 to support the quantity sold in the IV10200.

    - *CONV* - You would see this reference if the outflow being revalued was created by the upgrade. The upgrade from an older version of Microsoft Dynamics GP to 9, 10 or GP2010 may need to create an outflow if a receipt record was partially sold at the time of the conversion.

    - *PRCT* - You would see this reference if the item was overridden on an In-Transit Transfer transaction and then later brought in at a different cost.

    Exception: When quantity overrides are allowed in Inventory and users allow an override to occur, the prefix may not show as listed above. Instead it may reference the inflow transaction that brought the quantity back into inventory. See the example in the following section called "Inventory Example."

2. Section 2 or Suffix - Indicates what function changed the cost of the consumed item.

    - *No Suffix* - If there is only a prefix the cost was changed using an Inventory Adjustment.

    - *RCTxxxx* - Indicates the purchasing document that caused the cost adjustment.

    - *AdjustedCost* - Indicates that the Adjust Cost Utility changed the cost of the consumed layer.

    - *PO* - Indicates the PO was manually closed in the Edit PO Status window after being partially or fully received and sold, and then partially invoiced.

Purchase Order example:

Assume that you performed the following 4 transactions in the following order:

1. Enter a Purchase Order (PO2127) with New Item for a quantity of 1 @ $1.00.  

2. Enter and post a Shipment Receipt at the $1.00 cost (At this point Inventory is valued at $1.00).  Note: RCT1229

3. Sell the New Item at a cost of $1.00 in Sales Order Processing. (At this point Inventory is zero because we sold all of the items).  Note: STDINV2279

4. Enter/Match the Invoice in Purchase Order Processing for $1.05. (This means technically the cost at the time of the sale was incorrect and should have been sold it at $1.05 and NOT $1.00. ). Note: RCT1230

There is a PPV for the 5 cents (difference between the cost of the shipment receipt and the cost of invoice receipt in Purchase Order Processing and this difference gets recorded with the Purchase Order Invoice distributions.

Upon posting the Invoice in Purchase Order Processing, a General Ledger cost adjustment is automatically created in a Financials GLTRX batch. A Purchase Receipts Update Detail Report (PRUD) (seen below) will print after the Cost Variance Journal indicating a cost adjustment was present.

:::image type="content" source="media/gltrx-batch-not-originate-in-general-ledger/purchase-receipts-update-by-document.png" alt-text="Screenshot of the Purchase Receipts Update Detail for Purchase Order.":::

The journal entry created will appear in General Ledger like the following screenshot:

:::image type="content" source="media/gltrx-batch-not-originate-in-general-ledger/transaction-entry.png" alt-text="Screenshot of the Transaction Entry window for Purchase Order.":::

Source Document = GJ  
Batch ID begins with GLTRX  
Breaking the Reference/Distribution Reference field down into the 2 parts discussed above, our "prefix" is  SALES because it was a SOP invoice (STDINV2279) that consumed the receipt layer that is now being revalued. Our "suffix" is the document number of the receipt (RCT1230) that caused the revalue to occur.

Inventory example:  

Assume you performed the following 2 transaction in the following order:

1. Enter a Sales Order Processing invoice for an item you do not have on hand for a quantity of 1.  You will be asked to override the quantities since you don't have any on hand and the current cost of $2.00 will be used. NOTE: STDINV2280

2. Enter an increase adjustment into inventory at $5.00 and post. NOTE: Document number: 00000000000000163

Upon posting the increase adjustment in Inventory, a General Ledger cost adjustment is automatically created in a Financials GLTRX batch. PRUD report below:

:::image type="content" source="media/gltrx-batch-not-originate-in-general-ledger/purchase-receipts-update-detail-by-customer.png" alt-text="Screenshot of Purchase Receipts Update Detail for Inventory.":::

The journal entry created will appear in General Ledger like the following screenshot:

:::image type="content" source="media/gltrx-batch-not-originate-in-general-ledger/journal-entry created-appear-in-general-ledger.png" alt-text="Screenshot of the Transaction Entry window for Inventory.":::

Source Document = GJ  
Batch ID begins with GLTRX  
Breaking the Reference/Distribution Reference field down into the 2 parts discussed above, our "prefix" is IVA because the original quantities consumed were technically not available and overridden. Because of this exception, the Reference field lists the IV adjustment that brought back in the quantities.

BOM override example:

1. Let's say you created new items: BOM FG, and BOM COMPONENT 1. Both of these items are set up with an Average Perpetual valuation method.
2. The BOM was created like this:

    BOM FG  
    +BOM Component 1

    BOM Component 1 is also a BOM finished good:

    +BOM COMPONENT 1 (set to build if necessary)  
      128 SDRAM

3. Create a BOM Assembly for BOM FG. You need BOM COMPONENT 1. Since you don't have any, it will 'build' one, then consume it in the building of BOM FG - this gives you a sold layer for BOM COMPONENT 1.

4. Do an increase adjustment for BOM COMPONENT 1 at a different cost than is the current cost. When this step is performed back date the transaction prior to the BOM being assembled.

5. When it posts, print the Cost Variance Journal. This report will be empty, but on the PRUD report that prints immediately after, you will see the variance transaction.

6. Review the GLTRX batch created in General Ledger. The reference should be something like: BOM00000000000000246 indicating that it was a BOM transaction that consumed the item and document 00000000000000246 that caused the revaluation.

    > [!NOTE]
    > Pictures not included, but same concept applies as the other two transactions above.

> [!NOTE]
> Information regarding the dates used on GL Cost adjustments below.

The date used for the transactions in the GLTRX batch will depend on the outflow transaction that is getting revalued.  Starting with Microsoft Dynamics GP 10 SP2 and Microsoft Dynamics GP 9 SP4, we are now using the *last day of the fiscal period* that the rippled transaction occurred in to post to GL if the transaction occurred prior to the current period.

For example, say you posted the following transactions:

1. You posted a shipment using a 9/15 date.

2. You sold the quantity associated with that shipment on 9/17, 10/20, 11/5 and 12/4.

3. You posted the invoice match at a different cost using a 12/12 date.

When that purchasing invoice is posted, a GLTRX batch is created in GL to account for the cost difference as described above. That batch will contain 4 transactions. They will be dated: 9/30, 10/31, 11/30 and 12/12. So each cost adjustment transaction related to an outflow that got posted in a period prior to the one you are posting the invoice in, is dated using the last day of the month it occurred in.

> [!NOTE]
> Information regarding the Dex.ini switch below.

Add the following line in the DEX.INI to post to General Ledger in detail and populate the ORCTRNUM, ORMSTRID, ORMSTRNM, and ORDOCNUM fields in the GL10001 (GL Transaction Amounts Work) and GL20000 (GL Year-to-Date Transaction Open) tables.

> [!NOTE]
> The DEX.INI file is found in the Data directory of your Microsoft Dynamics GP 10 and 2010 installs.  It is in the code folder of your Microsoft Dynamics GP 9.0 install.

REVALJEINDETAIL=TRUE

If the above line is in the DEX.INI at the time a ripple cost adjustment transaction is created, the following 4 fields will be populated.

- ORCTRNUM-  Contains the originating document number of the outflow transaction such as the SOP number or the Inventory document number.

- ORMSTRID- Contains the item number involved in the cost change.

- ORMSTRNM- Contains the reference of 'IV Ripple Transaction'.

- ORDOCNUM- Contains the document number of the receipt record in the IV10200 being updated.

If you do not currently have this line in the DEX.INI, adding it now to every workstation will ensure you will be able to capture this information going forward.

Purchase Receipts Update Detail (PRUD) REPORT:

You can add additional detail to the PRUD report by importing the attached package file.

- The default PRUD report provides the Journal entry, document numbers and cost adjustment amount that will hit General Ledger (as seen in the above examples)

- The modified PRUD report provides additional fields such as original and new cost and the difference on a quantity basis.

[PRUD Report package file](https://mbs2.microsoft.com/fileexchange/?fileid=8b7a9301-38ad-4acd-8fa3-e7d9e3a4b4d8)

To use, Microsoft Dynamics GP has to be on build: 9.00.292 or newer. The modified reports are by Item and Document.

- By Item comes from the Adjust Cost window.

- By Document comes from an actual re-valuation (ripple).
