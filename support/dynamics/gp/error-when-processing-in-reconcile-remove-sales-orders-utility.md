---
title: Violation of PRIMARY KEY constraint PKSOP30200 error when processing in Reconcile - Remove Sales Orders Utility
description: This information contains information on what to do if you have duplicate SOP documents numbers in your Sales Order Processing work and history tables or if you are getting errors that contain the words Duplicate key when performing sales order functions.
ms.reviewer: theley, Beckyber
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Sales Order Processing
---
# "Violation of PRIMARY KEY constraint 'PKSOP30200'..." error when processing in the Reconcile - Remove Sales Orders Utility in Sales Order Processing

This article provides steps to solve the **Violation of PRIMARY KEY constraint 'PKSOP30200'** error that occurs when processing the Reconcile - Remove Sales Orders Utility in Sales Order Processing.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2433178

## Symptoms

When processing the Reconcile - Remove Sales Orders Utility in Sales Order Processing, you receive the following error message:

> Violation of PRIMARY KEY constraint 'PKSOP30200'. Cannot insert duplicate key in object 'dbo.SOP30200

## Cause

This message may indicate that the same order or invoice exists in both the SOP Work and SOP History table.

## Resolution

### Step 1 - Identify duplicate records

Identify duplicate records in the Sales Order Processing tables yourself. The tables are:

- SOP10100 - Sales Transactions Work
- SOP30200 - Sales Transactions History

There is an Automated Solution available to perform this task titled **Duplicates in SOP**.

> [!NOTE]
> The Automated Solution will only find and report any existing duplicate records between the tables. It will not correct the issue. You must determine which records are duplicates and then you must manually delete those records after researching which record is incorrect.

### Step 2 - Delete duplicate records

Once you have determined which records are duplicates, research them to determine which record is valid and manually delete the duplicated record using SQL Server Management Studio. If you want assistance deleting duplicated records, contact your Partner, Technical Support for Microsoft Dynamics at 1-8888-477-7877, or open a chargeable support case.
