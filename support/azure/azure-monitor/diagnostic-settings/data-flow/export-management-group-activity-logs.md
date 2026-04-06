---
title: Export management group activity logs to Event Hub
description: Export management group activity logs to Event Hub for processing and integration. Learn how to configure diagnostic settings across multiple subscriptions.
ms.author: neghuman
ms.date: 04/01/2026
ms.reviewer: v-ryanberg
ms.editor: v-jsitser
ms.service: azure-monitor
ms.custom: Send, Receive, or Capture events
---
# Export Azure management group activity logs to Event Hub

## Summary

This article explains how to export Microsoft Azure management group activity logs from multiple Azure subscriptions within a management group to an Azure Event Hub. You might encounter challenges when you try to configure log exports for more than one subscription at a time. This guide provides a solution that uses the Azure Management Diagnostic Settings API to streamline the process.

### Common problems and solutions

- **Problem**: Can't export logs from multiple subscriptions.
- **Solution**: Configure the diagnostic setting at the highest-level management group.

- **Problem**: Logs don't appear in Event Hub.
- **Solution**: Verify the API configuration, and check for any errors in the setup process.

### Resolve export issues

> [!NOTE]
> Currently, log export configuration is limited to one subscription at a time within a management group.

**Step 1: Use the Management Diagnostic Settings API**

    Access and use the Management Diagnostic Settings API to create or update settings. This API exports logs from all subscriptions within a management group to a Log Analytics workspace and an event hub. For more information, see [Diagnostic settings in Azure Monitor](/azure/azure-monitor/platform/diagnostic-settings).

**Step 2: Retrieve the management group ID**

    Use the commands that are provided in the Azure Governance documentation to get the management group ID. For more information, see [Manage your Azure subscriptions at scale with management groups](/azure/governance/management-groups/manage).

**Step 3: Configure diagnostic settings**

    Set up the diagnostic settings at the highest-level management group. This setup ensures that you capture and export logs from nested groups. For more information, see [Diagnostic settings in Azure Monitor](/azure/azure-monitor/platform/diagnostic-settings).

**Step 4: Verify export configuration**

    Make sure that the exported events include the `Hierarchy` field. This field shows the originating management group for each log entry.

### References

- [Azure Governance documentation](/azure/governance)
- [Azure management groups overview](/azure/governance/management-groups)
