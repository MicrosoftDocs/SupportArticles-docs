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

This article explains how to troubleshoot common errors that occur during inventory closing, recalculation, or reverse operations in Microsoft Dynamics 365 Supply Chain Management.

## Another closing or adjustment is in progress

### Symptoms

An inventory closing or recalculation fails and generates the following error message:

> Another closing or adjustment has not finished yet

Also, a new closing or recalculation voucher isn't created in the [Closing and Adjustment](/dynamics365/finance/localizations/russia/rus-inventory-adjustment-wizard) form.

### Cause

This issue occurs if you try to run a new closing or recalculation while a previous closing or voucher execution is still in progress.

### Solution

Wait for the previous closing or voucher process to finish before you run a new closing or recalculation.

## Can't select a record in current client sessions

### Symptoms

An inventory closing, recalculation, or reverse fails and generates the following error message:

> Batch task failed: Cannot select a record in Current client sessions (SysClientSessions). Sessionld: 0, 0. The SQL database has issued an error.

### Cause

This issue might be caused by Microsoft SQL Server database unavailability, deadlocks, blockings, or other errors.

### Solution

Usually, these issues are transient and don't cause any data corruption. Retry the operation.

## Duplicate reverse is not allowed

### Symptoms

An inventory reverse fails and generates the following error message:

> Another Inventory \<OperationType\> reverse for voucher \<VoucherID\> is running. Duplicate reverse is not allowed

### Cause

This issue occurs if you try to run the reversal or cancelation of multiple closing or recalculation vouchers at the same time. You must carry out reversals sequentially. This method prevents any inventory and ledger data corruption because of concurrent updates of adjustments, settlements, or postings.

### Solution

Always run the reversal of vouchers one at a time, and wait for each reversal to finish before proceeding to the next one.

This issue can also occur if a previous reversal execution doesn't finish successfully, the [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) generates errors, and then you try to run a new reverse of the original voucher. This behavior can occur because of system issues, programs that stop responding, system or SQL server unavailability, and similar issues. In such cases, contact Microsoft Support or your partner.

## Inventory closing can't proceed

### Symptoms

An inventory closing or recalculation fails and generates the following error message:

> Inventory closing can't proceed because available physical on-hand inventory on item \<Item\> is currently negative, which isn't allowed according to its item model group

