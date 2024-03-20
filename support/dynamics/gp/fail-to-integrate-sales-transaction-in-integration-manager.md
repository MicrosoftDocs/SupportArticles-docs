---
title: Error when you integrate a sales transaction in Integration Manager in Microsoft Dynamics GP
description: Describes a problem that occurs when you integrate a sales transaction in Integration Manager in Microsoft Dynamics GP. Provides a resolution.
ms.topic: troubleshooting
ms.reviewer: theley, kvogel
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Error message when you integrate a sales transaction in Integration Manager in Microsoft Dynamics GP: "Quantities for item '[Item Number]' must be allocated before they can be fulfilled"

This article provides a solution to an error that occurs when you integrate a sales transaction in Integration Manager in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 908684

## Symptoms

When you integrate a sales transaction in Integration Manager in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> DOC 1 ERROR: Quantities for item '**Item Number**' must be allocated before they can be fulfilled.

## Cause

This problem occurs if one or more of the following conditions are true:

- The invoice ID or the order ID that you want to integrate is configured to allocate by using the **Document/Batch** option.
- The invoice ID or the order ID that you want to integrate is configured to use a separate fulfillment process.
- The Sales Order Processing Setup Options window is configured to use the **Auto Assign Lot Numbers** option.

## Resolution

To resolve this problem, obtain the latest service pack for Integration Manager.

## Status

Microsoft has confirmed that this is a problem. This problem was first corrected in Microsoft Business Solutions - Great Plains 8.0 Integration Manager Service Pack 3.
