---
title: Products and categories don't appear in Commerce site builder after mapping a new site in Dynamics 365 Commerce
description: Provides a resolution for an issue where products and categories aren't shown in Commerce site builder after a new site is mapped in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/01/2023
---
# Products and categories don't appear in Commerce site builder after a new site is mapped

This article provides a resolution for an issue where products and categories don't appear in Commerce site builder after a new site is [mapped](/dynamics365/commerce/map-channels-sites) in Microsoft Dynamics 365 Commerce.

## Symptoms

Products and categories don't show up in Commerce site builder after a new site is mapped.

## Resolution

To solve this issue, follow these steps to add the products to the channel categories in Commerce headquarters:

1. Go to **Retail and Commerce** > **Channel setup** > **Channel categories and product attributes**.
1. In the left navigation, select the category that should appear on the e-commerce site.
1. On the **Products** FastTab, select **Add**.
1. In the **Available Products** section, select the products that should appear, and then select **Add**.
1. Select **OK**.
1. After the products appear on the **Products** FastTab, select **Publish channel updates** on the Action Pane.

## More information

[Configure a channel to use a channel navigation hierarchy](/dynamics365/commerce/configure-channel-hierarchy)
