---
title: Invalid Unit Cost error when doing PA Timesheet integration
description: Describes a problem that occurs because a functional currency is not set up in Microsoft Dynamics GP or in Microsoft Great Plains.
ms.reviewer: theley, kvogel
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Invalid Unit Cost. If Currency ID is different than Functional ID than you need to pass in PAUNITCOST" error when doing a PA Timesheet integration

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 912865

## Symptoms

When you do a PA Timesheet integration by using Integration Manager, you receive the following error message:

> Invalid Unit Cost. If Currency ID is different than Functional ID than you need to pass in PAUNITCOST Node Identifier Parameters: taPATimeSheetLineInsert

> [!NOTE]
> In the error message, the second "than" is a misspelling of "then."

## Cause

This problem occurs because a functional currency isn't set up in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

## Resolution

To resolve this problem, set up a functional currency in Microsoft Dynamics GP or in Microsoft Great Plains. To do this, follow these steps:

1. On the **Tools** menu, point to **Setup**, select **Financial**, and then select **Multicurrency**.
2. In the Multicurrency Setup window, select the functional currency that you want.
