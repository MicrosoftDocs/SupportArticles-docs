---
title: Troubleshoot the ZonalAllocationFailed or AllocationFailed error
description: Learn how to troubleshoot the ZonalAllocationFailed or AllocationFailed error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 3/10/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the ZonalAllocationFailed or AllocationFailed error code so that I can successfully create and deploy an Azure Kubernetes Service cluster.
---
# Troubleshoot the ZonalAllocationFailed or AllocationFailed error code

This article describes how to identify and resolve the `ZonalAllocationFailed` or `AllocationFailed` error that might occur if you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) (optional), version 2.0.59 or a later version. If Azure CLI is already installed, you can find the version number by using `az --version`.

- [Azure PowerShell](/powershell/azure/install-az-ps) (optional).

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> Reconcile vmss agent pool error: VMSSAgentPoolReconciler retry failed:
>
> Category: InternalError;
>
> SubCode: ZonalAllocationFailed;
>
> Dependency: Microsoft.Compute/VirtualMachineScaleSet;
>
> OrginalError: Code="ZonalAllocationFailed"
>
> Message="**Allocation failed. We do not have sufficient capacity for the requested VM size in this zone.** Read more about improving likelihood of allocation success at <https://aka.ms/allocation-guidance>";
>
> AKSTeam: NodeProvisioning

## Cause

You're trying to deploy a cluster in a zone that has limited availability for the specific SKU.

## Solution

Try one or more of the following methods:

- Redeploy the cluster in the same region by using a different SKU.
- Redeploy the cluster in a different zone in that region.
- Redeploy the cluster in a different region.
- Create a new node pool in a different region or zone.

For more information about how to fix this error, see [Resolve errors for SKU not available](/azure/azure-resource-manager/troubleshooting/error-sku-not-available).

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
