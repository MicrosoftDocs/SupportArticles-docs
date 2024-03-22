---
title: How the distribution accounts are used
description: Describes the distribution accounts in the Field Service Series in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Field Service Series
---
# Information about how the distribution accounts are used in the Field Service series in Microsoft Dynamics GP

This article describes how the distribution accounts are used in the Field Service series in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 937820

## Service Call Management in Microsoft Dynamics GP

> [!NOTE]
> The account sources are listed in the order of preference. If an account is not in the first account source that is listed, the next account source listed is used.

When the quantity that is sold on the C line or on the I line of a service call is updated, an inventory decrease adjustment is created. Then, this inventory decrease adjustment is posted. This inventory decrease adjustment updates the following general ledger accounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory||Yes|Inventory account from the Item Account Maintenance window</br>Inventory Control account from the Posting Accounts Setup window|
|Inventory Offset|Yes||Drop Ship Items account from the Item Account Maintenance window</br>Drop Ship Items account from the Posting Accounts Setup window</br>Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
  
  When this service call is billed, an invoice is created in Sales Order Processing in Microsoft Dynamics GP. Additionally, the line item is flagged as a drop ship item on the invoice. Because the line item is flagged as a drop ship item, no other adjustments are made in the inventory when you post the invoice. When you enter the parts line item in the Service Call Entry - Parts window, the inventory is decreased. Then, the inventory is processed. When you post the invoice, the following general ledger accounts are updated.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Sales||Yes|Parts Sales account from the Service Type Account window</br>Sales account from the Customer Account Maintenance window or from the Item Account Maintenance window</br>Sales account from the Posting Account Setup window|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Account Setup window|
|Drop Ship||Yes|Drop Ship Items account from the Item Account Maintenance window</br>Drop Ship Items account from the Posting Account Setup window</br>Inventory account from the Item Account Maintenance window</br>Inventory Control account from the Posting Account Setup window|
|Cost of Goods Sold|Yes||Part Cost of Goods Sold account from the Service Type Account window</br>Cost of Goods Sold account from the Customer Account Maintenance window or from the Item Account Maintenance window</br>Cost of Goods Sold account from the Posting Accounts Setup window|
  
> [!NOTE]
> You can specify whether you want the posting accounts that are selected for the customer or for the item to appear as the default entries when you enter a transaction. To do it, enable the **Customer** option or the **Item** option under **Posting Accounts From** in the Sales Order Processing Setup window.

When the quantity that is sold on the R line of a service call is updated, an inventory increase adjustment is created. Then, this inventory increase adjustment is posted. This inventory increase adjustment updates the following general ledger accounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory||Yes|Inventory account from the Item Account Maintenance window</br>Inventory Control account from the Posting Accounts Setup window|
|Cost of Goods Sold|Yes||Part Cost of Goods Sold account from Service Type Account</br>Cost of Goods Sold account from the Item Account Maintenance window</br>Cost of Goods Sold account from the Posting Accounts Setup window|
  
  When the service call is billed, a credit is created in Sales Order Processing. Additionally, the line item is flagged as a drop ship item on the invoice. Because the line item is flagged as a drop ship item, no other adjustments are made in the inventory when you post the credit. When you enter the parts line item in the Service Call Entry - Parts window, the inventory is increased. Then, the inventory is processed. When you post the credit, the following general ledger accounts are updated.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Sales|Yes||Part Sales account from the Service Type Account window</br>Sales account from the Item Account Maintenance window or from the Customer Account Maintenance window</br>Sales account from the Posting Accounts Setup window|
|Accounts Receivable||Yes|Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
  
> [!NOTE]
> You can specify whether you want the posting accounts that are selected for the customer or for the item to appear as the default entries when you enter a transaction. To do it, enable the **Customer** option or the **Item** option under **Posting Accounts From** in the Sales Order Processing Setup window.

## Contract Administration in Microsoft Dynamics GP

The following information is used to determine which posting accounts are updated when you run the contract billing process:

- The value in the **Bill Day Frequency** box in the Contract Entry/Update window
- The value in the **Discount Account** box in the Contract Type Maintenance window
- Any difference between the values in the **Bill To Customer** box and in the **Customer ID** box in the Contract Entry/Update window
- Whether the **Invoice Detail** check box is selected in the Contract Entry/Update window

The following accounts are used when you run the contract billing process if the contract is billed monthly in detail and if the contract doesn't use discounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
|Sales||Yes|Sales account from the Contract Type Maintenance window|
|Commission Expense|Yes||Commission Expense account from the Posting Accounts Setup window|
|Commission Payable||Yes|Commission Payable account from the Posting Accounts Setup window|
|Taxes||Yes|Account from the Tax Detail Maintenance window|
  
  The following accounts are used when you run the contract billing process if the contract is billed monthly in summary and if the contract doesn't use discounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
