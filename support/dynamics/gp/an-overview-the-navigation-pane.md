---
title: An overview of the Navigation Pane
description: Explains the new navigation lists for Microsoft Dynamics GP.  Provides a list of all of the lists and information about how to restrict security for each of these lists.
ms.reviewer: Theley
ms.date: 02/22/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# An overview of the Navigation Pane in Microsoft Dynamics GP

This article describes the new Navigation Pane in System Manager in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 887951

## Summary

This article describes the following parts:

- An overview of the navigation lists
- A table of the navigation lists
- An explanation of the individual list types
- Security information for the navigation lists

## Navigation list overview

One of the new features in System Manager is the ability to use list windows to locate needed information quickly and easily. The list windows are located on the Navigation Pane or on the **View** menu, and they're listed by series. When you select a series, the lists for that series are displayed in the list pane. When you select a list from the list pane, a list window opens and displays a list of records that you can search through or do actions against. The list pane isn't customizable.

The following table lists the series buttons that are available in the Navigation Pane and the lists that are associated with them:

|Series Buttons|Lists|
|---|---|
|Financial|Accounts, assets, checkbooks, and account transactions, trn dimensions, trn dimensions codes, account class, trees, and analytical accounts|
|Sales|Customers, prospects, salespeople, all sales transactions, receivables transactions, sales order transactions, and invoicing transactions|
|Purchasing|Vendors, all purchasing transactions, payables transactions, and purchase order transactions|
|Inventory|Inventory, bills of materials, and inventory transactions|
|Human Resources/Payroll|Employees, applicants, payroll transactions, and attendance transactions|
|Manufacturing|Manufacturing orders, manufacturing bill numbers, job costing, picking documents, and primary routines|
|Project Accounting|Projects, timesheet transactions, billing transactions, and project accounting purchase order transactions|
|Field Service|Service call transactions, contract transactions, RMA transactions, RTV transactions, depot transactions, inventory transfers, and equipment|
  
You can use the **Actions** menu in each list window to view actions that you can do from the list.

Only one list window can be open at a time. If you've opened a new list window from another list window, you can refer back to the previously opened list window by using the **Actions** menu.

There are two types of list windows. They're the master record lists and the transaction lists. In either type of window, you can select **Columns** to open the **List Customization** window, where you can customize the columns that are displayed in the list.

Mark a column name to include a column in the list window. To change the order of the columns, select a column name, and then select **Move Up** or **Move Down** to move the selected column name.

### Master record lists

Master record lists contain records that don't have associated dates. The customer list is an example of a master record list. You can do the following kinds of searches in a master record list:

- You can search through all records or only through active records.
- You can search for specific words by entering them in the **Look For** box.
- You can limit the records that are displayed by using the **Actions** menu on the toolbar.

### Transaction lists

Transaction lists are based on dates. The sales transaction list is an example of a transaction list. You can do the following kinds of searches in a transaction list:

- You can search by date.
- You can exclude historical records from your search.
- You can search for specific words by entering them in the **Look For** box.
- You can limit the records that are displayed by using the **Actions** menu on the toolbar.

## Navigation lists security

**Microsoft Dynamics GP**  
Security access to the list windows in Microsoft Dynamics GP is controlled by the security tasks. For a user to have access to navigation lists, the list window must be marked under a security task and that security task must be assigned to a role that is assigned to the user. The default security tasks already include access to the navigation lists. To grant access to a navigation list by using a new security task, follow these steps:

1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then select **Security Tasks**.

2. In the **Task ID** list, select the security task that you want to use.

3. In the **Product** list, select **Microsoft Dynamics GP**.

4. In the **Type** list, select **Navigation Lists**.

5. In the **Series** list, select **Navigation Lists**.

6. Select the navigation lists to which you want the task to have access.

7. Assign the new task to a role.

    For more information about security tasks and roles, see [Frequently asked questions about role-based security in Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010](frequently-asked-questions-role-based-security.md).

## Navigation lists security - table

Financial lists

|Lists|Forms|
|---|---|
|Accounts|Account Maintenance, Unit Account Maintenance, Variable Allocation Maintenance, Fixed Allocation Maintenance, Detail Inquiry|
|Account Transactions|Transaction Entry, Journal Entry Inquiry, Quick Journal Entry, Clearing Entry|
|Checkbooks|Checkbook Maintenance, Checkbook Register Inquiry|
|Assets (Fixed Assets)|Asset General Information|
|Trn Dimensions (Analytical Accounting)|Transaction Dimension Maintenance|
|Trn Dimension Codes (Analytical Accounting)|Transaction Dimension Code Maintenance, Transaction Dimension Maintenance|
|Account Class (Analytical Accounting)|Accounting Class Maintenance|
|Trees (Analytical Accounting)|Tree Maintenance, Transaction Dimension Maintenance|
|Analytical Accounts (Analytical Accounting)|Analytical Accounting Account Maintenance, Transaction Dimension Maintenance|
|Report List|Report List|
  
Sales lists

