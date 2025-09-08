---
title: Troubleshoot the InUseRouteTableCannotBeDeleted error code
description: Learn how to troubleshoot the InUseRouteTableCannotBeDeleted error when you try to delete an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/28/2025
editor: v-jsitser
ms.reviewer: rissing, chiragpa, edneto, wonkilee, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InUseRouteTableCannotBeDeleted error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the InUseRouteTableCannotBeDeleted error code

This article discusses how to identify and resolve the `InUseRouteTableCannotBeDeleted` error that occurs when you try to delete a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to delete an AKS cluster, you receive the following error message:

> Error Code: "InUseRouteTableCannotBeDeleted"
>
> {
>
> "Route table aks-agentpool-routetable is in use and cannot be deleted. ...../providers/Microsoft.Network/routeTables/aks-agentpool-test-routetable"
>
> }

## Cause

You tried to delete the AKS cluster while its associated route table was still in use.

## Solution

Remove the associated route table from the subnet. For instructions, see [Dissociate a route table from a subnet](/azure/virtual-network/manage-route-table#dissociate-a-route-table-from-a-subnet). Then, try again to delete the AKS cluster.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
