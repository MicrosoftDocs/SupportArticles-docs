---
title: HITB report and GL Trial Balance do not reconcile
description: Provides a resolution for the issue that the HITB report and GL Trial Balance do not reconcile in Microsoft Dynamics GP.
ms.reviewer: theley, beckyber, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The HITB report and GL Trial Balance do not reconcile

This article introduces the causes that may lead to the issue that the HITB report and GL Trial Balance do not reconcile in Microsoft Dynamics GP and the related resolution depends on the cause.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2714803

## Symptoms

When you print the Historical Inventory Trial Balance (HITB) for an inventory account and compare that balance for the same account on a General Ledger Trial Balance, the amounts are not the same.

## Cause

There are various reasons why HITB and GL could be out of balance with each other. Review this list for some possible reasons why.

1. You posted a transaction that affected the item's cost or quantity through Inventory, Sales Order Processing, Purchase Order Processing, etc. but then deleted the transaction before posting through GL.

2. You posted a transaction that affected the item's cost or quantity through Inventory, Sales Order Processing, Purchase Order Processing, etc. but then before posting the transaction through GL, the inventory account or amount was changed.

3. You posted a transaction using the inventory account directly in GL.

4. You posted a transaction that affected the item's cost or quantity through Inventory, Sales Order Processing, Purchase Order Processing, and so on. but didn't use an inventory account. Verify that you have the correct inventory account on your items in Item Account Maintenance or in Posting Account Setup.

5. You posted a transaction that didn't affect an item, but used an inventory account for the debit or credit side of the entry.

6. On a transaction that affected an item's cost or quantity, the same inventory account was used for both the debit and credit entries. This created no transaction in GL (or a washing one), but updated the item. This would be a normal situation for Inventory Transfer transactions where the quantity is being moved from site to site, but shouldn't be the case for increases or decreases to quantity. One way to verify this hasn't happened is to review the IVIVINDX and IVIVOFIX fields in the SEE30303 table to see if they're the same for transactions that aren't related to transfers. Here's a script that may be helpful for this. Any results should be investigated.

   ```sql
   Select * from SEE30303 where IVIVINDX=IVIVOFIX and DOCTYPE not in (3,103)
   ```

7. You received an item on a PO for the full quantity on the PO, but then invoiced the shipment for a lesser quantity. If there was a cost variance between the shipment receipt and the invoice, there will be a difference between HITB and GL. GL will be updated for the variance related only to the quantity that was invoiced. HITB will be updated for the variance of the full quantity shipped. If the remaining quantity is invoiced at a different cost than the original invoice, this difference between the GL and HITB will remain. For this reason, we don't recommend matching more than one invoice to a single shipment receipt.

8. You experienced an interruption while posting a transaction that affected an item's cost or quantity thereby not updating both the SEE30303 and GL tables completely. We recommend restoring a backup from prior to the interruption and posting again to ensure all tables are properly updated.

9. You use a third-party customization that doesn't use the GP posting logic and isn't writing to the HITB table. If you find this is the case, contact that third-party developer to see what changes can be made to the product so that it works with HITB.

10. The transaction has been posted in the subsidiary module so HITB is affected, but hasn't been posted in GL. Once the GL batch is posted, the difference should resolve.
11. Verify the dates and restrictions being used on the two reports are comparable.
12. You have made several unsuccessful attempts to close the General Ledger year that you haven't addressed.
13. You ran scripts in SQL that changed or updated inventory-related transactions or items, that weren't re-created in the SEE30303 table.

14. When a Purchase Order Processing unrealized purchase price variance or purchase price variance is posted, the Historical Inventory Trial Balance report displays the variance using the unrealized purchase price or purchase price variance account assigned to the item record or assigned in the Posting Setup window. If you edited the unrealized purchase price or purchase price variance account before posting a Purchase Order Processing transaction, the account displayed on the Historical Inventory Trial Balance report might be different from the account actually used.

15. There may be rounding issues between the Historical Inventory Trial Balance report and the General Ledger when the Extended Cost of a receipt is entered instead of the Unit Cost, or if landed costs are involved.

## Resolution

The resolution depends on the cause but will likely result in entries being made directly to GL, or inventory transactions posted and then deleted before updating General Ledger.

## More information

Since the Journal Entry number is stored in the HITB (SEE30303) table comparisons can be made at a SQL level using the JRENTRY field in the SEE30303 table to the GL10001/GL20000/GL30000 tables.

If you're using Microsoft Dynamics GP 2013, use the Reconcile to GL routine for the Inventory module to determine the transactional differences between inventory and the general ledger. The Reconcile to GL routine is found on the Microsoft Dynamics GP menu, point to **Tools**, point to **Routines**, point to **Financials**, and then select **Reconcile to GL**.