|Lists|Forms|
|---|---|
|Customers|Customer Maintenance, Customer Inquiry|
|Prospects|Sales Prospect Maintenance|
|Salespeople|Salesperson Maintenance, Salesperson Inquiry|
|All Sales Transactions|Receivables Transaction Inquiry Zoom, Receivables Transaction Entry, Cash Receipts Inquiry Zoom, Cash Receipts Entry, Receivables Scheduled Payments Entry, Edit Receivables Transaction, Receivables Posted Transaction Maintenance, Invoice Entry, Invoice Inquiry, Sales Transaction Entry, Sales Transaction Inquiry Zoom|
|Receivables Transactions|Receivables Transaction Inquiry Zoom, Receivables Transaction Entry, Cash Receipts Inquiry Zoom, Cash Receipts Entry, Receivables Scheduled Payments Entry, Edit Receivables Transaction, Receivables Posted Transaction Maintenance|
|Sales Order Transactions|Sales Transaction Entry, Sales Transaction Inquiry Zoom|
|Invoicing Transactions|Invoice Entry, Invoice Inquiry|
|Report List|Report List|
  
Purchasing lists

|Lists|Forms|
|---|---|
|Vendors|Vendor Maintenance, Vendor Inquiry|
|All Purchasing Transactions|Payables Transaction Entry, Edit Payables Transactions, Void Historical Payables Transactions, Payables Manual Payments Entry, Payables Payment Zoom, Payables Scheduled Payments Entry, Payables Transaction Entry Zoom, Purchase Order Entry, Purchase Order Inquiry Zoom, Purchasing Invoice Entry, Purchasing Invoice Inquiry Zoom, Receivings Transaction Entry, Receivings Transaction Inquiry Zoom, Returns Transaction Entry (Purchase Order Enhancements), Returns Transaction Inquiry Zoom (Purchase Order Enhancements)|
|Purchasing Transactions|Payables Transaction Entry, Edit Payables Transactions, Void Historical Payables Transactions, Payables Manual Payments Entry, Payables Payment Zoom, Payables Scheduled Payments Entry, Payables Transaction Entry Zoom, Purchase Order Entry, Receivings Transaction Entry, Purchasing Invoice Entry, Purchasing Invoice Inquiry Zoom, Receivings Transaction Inquiry Zoom, Returns Transaction Entry (Purchase Order Enhancements), Returns Transaction Inquiry Zoom (Purchase Order Enhancements)|
|Purchase Order Transactions|Purchase Order Entry, Purchase Order Inquiry Zoom, Purchasing Invoice Entry, Purchasing Invoice Inquiry Zoom, Receivings Transaction Entry, Receivings Transaction Inquiry Zoom, Returns Transaction Entry (Purchase Order Enhancements), Returns Transaction Inquiry Zoom (Purchase Order Enhancements)|
|Report List|Report List|
  
Inventory lists

|Lists|Forms|
|---|---|
|Items|Item Maintenance, Item Inquiry|
|Item Transactions|Item Transaction Entry, Item Transfer Entry, Item Bin Transfer Entry, Inventory Transaction Inquiry, Sales Transaction Inquiry Zoom (sales), Invoice Inquiry (sales), Receivings Transaction Inquiry Zoom (Purchasing), Assembly Inquiry Zoom, Item Maintenance, Item Inquiry, Purchasing Invoice Inquiry Zoom, Analytical Inventory Transaction Inquiry (Analytical Accounting)|
|Report List|Report List|
  
Human resources/payroll lists

|Lists|Forms|
|---|---|
|Employees|Employee Maintenance, Employee Inquiry|
|Attendance Transactions (HR)|Attendance Transaction Entry|
|Applicants (HR)|Applicant|
|Report List|Report List|
  
Manufacturing lists

|Lists|Forms|
|---|---|
|Bill of Materials|Bill of Materials Entry, Bill of Materials View|
|Picking Documents|Manufacturing Component Transaction Entry, Manufacturing Component Transaction Inquiry|
|Job Costing|Job Maintenance, Job Link Maintenance|
|Routings|Routing Sequence Entry, Routing View|
|Manufacturing Orders|Manufacturing Order Entry, Manufacturing Order Activity|
|Report List|Report List|
  
Project accounting

|Lists|Forms|
|---|---|
|Contracts|Contract Maintenance, PA Contract Maintenance|
|Projects|Project Maintenance, PA Project Inquiry|
|Cost Categories|Cost Category Maintenance, Cost Category Maintenance Inquiry|
|Timesheets|Timesheet Entry, Timesheet Inquiry Zoom|
|Employee Expenses|Employee Expense Entry, Employee Expense Inquiry Zoom|
|Purchase Orders|PA Purchase Order Entry, PA Purchase Order Inquiry Zoom|
|Billings|Billing Entry, Billing Inquiry Zoom|
|Report List|Report List|
  
Field service

|Lists|Forms|
|---|---|
|Service Call Transactions|Service Call Entry/Update, Service Call Inquiry|
|Contract Transactions|Contract Entry/Update, Contract Inquiry|
|RMA Transactions|RMA Entry/Update, RMA Inquiry|
|RTV Transactions|RTV Entry/Update, RTV Inquiry|
|Depot Transactions|Work Order Entry/Update, Work Order Inquiry|
|Inventory Transfers|Inventory Transfers, Inventory Transfers History Inquiry|
|Equipment|Equipment Maintenance|
|Report List|Report List|
  
By default, all users can see the list windows for all series on the Navigation Pane unless security access is removed as explained earlier. Users who want to change their view can open the Navigation Pane options window and remove any list window that they don't want listed on the Navigation Pane.
