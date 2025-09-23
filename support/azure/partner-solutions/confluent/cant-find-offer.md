---
title: Can't find Apache Kafka & Apache Flink on Confluent Cloud offer in Azure Marketplace
description: "Troubleshoot issues finding the Apache Kafka & Apache Flink on Confluent Cloud offer in Azure Marketplace."
author: v-albemi
ms.author: v-albemi
ms.service: Confluent integration
ms.topic: troubleshooting-general
ms.date: 09/23/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# Troubleshoot offer not found in Azure Marketplace

This article helps you troubleshoot issues finding the Apache Kafka & Apache Flink on Confluent Cloud offer in Azure Marketplace. Use this article if you can't locate the offer when searching in the Azure portal.

## Prerequisites

- Access to the Azure portal and permission to create resources.
- Your Microsoft Entra tenant ID (required if support needs to check tenant allow-list).

## Potential quick workarounds

1. Refresh the Azure portal and try searching again.
2. Try searching for the offer using a different browser or an incognito/private window.
3. Confirm you are signed in to the correct Azure account and tenant.

## Troubleshooting checklist

### 1) Search for the offer in Azure Marketplace

- In the [Azure portal](https://portal.azure.com), select **Create a resource**.
- Search for **Apache Kafka & Apache Flink on Confluent Cloud**.
- Select the application tile if it appears.

### 2) Check tenant allow-list

- If you don't see the offer, your Microsoft Entra tenant ID may not be on the list of allowed tenants for the offer.
- [Learn how to find your Microsoft Entra tenant ID.](https://learn.microsoft.com/azure/active-directory-b2c/tenant-management-read-tenant-name)
- Contact [Confluent support](https://support.confluent.io) and provide your tenant ID for allow-list verification.

### 3) Escalate to support

- If you still can't find the offer, contact [Confluent support](https://support.confluent.io) with your tenant ID and a description of the issue.

## Causes and/or solutions

### Solution: Offer not visible due to tenant restrictions

1. Confirm your Microsoft Entra tenant ID is allowed for the offer.
2. If not, request allow-listing from Confluent support.

### Solution: Portal or browser issue

1. Refresh the portal or use a different browser/incognito window.
2. Confirm you are signed in to the correct Azure account and tenant.

## Advanced troubleshooting and data collection

- Collect the following information if you need to escalate to Confluent or Microsoft support:
  - Your Microsoft Entra tenant ID
  - Azure subscription ID
  - Screenshots of the Azure Marketplace search results
  - Browser and OS version
  - Timestamp of the search attempt

## Related content

- [Find your Microsoft Entra tenant ID](https://learn.microsoft.com/azure/active-directory-b2c/tenant-management-read-tenant-name)
- [Confluent support](https://support.confluent.io)
- [Azure Marketplace documentation](https://learn.microsoft.com/azure/marketplace/marketplace-overview)