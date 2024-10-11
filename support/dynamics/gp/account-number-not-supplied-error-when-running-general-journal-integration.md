---
title: Account Number is a required field but value was not supplied error when running General Journal integration
description: Describes a problem that occurs if the integration source file contains blank rows in Integration Manager for Microsoft Dynamics GP. Provides several resolutions.
ms.reviewer: theley, Dclauson
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Error Field Entries.Account Number is a required field but value was not supplied" error when you run a General Journal integration

This article provides methods to solve the issue that ou can't run a General Journal integration in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929783

## Symptoms

When you run a General Journal integration in Integration Manager for Microsoft Dynamics GP, you receive the following error message:

> Error Field Entries.Account Number is a required field but value was not supplied.

## Cause

This problem occurs if the integration source file contains blank rows.

> [!NOTE]
> To determine whether the integration source file contains blank rows, examine the source queries when you receive this error message.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1

Manually delete any blank rows from the integration source file.

### Method 2

Create a row restriction in the source query to filter out blank rows. To do this, follow these steps:

1. Locate and then double-click the source query.
2. Select the **Rows** tab, and then select a column in the Columns list that contains a blank row. This column must contain data in other rows.
3. In the **Operator** list, select **Not Like**.
4. In the **Value** box, type two double quotation marks ("").
5. To add the restriction to the source query, select **And Into Criteria**, and then select **OK**.
6. Preview the source query to verify that the blank rows no longer appear.
