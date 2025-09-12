---
title: Teams dialer isn't visible in a custom app in Dynamics 365 Sales
description: Provides a resolution for an issue where the Teams dialer isn't visible in a custom app in Microsoft Dynamics 365 Sales.
ms.date: 08/22/2023
ms.reviewer: asaftzuk, ilanak
author: t-ronioded
ms.author: ronihemed
ms.custom: sap:Teams Dialer
---
# Microsoft Teams dialer isn't visible in a custom app

This article provides a resolution for an issue where the [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) isn't visible in a custom app in Microsoft Dynamics 365 Sales.

## Symptoms

A seller can't see the Teams dialer in a custom app.

## Cause

The plug-in that should install the custom app doesn't work when sellers don't have the necessary Teams license or a phone number assigned to their accounts.

## Resolution

To resolve this issue, re-add the custom app:

1. Go to the **Microsoft Teams calls** setting page. This page is only available in the [Sales Hub app](/dynamics365/sales/intro-saleshub).
2. Remove the custom app from the **Advanced settings** drop-down list.

   :::image type="content" source="media/dialer-not-available-in-custom-app/dialer-settings-page-advanced-settings.png" alt-text="Screenshot that shows how to remove a custom app from the Advanced settings on the Microsoft Teams calls page.":::

3. Select **Update**.
4. After the page is saved, refresh the page.
5. Add the custom app to the **Advanced settings** drop-down list.
6. Select **Update**.
7. Go to the custom app and check if the dialer is shown.
