---
title: Items without inventory can be checked out in Dynamics 365 Commerce
description: Provides a resolution for an issue where you can add out-of-stock items to your cart and proceed to check out in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/01/2023
ms.custom: sap:Order management\Issues with cart and checkout in e-commerce storefront
---
# Items without inventory can be checked out

This article provides a resolution for an issue where you can add out-of-stock items to your cart and proceed to check out without stock-related errors in Microsoft Dynamics 365 Commerce.

## Symptoms

You can add an item to your cart, even though there's no on-hand inventory in the store, and then proceed to the checkout page.

## Resolution

To solve this issue, follow these steps to enable the [Show out of stock errors](/dynamics365/commerce/add-cart-module#cart-module-properties-and-slots) property in Dynamics 365 Commerce site builder:

1. Select the site that you're working on.
1. In the left navigation, select **Pages**.
1. Select **CartPage** to open it.
1. Select the **Cart 1** slot and select **Edit**.
1. In the properties pane, select the **Show Out Of Stock Errors** check box.
1. Save and publish the page.

## More information

- [Apply inventory settings](/dynamics365/commerce/inventory-settings)
- [Calculate inventory availability for retail channels](/dynamics365/commerce/calculated-inventory-retail-channels)
- [Configure inventory buffers and inventory levels](/dynamics365/commerce/inventory-buffers-levels)
