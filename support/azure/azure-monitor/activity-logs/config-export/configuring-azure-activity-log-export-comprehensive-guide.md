---
title: Configuring Azure Activity Log Export
description: Provides guidance on resolving issues related to configuring the export of Azure Activity Logs
ms.date: 08/18/2025
ms.reviewer: v-liuamson; v-gsitser; v-sisidhu
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Configuring Azure Activity Log Export

When configuring Azure Activity Log exports, you might face issues, especially when transitioning from older methods. This guide outlines the steps to ensure a smooth configuration process, addressing common issues and providing actionable solutions.

## Configure Azure Activity Log Export

### Step 1: Verify Current Configuration

1. Go to the [Azure portal](https://ms.portal.azure.com/auth/login/) and access the **Activity Logs** section.
1. Check the current export settings to ensure they align with your requirements.

### Step 2: Update Legacy Methods

1. If you are using legacy APIs or PowerShell commands, update them to the latest versions.
1. Use the command `Get-AzOperationalInsightsDataSource` to verify existing data sources.

### Step 3: Configure New Export Settings

1. Go to **Azure Monitor** and select **Diagnostic settings**.
1. Create a new setting by specifying the **Log Analytics workspace** and **Event Hub** as destinations.

### Step 4: Test the Configuration

1. Make sure to test the configuration by generating sample logs.
1. Check the destination to verify that logs are exported as expected.

### Step 5: Monitor and Adjust

1. Regularly monitor the logs to ensure they are being exported correctly.
1. Adjust the settings as necessary based on the log data and performance.

**Frequently asked questions**

**Q1: Why don't the logs appear in the destination?**

**A1:** Make sure the network is well connected, and verify the permissions for Log Analytics workspace.

**Q1: Why are errors appearing in the PowerShell commands?**

**A1:** Make sure you are using the latest Azure PowerShell module.

## References

- [Azure Monitor Documentation](/azure/azure-monitor/fundamentals/overview)
- [Azure Activity Logs Overview](/azure/azure-monitor/fundamentals/data-sources)
- [Configure Diagnostic Settings](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal)

## Contact us for help

If you have questions or need help, create a [support request](https://ms.portal.azure.com/#view/Microsoft_Azure_Support/HelpAndSupportBlade/~/overview?DMC=troubleshoot), or ask [Azure community support](/answers/tags/133/azure). You can also submit product feedback to [Azure feedback community](https://feedback.azure.com/d365community)
