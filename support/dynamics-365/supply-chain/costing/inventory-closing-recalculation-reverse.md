---
title: Troubleshoot Common Issues During Inventory Closing, Recalculating, and Reverse
description: Error during inventory closing or recalculation -- Another closing or adjustment has not finished yet
ms.date: 11/26/2025
ms.search.form: InventClosing
ms.reviewer: soumyamoydas, kamaybac, aevengir, v-shaywood
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Issues with inventory closing and recalculation
---
# Troubleshoot inventory closing, recalculation, and reverse in Dynamics 365 Chain Management

This article provides troubleshooting guidance for common errors that might occur during inventory close, recalculation, or reverse in Microsoft Dynamics 365 Supply Chain Management.

## Batch task failed: Cannot select a record in Current client sessions

### Symptoms

Inventory closing, recalculation or reverse errors out with "Batch task failed: Cannot select a record in Current client sessions (SysClientSessions). Sessionld: 0, 0. The SQL database has issued an error.".

### Solution

This issue can occur due to SQL database unavailability, deadlocks, blockings or any other generic SQL limitation/error. Most of the time, these issues are transient and never cause any data corruption. Please retry the operation again. If the issue persists, please reach out to Microsoft Support or your Partner.

## Duplicate reverse is not allowed

### Symptoms

Inventory reverse fails with the following error as "Another Inventory %1 reverse for voucher %2 is running. Duplicate reverse is not allowed.".

### Solution

This issue mainly occurs when user tries to execute the reversal/cancellation of multiple closing/recalculation vouchers at the same time. As shared in the best practices for Inventory Reverse, always execute the reversal of one voucher at a time, and only after its completion, proceed with further reversals i.e. reversals should be carried out sequentially. This is a check used to prevent multiple reversals and thereby avoid any inventory & ledger data corruption due to concurrent updates of adjustments/settlements/postings.

This issue can rarely occur if the previous reversal execution has not completed successfully, but the batch job has ended with error, and user tries to execute a fresh reverse of the original voucher. This can be due to system issues, sudden crashes, system or SQL server unavailability, etc. In such cases, you can reach out to Microsoft Support or your Partner.

## Inventory closing cannot proceed because available physical on-hand inventory on item <ItemName> is currently negative

### Symptoms

Inventory closing or recalculation errors out with "Inventory closing cannot proceed because available physical on-hand inventory on item abc is currently negative, which is not allowed according to its item model group". The error can be viewed from the closing logs.

### Solution

This can happen because of data corruption in the posted inventory transactions, when the on-hand physical/financial inventory becomes negative which is otherwise not allowed as per the item’s Item Model Group configuration. Ideally this error should be flagged while posting transactions for an item which results in negative on-hand, and not during inventory closing/recalculation process. But if any manual intervention or data migration or direct database updates are done, these checks are skipped and hence the error is thrown during the stock closing process. In those cases, this error is thrown during the stock closing process.  

As the error already mentions the specific item, please go through the inventory transactions for that item and try to figure out the actual issue. If required, enable the negative physical/financial inventory, but final call should be taken as per your business requirements. Else manual adjustments can also be posted to balance out the inventory transactions resulting in negative inventory. Once these transactions are fixed, execute consistency check fix for that item from System administration -> Periodic tasks -> Database -> Fix error -> Inventory management -> Item -> Enable checkbox for Inventory transactions and On-hand, then filter the exact item from the dialog. If required, this process can be executed as a batch process in the background. The final fix logs can be viewed from the batch job logs. Upon completion of this process, resume the closing/recalculation operation.

## Close stock - processing level x with a total of y bundles

### Symptoms

Inventory closing or recalculation errors out with "Close stock - processing level x with a total of y bundles".

### Solution

This is a generic error thrown mostly in cases on business data corruption due to manual database interventions, manual changes in the decimal precision in the customized version, incorrect exchange rate configurations while posting source documents, etc. Try to trace the exact item, inventory transactions for which would be responsible for this error. Then execute the consistency check for that item for on-hand and inventory transactions (from System administration -> Periodic tasks -> Database -> Check/Fix error -> Inventory management -> Item -> Enable checkbox for Inventory transactions and On-hand, then filter the exact item from the dialog), to verify whether there are data inconsistencies which can be corrected autonomously. If the issue persists, please reach out to Microsoft Support or your Partner.

## Fiscal period is not open

### Symptoms

Inventory closing, recalculation or reverse or journal postings (like inventory journal, production orders, purchase orders, sales orders, etc.) errors out with the following message as "Fiscal period for XXX is not open".

### Solution

Please verify the ledger calendar period status from General Ledger -> Calendars -> Ledger calendars -> Select the required ledger period and then verify the period status for specific legal entities. Ideally, the period status should be “Open” to allow the posting of any adjustments.

## Account number for transaction type does not exist

### Symptoms

Inventory closing or recalculation errors out with "Account number for transaction type XXX does not exist".

