---
title: Detailed Guide on Pushing Subscription Activity Logs to Sentinel
description: Provides detailed instructions on how to push subscription activity logs to Sentinel.
ms.date: 07/10/2025
ms.reviewer: v-liuamson
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---
# Detailed Guide on Pushing Subscription Activity Logs to Sentinel

This article provides guidance on how to push subscription activity logs to Sentinel using Azure's Diagnostic Settings. This process is essential for monitoring and analyzing activity logs effectively.

## Introduction

Users may encounter challenges when attempting to push subscription activity logs to Sentinel. This guide outlines the steps to configure Azure Diagnostic Settings to achieve seamless data transfer to Sentinel.

### Step-by-Step Instructions to configure Azure Diagnostic Settings

1. **Access Azure Portal**: Log in to your Azure account and navigate to the **Azure Portal**.

2. **Navigate to Diagnostic Settings**:
   - Go to the **Azure Monitor** section.
   - Select **Diagnostic Settings** from the menu.

3. **Configure Diagnostic Settings**:
   - Choose the resource for which you want to configure the logs.
   - Click on **Add Diagnostic Setting**.
   - Name your setting and select the logs you wish to send to Sentinel.

4. **Select Log Analytics Workspace**:
   - Under the **Destination details**, choose **Send to Log Analytics**.
   - Select the appropriate Log Analytics workspace where you want the logs to be sent.

5. **Save Configuration**:
   - Review your settings and click **Save** to apply the changes.

6. **Verify Data Transfer**:
   - Use the following query in your Log Analytics workspace to verify data transfer:

        ```plaintext
         AzureActivity | where SubscriptionId contains "<YourSubscriptionId>"
        ```

### Common Issues and Solutions

- **Issue**: Logs are not appearing in Sentinel.
    - **Solution**: Ensure that the correct Log Analytics workspace is selected and that the Diagnostic Settings are properly configured.

## Reference

- [Azure Sentinel Data Connectors Reference](https://learn.microsoft.com/azure/sentinel/data-connectors-reference)
- [Azure Monitor Diagnostic Settings](https://learn.microsoft.com/azure/azure-monitor/platform/diagnostic-settings?tabs=CMD)
- [Connect Services via Diagnostic Setting-Based Connector](https://learn.microsoft.com/azure/sentinel/connect-services-diagnostic-setting-based#connect-via-a-diagnostic-setting-based-connector-managed-by-azure-policy)

If the issue persists after following the solution steps, please open a support case for further assistance.
