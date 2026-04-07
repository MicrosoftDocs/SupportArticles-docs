---
title: Resolve role definition fetch problems in Log Analytics
description: Learn how to fix role definition fetch problems in Log Analytics workspaces if subscriptions are missing, and follow these steps to restore access.
ms.author: neghuman
ms.date: 04/01/2026
ms.reviewer: v-ryanberg
ms.editor: v-jsitser
ms.service: azure-monitor
ms.custom: Create and manage Log Analytics workspaces
---

# Resolve role definition fetch problems in Log Analytics

## Summary

When you try to retrieve role definitions from Azure Log Analytics, errors can occur if subscriptions are missing. This article provides solutions to these problems.

### Common problems and causes

- **Problem**: You can't fetch role definitions from Log Analytics, often because of missing subscriptions.
- **Cause**: This problem usually occurs if you don't add the necessary subscription to your Azure account before you run the script.

### Resolve role definition fetch problems

To resolve this problem, follow these steps:

1. Verify the subscription. In the [Azure portal](https://portal.azure.com), go to **Subscriptions**, and verify that the necessary subscription is active.

1. Run an AzureActivity query to retrieve role definitions. Run this query in the Log Analytics workspace to get the data that you need.

> [!NOTE]
> If you're using a custom template, consider consulting a Cloud Solution Architect (CSA) from Microsoft for additional support.

### References

- [Azure Log Analytics documentation](/azure/log-analytics)
- [Azure subscription management](/azure/cost-management-billing/manage/cloud-subscription)
