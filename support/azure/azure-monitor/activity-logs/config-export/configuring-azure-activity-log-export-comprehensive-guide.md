---
title: Configuring Azure Activity Log Export
description: Provides guidance for resolving issues related to configuring the export of Azure activity logs
ms.date: 10/01/2025
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: v-gsitser, v-ryanberg, neghuman, vikamala 
ms.service: azure-monitor
ms.custom: I can’t configure export of activity logs
---

# Configure Azure activity log export

This article outlines the steps to successfully configure Azure activity log export. This article also provides solutions to common issues that you might experience, especially if you're transitioning from older methods.

## Configuring activity log export

To configure Azure activity log export, follow these steps.

### Step 1: Verify current configuration

1. Go to the [Azure portal](https://ms.portal.azure.com/auth/login/), and access the **Activity Logs** section.
1. Check the current export settings to make sure that they align with your requirements.

### Step 2: Update legacy methods

1. If you're using legacy APIs or PowerShell commands, update them to the latest versions.
1. Use the `Get-AzOperationalInsightsDataSource` command to verify existing data sources.

### Step 3: Configure new export settings

1. Select **Activity log** > **Export Activity Logs**.
1. Find and select the subscription, and then select **Add diagnostic setting**.
1. In the **Diagnostic setting name** box, enter a name.
1. Select all applicable categories and then select **Save**.

> [!NOTE]
> It usually takes about 30 minutes for the export to begin. For more information, see [Time before telemetry gets to destination](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal#time-before-telemetry-gets-to-destination).

## Common issues and solutions

- **Issue**: Logs aren't appearing in configured destinations.
- **Solution**: See the following guidance for log analytics, event hubs, and storage accounts.

### For log analytics

1. Navigate to **Log Analytics workspaces**.
1. Select the workspace and then run the following query:

```powershell
AzureActivity
| summarize count() by bin(TimeGenerated,1d)
```

This should determine the number of logs per day that are being ingested into this workspace.

### For event hubs

1. Navigate to **Event Hubs**.
1. Select the event hub and then select **Data Explorer**.
1. Verify the logs are reaching the event hub. 

If the logs aren't reaching the event hub, check for throttling using a metrics blade.

### For storage accounts

1. Navigate to **Storage center | Storage accounts (Blobs)**.
1. Locate and select the **insights-activity-logs** container.

The logs should be visible.

## Frequently asked questions

**Q1: Why don't the logs appear in the destination?**

**A1:** Make sure that the network is well connected, and verify the permissions for Log Analytics workspace.

**Q2: Why do errors appear in the PowerShell commands?**

**A2:** Make sure that you're using the latest Azure PowerShell module.

## References

- [Azure Monitor documentation](/azure/azure-monitor/fundamentals/overview)
- [Azure activity logs overview](/azure/azure-monitor/fundamentals/data-sources)
- [Configure diagnostic settings](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal)

[!INCLUDE [azure-help-support](../../../../includes/azure-help-support.md)]
