---
title: Enter a Transaction Dimension Code
description: Provides a solution to an error that occurs when using Edit Analysis for Analytical Accounting in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Analytical Accounting
---
# "Please enter a Transaction Dimension Code against Transaction Dimension XXXXXX." Error message when using Edit Analysis for Analytical Accounting in Microsoft Dynamics GP

This article provides a solution to an error that occurs when using Edit Analysis for Analytical Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2965456

## Symptoms

When you select the **Validate** button in the Analytical Adjustment Entry window using Edit Analysis for Analytical Accounting, you receive the message below. However, the dimension used is set up as **optional** and not **required** in the Accounting Class setup.

> Please enter a Transaction Dimension Code against Transaction Dimension XXXXXX.

## Cause

The checkbox for Code Required During Adjustment is marked on the Transaction Dimension Setup. With this option marked, a dimension code will be required on all adjustments made using Edit Analysis, regardless of the Analysis Type on the Accounting Class setup.

## Resolution

To resolve this issue, use the following steps:

1. Select **Cards**, point to **Financial**, point to **Analytical Accounting**, and select **Transaction Dimension**.

2. Select the appropriate Trx Dimension.

3. Unmark the checkbox for Code Required During Adjustment.

4. Select **Save**.
