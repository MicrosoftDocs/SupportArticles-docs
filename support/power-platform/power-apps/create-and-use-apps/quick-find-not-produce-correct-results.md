---
title: Quick Find doesn't return correct results in a model-driven app
description: Troubleshoots an issue where the Quick Find feature doesn't return correct results in a Power Apps model-driven app.
ms.reviewer: tapanm, moroch, dinusc
ms.custom: sap:Using grids and lists in model-driven apps
ms.date: 08/16/2024
author: shwetamurkute
ms.author: smurkute
---
# Quick Find doesn't return correct results in a model-driven app

This article provides troubleshooting steps for an issue where a [quick find search](/power-apps/user/quick-find) doesn't return correct results in a Power Apps model-driven app.

## Troubleshooting checklist

1. Use the [Power Apps Monitor tool](/power-apps/maker/monitor-overview) to inspect the [fetchXML](/power-apps/developer/data-platform/use-fetchxml-construct-query) query that is generated based on a [quick find search](/power-apps/user/quick-find).

   :::image type="content" source="media/columns-not-contain-data/viewfields-viewfetchxml.png" alt-text="Screenshot that shows an example of a quick find search.":::

2. Check the `recordsCount` attribute in the fetchXML query.

   :::image type="content" source="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png" alt-text="Screenshot of a fetchXML query that contains the recordsCount attribute." lightbox="media/grid-or-subgrid-displays-incorrect-content/gridchecker.png":::

3. The Quick Find filter is marked with the `isquickfindfields` attribute.

   :::image type="content" source="media/quick-find-not-produce-correct-results/isquickfindfields.png" alt-text="Screenshot of a fetchXML query that contains the isquickfindfields attribute." lightbox="media/quick-find-not-produce-correct-results/isquickfindfields.png":::

   If the columns from the `isquickfindfields` filters are incorrect, it's a strong indication that your organization's [Use quick find view of an entity for searching on grids and sub-grids](/power-platform/admin/settings-features#search) setting isn't set correctly.

   - If the setting is turned off, the search will be performed on all the searchable columns. For more information, see [Types of columns](/power-apps/maker/data-platform/types-of-fields).
   - If the setting is enabled, the search will be performed based on the entity's quick find view. Also, note that the entity's quick find view might contain a filter that will be applied to the search. You should be able to see that filter in the fetchXML data query that you inspect.

## More information

- [About quick find queries](/power-apps/developer/data-platform/quick-find)
- [Best Practices for Dynamics 365 CRM Quick Find View](https://community.dynamics.com/blogs/post/?postid=0ffbe287-8d5e-488f-a50d-737c7c5c0732)
- [Troubleshooting grid issues in Power Apps](grid-issues.md)
