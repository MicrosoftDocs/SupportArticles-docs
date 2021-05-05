---
title: QuotaExceeded error when scaling virtual machine scale sets
description: Steps to resolve issues when QuotaExceeded error appears.
ms.date: 05/04/2020
author: jc-mackin
ms.author: v-jcmackin
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: azure

---

# QuotaExceeded error when scaling virtual machine scale sets

This article provides guidance on resolving “QuotaExceeded” errors during the deployment, migration, or scaling of Azure virtual machine scale sets (VMSSs).

## Symptom
You receive a “QuotaExceeded” error when you deploy a VMSS, when a VMSS is scaled manually or automatically, when you migrate a VMSS between subscriptions, or when you migrate a VMSS from the classic deployment model to the Azure Resource Manager (ARM) deployment model. 
For example, you might see an error message such as the following:
```output
Error: Code=QuotaExceeded; Message=Operation could not be completed as it results in exceeding approved Total Regional Cores quota. Additional details - Deployment Model: Resource Manager,
Location: westus,
Current Limit: 100,
Current Usage: 56,
Additional Required: 56,
(Minimum) New Limit Required: 112.
```

## Cause
The VMSS does not have enough quota available in the target Azure location or subscription.
The Azure resources that are available to each VMSS, such as the total VM cores, are limited by subscription as well as by the region and SKU family being used. For more information, see [Virtual Machine Limits- Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-machines-limits---azure-resource-manager).

## Resolution
Consult the following article for steps to confirm that quota limitations are causing the error message, and for information about opening a support request to increase your quota: [Quota errors - Azure Resource Manager | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/error-resource-quota)
