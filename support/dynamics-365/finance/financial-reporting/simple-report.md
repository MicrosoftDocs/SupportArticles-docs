---
# required metadata

title: Troubleshoot Report Design and Data Issues 
description: Describes how to create a report to analyze data issues that occur in Microsoft Dynamics 365 Finance reports.
author: aprilolson
ms.date: 02/14/2025

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

A practical way to troubleshoot design or missing data issues in [financial reporting](/dynamics365/fin-ops-core/fin-ops/analytics/financial-reporting-intro) is to simplify the process and control variables. Focusing on a specific scope is often more manageable than diagnosing an entire report. Start by creating the smallest possible reproduction of the issue and make changes one at a time to help isolate the problem. In some cases, manually recreating a report or starting over with the design can help uncover design flaws or process bugs.

To troubleshoot report issues:

- [Check that your data mart integration is current and healthy.](#check-the-data-mart-state)
- [Create a minimal report.](#create-a-minimal-report)

## Check the data mart state

To check the state of your data mart, follow these steps:

1. In **Report designer**, go to **Tools** > **Integration status**.
2. Check that the **Status** isn't **Failed** and the **Last Runtime** date is after the creation of your data. Usually, the General Ledger transactions are tracked to **Fact map**. Occasionally, due to system load and data volume, data mart integration can take longer. You might need to wait more than one hour for larger data changes to complete integration into data mart.

3. To check more detailed statistics, go to **Tools** > **Reset data mart**, but don't reset the data mart.

   If there are transactions with six or more attempts, there might be data integrity issues. It doesn't mean data is missing from your report, but it can be a source of missing data. Work with [Microsoft support](/power-platform/admin/get-help-support) to determine the cause of the stuck data.

4. If there are [Misaligned main account categories](/dynamics365/fin-ops-core/dev-itpro/analytics/reset-financial-reporting-datamart-after-restore#misaligned-main-account-categories), reports based on account categories might report incorrect amounts.

## Create a minimal report

To create a minimal report to troubleshoot report issues, follow these steps:

1. Simplify the report as much as possible. The goal is to get to a single number.
2. Remove any [reporting tree](/dynamics365/fin-ops-core/fin-ops/analytics/financial-reporting-tree-definitions) and dimension set.
3. Set the **Detail level** to **Financial**, **Account**, and **Transaction**. For more information, see [Report definitions](/dynamics365/fin-ops-core/fin-ops/analytics/design-financial-report-definitions).
4. Remove other special options.

5. In the [row definition](/dynamics365/fin-ops-core/fin-ops/analytics/row-definitions-financial-reporting), include a single row with a single account or dimension combination.
      - No wildcard or ranges.
      - No modifiers or calculations to start.

6. In the [column definition](/dynamics365/fin-ops-core/fin-ops/analytics/column-definitions-financial-reports), include a single **DESC** and **FD** column for a specific period.
      - **Fiscal Year**: 2025 (specific year)
      - **Period**: 11 (specific period)
      - **Periods Covered**: PERIODIC
      - Remove all modifiers for the column.

7. This should display a report with a single cell of data.
8. Verify the report is working as expected.
9. If your issue includes specific design requirements, such as currency filter, attribute filter, year-to-date, or beginning balances, add these modifications one at a time.
10. If the issue still exists, contact [Microsoft support](/power-platform/admin/get-help-support) and provide the following information:
      - [The .tdbx exported files](/dynamics365/finance/general-ledger/view-financial-reports#export-a-financial-report) of the simplified and original reports.
      - Screenshots of the simplified report build block designs including rows and columns.
      - Excel export of the report output.
      - Reporting parameters: **Company**, **Reporting date**, and **Report name**.
      - Details about the incorrect amount and what the expected value is.

## More information

[Best practices for optimizing financial reports](/dynamics365/finance/general-ledger/fin-reports-best)
