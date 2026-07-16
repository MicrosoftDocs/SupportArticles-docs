---
title: Troubleshoot forwarding Azure activity logs to diagnostic settings
description: Learn why Azure activity logs stop forwarding and scripts fail after moving to diagnostic settings. Use this article to fix the problem.
ms.date: 03/31/2026
ms.author: kaushika
ms.editor: v-gsitser
ms.reviewer: v-ryanberg 
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
---

# Troubleshoot forwarding Azure activity logs to diagnostic settings

## Summary

This article addresses the transition from legacy solutions to diagnostic settings in order to forward Azure activity logs. You might encounter problems when you configure these settings, especially if automation relies on outdated APIs. This guide provides steps to identify and resolve these problems.

### Common problems and solutions

- **Problem**: Logs don't forward after configuration.
- **Solution**: Double-check the diagnostic settings, and make sure that all parameters are correct.

- **Problem 2**: Automation scripts fail after the transition.
- **Solution 2**: Update scripts to align with the new diagnostic settings API.

### Resolve configuration problems

To resolve configuration problems, follow these steps.

1. **Identify legacy API usage**
    
    1. Run the `Get-AzLogProfile` command.
    1. Check for any existing log profiles in your Azure subscriptions. If you find a log profile that's named **default** that isn't enabled, the profile isn't in use.

1. **Update automation scripts**

   1. Review any automation scripts or tools that interact with Azure activity logs.
   1. Make sure that the scripts or tools are updated to use the new diagnostic settings instead of legacy APIs.

1. **Configure diagnostic settings**
   
   1. In the [Azure portal](https://portal.azure.com), go to **Activity Logs**.
   1. Select **Diagnostic settings**, and configure the necessary parameters to forward logs as required.

1. **Verify configuration**

   1. After you update the settings, monitor the logs to make sure that they're forwarded correctly.
   1. Use Azure Monitor charts to visualize log data and verify successful configuration.

### References

- [Azure Monitor Documentation](/azure/azure-monitor/)
- [Azure Activity Logs Overview](/azure/azure-monitor/platform/activity-logs-overview)
- [Configure Diagnostic Settings](/azure/azure-monitor/platform/diagnostic-settings)
