---
title: Error codes for Spot container creation in Azure Container Instances
description: Learn how to fix common error codes when you create Spot containers in Azure Container Instances (ACI). Review causes and solutions to deploy successfully.
ms.date: 10/01/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: edneto, v-weizhu, v-leedennis, kegonzal, tysonfreeman, kaushika
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#customer intent: As a user of Azure Container Instances, I want find details and solutions to common user errors that involve Spot containers so that I can create Spot containers successfully.
ai-usage: ai-assisted
---
# Error codes for Spot container creation in Azure Container Instances

## Summary

This article provides solutions to common errors that occur when you try to create a Spot container in Azure Container Instances (ACI).

The following table lists common error codes, their messages, and solutions for Spot container creation in ACI.

| Code | Error message | Details and solution |
|--|--|--|
| `SpotPriorityContainerGroupNotSupportedForInboundConnectivity` | `Spot Priority is not supported for container groups with inbound connectivity.` | Remove the network-related properties from the request, and try again. |
| `SpotPriorityContainerGroupNotSupportedInSku` | `Spot Priority Container Group is not supported in '{xyz}' Sku.` | Only the **Standard** SKU is supported for Spot containers. Try again by specifying the **Standard** SKU. |
| `SpotPriorityContainerGroupWithGPUResourcesNotSupported` | `Spot Priority Container Groups that include containers requesting GPU resources are not supported.` | Graphics processing units (GPUs)  aren't supported for Spot containers. Remove the GPU from the request, and then try again. |
| `PriorityNotSpecified` | `The 'Priority' must be one of 'Regular,Spot' for container group '{xyz}'.` | If the priority is mentioned in the request body, specify a value of `Regular` or `Spot`. |

## References

- [Azure Container Instances Spot containers (preview)](/azure/container-instances/container-instances-spot-containers-overview)
- [FAQ - Spot containers on Azure Container Instances (Preview)](/azure/container-instances/container-instances-faq#spot-containers-on-azure-container-instances--preview)
