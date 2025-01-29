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

Here is a practical way to troubleshoot report design or missing data issues effectively. The key principle is to simplify the process and control variables, as focusing on a specific scope is often more manageable
than diagnosing an entire report. Start by creating the smallest possible reproduction of the issue and make changes one at a time. In some cases, manually recreating a report or starting over with the design can 
help uncover design flaws or process bugs, ensuring a smoother troubleshooting experience.

## Create a simple report for troubleshooting
To create a simple report to help troubleshoot report issues, follow these steps:
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
9. If the issue still exists, contact support. 
