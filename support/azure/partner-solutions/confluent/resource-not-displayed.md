---
title: Confluent Cloud resource not displayed in Azure portal
description: "Troubleshoot issues where the Confluent Cloud resource or its Overview/Delete panes are not visible in the Azure portal."
author: v-albemi
ms.author: v-albemi
ms.service: Confluent integration
ms.topic: troubleshooting-general
ms.date: 09/23/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# Troubleshoot Confluent Cloud resource not displayed in Azure portal

This article helps you troubleshoot issues where the Confluent Cloud resource or its Overview/Delete panes are not visible in the Azure portal.

## Prerequisites

- Access to the Azure portal and the subscription containing the Confluent Cloud resource.
- Permissions to view resources in the subscription.

## Potential quick workarounds

1. Refresh the Azure portal page and check if the Overview or Delete panes appear.
2. Try accessing the resource from a different browser or an incognito/private window.

## Troubleshooting checklist

### 1) Refresh the Azure portal

- If the Overview or Delete panes for Confluent Cloud aren't visible, refresh the page. This error might be intermittent.

### 2) Check All resources list

- In the Azure portal, go to **All resources** and search for the Confluent Cloud resource.
- If the resource isn't listed, contact [Confluent support](https://support.confluent.io).

### 3) Escalate to support

- If refreshing the page and browser troubleshooting don't resolve the issue, contact [Confluent support](https://support.confluent.io) with details about the missing resource and your Azure subscription.

## Causes and/or solutions

### Solution: Portal UI or caching issue

1. Refresh the portal or use a different browser/incognito window.
2. Clear browser cache and cookies.

### Solution: Resource not provisioned or missing

1. Confirm the resource was successfully created and is in the correct subscription.
2. If the resource is missing, contact Confluent support for assistance.

## Advanced troubleshooting and data collection

- Collect the following information if you need to escalate to Confluent or Microsoft support:
  - Azure subscription ID and resource group
  - Resource name and type
  - Screenshots of the missing panes or All resources list
  - Browser and OS version
  - Timestamp of the issue

## Related content

- [Confluent support](https://support.confluent.io)
- [Azure portal troubleshooting](https://learn.microsoft.com/azure/azure-portal/azure-portal-troubleshoot)
- [Azure Marketplace documentation](https://learn.microsoft.com/azure/marketplace/marketplace-overview)