---
title: Detailed Guidance for Pushing Subscription Activity Logs to Sentinel
description: Provides detailed instructions for pushing subscription activity logs to Sentinel.
ms.date: 07/10/2025
ms.reviewer: v-liuamson
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Push subscription activity logs to Sentinel

This article provides guidance for pushing subscription activity logs to Microsoft Sentinel by using Azure's Diagnostic Settings. This process is essential for monitoring and analyzing activity logs effectively.

Users might encounter challenges when they try to push subscription activity logs to Sentinel. This guide outlines the steps to configure Azure Diagnostic Settings to achieve seamless data transfer to Sentinel.

## Instructions to configure Azure Diagnostic Settings

1. **Access Azure Portal**: Log in to your Azure account, and navigate to the Azure portal.

2. **Navigate to Diagnostic Settings**:
   - Go to the **Azure Monitor** section.
   - On the menu, select **Diagnostic Settings**.

3. **Configure Diagnostic Settings**:
   - Select the resource that you want to configure the logs for.
   - Select **Add Diagnostic Setting**.
   - Name your setting, and select the logs that you want to send to Sentinel.

4. **Select Log Analytics workspace**:
   - Under **Destination details**, select **Send to Log Analytics**.
   - Select the appropriate Log Analytics workspace that you want to send the logs to.

5. **Save configuration**:
   - Review your settings, and select **Save** to apply the changes.

6. **Verify data transfer**:
   - Use the following query in your Log Analytics workspace to verify the data transfer:

        ```plaintext
         AzureActivity | where SubscriptionId contains "<YourSubscriptionId>"
        ```

### Common issues and solutions

- **Issue**: Logs aren't appearing in Sentinel.
    - **Solution**: Make sure that the correct Log Analytics workspace is selected and that the diagnostic settings are correctly configured.

## References

- [Azure Sentinel Data Connectors Reference](https://learn.microsoft.com/azure/sentinel/data-connectors-reference)
- [Azure Monitor Diagnostic Settings](https://learn.microsoft.com/azure/azure-monitor/platform/diagnostic-settings?tabs=CMD)
- [Connect Services via Diagnostic Setting-Based Connector](https://learn.microsoft.com/azure/sentinel/connect-services-diagnostic-setting-based#connect-via-a-diagnostic-setting-based-connector-managed-by-azure-policy)
- [Diagnostic settings in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/platform/diagnostic-settings#time-before-telemetry-gets-to-destination)

If the issue persists after following the solution steps, please open a support case for further assistance.
