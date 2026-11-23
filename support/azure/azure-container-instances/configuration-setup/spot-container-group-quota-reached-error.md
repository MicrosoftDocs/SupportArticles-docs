---
title: ContainerGroupQuotaReached error when deploying Spot containers in Azure Container Instances
description: Learn how to fix the ContainerGroupQuotaReached error when you deploy Spot containers to Azure Container Instances (ACI) by increasing your StandardSpotCores quota.
ms.date: 10/02/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, v-weizhu, kennethgp, kaushika
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
ai-usage: ai-assisted
---
# "ContainerGroupQuotaReached" error - Container group quota exceeded in region in Azure Container Instances

## Summary

This article explains how to resolve the "ContainerGroupQuotaReached" error that occurs when you deploy Spot containers in Azure Container Instances (ACI) and exceed the StandardSpotCores quota for your subscription.

## Symptoms

When you deploy a Spot container to ACI from the [Azure portal](https://portal.azure.com) or by using Azure CLI, the deployment fails with a "ContainerGroupQuotaReached" error like the following text.

> Code: ContainerGroupQuotaReached  
> Message: Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'StandardSpotCores' exceeded in region '\<region>'. Limit: '100', Usage: '12' Requested: '90'.

The following example shows a command for deploying a Spot container with Azure CLI.

```azurecli
az container create -g MyResourceGroup --name myapp --image myimage:latest --priority spot --cpu 10
```

## Cause

This error occurs because the container group default quota exceeds the default Spot quota for your Azure subscription. The following table shows the default Spot quota for different subscription types.

| Subscription type | StandardSpotCores limit |
|---|---|
| Enterprise Agreement | 100 |
| Default | 10 |
| Others | 0 |

To check the subscription type of your billing account, see [Check the type of your account](/azure/cost-management-billing/manage/view-all-accounts#check-the-type-of-your-account).

## Solution

To resolve this issue, increase the StandardSpotCores limit. Use one of the following methods:

- Change the subscription type to **Default** to get a 10 StandardSpotCores limit.
- [Change the subscription type to Enterprise Agreement](/azure/cost-management-billing/manage/mosp-ea-transfer) to get 100 StandardSpotCores limits.
- File a support request to increase capacity for Spot containers. For more information, see [How do I file quota requests for ACI Spot containers?](/azure/container-instances/container-instances-faq#spot-containers-on-azure-container-instances--preview)

> [!NOTE]
> Spot containers with ACI is currently in preview and not recommended for production scenarios.