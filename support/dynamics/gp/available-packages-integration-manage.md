---
title: Available packages for Integration Manager
description: Outlines the packages that are available for Integration Manager. Lists the items that are included in each package.
ms.reviewer: theley, kvogel
ms.date: 03/13/2024
---
# Packages that are available for Integration Manager for Microsoft Dynamics GP 10.0

This article outlines the packages that are available for Integration Manager.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939370

## Introduction

Several packages are available for Integration Manager for Microsoft Dynamics GP. This article outlines these packages. This article also lists the items that are included in each package.

The following packages are available for Integration Manager for Microsoft Dynamics GP:

- Integration Manager - Financials
- Integration Manager - Distributions
- Integration Manager - Conversions

> [!NOTE]
> You can purchase the Financials package and the Distributions package together for a reduced price.

## Integration Manager - Financials

The Integration Manager - Financials package includes access to the following modules, destinations, and adapters.

### Modules and destinations

General Ledger

- Master Records
  - Accounts
  - Budgets
  - Fixed Allocation Accounts
  - Unit Accounts
  - Variable Allocation Accounts
- Transactions
  - General Journal Entry Bank Reconciliation
- Transactions
  - Bank Reconcile

- Bank Transaction Entry Payables Management
- Master Records
  - Vendors
- Transactions
  - Payables Transaction Entry Receivables Management
- Master Records
  - Customers
- Transactions
  - Cash Receipt Entry
  - Receivables Transaction Entry System Manager (Setup)
- Master Records
  - Exchange Rates Project Accounting
- Transactions
  - Employee TimeSheets
  - Employee Expense Fixed Assets
- Master Records
  - Asset Book
  - Asset General Information
  - Asset Insurance
  - Asset Lease
  - Asset User Data Payroll
- Master Records
- Employee
- Transactions
- Payroll Transaction
- Payroll Manual Checks

### Adapters

- Microsoft Dynamics GP
- Microsoft Dynamics GP eConnect
- ODBC/Text Source

## Integration Manager - Distributions

The Integration Manager - Distributions package includes access to the following modules, destinations, and adapters.

### Modules and Destinations

Sales Order Processing

- Master Records
  - Customers
- Transactions
  - Sales Transaction Entry Purchase Order Processing
- Master Records
  - Vendors
- Transactions
  - Purchase Order Entry
  - Receivings Transaction Entry Inventory
- Master Records
  - Inventory Items
- Transactions
  - Inventory Transaction Entry
 System Manager (Setup)
- Master Records
  - Exchange Rates
  - Shipping Methods

### Adapter

- Microsoft Dynamics GP
- Microsoft Dynamics GP eConnect
- ODBC/Text Source

## Integration Manager - Conversions

The Integration Manager - Conversions package gives customers 240 days from the purchase date to do initial bulk loads by using Integration Manager. This time period doesn't begin on the installation date. This package is intended only for the entry of master records and for the entry of beginning balances. This package isn't intended for repeated integrations. To make the best use of the 240-day time period, some users set up Integration Manager, and set up integrations, before they purchase the Integration Manager - Conversions package.

The Integration Manager - Conversions package includes access to all the modules, destinations, and adapters.

Registration keys aren't required to install Integration Manager or to set up integrations. Registration keys are required to run integrations.

> [!NOTE]
>
> - To start this Integration Manager - Conversions package, click the **Integration Manager** shortcut on the desktop.
> - You cannot start the Integration Manager - Conversions package from Microsoft Dynamics GP.

> [!IMPORTANT]
>
> - The following adapters are combined into the Microsoft Dynamics GP eConnect adapter:
>   - The FA adapter
>   - The PA adapter
>   - The SQL Opt adapter
> - The Project Accounting destination and the Fixed Assets destination became available with Integration Manager 10.0 Service Pack 1. To obtain these adapters, install the latest Integration Manager 10.0 service pack.
> - The XML Source adapter is available in Integration Manager 10.0 Service Pack 2 (SP2). To gain access to this adapter, you must install Integration Manager SP2.
> - The "Direct to Table Adapter" has been discontinued. This adapter isn't included in Integration Manager for Microsoft Dynamics GP 10.0 or in later versions. You can use Table Import in Microsoft Dynamics GP to import data directly into tables without any data validation. Table Import is included with System Manager in Microsoft Dynamics GP.