You can view this error in the inventory closing logs. For more information on accessing closing logs, see [Inventory close](/dynamics365/supply-chain/cost-management/inventory-close#the-inventory-close-log).

### Cause

This error can occur because of data corruption in the posted inventory transactions. This error occurs when the on-hand physical or financial inventory becomes negative, which isn't allowed as per the item’s [Item Model Group](/dynamics365/supply-chain/cost-management/inventory-costing-faq#item-model-groups) configuration.

Usually, the system flags this error while posting transactions for an item that results in negative on-hand inventory, not during inventory closing or recalculation. But if you manually intervene, migrate data, or update the database directly, these checks are skipped. In this scenario, the error can occur during the stock closing process.

### Solution

1. Review the inventory transactions for the item mentioned in the error message to identify the cause of this issue.
   1. If it's necessary, based on your business requirements, enable the negative physical or financial inventory.
   1. Alternatively, you can post manual adjustments to balance out the inventory transactions that cause a negative inventory.
1. After you fix the transactions, run a [consistency check](/dynamics365/supply-chain/inventory/inventory-onhand-consistency-check) for that item:
   1. Go to **System administration** > **Periodic tasks** > **Database** > **Consistency check**.
   1. In the consistency check dialog box, set **Check/Fix** to **Fix error**.
      1. If you want only to identify inconsistencies but not make any changes, set **Check/Fix** to **Check**.
   1. Set **Module** to **Inventory management**.
   1. Expand the **Item** tree, and select the checkboxes for **Inventory transactions** and **On-hand**.
   1. Open the More menu (...), and select **Dialog**.
   1. Use the dialog box to filter for the item that's mentioned in the error message.
   1. Run the consistency check.

   > [!NOTE]
   > If it's necessary, you can run the check as a batch process in the background.

1. After the consistency check finishes, you can view the final fix logs from the [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) logs or in the notification panel.
1. After you complete the consistency check, resume the closing or recalculation operation.

## Failure when closing stock

### Symptoms

An inventory closing or recalculation fails and generates the following error message:

> Close stock - processing level \<Level\> with a total of \<Total\> bundles

### Cause

This error usually occurs because of:

- Business data corruption because of manual database interventions
- Manual changes to the decimal precision in the customized version
- Incorrect [exchange rate](/dynamics365/business-central/finance-set-up-currencies#exchange-rates) configurations while posting source documents and similar issues

### Solution

1. Identify the item and inventory transactions that's causing this error.
1. Run a [consistency check](/dynamics365/supply-chain/inventory/inventory-onhand-consistency-check) for that item for on-hand and inventory transactions.
   1. Go to **System administration** > **Periodic tasks** > **Database** > **Consistency check**.
   1. In the consistency check dialog box, set **Check/Fix** to **Fix error**.
      **Note:** If you want only to identify inconsistencies but not make any changes, set **Check/Fix** to **Check**.
   1. Set **Module** to **Inventory management**.
   1. Expand the **Item** tree, and select the checkboxes for **Inventory transactions** and **On-hand**.
   1. Open the More menu (...), and select **Dialog**.
   1. Use the dialog box to filter for the item that's causing the error.
   1. Run the consistency check.

   > [!NOTE]
   > If it's necessary, you can run the check as a batch process in the background.

1. After the consistency check finishes, you can view the final fix logs from the [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) logs or in the notification panel.
1. After you complete the consistency check, resume the closing or recalculation operation.

## Fiscal period is not open

### Symptoms

An inventory closing, recalculation, reverse, or journal posting (such as an [inventory journal](/dynamics365/supply-chain/inventory/inventory-journals), [production orders](/dynamics365/business-central/production-about-production-orders), [purchase orders](/dynamics365/field-service/create-purchase-order), [sales orders](/dynamics365/sales/create-edit-order-sales), or similar postings) fails and generates the following message:

> Fiscal period for \<Date\> is not open

### Solution

Verify the [ledger calendar](/dynamics365/finance/general-ledger/configure-ledger#configuring-calendars-for-the-ledger) period status:

1. Go to **General Ledger** > **Calendars** > **Ledger calendars**.
1. Select the required ledger period, and then verify the period status for the [legal entities](/dynamics365/guidance/organizational-strategy/define-organizational-strategy#legal-entity) that are experiencing issues.
   **Note:** The period status should be set to **Open** to enable the posting of any adjustments.
1. After you update the period status, resume the inventory operation.

## Account number for transaction type does not exist

### Symptoms

An inventory closing or recalculation fails with the following error message:

> Account number for transaction type \<Type\> does not exist

### Solution

Verify that the main account is set up for the specified [transaction type](/dynamics365/business-central/dev-itpro/developer/properties/devenv-transactiontype-property#remarks):

1. Go to **Inventory Management** > **Setup** > **Posting** > **Posting**.
1. Verify that the main account is set up for the transaction type mentioned in the error message.
    1. For more information about how to configure transaction types for an account, see [Inventory posting profiles](/dynamics365/finance/general-ledger/inventory-posting-profiles).

Also, check the financial dimensions in the [Accounting Structure Setup](/dynamics365/finance/general-ledger/configure-account-structures) for the corresponding main accounts:

1. Go to **General Ledger** > **Ledger setup** > **Ledger**
1. Select the account structure that's experiencing issues.
1. Verify that your financial dimensions are correctly configured. Follow the guidance that's provided in [Configure account structures](/dynamics365/finance/general-ledger/configure-account-structures).

After verifying your configuration, resume the closing or recalculation operation.

## User can't post in module for a given date

### Symptoms

An inventory closing or recalculation fails and generates the following error message:

> Only users in user group \<Group\> can post in module \<Module\> in the period containing the date \<Date\>

### Solution

1. Go to **General Ledger** > **Calendars** > **Ledger calendars**.
1. Select the required ledger period, then check the access level for the [legal entities](/dynamics365/guidance/organizational-strategy/define-organizational-strategy#legal-entity) that are experiencing issues and for the following modules:
    - Ledger
    - Sales tax
    - Bank
    - Customer
    - Vendor
    - Sales order
    - Purchasing
    - Inventory
    - Production
    - Project
    - Fixed assets
    - Payroll
    - Expense
    - Retail Headquarters
    - Fixed assets (Russia)
    - Landed cost

   > [!NOTE]
   > The default access level for all the modules is **&lt;All&gt;**.

1. After you update the access levels, resume the closing or recalculation operation.

## An entry can't be posted or approved because of the cost budget

### Symptoms

An inventory closing, recalculation, or reverse operation fails during the ledger posting stage and generates the following error message:

> The entry for category \<Category\> on project \<Project\> cannot be posted/approved because it would cause the cost budget to be exceeded by \<Amount\>

You can view this error in the inventory closing logs. For more information about how to access closing logs, see [Inventory close](/dynamics365/supply-chain/cost-management/inventory-close#the-inventory-close-log).

### Cause

This issue can occur if inventory closing, recalculation, or reverse adjustments settle the project-enabled inventory transactions. These particular adjustments or settlements exceed the [budget control](/dynamics365/finance/budgeting/budget-control-overview-configuration) price that's set for that specific project.

### Solution

To work around this issue:

1. Go to **Project management and accounting** > **Setup** > **Project management and accounting parameters** > **Cost control**.
1. Set **Budget control** to **Disabled**.
1. Resume the inventory closing, recalculation, or reverse voucher.
1. After the inventory operation finishes, revert **Budget control** to **Enabled**.

For a more permanent solution, update the project budget control cost to meet your business requirements.

## A transaction can't be reopened after being pre-closed

### Symptoms

An inventory closing or recalculation fails and generates the following error message:

> Transaction \<TransactionID\> can't be reopened as it has already been pre-closed

### Cause

This issue can occur if data corruptions exist in the inventory transactions or adjustments. The error occurs if pre-closing incorrectly posts settlements to and closes financial transactions. Pre-closing should affect only nonfinancial transactions.

The inventory closing and recalculation processes implicitly run pre-closing for the nonfinancial transfers against which they have any markings. This issue most likely occurs during that process.

### Solution

You can identify which transactions cause this issue from the `InventTrans` table in the database. Look for records that meet the following criteria:

- A value is specified for the `QtySettled` or `CostAmountSettled` fields
- The `ValueOpen` field is set to `false`
- The `NonFinancialTransferInventClosing` field is set to the record ID of a closing or recalculation voucher.

For each problematic transaction you identify, update the following field values:

- `ValueOpen = 0`
- `NonFinancialTransferInventClosing = 0`
- `DateClosed = 1900-01-01 00:00:00.000`

After you update all problematic transactions, resume the closing or recalculation operation.

> [!IMPORTANT]
> When you make any direct database data modification, make the change in a lower [replica](/dynamics365/business-central/dev-itpro/administration/migration-data-replication) and verify that everything works correctly before you proceed to other replicas.

## Can't edit a record in a table

### Symptoms

An inventory closing, recalculation, or reverse fails and generates the following error message:

> Unable to edit a record in InventSettlement table

### Cause

This issue occurs if a SQL Server error prevents further execution and causes a process or [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) to fail. Typically, these errors are deadlocks that occur when multiple processes run at the same time. Other possible causes include SQL Server availability issues because of increased traffic, or insufficient and inappropriate indexing that causes query timeouts for long-running queries.

### Solution

Usually, these issues are transient. Retry the operation.

Sometimes, customizations also cause deadlocks and blocking issues because of inappropriate transaction scopes and error handling. Trace the error message from the [batch job](/dynamics365/fin-ops-core/dev-itpro/sysadmin/priority-based-batch-scheduling#batch-jobs) or related processes, call stack, and SQL statement. Check whether any customizations exist. If customizations do exist, check the indexes and index fragmentation for the SQL table that's mentioned in the error message.
