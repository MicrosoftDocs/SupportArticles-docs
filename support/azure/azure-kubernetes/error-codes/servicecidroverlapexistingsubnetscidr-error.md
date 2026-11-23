---
title: Troubleshoot ServiceCidrOverlapExistingSubnetsCidr Error Code
description: Learn how to resolve the ServiceCidrOverlapExistingSubnetsCidr error that occurs when you try to upgrade an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/25/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: cssakscic, v-leedennis, andraciobanu, jotavar
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot a ServiceCidrOverlapExistingSubnetsCidr error so that I can upgrade the cluster successfully.
ai-usage: ai-assisted
---

# Troubleshoot the ServiceCidrOverlapExistingSubnetsCidr error during an AKS cluster upgrade

## Summary

This article discusses how to identify and resolve the "ServiceCidrOverlapExistingSubnetsCidr" error that might occur when you try to [upgrade a Microsoft Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-aks-cluster). Use these solutions to fix the service CIDR and subnet overlap so that your cluster upgrade can finish.

## Symptoms

An AKS cluster upgrade operation fails and displays the following error message:

> (ServiceCidrOverlapExistingSubnetsCidr) The specified service CIDR \<service-cidr-1> is conflicted with an existing subnet CIDR \<subnet-cidr-2>  
> Code: ServiceCidrOverlapExistingSubnetsCidr  
> Message: The specified service CIDR \<service-cidr-1> is conflicted with an existing subnet CIDR \<subnet-cidr-2>  
> Target: networkProfile.serviceCIDR

## Cause

The service address range of a cluster is the set of virtual IP addresses that Kubernetes assigns to internal services in the cluster. You define this range when you create the cluster. The range shouldn't overlap with the cluster's virtual network or any other network that you can route from the cluster. For more information, see [Deployment parameters](/azure/aks/azure-cni-overview#deployment-parameters).

Before AKS starts an upgrade operation, it checks the cluster's virtual network for any existing subnet Classless Inter-Domain Routing (CIDR) address spaces that overlap with the cluster's service CIDR. If the check finds any subnet overlap, the operation generates the "ServiceCidrOverlapExistingSubnetsCidr" error.

To resolve this issue, use one of the following solutions.

Before applying the solutions, use Azure PowerShell to run the following discovery commands.

```azurepowershell

az aks show \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --query "{serviceCIDR:networkProfile.serviceCidr,subnets:agentPoolProfiles[].vnetSubnetId}" \
  --output json

  az network vnet subnet list \
  --resource-group <vnet-resource-group> \
  --vnet-name <vnet-name> \
  --query "[].{name:name,addressPrefix:addressPrefix,addressPrefixes:addressPrefixes}" \
  --output table

```

Confirm any overlap while considering the following:

- Clarify whether AKS validates only subnets in the cluster virtual network or also peered and routable networks.
- Cover multiple node pools and virtual networks with multiple address spaces.
- Verify that a subnet has no connected resources before deletion.
- Explain that changing a subnet prefix can require removing or migrating attached resources.
- Add migration considerations for workloads, persistent data, identities, Domain Name System (DNS), ingress, and downtime before recommending redeployment.

## Solution 1: Remove the overlapping subnet

> [!NOTE]  
> Use this solution if no resources are attached to the subnet.

Follow these steps to remove the overlapping subnet:

1. Delete the subnet. To delete the subnet, follow the steps in [Delete a subnet](/azure/virtual-network/virtual-network-manage-subnet#delete-a-subnet).
1. Retry the AKS cluster upgrade operation.

## Solution 2: Adjust the overlapping subnet address range

> [!NOTE]  
> Use this solution if it's acceptable to change the subnet's address range.

Follow these steps to adjust the overlapping subnet address range:

1. Change the subnet's address range. To change the address range, follow the steps in [Change subnet settings](/azure/virtual-network/virtual-network-manage-subnet#change-subnet-settings).
2. Retry the AKS cluster upgrade operation.

## Solution 3: Redeploy the cluster with a different service CIDR

> [!NOTE]  
> Use this solution if it's not acceptable or not possible to remove the overlapping subnet or adjust its configuration. You can't change the cluster's service CIDR after cluster creation.

Review the [deployment parameters](/azure/aks/azure-cni-overview#deployment-parameters) and redeploy your cluster by using a different service CIDR.

Use Azure PowerShell to validate the post-change configuration.

Run the following commands.

```azurepowershell

az aks upgrade \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --kubernetes-version <version>

kubectl get nodes
kubectl get pods --all-namespaces
kubectl get services --all-namespaces

```