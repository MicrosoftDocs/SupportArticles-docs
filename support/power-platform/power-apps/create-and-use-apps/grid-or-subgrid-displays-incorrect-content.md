---
title: Grid or sub-grid displays incorrect content in a model-driven app
description: Provides troubleshooting steps for an issue where the grid or sub-grid displays incorrect content in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/03/2024
author: fikaradz
ms.author: fikaradz
---
# Grid or sub-grid displays incorrect content in a model-driven app

This article provides troubleshooting steps for an issue where the grid or sub-grid displays incorrect content in a model-driven app in Microsoft Power Apps.

## Symptoms

You might find the grid doesn't display the expected content immediately after navigating to the parent page or form. Data is rendered but the content doesn't match the default view or the view selected from the view selector.

For similar issues, see [Grid or sub-grid does not display all the records](grid-or-subgrid-not-display-all-records.md) and [The overall record count doesn't match the displayed content](overall-record-count-not-match-displayed-content.md).

## Troubleshooting step

The first step is to check if the grid is receiving the expected data. Use the [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) to investigate the latest "GridChecker" event that's related to the grid or sub-grid.

:::image type="content" source="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png" alt-text="Screenshot that shows how to use the monitoring tool to get page and records information." lightbox="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png":::

If the `recordsCount` and `initialPageSize` matches the actual content displayed in the grid, this is a strong indication that the view isn't configured correctly. Check the view configuration (columns and filters). If the issue occurs in a sub-grid, also check if the grid is configured to only show related records.
