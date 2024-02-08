---
title: Pick this up option doesn't appear on cart or product details pages in Dynamics 365 Commerce
description: Provides a resolution for an issue where the option for in-store pickup doesn't appear on the cart page or product details page in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 12/22/2023
---
# The "Pick this up" option doesn't appear on cart or product details pages 

This article provides a resolution for an issue where the option for in-store pickup doesn't appear on the cart page or product details page.

## Symptoms

The **Pick this up** option doesn't appear on the cart page or product details page.

The following screenshot shows an example of a page that includes the **Pick this up** option.

:::image type="content" source="media/pickup-store-link-missing/pick-this-up-button.png" alt-text="Screenshot that shows the page that contains the Pick this up option.":::

## Resolution

To solve the issue, follow these steps:

#### Step 1: Configure modes of delivery in Commerce headquarters

To configure modes of delivery in Commerce headquarters, follow these steps:

1. Go to **Procurement and sourcing** > **Setup** > **Modes of delivery**.
1. Make sure that a **Customer pickup** mode of delivery has been created and that products and addresses are assigned to it.
1. Go to **Retail and Commerce** > **Headquarters setup** > **Parameters**.
1. In the left navigation, select **Customer orders**.
1. Make sure that **Pickup mode of delivery** is correctly configured.

#### Step 2: Configure customer orders payments

To configure customer orders payments in Commerce headquarters, follow these steps:

1. Go to **Retail and Commerce** > **Headquarters setup** > **Parameters**.
1. In the left navigation, select **Customer orders**.
1. On the **Payments** FastTab, make sure that the **Terms of payment** and **Method of payment** fields are correctly set.

## More information

- [Configure BOPIS](/dynamics365/commerce/cpe-bopis)
- [Enable multiple pickup delivery modes for customer orders](/dynamics365/commerce/multiple-pickup-modes)
- [Omni-channel Commerce order payments](/dynamics365/commerce/dev-itpro/commerce-payments)
- [Store selector module](/dynamics365/commerce/store-selector)
