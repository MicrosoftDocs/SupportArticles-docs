---
title: Customers can't hear a seller in a call in Dynamics 365 Sales
description: Provides a resolution for an issue where customers can't hear a seller in a call in Microsoft Dynamics 365 Sales.
ms.date: 08/18/2023
ms.reviewer: t-ronioded
ms.custom: sap:Teams Dialer
---
# Customers can't hear a seller in a call

This article provides a resolution for an issue where customers can't hear a seller in a call in Microsoft Dynamics 365 Sales.

## Symptoms

When a seller and a customer talk in a call in Dynamics 365 Sales, the customer can't hear the seller.

## Cause 1: An incorrect device is selected

The issue occurs because the seller doesn't select the correct microphone device in the dialer's device settings.

#### Resolution

To resolve the issue, ensure the correct microphone device is selected by following these steps:

1. Select the three dots ("...") icon on the dialer menu, and then select **Device Settings**.

   :::image type="content" source="media/seller-voice-unheard-by-other-customer/dialer-menu.png" alt-text="Screenshot that shows the Device Settings option in the dialer menu.":::

2. Select the appropriate microphone device.

   :::image type="content" source="media/seller-voice-unheard-by-other-customer/dialer-device-settings.png" alt-text="Screenshot that shows the dialer device settings.":::

## Cause 2: Microphone isn't enabled in the web browser

The issue occurs because the web browser can't access your microphone.

#### Resolution

To enable the access to your microphone in the web browser, follow these steps:

1. Open the browser, navigate to the Dynamics 365 Sales page, and select the lock icon in the address bar.

1. Select **Allow** in the pop-up window to enable the access. Depending on the browser you use, the pop-up window may be slightly different, but the process of enabling the access remains the same. The following screenshots show the **Allow** option in Google Chrome and Microsoft Edge.

   - The **Allow** option in Google Chrome:

     :::image type="content" source="media/seller-voice-unheard-by-other-customer/chrome-allow-microphone.png" alt-text="Screenshot that shows the Allow option to enable your microphone in Google Chrome.":::

   - The **Allow** option in Microsoft Edge:

     :::image type="content" source="media/seller-voice-unheard-by-other-customer/edge-allow-microphone.png" alt-text="Screenshot that shows the Allow option to enable your microphone in Microsoft Edge.":::

If you have previously disabled access to your microphone in the web browser, you can also re-enable it by selecting the lock icon in the address bar.

- In Google Chrome, turn on the toggle next to **Microphone**.

   :::image type="content" source="media/seller-voice-unheard-by-other-customer/chrome-enable-microphone.png" alt-text="Screenshot that shows how to re-enable your microphone in Google Chrome.":::

- In Microsoft Edge, select **Block** > **Allow**.

   :::image type="content" source="media/seller-voice-unheard-by-other-customer/edge-enable-microphone.png" alt-text="Screenshot that shows how to re-enable your microphone in Microsoft Edge.":::

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]
