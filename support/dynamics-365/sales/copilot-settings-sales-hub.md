---
title: Fix Copilot settings issues in Dynamics 365 Sales Hub
description: Resolves issues where Copilot settings aren't visible in Sales Hub navigation or the Sales Copilot bot isn't functioning. Covers publishing the bot in Copilot Studio and adding the Copilot settings navigation link.
ms.reviewer: ramakris, josaw, v-shaywood
ms.date: 05/21/2026
ms.custom: sap:Copilot in Dynamics 365 Sales\Turn Copilot features on or off in Sales Hub
ms.collection: CEnSKM-ai-copilot
ai-usage: ai-assisted
---

# Troubleshoot Copilot feature settings in Dynamics 365 Sales Hub

## Summary

This article helps administrators resolve issues where they can't turn Copilot features on or off, or where Copilot settings aren't visible in the Microsoft Dynamics 365 Sales Hub app. It covers publishing the Sales Copilot bot from Copilot Studio and adding the Copilot settings navigation link to the Sales Hub app so that Copilot for Sales works as expected.

## Symptoms

As an administrator, you might run into these symptoms when you configure Copilot in Dynamics 365 Sales Hub:

- Copilot doesn't work after you turn on Copilot features in the Sales Hub app settings.
- The Copilot settings option is missing from the Sales Hub app navigation.

If you see either symptom, work through the following steps in order.

## Publish the Sales Copilot bot from Copilot Studio

[Copilot in Dynamics 365 Sales](/dynamics365/sales/copilot-overview) relies on the Sales Copilot Power Virtual Agents bot. If the bot isn't published or is in a stale state, Copilot might not work correctly even when the settings are turned on.

Republish the bot to refresh its state:

1. Go to [Copilot Studio](https://copilotstudio.microsoft.com/).
1. Find and open the **Sales Copilot Power Virtual Agents Bot**.
1. Select **Publish**.
1. Wait a few minutes for the changes to propagate.
1. Return to the Sales Hub app and check that Copilot works.

## Add the Copilot settings navigation link to the Sales Hub app

The Copilot settings page doesn't appear in the Sales Hub app if the navigation link is missing from the app configuration. Add the link in the app designer to make the settings page visible.

1. Open the Sales Hub app in the [Power Apps app designer](https://make.powerapps.com/).
1. Select **Change area**, and then select **App Settings**.
1. Add the following navigation link to the app:

    `/main.aspx?pagetype=control&controlName=msdyn_Sales.Controls.CopilotSettingsControl`

1. Save and publish the app.
1. Refresh the Sales Hub app and go to **App Settings** > **General Settings** > **Copilot** to check that the settings page is visible.

## Related content

- [Ask Copilot questions in Dynamics 365 Sales](/dynamics365/sales/use-sales-copilot)
- [Control access to Copilot in Dynamics 365 Sales](/dynamics365/sales/copilot-control-access)
- [Turn on and set up Copilot in Dynamics 365 Sales](/dynamics365/sales/enable-setup-copilot)
