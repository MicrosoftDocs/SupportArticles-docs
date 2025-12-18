---
title: Resource Monitoring Stopped Working 
description: Troubleshoot situations in which New Relic stops receiving logs or metrics from Azure resources.
author: shijojoy
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.service: partner-services
ms.topic: troubleshooting-general
ms.custom: New Relic troubleshooting
ms.date: 09/19/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to troubleshoot situations in which New Relic monitoring stops working.

---

# Resource monitoring stopped working 

This article helps you troubleshoot situations in which New Relic stops receiving telemetry (logs, metrics, or events) from Azure resources like virtual machines (VMs) and app services. 

## Prerequisites

- Access to the New Relic account that owns the ingest API key (API key admin or owner).
- Access to the Azure subscription and resource group that contain the affected resources (Reader to view, Contributor/Owner to remediate or change billing).
 
## Causes and solutions

### Cause: Ingest API key is revoked

Resource monitoring in New Relic is enabled through the *ingest API key*, which you set up at the time of resource creation. Revoking the ingest API key from the New Relic portal disrupts monitoring of logs and metrics for all resources, including virtual machines and app services. You shouldn't revoke the ingest API key.

#### Solution

- If the API key is revoked, contact [New Relic support](https://support.newrelic.com/).

### Cause: Azure subscription suspended or deleted 

If your Azure subscription is suspended or deleted for payment-related issues, resource monitoring in New Relic automatically stops. 

#### Solution

- If the subscription is suspended or deleted for payment-related reasons, either update the payment method or move resources to an active subscription. For more information, see [Add, update, or delete a payment method](/azure/cost-management-billing/manage/change-credit-card).

### Cause: New Relic service issues

New Relic manages the APIs for creating and managing resources, and for the storage and processing of telemetry data. The New Relic APIs might be on or outside of Azure. Some issues can originate outside of Azure.  

#### Solution

If your Azure subscription and resource are working correctly but the New Relic portal shows problems with monitoring data, contact [New Relic support](https://support.newrelic.com/).

## Related content

- [Add, update, or delete a payment method](/azure/cost-management-billing/manage/change-credit-card)
- [New Relic support](https://support.newrelic.com/)

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]