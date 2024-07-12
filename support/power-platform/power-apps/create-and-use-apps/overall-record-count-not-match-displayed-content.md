---
title: Total record count doesn't match the displayed content
description: Troubleshoots an issue where the overall record count doesn't match the displayed content in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/12/2024
author: fikaradz
ms.author: fikaradz
---
# The overall record count doesn't match the displayed content in a model-driven app

This article provides troubleshooting methods for an issue where the overall record count doesn't match the displayed content in a Power Apps model-driven app.

## Symptoms

A typical example of this issue is that the number of records displayed is lower than the count displayed at the bottom of the page.

## Cause

The most likely reason is that the data displayed in the grid contains duplicate records (by the value in the primary field). The issue is caused by pulling related record duplicates from the same table.

## Troubleshooting checklist

- Use the [Power Apps Monitor tool](/power-apps/maker/monitor-overview) to check the total number of records.

  :::image type="content" source="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png" alt-text="Screenshot that shows how to use the monitoring tool to get page and record information." lightbox="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png":::

  If the `recordsCount` matches the total number of records displayed at the bottom of the grid, but the data in the grid has fewer records, it's a strong indication that the data contains duplicate records. Use the monitoring tool to get the current `viewFetchXML` request.

  :::image type="content" source="media/modern-advanced-find-not-work-correctly/entity-support-page-filters.png" alt-text="Screenshot that shows a fetchXML query." lightbox="media/modern-advanced-find-not-work-correctly/entity-support-page-filters.png":::

- The issue can be solved by adding `distinct="true"` to the fetchXML query. For more information, see [Query data using FetchXml](/power-apps/developer/data-platform/use-fetchxml-construct-query).

  If adding `distinct="true"` doesn't solve the problem, consider changing the query to avoid pulling duplicate records. The primary column (field) can also be found by using the [Power Apps Monitor tool](/power-apps/maker/monitor-overview).

  :::image type="content" source="media/overall-record-count-not-match-displayed-content/all-filters-in-fetchxml-query.png" alt-text="Screenshot that shows the primary column in a fetchXML query.":::
