---
title: Consolidate companies with year end dates produce wrong results
description: Information on the two Management Reporter Consolidate with different fiscal year ends options.
ms.reviewer: trentone, kevogt
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Consolidate companies in Management Reporter that have different fiscal year ends produce wrong results

This article provides options to solve the issue that Consolidate companies in Microsoft Management Reporter that have different fiscal year ends may produce incorrect results.

_Applies to:_ &nbsp; Microsoft Dynamics AX 2009, Microsoft Dynamics GP, Microsoft Dynamics SL 2011, Microsoft Management Reporter 2012  
_Original KB number:_ &nbsp; 2697438

## Symptoms

When you consolidate companies that have year-end dates, the report may not produce the expected results.

## Cause

Period end dates may not match causing unexpected mismatches between consolidating company periods.

## Resolution

There are two options to make the report work correctly. These options are found in the report definition, on the **Settings** tab. Select **Other** and then select the **Additional Options** tab.

> [!NOTE]
> The default company is considered the company that is specified in the report definition. If @ANY is used, then the default company is the company that you are currently logged into.

### Option 1

Rollup by using default company period number

The period that is specified in the column definition is used for all companies that are defined in the tree.

For example, 6/30/2012 is Period 12 for the default company and is Period 6 for the second company. If the report was run for period 12, the default company would pull data from June, whereas the second company would pull data from December.

In order to obtain data for June for both companies, you would have to set one column to period 12 and a second column to period 6. Each column would then have to be restricted to its respective company in the tree, by using the Reporting Unit.

This option is the default setting.

### Option 2

Rollup by using default company period end date

The period that is specified in the column definition is used to retrieve the date from default company.

If the default company's Period 12 has end date of 6/30/2012, then this date will be used against all companies regardless of period numbers. Using this example, the second company would pull data from period 6.

## Issue with YTD columns

YTD columns may not work as expected with this option as data is pulled as YTD for the source company not the default company.

Workaround:

- Create Periodic columns for each period and sum in CALC column.
- This may need to be done by using a Rollup by end date and columns to specify BASE-1, BASE-2, and so on.

## Using Budget data

- A Date Range Budget must be created for each non-default company calendar.
- Data in the Date Range Budget must correspond to the default company dates and may cross between different source company regular budgets.
- Default company calendar needs to be consistent when report is run.

> [!NOTE]
> Changing from a Calendar year company to a Fiscal year company may produce bad resulting data.

## More information

The following script may have to be used to correct the YEAR1 bug is GP2010.

```sql
UPDATE GL00200 SET YEAR1 = YEAR(TODATE) where BUDGETID ='xxxx'
```

(Replace xxxx with the Budget ID)
