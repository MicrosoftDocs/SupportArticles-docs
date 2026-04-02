---
title: Resolve role definition fetch problems in Log Analytics
description: Learn how to fix role definition fetch problems in Log Analytics workspaces when subscriptions are missing, and follow these steps to restore access.
ms.author: neghuman
ms.date: 04/01/2026
ms.reviewer: v-ryanberg
ms.editor: v-jsitser
ms.service: azure-monitor
ms.custom: Create and manage Log Analytics workspaces
---

# Resolve role definition fetch problems in Log Analytics

## Summary

When you try to retrieve role definitions from Azure Log Analytics, errors can occur if subscriptions are missing. This article provides solutions to address these problems.

### Common problems and causes

- **Problem**: You can't fetch role definitions from Log Analytics, often due to missing subscriptions.
- **Cause**: This problem usually happens when you don't add the necessary subscription to your Azure account before running the script.

### Resolve role definition fetch problems

1. **Verify subscription**

    1. In the [Azure portal](https://portal.azure.com), go to **Subscriptions** and confirm that the necessary subscription is active.

1. **Run AzureActivity query**

    1. Use the AzureActivity query to retrieve role definitions. Run this query in the Log Analytics workspace to get the data you need.

> [!NOTE]
> If you're using a custom template, consider consulting a Cloud Solution Architect (CSA) from Microsoft for additional support.

### References

- [Azure Log Analytics documentation](/azure/log-analytics)
- [Azure subscription management](/azure/cost-management-billing/manage/cloud-subscription)
