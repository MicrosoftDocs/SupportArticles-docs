---
title: Hierarchy is incorrectly published to a future date
description: Provides a resolution for an issue where a hierarchy is incorrectly published to a future date in Microsoft Dynamics 365 Commerce.
author: bstorie
ms.author: brstor
ms.date: 02/07/2024
---
# A hierarchy is incorrectly published to a future date

This article resolves an issue where a hierarchy change is incorrectly published to a future date in Microsoft Dynamics 365 Commerce.

## Symptoms

A user makes changes to an [organization's hierarchy](/dynamics365/fin-ops-core/fin-ops/organization-administration/organizations-organizational-hierarchies?context=%2Fdynamics365%2Fcontext%2Fcommerce), and then publishes the hierarchy. However, the **date** field is incorrectly set to a future date. This issue prevents the system from replicating data to the channel database. As a result, the products, pricing, and other items don't appear in a [channel](/dynamics365/commerce/channels-overview).

## Resolution

To resolve this issue, follow these steps to delete the incorrect dated hierarchy. Once the incorrect hierarchy is deleted, recreate your changes to the hierarchy and ensure you publish it to the correct date.

1. In the navigation pane, go to **Modules** > **Organization administration** > **Organizations** > **Organization hierarchies**.
2. Select the hierarchy that you want to delete.
3. Select **View**.
4. On the right side of the screen, select the **Related information** flyout.
5. Under **Future changes**, select **More**.

   :::image type="content" source="media/fix-incorrectly-published-heirarchy/hiearchy-related-information.png" alt-text="Screenshot that shows the More option under the Future changes on the Related information flyout.":::

6. On the **Publication date** column, select the "Filter" icon.

   :::image type="content" source="media/fix-incorrectly-published-heirarchy/hiearchy-publication-date-filter.png" alt-text="Screenshot that shows the filter icon on the Publication date column.":::

7. Select **Clear** to remove the filtered value.
8. In the list, select the hierarchy with the future publish date.
9. Select **delete**.
