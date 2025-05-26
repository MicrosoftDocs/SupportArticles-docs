---
title: Percentage format changes to Numeric
description: Fix a problem where percentage (%) format in chart data table and axis changes to numeric format.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Editing\Cells
  - CSSTroubleshoot
appliesto:
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 05/26/2025
---
# Percentage format in pasted chart data table and axis will change to Numeric when source workbook is closed

## Symptoms

Assume below scenario:

1. Create *test1.xlsx*, input some data with \% format.
2. Create a chart based the data, then show data table from **Chart Tools**->**Layout->Data table**->**Show Data Table**.
3. Create a new workbook, named *test2.xlsx*.
4. Copy chart from *test1.xlsx* to *test2.xlsx*.

When you close test1.xlsx, in test2.xlsx you will find percentage (\%) format in chart data table and axis changes to numeric format.

## Cause

By default, data table and axis formatting of pasted chart are linked to source workbook. Once the source workbook is closed, the link is lost, and hence percentage (%) format is changed to default numeric format.

## Resolution

For axis, you can avoid this issue by unlinking the axis formatting:

1. Right-click **axis** in chart.
2. Select **Format Axis**.
3. Select **Number** tab.
4. Uncheck **Linked to Source** checkbox

For data table, it is always linked to source data so the issue can't be avoided.
