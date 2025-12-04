---
title: Troubleshoot Common Issues During Inventory Closing, Recalculating, and Reverse Operations
description: Resolve common inventory closing, recalculation, and reverse operation errors in Dynamics 365 Supply Chain Management. Get step-by-step troubleshooting guidance for SQL issues, fiscal periods, and more.
ms.date: 11/26/2025
ms.search.form: InventClosing
ms.reviewer: soumyamoydas, kamaybac, aevengir, v-shaywood
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Issues with inventory closing and recalculation
---
# Troubleshoot inventory closing, recalculation, and reverse operations

This article explains how to troubleshoot common errors during inventory closing, recalculation, or reverse operations in Dynamics 365 Supply Chain Management.

## Another closing or adjustment is in progress

### Symptoms

An inventory closing or recalculation fails with the following error message:

> Another closing or adjustment has not finished yet

Also, a new closing or recalculation voucher isn't created in the [Closing and Adjustment](/dynamics365/finance/localizations/russia/rus-inventory-adjustment-wizard) form.

### Cause

This issue occurs when you attempt to execute a new closing or recalculation while a previous closing or voucher execution is still in progress.

### Solution

Wait for the previous closing or voucher execution to complete, then you can execute a new closing or recalculation.

## Cannot select a record in current client sessions

### Symptoms

An inventory closing, recalculation, or reverse fails with the following error message:

> Batch task failed: Cannot select a record in Current client sessions (SysClientSessions). Sessionld: 0, 0. The SQL database has issued an error.

### Cause

This issue can occur due to SQL database unavailability, deadlocks, blockings, or other SQL errors.

### Solution

Most of the time, these issues are transient and don't cause any data corruption. Retry the operation.

## Duplicate reverse is not allowed

### Symptoms

An inventory reverse fails with the following error message:

> Another Inventory \<OperationType\> reverse for voucher \<VoucherID\> is running. Duplicate reverse is not allowed

### Cause

This issue occurs when you try to execute the reversal or cancellation of multiple closing or recalculation vouchers at the same time. You must carry out reversals sequentially. This approach prevents any inventory and ledger data corruption due to concurrent updates of adjustments, settlements, or postings.

### Solution

Always execute the reversal of vouchers one at a time, and wait for each reversal to complete before proceeding to the next one.

This issue can also occur if a previous reversal execution doesn't complete successfully, the [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) ends with errors, then you try to execute a new reverse of the original voucher. This behavior can occur due to system issues, sudden crashes, system or SQL server unavailability, and similar issues. In such cases, contact Microsoft Support or your partner.

## Inventory closing cannot proceed

### Symptoms

An inventory closing or recalculation fails with the following error message:

> Inventory closing cannot proceed because available physical on-hand inventory on item \<Item\> is currently negative, which isn't allowed according to its item model group

