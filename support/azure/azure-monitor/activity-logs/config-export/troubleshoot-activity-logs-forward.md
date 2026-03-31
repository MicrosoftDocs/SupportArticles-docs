---
title: Troubleshoot forwarding Azure activity logs to diagnostic settings
description: Learn why Azure activity logs stop forwarding and scripts fail after moving to diagnostic settings, and follow steps to fix the issue.
ms.date: 03/31/2026
ms.author: jarrettr
ms.editor: v-gsitser
ms.reviewer: v-ryanberg 
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
---

# Troubleshoot forwarding Azure activity logs to diagnostic settings

## Summary

This article addresses the transition from legacy solutions to diagnostic settings for forwarding Azure activity logs. You might encounter problems when configuring these settings, especially if automation relies on outdated APIs. This guide provides steps to identify and resolve these problems.

### Common problems and solutions

- **Problem**: Logs don't forward after configuration.
- **Solution**: Double-check the diagnostic settings and ensure all parameters are correct.

- **Issue**: Automation scripts fail after the transition.
- **Solution**: Update scripts to align with the new diagnostic settings API.

### Resolve configuration issues

1. **Identify legacy API usage**
    
    a. Use the command `Get-AzLogProfile` to check for any existing log profiles in your Azure subscriptions.

    If you find a log profile named **default** but it's not enabled, it means the profile isn't in use.

1. **Update automation scripts**

    a. Review any automation scripts or tools that interact with Azure activity logs.
    b. Ensure they're updated to use the new diagnostic settings instead of legacy APIs.

1. **Configure diagnostic settings**
   
   a. In the [Azure portal](https://portal.azure.com), go to **Activity Logs**.
   b. Select **Diagnostic settings** and configure the necessary parameters to forward logs as required.

1. **Verify configuration**

   a. After updating the settings, monitor the logs to ensure they're being forwarded correctly.
   b. Use Azure Monitor charts to visualize log data and confirm successful configuration.

### References

- [Azure Monitor Documentation](/azure/azure-monitor/)
- [Azure Activity Logs Overview](/azure/azure-monitor/platform/activity-logs-overview)
- [Configure Diagnostic Settings](/azure/azure-monitor/platform/diagnostic-settings)
