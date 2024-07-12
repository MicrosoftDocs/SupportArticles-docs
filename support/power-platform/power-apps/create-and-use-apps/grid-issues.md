---
title: Troubleshoot grid issues in model-driven apps
description: Provides a resolution for grid issues in model-driven apps in Microsoft Power Apps.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/08/2024
author: fikaradz
ms.author: fikaradz
---
# Troubleshooting grid issues in Power Apps

This guide helps you resolve the following grid issues that occur in a Power Apps model-driven app.

- [Can't use sorting or sorting doesn't work correctly](cannot-use-sorting-or-sorting-not-work-correctly.md).
- [Can't use column filters on a grid or subgrid or filtering doesn't work correctly](cannot-use-column-filters-on-grid-subgrid-or-filtering-not-work-correctly.md).
- [Can't edit data in the grid after enabling editing mode](cannot-edit-data-in-the-grid-in-editing-mode.md).
- [Grid or subgrid displays incorrect content](grid-or-subgrid-displays-incorrect-content.md).
- [Grid or subgrid doesn't display all the records](grid-or-subgrid-not-display-all-records.md).
- [Modern Advanced Find doesn't work correctly](modern-advanced-find-not-work-correctly.md).
- [Nested grid doesn't display data](nested-grid-not-display-data.md).
- [Quick Find doesn't return correct results](quick-find-not-produce-correct-results.md).
- [Some columns don't contain data](columns-not-contain-data.md).
- [The overall record count doesn't match the displayed content](overall-record-count-not-match-displayed-content.md).

## Terms

1. [Grid control](/power-apps/maker/model-driven-apps/the-power-apps-grid-control) - a control that's displayed on an entity page.
2. Subgrid control - a control that's displayed in a form or inside a reference panel.
3. View selector - a drop-down control that allows selecting the current view.
4. Ribbon command bar - the content-dependent button bar at the top of a page or form.
5. Subgrid menu - a content-dependent menu.
6. Quick Find - a search control that allows filtering the current view by typing a search string.
7. Column Editor - a tool that allows adding, removing, or reordering columns in the current view.
8. Modern Advanced Find - a tool that allows applying complex filters to the current view.
9. Column filters - a tool that allows applying simple filters to the grid.
10. Column sorting - a tool that allows sorting the grid content by one or more columns.
11. Status column - a grid column that allows selecting rows. It's also used for displaying row related messages.
12. Nested grid - a child grid that renders inside a grid or subgrid control.
13. Column header - the header at the top of the grid or subgrid control.
14. Jump bar - the alpha-numeric bar at the bottom of the grid.

Here are the screenshots of the terms:

:::image type="content" source="media/grid-issues/grid-control.png" alt-text="Screenshot that shows an entity page that contains the terms 1, 3, 4, 6, 7, 8, 14." lightbox="media/grid-issues/grid-control.png":::

:::image type="content" source="media/grid-issues/form-page.png" alt-text="Screenshot that shows a form page that contains the terms 2, 3, 4, 5." lightbox="media/grid-issues/form-page.png":::

:::image type="content" source="media/grid-issues/column-filters-sorting-header-status.png" alt-text="Screenshot that shows a page that contains the terms 9, 10, 11, 13." lightbox="media/grid-issues/column-filters-sorting-header-status.png":::

:::image type="content" source="media/grid-issues/nested-grid.png" alt-text="Screenshot that shows a page that contains the term 12." lightbox="media/grid-issues/nested-grid.png":::

## Useful tools

- [Power Apps Monitor tool](/power-apps/maker/monitor-overview)
- [Web Developer tool](https://developer.chrome.com/docs/devtools/network)

## Steps to perform before starting troubleshooting

1. Remove or disable custom scripts. One of the first steps is to ensure that custom scripts don't interfere with product functionality. It's highly recommended to perform this step even when custom scripts used to work in one of the previous versions.

    - If all custom scripts are attached via form events, follow the steps in [Troubleshoot form issues in model-driven apps](/power-apps/developer/model-driven-apps/troubleshoot-forms) to disable them.
    - Other custom scripts are added directly via web resources, custom solutions, or plugins.
    - If the issue can't be reproduced after removing custom scripts, investigate all the customizations to find the problem.
    - If custom scripts are correctly using publicly documented APIs and the product doesn't behave as expected, try to simplify the custom script to localize the problem. In most of the cases, 10-30 lines of script code are enough to reproduce an issue.

2. If the problem involves custom entities, custom relationships, custom views, custom configurations, or other custom resources, try to reproduce the issue with out-of-the-box (OOB) standard resources and avoid any custom resources. This method helps localize the problem.

3. Disable all the applicable business rules to see if the issue is caused by a business rule.

4. If reproducing the issue involves the use of third-party tools, try to reproduce the issue with standard out-of-the-box (OOB) tools.
