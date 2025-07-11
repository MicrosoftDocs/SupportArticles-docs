---
title: Resolving Log Limit Issues in Azure Function Apps
description: Provides step-by-step instructions to resolve log limit issues in Azure Function Apps.
ms.date: 07/10/2025
ms.reviewer: v-liuamson
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---
# Resolving Log Limit Issues in Azure Function Apps

## Introduction

This article addresses the issue of Azure Function Apps reaching their daily log limit, which prevents further logs from being sent. This can occur when the log volume exceeds the configured quota, impacting the application's performance and monitoring capabilities.

### Step-by-Step Instructions to Resolve Log Limit Issues

1. **Identify the Function App**: Navigate to the Azure portal and locate the specific Function App experiencing log issues.

2. **Check Current Log Quota**: Access the **Application Insights** associated with the Function App. Review the current log quota settings to determine if they are being exceeded.

3. **Evaluate Log Volume**: Analyze the logs to assess whether the increase in log volume is justified. Use **Azure Monitor** charts to visualize log trends and identify any anomalies.

4. **Increase Log Quota**: If the log volume increase is reasonable, adjust the log quota in **Application Insights**. Go to the **Settings** section, select **Usage and estimated costs**, and modify the quota as needed.

5. **Contact Function App Owner**: If the log increase is unexpected, reach out to the Function App owner for further troubleshooting. Ensure they are aware of the log limits and potential impacts.

6. **Check Log Analytics Workspace**: Verify that the **Log Analytics Workspace** associated with the Application Insights does not have its own quota limitations that could affect logging.

7. **Monitor for Bottlenecks**: After adjusting quotas, monitor the workspace for any potential bottlenecks that may arise due to increased log volumes.

### Common Issues and Solutions

- **Unexpected Log Volume**: If logs are unexpectedly high, investigate recent changes in the application or external factors contributing to the increase.
- **Quota Adjustment**: Ensure that any quota adjustments are aligned with the application's monitoring needs and budget constraints.

Reference

- [Azure Monitor Documentation](https://learn.microsoft.com/azure/azure-monitor/)
- [Application Insights Quota Management](https://learn.microsoft.com/azure/azure-monitor/app/pricing)
- [Log Analytics Workspace Management](https://learn.microsoft.com/azure/azure-monitor/logs/manage-cost-storage)

If the issue persists after following the solution steps, please open a support case for further assistance.