### Solution

Verify whether Main Account is correctly setup for the specified transaction type under proper head in Inventory Management -> Setup -> Posting -> Posting. Also, verify the financial dimensions' in the Accounting Structure Setup for the corresponding Main Accounts from General Ledger -> Ledger setup -> Ledger. 
Once all the setup are verified, try resuming calculation for the corresponding voucher.

## Only users in user group x can post in module y in the period containing the date z

### Symptoms

Inventory closing or recalculation errors out with "Only users in user group x can post in module y in the period containing the date z".

### Solution

Please verify the ledger calendar period access level from General Ledger -> Calendars -> Ledger calendars -> Select the required ledger period and then verify the access level for specific modules and legal entities. Default access level for all the modules is **\<All\>**.

## The entry for category x on project y cannot be posted/approved because it would cause the cost budget to be exceeded by z

### Symptoms

Inventory closing, recalculation, or reverse fails with "The entry for category x on project y cannot be posted/approved because it would cause the cost budget to be exceeded by z" error during the ledger posting stage. The error can be traced from the Logs in Closing and Adjustment form, after selecting the specific voucher.

### Solution

This issue can appear when inventory closing, recalculation or reverse adjusts/settles the project enabled inventory transactions, and such adjustments/settlements exceed the budget control price set for that specific project. As a temporary mitigation, please navigate to Project management and accounting -> Setup -> Project management and accounting parameters -> Cost control -> Budget control -> Disable “Use budget control” 

Once disabled, resume the inventory closing/recalculation/reverse voucher, and once the operation completes, enable the parameter back. 

For permanent mitigation, please try updating the project budget control cost as per the business requirement. 

## Transaction cannot be reopened as it has already been pre-closed

### Symptoms

Inventory closing or recalculation errors out with "Transaction XXX cannot be reopened as it has already been pre-closed".

### Solution

This issue can rarely occur if there are any data corruptions in the inventory transactions/adjustments, when pre-closing has posted settlements to financial transactions and closed them, instead of the non-financial transactions. Pre-closing is executed implicitly in the inventory closing/recalculation process for the non-financial transfers against which we have any markings. This issue might have most likely occurred in that process. 

This can be traced directly from the database in InventTrans table. The records agianst which we have some values posted in QtySettled and CostAmountSettled fields but again ValueOpen is false and NonFinancialTransferInventClosing has got some record id of a closing/recalculation voucher. 

One of the mitigations is to explicitly reset the ValueOpen, NonFinancialTransferInventClosing and DateClosed in those records in InventTrans and retry the closing process again. In case of any direct database data modifications, please carry out first in any lower replica and check whether everything is correct as per the business and calculation procedures.

In case of any further assisstance, please reach out to Microsoft Support or your Partner to fix this issue.

## Transaction cannot be reopened as it has already been pre-closed

### Symptoms

Inventory closing or recalculation errors out with "Transaction XXX cannot be reopened as it has already been pre-closed".

### Solution

This issue can rarely occur if there are any data corruptions in the inventory transactions/adjustments, when pre-closing has posted settlements to financial transactions and closed them, instead of the non-financial transactions. Pre-closing is executed implicitly in the inventory closing/recalculation process for the non-financial transfers against which we have any markings. This issue might have most likely occurred in that process. 

This can be traced directly from the database in InventTrans table. The records agianst which we have some values posted in QtySettled and CostAmountSettled fields but again ValueOpen is false and NonFinancialTransferInventClosing has got some record id of a closing/recalculation voucher. 

One of the mitigations is to explicitly reset the ValueOpen, NonFinancialTransferInventClosing and DateClosed in those records in InventTrans and retry the closing process again. In case of any direct database data modifications, please carry out first in any lower replica and check whether everything is correct as per the business and calculation procedures.

In case of any further assisstance, please reach out to Microsoft Support or your Partner to fix this issue. 

## Unable to edit a record in table

### Symptoms

Inventory closing, recalculation or reverse errors out with the following message as "Unable to edit a record in InventSettlement table". The same can be traced with multiple other processes like inventory journal, sales order, production or purchase order postings, or with different other tables like InventTrans, AssetTrans, ProdTable, etc.

### Solution

This message signifies that some SQL issues have prevented further execution, due to which any process or batch job failed. Normally these issues can be deadlocks as multiple other processes are also executing at the same time, or SQL Server Availability issues due to increased traffic, or due to insufficient and inappropriate indexing resulting to query timeouts for long running queries. Generally, these SQL issues are mostly transient and shall be done away with retries. 

Sometimes, it is observed that customizations also result in deadlocks and blockings due to inappropriate transaction scope and error handling. Please try to trace the error message from the batch job (or related processes), call stack, SQL statement, verify whether any customizations are poresent, check the indexes and index fragmentations. 

In case the issue persists after retrying, please feel free to contact Microsoft Support or your Partner.