---
title: Resolve Issues in Configuring Long-Term Storage for Azure Activity Logs
description: Discusses how to configure long-term storage for Azure Activity Logs past the default 90 days. 
ms.date: 01/14/2026
ms.author: jarrettr
ms.editor: v-gsitser
ms.reviewer: v-ryanberg 
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Configure long-term storage for Azure Activity Logs

This article discusses how to configure long-term storage for Azure Activity Logs. By default, Activity Logs are retained for 90 days. Users might have to store logs for a longer time for compliance or extended analysis.

## Configure long-term storage

### Step 1: Create a diagnostic setting

1.  Go to [Azure portal](https://ms.portal.azure.com/auth/login/) > **Monitor**.

2.  Under **Settings**, select **Diagnostic settings**.

3.  Select **Add diagnostic setting**.

4.  In **Activity Log**, select the log that you want to configure.

### Step 2: Specify the destination

1.  Go to **Log Analytic** > **Event Hubs** > **Azure Storage**, and then select the destinations for your logs.

2.  Set the destination resource to retain logs for more than 90 days.

### Step 3: Configure the retention settings

1.  If you use Azure Storage, navigate to **Storage Account**.

2.  Under **Data Management**, select **Lifecycle Management**.

3.  Set the retention period to your desired duration.

### Step 4: Verify the configuration

1.  Return to **Diagnostic settings**, and make sure that your settings are saved.

2.  Check the destination resource to verify that logs are stored as expected.

## Frequently asked questions

**Q1: Why don't the logs appear in the destination?**

**A1:** Make sure that the diagnostic setting is correctly configured and the destination resource is active.

**Q2: Why is the retention period not applied?**

**A2:** Verify that the retention settings in the destination resource are set correctly.

## References

- [Azure Monitor Documentation](/azure/azure-monitor/platform/activity-log?tabs=powershell)

- [Azure Storage Lifecycle Management](/azure/storage/blobs/storage-lifecycle-management-concepts)
