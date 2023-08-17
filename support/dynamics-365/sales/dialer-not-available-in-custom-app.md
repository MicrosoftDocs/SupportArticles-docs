---
title: Teams dialer isn't visible in a custom app in Dynamics 365 Sales
description: Provides a resolution for an issue where a Teams dialer isn't visible in a custom app in Microsoft Dynamics 365 Sales.
ms.date: 08/14/2023
ms.reviewer: t-ronioded
---
# A Teams dialer isn't visible in a custom app

This article provides a resolution for an issue where a Microsoft Teams dialer isn't visible in a custom app in Dynamics 365 Sales.

## Symptoms

A seller can't see a Teams dialer in a custom app.

## Cause

The plug-in that should install the custom app doesn't work when the sellers don't have the necessary Teams license or a phone number assigned to their accounts.

## Resolution

To resolve this issue, you should readd the custom app:

1. Go to the **Microsoft Teams calls** setting page. The settings page is only available in the [Sales Hub app](/dynamics365/sales/intro-saleshub).
2. Remove the custom app from the **Advanced settings** drop-down list.

   :::image type="content" source="media/dialer-not-available-in-custom-app/dialer-settings-page-advanced-settings.png" alt-text="Screenshot that shows how to remove a custom app from the Advanced settings on the Microsoft Teams calls page.":::

3. Select **Update**.
4. After the page is saved, refresh the page.
5. Add the custom app to the **Advanced settings** drop-down list.
6. Select **Update**.
7. Go to the custom app and check if the dialer is shown.
