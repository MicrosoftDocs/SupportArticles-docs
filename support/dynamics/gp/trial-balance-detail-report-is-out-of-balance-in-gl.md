---
title: Trial Balance Detail report is out of balance in GL
description: The Trial Balance Detail report in GL is out of balance due to an unbalanced journal entry, or rounding difference using Multi-currency. The below steps show you how to key a one-sided journal entry to resolve the issue.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# Trial Balance Detail report is out of balance in General Ledger using Microsoft Dynamics GP

This article provides a resolution for the issue that the Trial Balance Detail report is out of balance in General Ledger using Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2428683

## Symptoms

The Trial Balance Detail report in GL is out of balance due to an unbalanced journal entry, or rounding difference using Multi-currency.

To print the Trial Balance Detail report, select **Reports**, point to **Financial** and select **Trial Balance**. Under **Reports**, select **Detailed**. Insert a report option or create a new report option. In the Trial Balance Report Options window, select the report restrictions as needed and save. Print the report to verify if the total debit amount is equal to the total credit amount.

## Cause

There is an unbalanced journal entry in the General Ledger tables.

## Resolution

Follow the steps below to locate unbalanced journal entries:

### Step 1 - Print the Trial Balance report

1. Open the Trial Balance Report Options window for the Detailed Trial Balance Report by selecting the report option and select the **Modify** button.
2. In the Include section, make sure the checkbox for Unit Accounts is not marked.
3. In the Include section, make sure the checkbox for Inactive Accounts is marked.
4. Print the report again.
5. Verify that the Detailed Trial Balance Report is still unbalanced.

### Step 2 - Identify unbalanced General Ledger transaction(s)

To identify unbalanced GL transaction(s), follow these steps:

Method 1: Use SQL scripts

1. Use the appropriate step below to open SQL Server Management Studio:
   - If you use SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - If you use Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
   - If you use Microsoft SQL Server 2008 or R2, start SQL Server Management Studio. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

2. Copy the below script in to a query window and execute against the company database to identify unbalanced journal entries.

    ```sql
    select JRNENTRY, sum(DEBITAMT) - sum(CRDTAMNT) from GL20000, GL00100 where ACCTTYPE = 1 group by JRNENTRY having sum(DEBITAMT) - sum(CRDTAMNT) <> 0
    ```

Method 2: Use the automated solution for **General Ledger Out of Balance** to find the unbalanced journal entries. This solution can be found in [Automated solutions that are available for the Financials series in Microsoft Dynamics GP](https://support.microsoft.com/topic/automated-solutions-that-are-available-for-the-financials-series-in-microsoft-dynamics-gp-28c04364-f0e9-aef9-1367-4a9063c0a62f).

### Step3 - Fix

Once you have identified the unbalanced journal entry, the course of action will vary depending on if it is in a current open year, or in a historical year as follows:

- If the unbalanced journal entry is in a current open year, you can delete the entry directly from the GL20000 table, and reconcile the year in the front-end (to get the GL summary tables updated). Then rekey the journal entry correctly.
- If the unbalanced journal entry is in a historical year, you will need to reopen the GL year first. If you are on Microsoft Dynamics GP 2013 R2 or later versions, you can do this yourself using the 'Reverse Historical Year' checkbox in the Year-End Closing routine window. However, if you are Microsoft Dynamics GP 2013 SP2 or a prior version, you must contact your Partner to start a consulting service to have the GL year reopened for you via SQL Scripting. Once the year is reopened, you can delete the entry directly from the GL20000 table, reconcile the year in the front-end, rekey the entry correctly, and then reclose the year again.
