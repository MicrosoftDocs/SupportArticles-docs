---
title: Understanding and Mitigating High Data Consumption in Log Analytics
description: Provides instructions to resolve high data usage in Log Analytics.
ms.date: 07/23/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Understand and mitigate high data consumption in Log Analytics

This article discusses high data consumption that occurs in Log Analytics workspaces, and focuses on tables such as `AzureDiagnostics`. This article also provides insights into the costs that are associated with data usage, and offers steps to optimize and reduce these costs.

## Common issues and solutions

- **Data retention**: Make sure that data retention settings are configured appropriately to avoid unnecessary storage costs.
- **Data filtering**: Implement data filtering to collect only necessary data and reduce the volume of data ingested.

### Instructions to resolve high data usage

1. Identify high data tables:

   1. Use the `AzureDiagnostics` table to determine which listed references are sending large amounts of data.
   1. To identify the reference that's contributing to high data usage, run the following query in your Log Analytics workspace:

        ```plaintext
        AzureDiagnostics | distinct _ResourceId
        ```
2. Review the diagnostic settings:

   1. Navigate to the diagnostic settings of the identified reference.
   1. Remove unnecessary diagnostic settings if the data isn't required. This step stops the data from being sent to the AzureDiagnostics table.

3. Review the articles in the ["References" section](#reference) to understand the costs that are associated with your Log Analytics workspace.

4. To optimize data usage and reduce costs, follow the best practices that are outlined in the "References" section.

## References

- [Understand Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/)
- [Best Practices for Cost Management](/azure/azure-monitor/fundamentals/best-practices-cost)
- [Cost Management for Logs](/azure/azure-monitor/logs/cost-logs)

If the issue persists after you follow the solution steps, open a support case for further assistance.
