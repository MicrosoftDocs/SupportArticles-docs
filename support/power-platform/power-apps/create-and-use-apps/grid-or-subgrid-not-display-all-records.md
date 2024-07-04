---
title: Grid or sub-grid doesn't display all the records
description: Fixes an issue in which the grid or sub-grid doesn't display all the records in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/03/2024
author: fikaradz
ms.author: fikaradz
---
# Grid or sub-grid doesn't display all the records

You might find the content displayed in the grid or sub-grid in a Power Apps model-driven app is correct, but it seems incomplete.

## Resolution

- For a grid control, make sure the page size and the number of records provided to the grid control is expected. To check the settings, see the screenshot in the [Grid or sub-grid displays incorrect content](grid-or-subgrid-displays-incorrect-content.md).
- For a sub-grid, note that the page size can be also defined by the **Maximum number of rows** setting in the form designer (sub-grid component).

  :::image type="content" source="media/grid-or-subgrid-not-display-all-records/maximum-number-of-rows.png" alt-text="Screenshot that shows the Maximum number of rows setting that can be used to define the page size for a sub-grid.":::
