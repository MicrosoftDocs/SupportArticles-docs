---
title: Sellers can't hear customers in a call in Dynamics 365 Sales
description: Provides a resolution for an issue where a seller can't hear customers in a call in Microsoft Dynamics 365 Sales.
ms.date: 08/22/2023
ms.reviewer: asaftzuk, ilanak
author: t-ronioded
ms.author: ronihemed
---
# A seller can't hear customers in a call

This article provides a resolution for an issue where a seller can't hear customers in a call in Microsoft Dynamics 365 Sales.

## Symptoms

When a customer and a seller talk in a call in Dynamics 365 Sales, the seller can't hear the customer.

## Cause 1: An incorrect device is selected

The issue occurs because the seller doesn't select the correct speaker device in the dialer's device settings.

#### Resolution

To resolve the issue, ensure the correct speaker device is selected by following these steps:

1. Select the three dots ("...") icon on the dialer menu, and then select **Device Settings**.

   :::image type="content" source="media/cannot-hear-other-customer/dialer-menu.png" alt-text="Screenshot that shows the Device Settings option in the dialer menu.":::

2. Select the appropriate speaker device.

   :::image type="content" source="media/cannot-hear-other-customer/dialer-device-settings.png" alt-text="Screenshot that shows the dialer device settings.":::

## Cause 2: The browser sound permission isn't enabled

The issue occurs because the seller doesn't enable the sound permission for the web browser.

#### Resolution

To enable the sound permission for the browser, open the browser, navigate to the Dynamics 365 Sales page, and select the lock icon in the address bar.

- In Google Chrome, if the **Sound** option is turned off, toggle the option to **On** to enable the sound permission.

  :::image type="content" source="media/cannot-hear-other-customer/chrome-enable-sound.png" alt-text="Screenshot that shows how to enable sound permissions in Google Chrome.":::

- In Microsoft Edge, select the drop-down list of **Sound**, and then select the **Automatic(Default)** option to enable the sound permission.

  :::image type="content" source="media/cannot-hear-other-customer/edge-enable-sound.png" alt-text="Screenshot that shows how to enable sound permissions by selecting Automatic(Default) after you select the Mute in Microsoft Edge.":::

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]
