---
title: Resolve Issues Configuring Long-Term Storage for Azure Activity Logs
description: This article addresses the issue of configuring long-term storage for Azure Activity Logs, which by default are retained for 90 days. Users may need to store logs for a longer period for compliance or analysis purposes.
ms.date: 07/23/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Resolve Issues Configuring Long-Term Storage for Azure Activity Logs

This article addresses the issue of configuring long-term storage for Azure Activity Logs, which by default are retained for 90 days. Users may need to store logs for a longer period for compliance or analysis purposes.

## Introduction

Azure Activity Logs are retained for 90 days by default. This guide provides steps to configure long-term storage for these logs, ensuring they are available for extended analysis or compliance needs.

### Step-by-Step Instructions to Configure Long-Term Storage

#### Create a Diagnostic Setting

1. Navigate to the [Azure portal](https://ms.portal.azure.com/auth/login/) and select **Monitor**.
1. Under **Settings**, choose **Diagnostic settings**.
1. Select **Add diagnostic setting**.
1. Select the **Activity Log** you wish to configure.

#### Specify the Destination

1. Choose the destinations for your logs from **Log Analytic**, **Event Hubs**, **Azure Storage.**
1. Ensure the destination resource is configured to retain logs for more than 90 days.

#### Configure Retention Settings

1. If using Azure Storage, navigate to the **Storage Account**.
1. Under **Data Management**, select **Lifecycle Management**.
1. Set the retention period to your desired duration.

#### Verify Configuration

1. Return to the **Diagnostic settings** and ensure your settings are saved.
1. Check the destination resource to confirm logs are being stored as expected.

### Frequenctly Asked Questions

**Why aren’t the logs appearing in the destination?**

Ensure the diagnostic setting is correctly configured and the destination resource is active.

**Why is the retention period not applied?d**

Verify that the retention settings in the destination resource are correctly set.

## Reference

- [Azure Monitor Documentation](/azure/azure-monitor/platform/activity-log?tabs=powershell)
- [Azure Storage Lifecycle Management](/azure/storage/blobs/storage-lifecycle-management-concepts)

If the issue persists after following the solution steps, please open a support case for further assistance.
