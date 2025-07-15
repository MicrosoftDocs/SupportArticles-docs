---
title: Resolving Log Limit Issues in Azure Function Apps
description: Provides step-by-step instructions to resolve log limit issues in Azure Function Apps.
ms.date: 07/10/2025
ms.reviewer: v-liuamson
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---
# Resolving log limit issues in Azure Function Apps

This article discusses the issue of Azure Function Apps reaching their daily log limit. This condition prevents additional logs from being sent and affects the application's performance and monitoring capabilities. The issue might occur if the log volume exceeds the configured quota. 

## Instructions to resolve log limit issues

To resolve log limit issues in Azure Function Apps, follow these steps:

1. **Identify the Function App**: Navigate to the Azure portal, and locate the specific Function App that is experiencing log issues.

2. **Check current log quota**: Access the **Application Insights** that's associated with the Function App. Review the current log quota settings to determine whether they're being exceeded.

3. **Evaluate log volume**: Analyze the logs to assess whether the increase in log volume is justified. Use Azure Monitor charts to visualize log trends and identify any anomalies.

4. **Increase log quota**: If the log volume increase is reasonable, adjust the log quota in Application Insights. Go to the **Settings** section, select **Usage and estimated costs**, and modify the quota as appropriate.

5. **Contact function app owner**: If the log increase is unexpected, reach out to the Function App owner for further troubleshooting. Make sure that they are aware of the log limits and potential effects.

6. **Check Log Analytics workspace**: Verify that the Log Analytics workspace that's associated with the Application Insights doesn't have its own quota limitations that could affect logging.

7. **Monitor for bottlenecks**: After you adjust the quotas, monitor the workspace for any potential bottlenecks that might occur because of increased log volumes.

## Common issues and solutions

- **Unexpected log volume**: If log volumes are unexpectedly high, investigate recent changes in the application or external factors that might contribute to the increase.
- **Quota adjustment**: Make sure that any quota adjustments are aligned with the application's monitoring needs and budget constraints.

## References

- [Azure Monitor Documentation](https://learn.microsoft.com/azure/azure-monitor/)
- [Application Insights Quota Management](https://learn.microsoft.com/azure/azure-monitor/app/pricing)
- [Log Analytics Workspace Management](https://learn.microsoft.com/azure/azure-monitor/logs/manage-cost-storage)

If the issue persists after following the solution steps, please open a support case for further assistance.
