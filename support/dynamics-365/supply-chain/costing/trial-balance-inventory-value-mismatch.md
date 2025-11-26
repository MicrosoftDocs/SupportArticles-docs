---
title: Ledger Trial Balance differs from Inventory Value post execution of inventory closing, recalculation or reverse
description: Ledger Trial Balance differs from Inventory Value post execution of inventory closing, recalculation or reverse
author: soumyamoydas
ms.date: 11/26/2025
ms.topic: troubleshooting
ms.search.form: InventClosing
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: soumyamoydas
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Ledger Trial Balance differs from Inventory Value post execution of inventory closing, recalculation or reverse
---

# Ledger Trial Balance differs from Inventory Value post execution of inventory closing, recalculation or reverse

## Symptoms

Upon checking the inventory value and trial balance reports, it is observed that trial balance for the corresponding main accounts differs from the inventory value.

## Resolution

Normally this issue is resolved after rebuilding the Trial Balance for the corresponding Main Accounts from General Ledger -> Inquiries and reports -> Trial Balance.

Verify whether inventory closing, recalculation or reverse execution has been completed successfully and whether voucher postings are present. Cross check the status of batch job with the voucher execution status. Check the logs in the Closing and Adjustment form for the correponding voucher. Once verified, rebuild the trial balance for the specific account where you are observing the differences. 

If the issue persists, this means there is inconsistency between the general ledger and inventory postings. Try generating potential conflicts report to trace the items resulting in conflicts.  

Next, inventory value report can be generated for those specific items to trace the inconsistent inventory transactions. Consistency check shall be executed for those items for on-hand and inventory transactions to check whether it resolves the data inconsistencies. Consistency check can be executed from System administration -> Periodic tasks -> Database -> Check/Fix error -> Inventory management -> Item -> Enable checkbox for Inventory transactions and On-hand, then filter the exact item from the dialog. If the consistency check fix makes any changes to the inventory postings, execute inventory closing again and rebuild the trial balances to check whether the balance matches now.  

In case none of these help, please reach out to Microsoft support or your partner. 