You can view this error in the inventory closing logs. For more information on accessing closing logs, see [Inventory close](/dynamics365/supply-chain/cost-management/inventory-close#the-inventory-close-log).

### Cause

This error can occur because of data corruption in the posted inventory transactions. This error occurs when the on-hand physical or financial inventory becomes negative, which isn't allowed as per the item’s [Item Model Group](/dynamics365/supply-chain/cost-management/inventory-costing-faq#item-model-groups) configuration.

Usually, the system flags this error while posting transactions for an item that results in negative on-hand inventory, not during inventory closing or recalculation. But if you manually intervene, migrate data, or update the database directly, these checks are skipped. In this scenario, the error can occur during the stock closing process.

### Solution

1. Review the inventory transactions for the item mentioned in the error message to identify the cause of this issue.
   1. If necessary, based on your business requirements, enable the negative physical or financial inventory.
   1. Alternatively, you can post manual adjustments to balance out the inventory transactions that result in a negative inventory.
1. Once you fix the transactions, execute a [consistency check](/dynamics365/supply-chain/inventory/inventory-onhand-consistency-check) for that item:
   1. Go to **System administration** > **Periodic tasks** > **Database** > **Consistency check**.
   1. In the consistency check dialog, set **Check/Fix** to **Fix error**.
      1. If you just want to identify inconsistencies but not make any changes, set **Check/Fix** to **Check**.
   1. Set **Module** to **Inventory management**.
   1. Expand the **Item** tree and select the checkboxes for **Inventory transactions** and **On-hand**.
   1. Open the More menu (**...**) and select **Dialog**.
   1. Use the dialog to filter for the item mentioned in the error message.
   1. Run the consistency check.

   > [!NOTE]
   > If necessary, you can run the check as a batch process in the background.

1. Once the consistency check completes, you can view the final fix logs from the [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) logs or in the notification panel.
1. After completing the consistency check, resume the closing or recalculation operation.

## Failure when closing stock

### Symptoms

An inventory closing or recalculation fails with the following error message:

> Close stock - processing level \<Level\> with a total of \<Total\> bundles

### Cause

This error usually occurs because of:

- Business data corruption due to manual database interventions.
- Manual changes to the decimal precision in the customized version.
- Incorrect [exchange rate](/dynamics365/business-central/finance-set-up-currencies#exchange-rates) configurations while posting source documents and similar issues.

### Solution

1. Identify the item and inventory transactions causing this error.
1. Execute a [consistency check](/dynamics365/supply-chain/inventory/inventory-onhand-consistency-check) for that item for on-hand and inventory transactions.
   1. Go to **System administration** > **Periodic tasks** > **Database** > **Consistency check**.
   1. In the consistency check dialog, set **Check/Fix** to **Fix error**.
      1. If you just want to identify inconsistencies but not make any changes, set **Check/Fix** to **Check**.
   1. Set **Module** to **Inventory management**.
   1. Expand the **Item** tree and select the checkboxes for **Inventory transactions** and **On-hand**.
   1. Open the More menu (**...**) and select **Dialog**.
   1. Use the dialog to filter for the item causing the error.
   1. Run the consistency check.

   > [!NOTE]
   > If necessary, you can run the check as a batch process in the background.

1. Once the consistency check completes, you can view the final fix logs from the [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) logs or in the notification panel.
1. After completing the consistency check, resume the closing or recalculation operation.

## Fiscal period is not open

### Symptoms

An inventory closing, recalculation, reverse, or journal posting (such as an [inventory journal](/dynamics365/supply-chain/inventory/inventory-journals), [production orders](/dynamics365/business-central/production-about-production-orders), [purchase orders](/dynamics365/field-service/create-purchase-order), [sales orders](/dynamics365/sales/create-edit-order-sales), or similar postings) fails with the following message:

> Fiscal period for \<Date\> is not open

### Solution

Verify the [ledger calendar](/dynamics365/finance/general-ledger/configure-ledger#configuring-calendars-for-the-ledger) period status:

1. Go to **General Ledger** > **Calendars** > **Ledger calendars**.
1. Select the required ledger period and then verify the period status for the [legal entities](/dynamics365/guidance/organizational-strategy/define-organizational-strategy#legal-entity) experiencing issues.
   1. The period status should be **Open** to allow for the posting of any adjustments.
1. After updating the period status, resume the inventory operation.

## Account number for transaction type does not exist

### Symptoms

An inventory closing or recalculation fails with the following error message:

> Account number for transaction type \<Type\> does not exist

### Solution

Verify that the main account is set up for the specified [transaction type](/dynamics365/business-central/dev-itpro/developer/properties/devenv-transactiontype-property#remarks):

1. Go to **Inventory Management** > **Setup** > **Posting** > **Posting**
1. ???? <!-- Need to confirm with the SME how to enable the transaction type -->

Also, check the financial dimensions in the [Accounting Structure Setup](/dynamics365/finance/general-ledger/configure-account-structures) for the corresponding main accounts:

1. Go to **General Ledger** > **Ledger setup** > **Ledger**
1. Select the account structure that is experiencing issues.
1. ???? <!-- Need to confirm with the SME how to check the financial dimensions -->

After verifying your configuration, resume the closing or recalculation operation.

## User can't post in module for a given date

### Symptoms

An inventory closing or recalculation fails with the following error message:

> Only users in user group \<Group\> can post in module \<Module\> in the period containing the date \<Date\>

### Solution

1. Go to **General Ledger** > **Calendars** > **Ledger calendars**.
1. Select the required ledger period, then check the access level for specific modules and the [legal entities](/dynamics365/guidance/organizational-strategy/define-organizational-strategy#legal-entity) experiencing issues.

   > [!NOTE]
   > The default access level for all the modules is **\<All\>**

1. After updating the access levels, resume the closing or recalculation operation.

## An entry can't be posted or approved because of the cost budget

### Symptoms

An inventory closing, recalculation, or reverse operation fails during the ledger posting stage with the following error message:

> The entry for category \<Category\> on project \<Project\> cannot be posted/approved because it would cause the cost budget to be exceeded by \<Amount\>

You can view this error in the inventory closing logs. For more information on accessing closing logs, see [Inventory close](/dynamics365/supply-chain/cost-management/inventory-close#the-inventory-close-log).

### Cause

This issue can appear when inventory closing, recalculation, or reverse adjustments settle the project-enabled inventory transactions. Then those adjustments or settlements exceed the budget control price set for that specific project.

### Solution

As a temporary workaround:

1. Go to **Project management and accounting** > **Setup** > **Project management and accounting parameters** > **Cost control**.
1. Set **Budget control** to **Disabled**.
1. Resume the inventory closing, recalculation, or reverse voucher.
1. After the inventory operation completes, set **Budget control** back to **Enabled**.

For a more permanent solution, update the project budget control cost to meet your business requirements.

## A transaction cannot be reopened after being pre-closed

### Symptoms

An inventory closing or recalculation fails with the following error message:

> Transaction \<TransactionID\> cannot be reopened as it has already been pre-closed

### Cause

This issue can occur if data corruptions exist in the inventory transactions or adjustments. The error happens when pre-closing incorrectly posts settlements to and closes financial transactions. Pre-closing should only affect non-financial transactions.

The inventory closing and recalculation processes implicitly execute pre-closing for the non-financial transfers against which they have any markings. This issue most likely occurs during that process.

### Solution

You can identify which transactions cause this issue from the `InventTrans` table in the database. Look for records that meet the following criteria:

- A value is specified for the `QtySettled` or `CostAmountSettled` fields
- The `ValueOpen` field is set to `false`
- The `NonFinancialTransferInventClosing` field is set to the record ID of a closing or recalculation voucher.

For each problematic transaction you identify, update the following field values:

- `ValueOpen = 0`
- `NonFinancialTransferInventClosing = 0`
- `DateClosed = 1900-01-01 00:00:00.000`

After updating all problematic transactions, resume the closing or recalculation operation.

> [!IMPORTANT]
> When making any direct database data modification, first make the change in a lower [replica](/dynamics365/business-central/dev-itpro/administration/migration-data-replication) and confirm everything works correctly before proceeding to other replicas.

## Unable to edit a record in table

### Symptoms

An inventory closing, recalculation, or reverse fails with the following error message:

> Unable to edit a record in InventSettlement table

### Cause

This issue occurs when a SQL error prevents further execution and causes a process or [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) to fail. Typically, these SQL errors are deadlocks that occur when multiple processes execute at the same time. Other possible causes include SQL Server availability issues due to increased traffic, or insufficient and inappropriate indexing that results in query timeouts for long running queries.

### Solution

Usually, these SQL issues are transient and go away with retries.

Sometimes, customizations also result in deadlocks and blocking issues due to inappropriate transaction scopes and error handling. Trace the error message from the [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) or related processes, call stack, and SQL statement. Verify if any customizations are present. If customizations are present, check the indexes and index fragmentation for the SQL table mentioned in the error message.
