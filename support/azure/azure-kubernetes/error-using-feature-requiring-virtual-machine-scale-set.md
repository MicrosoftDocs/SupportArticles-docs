---
title: Errors using features that require virtual machine scale sets
description: Troubleshoot errors that occur when you try to use a feature that requires virtual machine scale sets on an Azure Kubernetes Service (AKS) cluster.
ms.date: 06/01/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot errors so that I can successfully use features that require virtual machine scale sets on an Azure Kubernetes Service (AKS) cluster.
---
# Errors using features that require virtual machine scale sets

This article discusses how to troubleshoot errors that occur when you try to use a feature that requires virtual machine scale sets on a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

You receive the following error message:

> AgentPool \<agentpoolname> has set auto scaling as enabled but isn't on Virtual Machine Scale Sets

## Cause

Features such as the cluster autoscaler or multiple node pools require virtual machine scale sets as the `vm-set-type`.

## Solution

To successfully create an AKS cluster that uses the required scale set features, follow the steps in the "Before you begin" section of the appropriate article:

| Feature             | Article link                                                                                                |
|---------------------|-------------------------------------------------------------------------------------------------------------|
| Cluster autoscaler  | [Automatically scale a cluster to meet application demands](/azure/aks/cluster-autoscaler#before-you-begin) |
| Multiple node pools | [Create and manage multiple node pools for a cluster](/azure/aks/use-multiple-node-pools#before-you-begin)  |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
