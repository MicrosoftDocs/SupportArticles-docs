---
title: Teams Dialer Not Visible in Dynamics 365 Sales Custom App
description: Learn how to fix an issue where the Microsoft Teams dialer doesn't appear in a custom app in Dynamics 365 Sales by reinstalling the dialer plug-in.
ms.date: 05/21/2026
ms.reviewer: ramakris, v-shaywood
ms.custom: sap:Teams Dialer
ai-usage: ai-assisted
---
# Microsoft Teams dialer isn't visible in a custom app

## Summary

This article provides a resolution for an issue where the [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer) isn't visible in a custom app in Microsoft Dynamics 365 Sales.

## Symptoms

A seller can't see the Teams dialer in a custom app.

## Cause

The plug-in that installs the dialer to the custom app doesn't run when the seller doesn't have a Microsoft Teams license or a phone number assigned to their account.

> [!IMPORTANT]
> Before you continue, verify that the affected user has a [Microsoft Teams license](/microsoftteams/user-access) and a phone number assigned to their account. If either is missing, the plug-in that adds the dialer to the custom app doesn't run.

## Solution

To fix this issue, re-add the custom app:

1. Go to the **Microsoft Teams calls** settings page. You can find this page in the [Sales Hub app](/dynamics365/sales/intro-saleshub).
1. In the **Advanced settings** drop-down list, remove the custom app.

   :::image type="content" source="media/dialer-not-available-in-custom-app/dialer-settings-page-advanced-settings.png" alt-text="Screenshot that shows how to remove a custom app from the Advanced settings on the Microsoft Teams calls page.":::

1. Select **Update**, and then refresh the page after it saves.
1. In the **Advanced settings** drop-down list, add the custom app back.
1. Select **Update**.
1. Open the custom app and verify that the dialer appears.

> [!NOTE]
> If the dialer still doesn't appear after you re-add the custom app, try the [Microsoft Teams dialer basic troubleshooting steps](dialer-basic-troubleshooting.md).

## Related content

- [Teams dialer isn't visible in Dynamics 365 Sales](dialer-not-visible-in-sales.md)
- [Microsoft Teams calls with conversation intelligence](/dynamics365/sales/digital-selling-microsoft-teams-calls)
