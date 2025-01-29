---
# required metadata

title: Troubleshoot report design and data issues
description: Describes how to create a simple report to analyze some issues that occur in Microsoft Dynamics 365 Finance reports.
author: aprilolson
ms.date: 01/29/2025

# optional metadata

ms.search.form: FinancialReports
# ROBOTS: 
audience: Application User
# ms.devlang: 
ms.reviewer: twheeloc
# ms.tgt_pltfrm: 
ms.collection: get-started
ms.assetid: 3eae6dc3-ee06-4b6d-9e7d-1ee2c3b10339
ms.search.region: Global
# ms.search.industry: 
ms.author: aolson
ms.search.validFrom: 2016-02-28
ms.dyn365.ops.version: AX 7.0.0
ms.custom: sap:Financial reporting and management reporter\Issues with report designer
---
# Troubleshoot report design and data issues

A practical way to troubleshoot report design or missing data issues effectively is to simplify the process and control variables. Focusing on a specific scope is often more manageable than diagnosing an entire report. Start by creating the smallest possible reproduction of the issue and make changes one at a time. In some cases, manually recreating a report or starting over with the design helps uncover design flaws or process bugs. 

To help determine the cause of a data mismatch, some common areas to validate are:
 - Create a simple report to troubleshoot the issue.
 - Check that your data mart integration is current and healthy.  


## Create a simple report for troubleshooting
To create a simple report to troubleshoot report issues, follow these steps:
1. Simplify the report as much as possible. The goal is to get to a single number.
2. Remove any reporting tree and dimension set.
3. Set the **Detail level** to **Financial**, **Account**, and **Transaction**.
4. Remove any other special options.
5. In the row definition, include a single row with a single account or dimension combination.
 - No wildcard or ranges.
 - No modifiers or calculations to start.
6. In the column definition, include a single **DESC** and **FD** column for a specific period.
 - Remove all modifiers for the column. 
7. This should display a report with a single cell of data.
8. Verify the report is working as expected.
9. Add one modification at a time if your issue includes specific design requirements.
   a.	For example: currency filter, attribute filter, year-to-date, or beginning balances.
10.	If the issue still exists, contact support and provide the following:
 - Export .tdbx files of the simplified and original reports.
 - Screenshots of the simplified report build block designs including rows and columns.
 - Excel export of the report output.
 - Reporting parameters: **Company**, **Reporting date**, and **Report name**.
 - Details about the incorrect amount and what the expected value is.
   
### Check the data mart state
To check the state of your data mart, follow these steps:
1. In **Report designer**, go to **Tools** > **Integration status**.
2. Check that the **Status** isn't **Failed** and the **Last Runtime** date is after you created your data. Usually, the General Ledger transactions are tracked to **Fact map**. Occasionally, due to system load and data volume, this can take longer. You may need to wait more than one hour for larger data changes to complete integration into data mart.
3. To check more detailed statistics, go to **Tools** > **Reset data mart**. DO NOT reset the data mart.
If there are transactions with six or more attempts, this could be *stuck* data due to integrity issues. Having amounts here doesn’t mean data is missing from your report, but it can be a source of missing data. Work with Microsoft support to determine the cause of the stuck data.
4. If there are any **Misaligned main account** categories, reports based on account categories could report incorrect amounts.


   
