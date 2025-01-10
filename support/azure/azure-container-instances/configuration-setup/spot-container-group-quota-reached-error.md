---
title: ContainerGroupQuotaReached error when deploying Spot containers
description: Provides solutions to the ContainerGroupQuotaReached error that occurs when you deploy a Spot container to Azure Container Instances.
ms.date: 10/28/2024
ms.reviewer: chiragpa, v-weizhu
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
---
# ContainerGroupQuotaReached error - Container group quota exceeded in region

This article provides a solution to the Spot container deployment error ContainerGroupQuotaReached.

## Symptoms 

When you deploy a Spot container to Azure Container Instances (ACI) from the Azure portal or by using the Azure CLI, the deployment fails with a ContainerGroupQuotaReached error like the following text:

> Code: ContainerGroupQuotaReached  
> Message: Resource type 'Microsoft.ContainerInstance/containerGroups' container group quota 'StandardSpotCores' exceeded in region 'westeurope'. Limit: '100', Usage: '12' Requested: '90'.

Here's a command example for deploying a Spot container:

```azurecli
az container create -g MyResourceGroup --name myapp --image myimage:latest --priority spot --cpu 10
```

> [!NOTE]
> Currently, Spot containers are only available in these regions: East US 2, West Europe, and West.

## Cause

This issue occurs because the container group default quota exceeds the default Spot quota bound by your Azure subscription. The following table shows the default Spot quota for different subscription types:

|Subscription type|	StandardSpotCores limit|
|---|---|
|Enterprise Agreement|	100|
|Default|	10|
|Others|	0|

To check the subscription type of your billing account, see [Check the type of your account](/azure/cost-management-billing/manage/view-all-accounts#check-the-type-of-your-account).

## Solution

To resolve this issue, increase the StandardSpotCores limit. To do so, use one of the following methods:

- Change the subscription type to Default to get 10 StandardSpotCores limit.
- [Change the subscription type to Enterprise Agreement](/azure/cost-management-billing/manage/mosp-ea-transfer) to get 100 StandardSpotCores limits.
- File support request to increase capacity for Spot containers. For more information, see [How do I file quota requests for ACI Spot containers?](/azure/container-instances/container-instances-faq#spot-containers-on-azure-container-instances--preview)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
