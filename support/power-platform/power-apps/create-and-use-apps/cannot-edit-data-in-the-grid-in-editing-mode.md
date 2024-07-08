---
title: Can't edit data in the grid after enabling editing mode
description: Provides troubleshooting steps for an issue where you can't edit data in the grid after enabling editing mode in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/05/2024
author: fikaradz
ms.author: fikaradz
---
# Can't edit data in the grid after enabling editing mode in a model-driven app

This article provides troubleshooting steps for different scenarios where you can't edit data in the grid after [enabling editing mode](/power-apps/maker/model-driven-apps/the-power-apps-grid-control#configure-the-power-apps-grid-control) in a model-driven app in Microsoft Power Apps.

## Scenario 1: The entire grid control isn't editable even though editing mode is enabled

### Troubleshooting step

The first step is to check the grid and column parameters using the [Power Apps Monitoring tool](/power-apps/maker/monitor-overview).

:::image type="content" source="media/cannot-edit-data-in-the-grid-in-editing-mode/power-apps-monitoring-tool.png" alt-text="Screenshot that shows the grid and column parameters in the Power Apps Monitoring tool.":::

Make sure the grid editable mode is set to "yes". If not, check the grid configuration and make sure the last configuration is saved and published. Also note that the form might also forcibly set sub-grids to read-only or disabled modes in certain cases (for example, when the currently edited record is deactivated). You can troubleshoot this issue by checking the `isControlDisabled` attribute.

:::image type="content" source="media/cannot-edit-data-in-the-grid-in-editing-mode/iscontroldisabled.png" alt-text="Screenshot that shows the isControlDisabled attribute in the Power Apps Monitoring tool.":::

## Scenario 2: Only certain cells from certain columns aren't editable

### Troubleshooting step

Using the [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) to check the attributes of the column that isn't editable (see the first screenshot in this article). If the `IsEditable` attribute is set to "false", then editing isn't allowed here. Possible reasons include but aren't limited to:

- Dataverse doesn't support editing of the underlying column type. For example, calculated type columns aren't editable.
- The user might not have permission to edit that column.
- A [custom script](grid-issues.md#steps-to-perform-before-starting-troubleshooting) alters the cell attribute making it permanently or conditionally read-only.
