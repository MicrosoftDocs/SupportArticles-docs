---
title: Error codes for Spot container creation in Container Instances
description: Provides a solution to common Spot container errors.
ms.date: 01/30/2024
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: v-weizhu, v-leedennis
ms.service: container-instances
ms.topic: error-reference
#customer intent: As a user of Azure Container Instances, I want find details and solutions to common user errors that involve Spot containers so that I can create Spot containers successfully.
---
# Error codes for Spot container creation in Azure Container Instances

This article provides solutions to common errors that occur when you try to create a Spot container in Microsoft Azure Container Instances.

| Code | Error message | Details and solution |
|--|--|--|
| `SpotPriorityContainerGroupNotSupportedForInboundConnectivity` | `Spot Priority is not supported for container groups with inbound connectivity.` | Remove the network-related properties from the request, and try again. |
| `SpotPriorityContainerGroupNotSupportedInSku` | `Spot Priority Container Group is not supported in '{xyz}' Sku.` | Only the **Standard** SKU is supported for Spot. Try again by specifying the **Standard** SKU. |
| `SpotPriorityContainerGroupWithGPUResourcesNotSupported` | `Spot Priority Container Groups that include containers requesting GPU resources are not supported.` | GPUs aren't supported for Spot containers. Remove the GPU from the request, and try again. |
| `PriorityNotSpecified` | `The 'Priority' must be one of 'Regular,Spot' for container group '{xyz}'.` | If the priority is mentioned in the request body, specify a value of `Regular` or `Spot`. |

## More information

- [Azure Container Instances Spot containers (preview)](/azure/container-instances/container-instances-spot-containers-overview)

- [FAQ - Spot containers on Azure Container Instances (Preview)](/azure/container-instances/container-instances-faq#spot-containers-on-azure-container-instances--preview)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
