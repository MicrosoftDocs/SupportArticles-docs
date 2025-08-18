---
title: Configuring Azure Activity Log Export
description: Provides guidance for resolving issues related to configuring the export of Azure Activity logs
ms.date: 08/18/2025
ms.reviewer: v-liuamson; v-gsitser; v-sisidhu
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

1. Go to **Azure Monitor**, and select **Diagnostic settings**.
1. Create a setting by specifying the **Log Analytics workspace** and **Event Hub** as destinations.

### Step 4: Test the new configuration

1. Make sure to test the configuration by generating sample logs.
1. Check the destination to verify that logs are exported as expected.

### Step 5: Monitor and adjust

1. Regularly monitor the logs to make sure that they're exported correctly.
1. Adjust the settings as necessary, based on the log data and performance.

## Frequently asked questions

**Q1: Why don't the logs appear in the destination?**

**A1:** Make sure that the network is well connected, and verify the permissions for Log Analytics workspace.

**Q2: Why do errors appear in the PowerShell commands?**

**A2:** Make sure that you're using the latest Azure PowerShell module.

## References

- [Azure Monitor documentation](/azure/azure-monitor/fundamentals/overview)
- [Azure activity logs overview](/azure/azure-monitor/fundamentals/data-sources)
- [Configure diagnostic settings](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal)

## Contact us for help

If you have questions or need help, create a [support request](https://ms.portal.azure.com/#view/Microsoft_Azure_Support/HelpAndSupportBlade/~/overview?DMC=troubleshoot), or ask [Azure community support](/answers/tags/133/azure). You can also submit product feedback to [Azure feedback community](https://feedback.azure.com/d365community)
