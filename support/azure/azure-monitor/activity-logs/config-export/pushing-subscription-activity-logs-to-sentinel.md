---
title: Detailed Guidance for Pushing Subscription Activity Logs to Sentinel
description: Provides detailed instructions for pushing subscription activity logs to Sentinel.
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser; v-sisidhu
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Push subscription activity logs to Sentinel

This article provides guidance for how to push subscription activity logs to Microsoft Sentinel by using Microsoft Azure Diagnostic Settings. This process is essential to  monitor and analyze activity logs effectively.

Users might encounter challenges when they try to push subscription activity logs to Sentinel. This guide outlines the steps to configure Azure Diagnostic Settings to achieve seamless data transfer to Sentinel.

### Common issues and solutions

- **Issue**: Logs aren't appearing in Sentinel.
  - **Solution**: Make sure that the correct Log Analytics workspace is selected and that the diagnostic settings are correctly configured.

### Instructions to configure Azure Diagnostic Settings

1. Navigate to the Azure portal.

2. Open Diagnostic Settings:
   1. Go to the **Azure Monitor** section.
   1. On the menu, select **Diagnostic Settings**.

3. **Configure Diagnostic Settings**:
   1. Select the resource that you want to configure the logs for.
   1. Select **Add Diagnostic Setting**.
   1. Name your setting, and select the logs that you want to send to Sentinel.

4. **Select Log Analytics workspace**:
   1. Under **Destination details**, select **Send to Log Analytics**.
   1. Select the appropriate Log Analytics workspace that you want to send the logs to.

5. Review your settings, and select **Save** to apply the changes.

6. To verify the data transfer, run the following query in your Log Analytics workspace:

        ```plaintext
         AzureActivity | where SubscriptionId contains "<YourSubscriptionId>"
        ```

## References

- [Azure Sentinel data connectors reference](/azure/sentinel/data-connectors-reference)
- [Azure Monitor diagnostic settings](/azure/azure-monitor/platform/diagnostic-settings?tabs=CMD)
- [Connect services through a diagnostic setting-based connector](/azure/sentinel/connect-services-diagnostic-setting-based#connect-via-a-diagnostic-setting-based-connector-managed-by-azure-policy)
- [Diagnostic settings in Azure Monitor](/azure/azure-monitor/platform/diagnostic-settings#time-before-telemetry-gets-to-destination)

If the issue persists after you follow these steps, open a support case for further assistance.
