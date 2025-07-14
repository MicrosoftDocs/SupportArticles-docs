---
title: QuotaExceeded error when scaling virtual machine scale sets
description: Steps to resolve issues when QuotaExceeded error appears.
ms.date: 05/04/2020
author: genlin
ms.author: genli
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: azure-virtual-machine-scale-sets
ms.custom: sap:Scaling issue with my scale set
---

# QuotaExceeded error when scaling virtual machine scale sets

This article provides guidance on resolving "QuotaExceeded" errors during the deployment, migration, or scaling of Azure Virtual Machine Scale Sets.

## Symptom

You receive a "QuotaExceeded" error when a virtual machine scale set is deployed, scaled, migrated between subscriptions, or migrated from the classic deployment model to the Azure Resource Manager (ARM) deployment model.
For example, you might see an error such as the following example:

```output
Error: Code=QuotaExceeded; Message=Operation could not be completed as it results in exceeding approved Total Regional Cores quota. Additional details - Deployment Model: Resource Manager,
Location: westus,
Current Limit: 100,
Current Usage: 56,
Additional Required: 56,
(Minimum) New Limit Required: 112.
```

## Cause

The virtual machine scale set doesn't have enough quota available in the target Azure location or subscription.
The Azure resources that are available to each virtual machine scale set, such as the total VM cores, are limited by subscription and by both the region and SKU family being used. For more information, see [Virtual Machine Limits- Azure Resource Manager](/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-machines-limits---azure-resource-manager).

## Resolution

Consult the following article for steps to confirm that quota limitations are causing the error message, and for information about opening a support request to increase your quota: [Resolve errors for resource quotas](/azure/azure-resource-manager/templates/error-resource-quota)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