|Sales||Yes|Sales account from the Contract Type Maintenance window|
|Commission Expense|Yes||Commission Expense account from the Posting Accounts Setup window|
|Commission Payable||Yes|Commission Payable account from the Posting Accounts Setup window|
|Taxes||Yes|Account from the Tax Detail Maintenance window|
  
  The following accounts are used when you run the contract billing process if the contract is billed monthly in detail and if the contract uses discounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
|Sales||Yes|Sales account from the Contract Type Maintenance window|
|Markdown|Yes||Discount account from the Contract Type Maintenance window|
|Commission Expense|Yes||Commission Expense account from the Posting Accounts Setup window|
|Commission Payable||Yes|Commission Payable account from the Posting Accounts Setup window|
|Taxes||Yes|Account from the Tax Detail Maintenance window|
  
  The following accounts are used when you run the contract billing process if the contract is billed monthly in summary and if the contract uses discounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
|Sales||Yes|Sales account from the Contract Type Maintenance window|
|Markdown|Yes||Discount account from the Contract Type Maintenance window|
|Commission Expense|Yes||Commission Expense account from the Posting Accounts Setup window|
|Commission Payable||Yes|Commission Payable account from the Posting Accounts Setup window|
|Taxes||Yes|Account from the Tax Detail Maintenance window|
  
  The following accounts are used when you run the contract billing process if the contract is billed bi-monthly, quarterly, semi-annually, or annually in detail and if the contract doesn't use discounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
|Sales||Yes|Accrual/Liability account from the Contract Type Maintenance window|
|Commission Expense|Yes||Commission Expense account from the Posting Accounts Setup window|
|Commission Payable||Yes|Commission Payable account from the Posting Accounts Setup window|
|Taxes||Yes|Account from the Tax Detail Maintenance window|
  
  The following accounts are used when you run the contract billing process if the contract is billed bi-monthly, quarterly, semi-annually, or annually in summary and if the contract doesn't use discounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
|Sales||Yes|Accrual/Liability account from the Contract Type Maintenance window|
|Commission Expense|Yes||Commission Expense account from the Posting Accounts Setup window|
|Commission Payable||Yes|Commission Payable account from the Posting Accounts Setup window|
|Taxes||Yes|Account from the Tax Detail Maintenance window|
  
  The following accounts are used when you run the contract billing process if the contract is billed bi-monthly, quarterly, semi-annually, or annually in detail and if the contract uses discounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
|Sales||Yes|Accrual/Liability account from the Contract Type Maintenance window|
|Markdown|Yes||Discount account from the Contract Type Maintenance window|
|Commission Expense|Yes||Commission Expense account from the Posting Accounts Setup window|
|Commission Payable||Yes|Commission Payable account from the Posting Accounts Setup window|
|Taxes||Yes|Account from the Tax Detail Maintenance window|
  
  The following accounts are used when you run the contract billing process if the contract is billed bi-monthly, quarterly, semi-annually, or annually in summary and if the contract uses discounts.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
|Sales||Yes|Accrual/Liability account from the Contract Type Maintenance window|
|Markdown|Yes||Discount account from the Contract Type Maintenance window|
|Commission Expense|Yes||Commission Expense account from the Posting Accounts Setup window|
|Commission Payable||Yes|Commission Payable account from the Posting Accounts Setup window|
|Taxes||Yes|Account from the Tax Detail Maintenance window|
  
### Revenue recognition report

The following general ledger accounts are updated when you post the revenue recognition report.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Accrual Liability|Yes||Accrual Liability Account from the Contract Type Maintenance window|
|Sales||Yes|Sales Account from the Contract Type Maintenance window|

> [!NOTE]
> You cannot post the revenue recognition report for contracts that are billed monthly.

## Returns Management in Microsoft Dynamics GP

The following sections describe Returns Management in Microsoft Dynamics GP.

### Return Materials Authorization (RMA) transactions

The following accounts are used for your repair charges on items in RMA transactions.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Sales||Yes|Repair Sales account from the RMA Type Accounts window</br>Sales account from the Item Account Maintenance window or from the Customer Account Maintenance window</br>Sales account from the Posting Accounts Setup window|
|Accounts Receivable|Yes||Accounts Receivable account from the Customer Account Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
  
### RMA Receiving process

The following accounts are used when the RMA Receiving process creates and then posts an inventory adjustment.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory|Yes||Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
|Cost of Goods Sold||Yes|Cost of Goods Sold account from the Item Account Maintenance window</br>Cost of Goods Sold account from the Posting Accounts Setup window|
  
