---
title: Can't access the cluster API server using authorized IP ranges
description: Troubleshoot problems accessing the cluster API server when you use authorized IP address ranges in Azure Kubernetes Service (AKS).
ms.date: 06/08/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot access issues to the cluster API server when I use authorized IP address ranges so that I can work with my Azure Kubernetes Service (AKS) cluster successfully.
---
# Can't access the cluster API server when using authorized IP ranges

This article discusses how to resolve a scenario in which you can't use authorized IP address ranges to access the API server for a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

If you try to create or manage an AKS cluster, you can't access the cluster API server.

## Cause

You configured your AKS cluster to access the cluster API server by using authorized IP address ranges that your computer can't access.

## Solution

Make sure that when you run the [az aks create](/cli/azure/aks#az-aks-create) or [az aks update](/cli/azure/aks#az-aks-update) command in [Azure CLI](/cli/azure/install-azure-cli), the `--api-server-authorized-ip-ranges` parameter includes the IP addresses or IP address ranges of the automation, development, or tooling systems that are being used.

## More information

- [How to find my IP to include in --api-server-authorized-ip-ranges?](/azure/aks/api-server-authorized-ip-ranges#how-to-find-my-ip-to-include-in---api-server-authorized-ip-ranges)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
