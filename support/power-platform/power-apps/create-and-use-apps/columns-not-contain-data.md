---
title: Some columns don't contain data in a model-driven app
description: Provides troubleshooting steps for an issue where some columns don't contain data in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 07/03/2024
author: fikaradz
ms.author: fikaradz
---
# Some columns don't contain data in a model-driven app

This article provides troubleshooting steps for an issue where some columns don't contain data in a model-driven app in Microsoft Power Apps.

## Symptoms

You might find data isn't displayed in certain columns in a Power Apps model-driven app.

## Cause

This issue is often caused by the discrepancies between the fetchXML request (the query for data) and the layoutXML (the column definitions), which might be due to custom code that incorrectly modifies the query. Before troubleshooting the issue, follow the steps described in [Steps to perform before starting troubleshooting](grid-issues.md#steps-to-perform-before-starting-troubleshooting).

## Troubleshooting step

First, you should ensure the issue isn't related to insufficient permissions. The easiest way to check this is to navigate to the page but as a user with full administrative privileges. The [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) can also be used to ensure the column data is readable.

:::image type="content" source="media/columns-not-contain-data/isreadable.png" alt-text="Screenshot that shows the isreadable attribute in the Power Apps Monitoring tool.":::

If the issue isn't related to insufficient permissions, use the [Power Apps Monitoring tool](/power-apps/maker/monitor-overview) to check the query and columns definition as shown in the following screenshot.

:::image type="content" source="media/columns-not-contain-data/viewfields-viewfetchxml.png" alt-text="Screenshot that shows the viewFields section and the  viewFetchXML query in the Power Apps Monitoring tool.":::

Make sure that all the columns listed in the "viewFields" section are present in the "viewFetchXML" query and that the respective columns aren't marked as "hidden".

The issue can also be caused by a corrupt view. Resaving and republishing such a view might help address the problem.
