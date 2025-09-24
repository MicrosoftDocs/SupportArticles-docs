---
title: Troubleshoot Slow or Failed Confluent Cloud Resource reation in Azure
description: "Troubleshoot slow or failed resource creation for Confluent Cloud in Azure."
author:  
ms.author: jarrettr
ms.service: partner-services
ms.topic: troubleshooting-general
ms.date: 09/24/2025

# customer intent: As an Azure administrator or user, I want to troubleshoot problems with slow or failed Confluent Cloud resource creation.

---

# Resource creation is slow or fails 

This article helps you troubleshoot issues where Confluent Cloud resource creation in Azure takes a long time or fails.

## Prerequisites

- Access to the Azure portal and the subscription where you are deploying the resource.
- Permissions to view resource status and delete resources.

## Potential quick workarounds

1. If deployment takes more than three hours, contact [Confluent support](https://support.confluent.io).
2. If deployment fails and the resource status is `Failed`, delete the resource and try to create it again.

## Troubleshooting checklist

### 1) Monitor deployment status

- In the Azure portal, check the status of the Confluent Cloud resource deployment.
- If the process exceeds three hours, escalate to support.

### 2) Retry after deletion

- If the resource status is `Failed`, delete the resource from the portal.
- Retry the resource creation process.

### 3) Escalate to support

- If repeated attempts fail or deployment is consistently slow, contact [Confluent support](https://support.confluent.io) with details about the resource and subscription.

## Causes and/or solutions

### Solution: Deployment is slow or stuck

1. Wait up to three hours for deployment to complete.
2. If still not complete, escalate to support for investigation.

### Solution: Deployment fails

1. Delete the failed resource in the Azure portal.
2. Retry the resource creation process.

## Advanced troubleshooting and data collection

- Collect the following information if you need to escalate to Confluent or Microsoft support:
  - Azure subscription ID and resource group
  - Resource name and type
  - Deployment status and error messages
  - Timestamps of deployment attempts
  - Screenshots of the deployment status

## Related content

- [Confluent support](https://support.confluent.io)
- [Azure portal troubleshooting](https://learn.microsoft.com/azure/azure-portal/azure-portal-troubleshoot)
- [Azure Marketplace documentation](https://learn.microsoft.com/azure/marketplace/marketplace-overview)