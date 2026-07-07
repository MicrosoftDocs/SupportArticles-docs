---
title: Troubleshoot activity log export configuration issues
description: Fix Azure activity log export configuration issues by checking permissions and settings. Use this guide to restore log exports and verify success.
ms.date: 09/17/2025
ms.author: jarrettr
ms.reviewer: v-ryanberg; v-gsitser
ms.service: azure-monitor
ms.custom: I can't configure export of activity logs
---

# Troubleshoot activity log export configuration issues

## Summary

This article helps you troubleshoot activity log export configuration issues in Azure. Use it to identify permission and settings problems and restore successful log exports.

When you try to configure the export of activity logs in Microsoft Azure, you might encounter difficulties because of various settings or permissions. This guide provides a concise overview of common problems and their root causes, together with solutions.

## Common issues and solutions

- **Problem**: You receive permission-based error messages.
- **Solution**: Make sure that you have the necessary permissions to configure log exports. Check your role assignments in the Azure portal.

- **Problem**: You receive incorrect configuration settings error messages.
- **Solution**: Verify that all settings are correctly configured according to Azure documentation. Misconfigurations can prevent successful log exports.

### Instructions to resolve export configuration issues

**Verify permissions**

1. Go to the [Azure portal](https://portal.azure.com).
1. Go to **Subscriptions** and select the relevant subscription.
1. Check the **Access control (IAM)** section to verify that you have the required permissions.

**Check configuration settings**

1. Go to the Azure portal.
1. Go to the **Activity Log** section.
1. Review **Export Settings** to verify that the settings match the recommended configurations.
1. Adjust any incorrect settings, and then save your changes.

**Test export functionality**

1. Initiate a test export to verify that logs are exporting correctly.
1. Monitor the **Logs** section to verify a successful export.

## References

- [Azure activity logs documentation](/azure/azure-monitor/platform/activity-logs-overview)
- [Azure Monitor Logs overview](/azure/azure-monitor/logs/data-platform-logs)
- [Azure role-based access control](/azure/role-based-access-control/overview)

