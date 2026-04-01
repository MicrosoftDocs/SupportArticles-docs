---
title: Troubleshoot data export and pricing problems in Azure Event Hubs
description: Learn how to troubleshoot problems related to data export and pricing in Azure Event Hubs, including common causes and solutions.
ms.author: neghuman
ms.date: 04/01/2026
ms.reviewer: v-ryanberg
ms.editor: v-jsitser
ms.service: azure-monitor
ms.custom: Send, Receive, or Capture events
---

# Troubleshoot data export and pricing problems in Azure Event Hubs

## Summary

This article addresses common questions about exporting data to Azure Event Hubs and the associated pricing. It provides insights into data export processes, potential charges, and how to manage data efficiently.

### Common concerns

- **Data export process**: When you export data to Azure Event Hubs, the data generates ingress events. These events are units of data, each 64 KB or less, and are billable. Larger messages are billed in multiples of 64 KB.
- **Pricing structure**: Azure Event Hubs offers four SKUs: Basic, Standard, Premium, and Dedicated. Each SKU has different pricing based on data volume and performance needs. For instance, the Basic and Standard tiers charge $0.028 per million ingress events.
- **Data charges**: When the system wipes data after a short duration, charges can still apply for the hour. You pay throughput units hourly based on the maximum number of units selected during that hour.

### Troubleshoot data export problems

1. **Select the appropriate SKU**

    1. In the [Azure portal](https://portal.azure.com), go to **Event Hubs** and select your namespace. 
    1. Choose the SKU that matches your data volume and performance requirements.

1. **Configure diagnostic settings**

    1. Go to **Azure Monitor** in the portal.
    1. Set up a diagnostic setting at the subscription or resource group level.
    1. Select the **Administrative** category to filter logs.

1. **Manage throughput units**

    1. In the Event Hubs namespace, adjust the throughput units based on your needs.
    1. Monitor usage to ensure optimal performance and cost-efficiency.

1. **Review pricing details**
   - See [Azure Event Hubs Pricing](https://learn.microsoft.com/azure/event-hubs/event-hubs-pricing) for detailed information on costs and billing.

### FAQ: Data export and pricing

**Q1: How are ingress events billed?**
**A1**: You pay for ingress events per 64-KB unit. Larger messages incur extra charges based on their size.

**Q2: Can I filter specific log categories before exporting?**
**A2**: Currently, Azure doesn't support filtering specific categories like **Administrative** logs before exporting. Use diagnostic settings to manage this.

### References

- [Azure Event Hubs documentation](/azure/event-hubs/)
- [Azure Monitor diagnostic settings](/azure/azure-monitor/essentials/diagnostic-settings)
