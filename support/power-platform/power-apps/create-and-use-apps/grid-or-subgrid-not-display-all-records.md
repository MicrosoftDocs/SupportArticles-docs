---
title: Grid or sub-grid doesn't display all the records in a model-driven app
description: Provides troubleshooting steps for an issue where the grid or sub-grid doesn't display all the records in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/03/2024
author: fikaradz
ms.author: fikaradz
---
# Grid or sub-grid doesn't display all the records in a model-driven app

This article provides troubleshooting steps for an issue where you might find the content displayed in the grid or sub-grid in a Power Apps model-driven app is correct, but it seems incomplete.

## Troubleshooting step

- For a grid control, make sure the page size and the number of records provided to the grid control is expected.

  :::image type="content" source="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png" alt-text="Screenshot that shows how to use the monitoring tool to get page and records information." lightbox="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png":::

- For a sub-grid, note that the page size can be also defined by the **Maximum number of rows** setting in the form designer (sub-grid component).

  :::image type="content" source="media/grid-or-subgrid-not-display-all-records/maximum-number-of-rows.png" alt-text="Screenshot that shows the Maximum number of rows setting that can be used to define the page size for a sub-grid.":::

## More information

For similar issues, see [Grid or sub-grid displays incorrect content in a model-driven app](grid-or-subgrid-displays-incorrect-content.md) and [The overall record count doesn't match the displayed content](overall-record-count-not-match-displayed-content.md).
