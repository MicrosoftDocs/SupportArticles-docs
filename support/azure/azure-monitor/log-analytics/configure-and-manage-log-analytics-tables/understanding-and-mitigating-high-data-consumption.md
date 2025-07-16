---
title: Understanding and Mitigating High Data Consumption in Log Analytics
description: Provides step-by-step instructions on how to resolve high data usage in Log Analytics.
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Understanding and Mitigating High Data Consumption in Log Analytics

## Introduction

This article addresses the issue of high data consumption in Log Analytics workspaces, specifically focusing on tables like `AzureDiagnostics`. It provides insights into understanding the costs associated with data usage and offers steps to optimize and reduce these costs.

## Step-by-Step Instructions to Resolve High Data Usage

### 1. Identify High Data Tables

- Use the `AzureDiagnostics` table to determine which Reference are sending large amounts of data.
- Run the following query in your Log Analytics workspace:

    ```plaintext
    AzureDiagnostics | distinct _ResourceId
    ```

- This will help you identify the Reference contributing to high data usage.

### 2. Review Diagnostic Settings

- Navigate to the diagnostic settings of the identified Reference.
- Remove unnecessary diagnostic settings if the data is not needed. This will stop the data from being sent to the AzureDiagnostics table.

### 3. Understand Cost Implications

Review the following Reference to understand the costs associated with your Log Analytics workspace:

- [Understand Log Analytics Workspace Billing](https://learn.microsoft.com/azure/azure-monitor/log-analytics/billing/understand-log-analytics-workspace-bill)
- [Best Practices for Cost Management](https://learn.microsoft.com/azure/azure-monitor/fundamentals/best-practices-cost)
- [Cost Management for Logs](https://learn.microsoft.com/azure/azure-monitor/logs/cost-logs)

### 4. Implement Cost Optimization Strategies

- Follow the best practices outlined in the Reference to optimize data usage and reduce costs.

## Common Issues and Solutions

- **Data Retention**: Ensure that data retention settings are configured appropriately to avoid unnecessary storage costs.
- **Data Filtering**: Implement data filtering to only collect necessary data, reducing the volume of data ingested.

## Reference

- [Understand Log Analytics Workspace Billing](https://learn.microsoft.com/azure/azure-monitor/log-analytics/billing/understand-log-analytics-workspace-bill)
- [Best Practices for Cost Management](https://learn.microsoft.com/azure/azure-monitor/fundamentals/best-practices-cost)
- [Cost Management for Logs](https://learn.microsoft.com/azure/azure-monitor/logs/cost-logs)

If the issue persists after following the solution steps, please open a support case for further assistance.
