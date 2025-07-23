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

1. **Create a Diagnostic Setting**:
   - Navigate to the Azure portal and select **Monitor**.
   - Under **Settings**, choose **Diagnostic settings**.
   - Click on **Add diagnostic setting**.
   - Select the **Activity Log** you wish to configure.

2. **Specify the Destination**:
   - Choose the destination for your logs. Options include **Log Analytics**, **Event Hubs**, or **Azure Storage**.
   - Ensure the destination resource is configured to retain logs for more than 90 days.

3. **Configure Retention Settings**:
   - If using Azure Storage, navigate to the **Storage Account**.
   - Under **Data Management**, select **Lifecycle Management**.
   - Set the retention period to your desired duration.

4. **Verify Configuration**:
   - Return to the **Diagnostic settings** and ensure your settings are saved.
   - Check the destination resource to confirm logs are being stored as expected.

### Common Issues and Solutions

- **Logs Not Appearing in Destination**: Ensure the diagnostic setting is correctly configured and the destination resource is active.
- **Retention Period Not Applied**: Verify that the retention settings in the destination resource are correctly set.

## Reference

- [Azure Monitor Documentation](/azure/azure-monitor/platform/activity-log?tabs=powershell)
- [Azure Storage Lifecycle Management](/azure/storage/blobs/storage-lifecycle-management-concepts)

If the issue persists after following the solution steps, please open a support case for further assistance.
