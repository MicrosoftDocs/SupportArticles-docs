---
title: Grid or subgrid doesn't display all the records in a model-driven app
description: Provides troubleshooting steps for an issue where the grid or subgrid doesn't display all the records in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 08/16/2024
author: shwetamurkute
ms.author: smurkute
---
# Grid or subgrid doesn't display all the records in a model-driven app

This article provides troubleshooting steps for an issue where you might find the content displayed in the grid or subgrid in a Power Apps model-driven app is correct, but it seems incomplete.

## Troubleshooting step

- For a grid control, make sure the page size and the number of records provided to the grid control are expected.

  :::image type="content" source="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png" alt-text="Screenshot of how to use the monitor tool to get page and records information." lightbox="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png":::

- For a subgrid, the page size can be also defined by the [Maximum number of rows](/power-apps/maker/model-driven-apps/form-designer-add-configure-subgrid) setting (a subgrid component) in the form designer.

  :::image type="content" source="media/grid-or-subgrid-not-display-all-records/maximum-number-of-rows.png" alt-text="Screenshot of the Maximum number of rows setting that can be used to define the page size for a subgrid.":::

## More information

- For similar issues, see [Grid or subgrid displays incorrect content in a model-driven app](grid-or-subgrid-displays-incorrect-content.md) and [The overall record count doesn't match the displayed content](overall-record-count-not-match-displayed-content.md).
- For other grid issues, see [Troubleshooting grid issues in Power Apps](grid-issues.md).
