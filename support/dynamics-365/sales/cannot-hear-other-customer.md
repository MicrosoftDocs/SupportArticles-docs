---
title: Seller can't hear customers in a call in Dynamics 365 Sales
description: Provides a resolution for an issue where a seller can't hear customers in a call in Microsoft Dynamics 365 Sales.
ms.date: 08/14/2023
ms.reviewer: t-ronioded
---
# A seller can't hear customers in a call

This article provides a resolution for an issue where a seller can't hear customers in a call in Microsoft Dynamics 365 Sales.

## Symptoms

When a customer is speaking in a call in Dynamics 365 Sales, the seller can't hear the customer.

### Cause 1: An incorrect device is selected

The issue occurs because the seller doesn't select the correct speaker device in the dialer's device settings.

#### Resolution

To resolve the issue, ensure the correct speaker device is selected by following these steps:

1. Select the three dots ("...") on the dialer menu, and then select **Device Settings**.

   :::image type="content" source="media/cannot-hear-other-customer/dialer-menu.png" alt-text="Screenshot that shows the Device Settings option in the dialer menu.":::

2. Select the appropriate speaker device.

   :::image type="content" source="media/cannot-hear-other-customer/dialer-device-settings.png" alt-text="Screenshot that shows the dialer device settings.":::

### Cause 2: Sound isn't enabled in the web browser

The issue occurs because the seller doesn't enable the sound permissions for the web browser.

#### Resolution

To enable the sound permissions for the web browser, open the web browser and select the lock icon in the address bar.

- In Google Chrome, if the **Sound** option is turned off, toggle the option to **On** to enable the sound permissions.

  :::image type="content" source="media/cannot-hear-other-customer/chrome-enable-sound.png" alt-text="Screenshot that shows how to enable sound permissions in Google Chrome.":::

- In Microsoft Edge, select **Mute** and then select **Automatic(Default)** to enable the sound permissions.

  :::image type="content" source="media/cannot-hear-other-customer/edge-enable-sound-1.png" alt-text="Screenshot that shows how to enable sound permissions by selecting Mute in Microsoft Edge.":::

  :::image type="content" source="media/cannot-hear-other-customer/edge-enable-sound-2.png" alt-text="Screenshot that shows how to enable sound permissions by selecting Automatic(Default) after you select the Mute in Microsoft Edge.":::
