---

title: Items without inventory can be checked out
description: This article provides troubleshooting guidance that can help when customers can add out-of-stock items to their cart and proceed to checkout.
author: Reza-Assadi
ms.author: josaw
ms.topic: troubleshooting
ms.date: 03/11/2021

---

# Items without inventory can be checked out

This article provides troubleshooting guidance that can help when customers can add out-of-stock items to their cart and proceed to checkout.

## Description

Users can add an item to their cart, even though there is no on-hand inventory in the store, and then proceed to the checkout page.

## Resolution

### Enable the Show Out Of Stock Errors property in Commerce site builder

To enable the **Show Out Of Stock Errors** property in Commerce site builder, follow these steps.

1. Select the site that you're working on.
1. In the left navigation, select **Pages**.
1. Select **CartPage** to open it.
1. Select the **Cart 1** slot, select **Edit**, and then, in the properties pane, select the **Show Out Of Stock Errors** check box.
1. Save and publish the page.

## Additional resources

[Apply inventory settings](/dynamics365/commerce/inventory-settings)

[Calculate inventory availability for retail channels](/dynamics365/commerce/calculated-inventory-retail-channels)

[Configure inventory buffers and inventory levels](/dynamics365/commerce/inventory-buffers-levels)
