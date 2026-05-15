---
title: Troubleshoot Copilot feature settings in Dynamics 365 Sales Hub
description: Resolves issues where Copilot settings aren't visible or Copilot isn't functioning in the Microsoft Dynamics 365 Sales Hub app.
ms.reviewer: ramakris
ms.date: 05/15/2026
ms.custom: sap:Copilot\Copilot settings
ms.collection: CEnSKM-ai-copilot
author: ramakris
ms.author: ramakris
ai-usage: ai-assisted
---

# Troubleshoot Copilot feature settings in Dynamics 365 Sales Hub

This article helps resolve issues where Copilot features can't be turned on or off, or Copilot settings aren't visible in the Microsoft Dynamics 365 Sales Hub app.

## Symptoms

As an administrator, you might encounter the following symptoms when you try to configure Copilot in Dynamics 365 Sales Hub:

- Copilot isn't functioning after you turn on Copilot features in the Sales Hub app settings.
- You can't find the Copilot settings option in the Sales Hub app navigation.

## Cause 1: Copilot bot isn't published

Copilot in Dynamics 365 Sales relies on the Sales Copilot Power Virtual Agents bot. If this bot isn't published or is in a stale state, Copilot might not function correctly even when the settings appear to be turned on.

### Solution 1: Publish the Sales Copilot bot from Copilot Studio

1. Go to [Copilot Studio](https://copilotstudio.microsoft.com/).
2. Find and open the **Sales Copilot Power Virtual Agents Bot**.
3. Select **Publish** to publish the bot.
4. Wait a few minutes for the changes to propagate.
5. Return to the Sales Hub app and verify that Copilot is functioning.

## Cause 2: Missing Copilot settings navigation link

The Copilot settings page might not appear in the Sales Hub app if the navigation link wasn't added to the app configuration.

### Solution 2: Add the Copilot settings navigation link

1. Open the Sales Hub app in the [Power Apps app designer](https://make.powerapps.com/).
2. In the app designer, select **Change area** and choose **App Settings**.

   :::image type="content" source="media/copilot-settings-sales-hub/copilot-app-settings-navigation.png" alt-text="Screenshot showing how to navigate to App Settings in the Sales Hub app designer.":::
3. Add the following navigation link to the app:

   `/main.aspx?pagetype=control&controlName=msdyn_Sales.Controls.CopilotSettingsControl`

4. Save and publish the app.
5. Refresh the Sales Hub app and navigate to **App Settings** > **General Settings** > **Copilot** to verify that the settings page is visible.

   :::image type="content" source="media/copilot-settings-sales-hub/copilot-settings-page.png" alt-text="Screenshot of the Copilot settings page in Sales Hub App Settings.":::

## More information

- [Turn on and set up Copilot in Dynamics 365 Sales](/dynamics365/sales/enable-setup-copilot)
- [Control access to Copilot in Dynamics 365 Sales](/dynamics365/sales/copilot-control-access)
