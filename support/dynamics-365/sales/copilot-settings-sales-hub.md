---
title: Fix Copilot settings issues in Dynamics 365 Sales
description: Troubleshoot missing Copilot settings in the Sales Hub navigation and Copilot features that don't work in Microsoft Dynamics 365 Sales.
ms.reviewer: ramakris, josaw, v-shaywood
ms.date: 05/21/2026
ms.custom: sap:Copilot in Dynamics 365 Sales\Turn Copilot features on or off in Sales Hub
ms.collection: CEnSKM-ai-copilot
ai-usage: ai-assisted
---

# Troubleshoot Copilot feature settings in Dynamics 365 Sales

## Summary

This article helps administrators resolve issues where they can't turn Copilot features on or off, or where Copilot settings aren't visible in Microsoft Dynamics 365 Sales. It covers publishing the Copilot in Dynamics 365 Sales agent from Microsoft Copilot Studio and adding the Copilot settings navigation link to the Sales Hub app so that Copilot in Dynamics 365 Sales works as expected.

## Symptoms

As an administrator, you might run into these symptoms when you configure Copilot in Dynamics 365 Sales:

- Copilot doesn't work after you turn on Copilot features in the Sales Hub app settings.
- The Copilot settings option is missing from the Sales Hub app navigation.

If you see either symptom, work through the following steps in order.

## Publish the Copilot in Dynamics 365 Sales agent from Copilot Studio

[Copilot in Dynamics 365 Sales](/dynamics365/sales/copilot-overview) relies on the Copilot in Dynamics 365 Sales agent. If the agent isn't published or is in a stale state, Copilot might not work correctly even when the settings are turned on.

Republish the agent to refresh its state:

1. Sign in to [Copilot Studio](https://copilotstudio.microsoft.com/).
1. Select your Dynamics 365 environment and then select **Agents**.
1. Select **Copilot in Dynamics 365 Sales**.
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
