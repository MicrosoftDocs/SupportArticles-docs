---
title: Budget amounts not shown for budgets that use date range
description: Provides a resolution for the issue that Microsoft Management Report does not show budget amounts for budgets that use a date range.
ms.reviewer: kevogt, erikjohn
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Microsoft Management Report does not display budget amounts for budgets that use a date range

This article provides a resolution to show the budget amounts for budgets that use a date range in Microsoft Management Report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2655682

## Symptoms

When you create a report in Microsoft Management Reporter, no data is returned for budget columns. This happens if the budget is set up in Microsoft Dynamics GP with a date range.

## Cause

The GL00201 table in the company database is populated with a 0 instead of the actual year.

## Resolution

1. Back up your Dynamics and Company Database.
2. Run the following statement against your company database.

    ```console
    update GL00201 set YEAR1 = (select YEAR (perioddt))
    ```
