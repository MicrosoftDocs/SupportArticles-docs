---
title: Resolve Log Limit Issues in Azure Functions Apps
description: Provides instructions to resolve log limit issues in Azure Functions apps.
ms.date: 07/28/2025
ms.reviewer: v-liuamson; v-gsitser; v-sisidhu
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
---

# Resolve log limit issues in Azure Functions apps

This article discusses an issue that occurs if an Azure Functions app reaches its daily log limit. This condition prevents additional logs from being sent, and it affects the application's performance and monitoring capabilities. The issue might occur if the log volume exceeds the configured quota.

## Common issues and solutions

- **Unexpected log volume**: If log volumes are unexpectedly high, investigate any recent changes in the application or any external factors that might contribute to the increase.
- **Quota adjustment**: Make sure that any quota adjustments are aligned with the application's monitoring needs and budget constraints.

### Instructions to resolve log limit issues

To resolve log limit issues in Azure Functions apps, follow these steps:

1. Navigate to the Azure portal, and locate the specific Functions app that's experiencing log issues.

2. Access the **Application Insights** that's associated with the Functions app. Review the current log quota settings to determine whether they're being exceeded.

3. Analyze the logs to assess whether the increase in log volume is justified. Use Azure Monitor charts to visualize log trends and identify any anomalies.

4. If the log volume increase is reasonable, adjust the log quota in Application Insights. Go to the **Settings** section, select **Usage and estimated costs**, and then modify the quota as appropriate.

5. If the log increase is unexpected, reach out to the Functions app owner for further troubleshooting. Make sure that the app owner is aware of the log limits and potential effects.

6. Verify that the Log Analytics workspace that's associated with the Application Insights doesn't have its own quota limitations that could affect logging.

7. After you adjust the quotas, monitor the workspace for any potential bottlenecks that might occur because of increased log volumes.

## References

- [Azure Monitor documentation](/azure/azure-monitor/)
- [Application Insights quota management](/azure/azure-monitor/app/pricing)
- [Log Analytics workspace management](/azure/azure-monitor/logs/manage-cost-storage)

[!INCLUDE [azure-help-support](../../../../includes/azure-help-support.md)]
