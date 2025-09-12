---
title: Troubleshoot issues with Sales Pipeline chart and its phases
description: Provides resolutions for the issues that may occur when you work with the sales pipeline chart or its phases in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Forecasting
---
# Troubleshoot issues with the Sales Pipeline chart and its phases in Dynamics 365 Sales

This article helps you troubleshoot and resolve issues related to the Sales Pipeline chart and its phases.

The Sales Pipeline chart consists of pipeline phases of an opportunity. The phase is based on the stage of the business process flow the opportunity is in, such as 1-Qualify, 2-Develop, and so on. For more information, see [Understand the sales pipeline chart and its phases](/dynamics365/sales/sales-pipeline-chart).

## Issue 1 - Multiple pipeline phases with different sequences, such as 6-Close and 7-Close

### Cause

This issue can occur if you've changed the sequence of a stage category option (for example, you changed **Close** from 6 to 7). Existing opportunities that moved to the **Close** stage before you made this change will continue to show the same pipeline phase value that was set when they moved to the **Close** stage. However, opportunities that move to the **Close** stage after you made this change will use the new sequence for the **Close** stage.

### Resolution

You can resolve this issue by resetting the values for older opportunities either by changing the stage of the business process flow to some other stage and then bringing it back to the **Close** stage, or by updating the **stepname** attribute of the opportunity programmatically.

## Issue 2 - Pipeline phase values from multiple business process flow definitions

### Cause

This is to be expected if you use multiple business process flow definitions for the Opportunity entity. The out-of-the-box pipeline phase attribute is set on every stage change in the business process flow of the **Opportunity** record, irrespective of how many business process flows are associated with that record.

### Resolution

If you have multiple business process flows, consider adding a custom field to the Opportunity Sales Process and setting its value programmatically for the stage changes you require in the business process flow for the opportunity.

## Issue 3 - The sales pipeline chart ordering is displayed differently in Unified Interface vs. the legacy web client

The legacy web client displays the chart by using the value of the associated category option, whereas in Unified Interface the stages are displayed alphabetically. Because the pipeline phases are prefixed with the order defined in the **Stage category** option set, they're displayed according to the category option sequence (1, 2, and so on).

## Issue 4 - The stages are not sorted numerically when the number of stages are beyond 9

### Cause

Charts in Unified Interface are sorted alphabetically. When you've sales stages beyond 9, (for example: 10-OnHold, 11-Pipeline), those stages appear in the chart before any stage which starts with 2. In other words, the chart renders all the phases with first character as 1 and then displays the phases starting with 2 and so on.

### Resolution

To resolve this issue, you must set up a custom attribute/column and populate it based on the chart requirements. For more information, see [How to create and edit columns](/powerapps/maker/data-platform/create-edit-fields).
