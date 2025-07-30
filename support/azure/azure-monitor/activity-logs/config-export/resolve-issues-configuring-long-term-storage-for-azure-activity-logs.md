---
title: Resolve Issues Configuring Long-Term Storage for Azure Activity Logs
description: Discusses how to configure long-term storage for Azure Activity Logs past the default 90 days. 
ms.date: 07/23/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Configure long-term storage for Azure Activity Logs

This article discusses how to configure long-term storage for Azure Activity Logs. By default, Activity Logs are retained for 90 days. Users might have to store logs for a longer time for compliance or extended analysis.

## Configure long-term storage

### Step 1: Create a diagnostic setting

1. Go to the [Azure portal](https://ms.portal.azure.com/auth/login/) > **Monitor**.
1. Under **Settings**, select **Diagnostic settings**.
1. Select **Add diagnostic setting**.
1. Under **Activity Log**, select the log that you want to configure.

### Step 2: Specify the destination

1. Got to **Log Analytic** > **Event Hubs** > **Azure Storage**, and select the destinations for your logs. 
1. Set the destination resource to retain logs for more than 90 days.

### Step 3: Configure the retention settings

1. If you use Azure Storage, navigate to the **Storage Account**.
1. Under **Data Management**, select **Lifecycle Management**.
1. Set the retention period to your desired duration.

### Step 4: Verify the configuration

1. Return to **Diagnostic settings**, and make sure that your settings are saved.
1. Check the destination resource to verify that logs are stored as expected.

### Frequenctly asked questions

**Q1: Why don't the logs appear in the destination?**

**A1:** Make sure that the diagnostic setting is correctly configured and the destination resource is active.

**Q2: Why is the retention period not applied?**

**A2** Verify that the retention settings in the destination resource are set correctly.

## References

- [Azure Monitor Documentation](/azure/azure-monitor/platform/activity-log?tabs=powershell)
- [Azure Storage Lifecycle Management](/azure/storage/blobs/storage-lifecycle-management-concepts)

If the issue persists after you follow these steps, open a support case for further assistance.
