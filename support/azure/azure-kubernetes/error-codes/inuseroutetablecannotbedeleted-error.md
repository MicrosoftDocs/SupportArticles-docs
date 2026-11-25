---
title: Troubleshoot InUseRouteTableCannotBeDeleted error code in AKS
description: Learn how to resolve the InUseRouteTableCannotBeDeleted error when you delete an Azure Kubernetes Service (AKS) cluster. Follow these steps to fix it.
ms.date: 11/25/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, edneto, wonkilee, v-leedennis, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InUseRouteTableCannotBeDeleted error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot the "InUseRouteTableCannotBeDeleted" error code in Azure Kubernetes Service

## Summary

This article helps you troubleshoot the `InUseRouteTableCannotBeDeleted` error that occurs when you delete an Azure Kubernetes Service (AKS) cluster. Remove the route table association from the subnet to complete the deletion.

## Symptoms

When you try to delete an AKS cluster, you receive the following error message.

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

Remove the associated route table from the subnet. For more information (including instructions), see [Dissociate a route table from a subnet](/azure/virtual-network/manage-route-table#dissociate-a-route-table-from-a-subnet). Then, try again to delete the AKS cluster.