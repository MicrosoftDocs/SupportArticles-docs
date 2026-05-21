---
title: Teams dialer isn't visible in a custom app in Dynamics 365 Sales
description: Provides a resolution for an issue where the Teams dialer isn't visible in a custom app in Microsoft Dynamics 365 Sales.
ms.date: 05/21/2026
ms.reviewer: ramakris
author: t-ronioded
ms.author: ramakris
ms.custom: sap:Teams Dialer
ai-usage: ai-assisted
---
# Microsoft Teams dialer isn't visible in a custom app

This article provides a resolution for an issue where the [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) isn't visible in a custom app in Microsoft Dynamics 365 Sales.

## Symptoms

A seller can't see the Teams dialer in a custom app.

## Cause

The plug-in that should install the custom app doesn't work when sellers don't have the necessary Teams license or a phone number assigned to their accounts.

> [!IMPORTANT]
> Before proceeding, verify that the affected user has a Microsoft Teams license and a phone number assigned to their account. If either is missing, the plug-in that adds the dialer to the custom app won't run.

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

> [!NOTE]
> If the dialer is still not visible after re-adding the custom app, try the [Microsoft Teams dialer basic troubleshooting steps](dialer-basic-troubleshooting.md).

## See also

- [Teams dialer isn't visible in Dynamics 365 Sales](dialer-not-visible-in-sales.md)
- [Microsoft Teams dialer basic troubleshooting](dialer-basic-troubleshooting.md)