If the return item number is changed during the RMA Receiving process and if the RMA transaction originated from a service call return line, an inventory decrease adjustment is posted for the original item number. Additionally, an increase adjustment is posted for the return item number. In this situation, the following accounts are updated.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory||Yes|Inventory account from the Service Call Entry - Part Distribution window|
|Cost of Goods Sold|Yes||Cost of Goods Sold account from the Service Call Entry - Part Distribution window|
|Inventory|Yes||Inventory account from the Item Account Maintenance window or from the Customer Account Maintenance window</br>Inventory account from the Posting Accounts Setup window</br>|
|Inventory Offset||Yes|Cost of Goods Sold account from the Item Account Maintenance window or from the Customer Account Maintenance window</br>Cost of Goods Sold account from the Posting Accounts Setup window|
  
When the Sales Order Processing (SOP) Return document is created, the line item is flagged as a drop ship item to suppress any adjustments to the inventory. The following accounts are used on the SOP Return document.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Sales Return|Yes||Sales Return account from the RMA Type Accounts window</br>Sales Return account from the Item Account Maintenance window or from the Customer Account Maintenance window</br>Sales Return account from the Posting Accounts Setup window|
|Accounts Receivable||Yes|Accounts Receivable account from the Customer Maintenance window</br>Accounts Receivable account from the Posting Accounts Setup window|
  
### Inventory scrap process

The following accounts are affected when you run the inventory scrap process.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Cost of Goods Sold|Yes||Scrap account from the RMA Type Accounts window</br>Cost of Goods Sold account from the Item Account Maintenance window or from the Customer Account Maintenance window</br>Cost of Goods Sold account from the Posting Accounts Setup window|
|Inventory||Yes|Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
  
### Return to vendor (RTV) entries

If amounts exist in the cost fields on the RTV line, the following accounts are used. The amount recorded is the sum of all the costs for parts, for labor, for expenses, and for travel.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Purchases|Yes||Cost account from the RTV Type Accounts window</br>Purchases account from the Vendor Account Maintenance window</br>Purchases account from the Posting Accounts Setup window|
|Accounts Payable||Yes|Accounts Payable account from the Vendor Account Maintenance window</br>Accounts Payable account from the Posting Accounts Setup window|
  
If amounts exist in the **Reimbursement** section, the following accounts are used. The amount recorded is the sum of all the reimbursement costs for parts, for labor, for expenses, and for travel.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Purchases|Yes||Reimbursement account from the RTV Type Accounts window</br>Purchases account from the Vendor Account Maintenance window</br>Purchases account from the Posting Accounts Setup window|
|Accounts Payable||Yes|Accounts Payable account from the Vendor Account Maintenance window</br>Accounts Payable account from the Posting Accounts Setup window|
  
### RTV Shipping process

The following accounts are used when the RTV Shipping process creates and then posts an inventory adjustment.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory||Yes|Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
|Inventory Offset|Yes||Purchases account from Vendor Account Maintenance window</br>Purchases account from the Posting Accounts Setup window|
  
When you run the RTV Shipping process, a credit voucher is created in Payables Management for all the RTV types in which the inventory is decreased. When the credit voucher is posted, the following accounts are used.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Purchases||Yes|Purchases account from the Vendor Account Maintenance window</br>Purchases account from Posting Accounts Setup</br>|
|Accounts Payable|Yes||Accounts Payable account from the Vendor Account Maintenance window</br>Accounts Payable account from the Posting Accounts Setup window|
  
### RTV Receiving process

The following accounts are used when the RTV Receiving process creates a decrease adjustment.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory||Yes|Inventory account from the Item Account Maintenance window for item in the **Out-Item** field</br>Inventory account from the Posting Accounts Setup window</br>|
|Cost of Goods Sold|Yes||Cost of Goods Sold account from the Item Account Maintenance window for the item in the **Out-Item** field</br>Cost of Goods Sold account from the Posting Accounts Setup window</br>|
  
The following accounts are used when the RTV Receiving process creates an increase adjustment.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory|Yes||Inventory account from the Item Account Maintenance window for the item in the **In-Item** field</br>Inventory account from the Posting Accounts Setup window|
|Cost of Goods Sold||Yes|Cost of Goods Sold account from the Item Account Maintenance window for the item in the **In-Item** field</br>Cost of Goods Sold account from the Posting Accounts Setup window|
  
### RTV Closing process

