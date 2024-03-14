---
title: Determine whether the begin date and the end date are accurate for a project in Project Accounting
description: Describes the windows that you can use in Project Accounting to verify that the begin date and the end date are accurate for a project.
ms.topic: how-to
ms.reviewer: theley, marianv
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# How to determine whether the begin date and the end date are accurate for a project in Project Accounting in Microsoft Dynamics GP

This article describes how to determine whether the begin date and the end date are accurate for a project in the Project Maintenance window in Project Accounting for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929784

## Summary

The values in the **Begin Date** field and in the **End Date** field for a project in the Project Maintenance window are derived from the earliest begin date and from the latest end date in the following windows:

- Budget Detail Entry
- Fee Schedule
- Fee Details

To determine whether the begin date and the end date are accurate for a project, review the information in each of these windows.

## The Budget Detail Entry window

Locate the begin dates and the end dates of the budget that is associated with the project. To do this, follow these steps:

1. On the **Cards** menu, point to **Project**, and then click **Project**.
2. Type the project number in the **Project No.** field, and then click **Budget**.
3. In the Budget Maintenance window, select the cost category, and then click the expansion arrow next to the **Cost Category** field.

The Budget Detail Entry window opens. In the Budget Detail Entry window, the following budget begin dates and end dates appear.

|-| Begin Date|End Date|
|---|---|---|
| **Scheduled**| **begin date**| **end date** |
| **Forecast**| **begin date**| **end date** |
| **Actual**| **begin date**| **end date** |

Project Accounting uses the forecasted begin date and the forecasted end date to determine the begin date and the end date for the project.

## The Fee Schedule window

Locate the begin dates and the end dates of the fee schedule that is associated with the project. To do this, follow these steps:

1. On the **Cards** menu, point to **Project**, and then click **Project**.
2. Type the project number in the **Project No.** field, and then click **Fees**.

    The Fee Entry window opens. In this window, all the fees that are associated with the project are displayed.

3. In the Fee Entry window, select each fee, and then click the expansion button next to the **Frequency** field to open the Fee Schedule window. The fee schedule dates are displayed in the Fee Schedule window.

## The Fee Details window

Locate the begin dates and the end dates of the fee details that are associated with the project. To do this, follow these steps:

1. On the **Cards** menu, point to **Project**, and then click **Project**.
2. Type the project number in the **Project No.** field, and then click **Fees**.

    The Fee Entry window opens. In this window, all the fees that are associated with the project are displayed.

3. In the Fee Entry window, select each fee, and then click the expansion button next to the **Fee ID** field to open the Fee Details window.

The begin dates and the end dates are displayed for the fee.