When you run the RTV Closing process, a credit voucher is created in Payable Management for the sum of the reimbursement amounts. When the credit voucher is posted, the following accounts are used.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Purchases||Yes|Purchases account from the Vendor Account Maintenance window</br>Purchases account from the Posting Accounts Setup window|
|Accounts Payable|Yes||Accounts Payable account from the Vendor Account Maintenance window</br>Accounts Payable account from the Posting Accounts Setup window|
  
When you run the RTV Closing process, an invoice is created in Payables Management for the sum of the cost amounts. When the invoice is posted, the following accounts are used.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Purchases|Yes||Purchases account from the Vendor Account Maintenance window</br>Purchases account from the Posting Accounts Setup window|
|Accounts Payable||Yes|Accounts Payable account from the Vendor Account Maintenance window</br>Accounts Payable account from the Posting Accounts Setup window|
  
## Depot Management in Microsoft Dynamics GP

When the quantity for a part is entered, an inventory adjustment is created. When the inventory adjustment is posted, the following accounts are used.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|WIP Parts|Yes||WIP Inventory account from the Work Order Type Maintenance window|
|Inventory||Yes|Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
  
When a labor entry is posted against a work order, the following accounts are used.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|WIP Labor|Yes||WIP Labor account from the Work Order Type Maintenance window|
|Labor Consumption||Yes|Item Account Maintenance window for the depot labor item that is assigned to the station ID|
  
### Work Order Completion process

If the **Expense** check box isn't selected in the Work Order Type Maintenance window, the Work Order Completion process posts to clear the following WIP accounts.

WIP Material

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory Offset|Yes||Inventory Offset account from the Item Account Maintenance window</br>Inventory Offset account from the Posting Accounts Setup window|
|WIP Parts||Yes|WIP Inventory account from the Work Order Type Maintenance window|
  
WIP Labor

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory Offset|Yes||Inventory Offset account from the Item Account Maintenance window</br>Inventory Offset account from the Posting Accounts Setup window|
|WIP Parts||Yes|WIP Inventory account from the Work Order Type Maintenance window|
  
When you post a work order in the Work Order Completion window, an inventory adjustment is created to remove the item from the inventory. Additionally, the inventory adjustment adjusts the item back into the inventory.

If the work order type isn't flagged to expense the repair cost, the item is adjusted back into the inventory at the repair cost from the item extension. Additionally, the work order cost is added. If the **Returned Item Cost** field in the Item Extensions window is empty, the appropriate cost is used depending on the valuation method of the item. The appropriate cost may be the standard cost or the current cost. This adjustment doesn't update the cost fields in the Item Maintenance window.

The following accounts are used when an inventory adjustment removes items from the inventory at cost.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory Offset|Yes||Inventory Offset account from the Item Account Maintenance window</br>Inventory Offset account from the Posting Accounts Setup window|
|Inventory||Yes|Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
  
The following accounts are used when an inventory adjustment adjusts items back into the inventory at the repair cost and at the work order cost.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory|Yes||Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
|Inventory Offset||Yes|Inventory Offset account from the Item Account Maintenance window</br>Inventory Offset account from the Posting Accounts Setup window|
  
If the work order type is flagged to expense the repair cost, the Work Order Completion process posts a general journal to clear the following WIP accounts.

WIP Material

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory Offset|Yes||Expense Cost account from the Work Order Type Maintenance window|
|WIP Labor||Yes|WIP Labor account from the Work Order Type Maintenance window|
  
WIP Labor

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory Offset|Yes||Expense Cost account from the Work Order Type Maintenance window|
|WIP Labor||Yes|WIP Labor account from the Work Order Type Maintenance window|
  
If the **Repair Cost** field in the Item Extensions window is empty, the appropriate cost is used depending on the valuation method of the item. The appropriate cost may be the standard cost or the current cost. This adjustment does not update the cost fields in the Item Maintenance window.

The following accounts are used when an inventory adjustment removes items from the inventory at cost.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory Offset|Yes||Inventory Offset account from the Item Account Maintenance window</br>Inventory Offset account from the Posting Accounts Setup window|
|Inventory||Yes|Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
  
The following accounts are used when an inventory adjustment adjusts items back into the inventory at the repair cost and at the work order cost.

|Account|Debit|Credit|Account Source|
|---|---|---|---|
|Inventory|Yes||Inventory account from the Item Account Maintenance window</br>Inventory account from the Posting Accounts Setup window|
|Inventory Offset||Yes|Inventory Offset account from the Item Account Maintenance window</br>Inventory Offset account from the Posting Accounts Setup window|
  
> [!NOTE]
> For work orders in which the **Customer Owned** check box is selected, no final inventory adjustments occur. Additionally, the WIP accounts are cleared as expected.
