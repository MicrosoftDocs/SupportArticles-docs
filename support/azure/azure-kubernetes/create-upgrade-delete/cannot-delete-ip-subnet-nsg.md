---
title: Public IP address/subnet/network security group in use can't be deleted
description: Provides a solution to the PublicIPAddressCannotBeDeleted, InUseSubnetCannotBeDeleted, or InUseNetworkSecurityGroupCannotBeDeleted error when you delete an AKS cluster.
ms.date: 12/04/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, edneto, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the PublicIPAddressCannotBeDeleted, InUseSubnetCannotBeDeleted, or InUseNetworkSecurityGroupCannotBeDeleted error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# A public IP address/subnet/network security group in use can't be deleted

This article discusses how to identify and resolve the `PublicIPAddressCannotBeDeleted`, `InUseSubnetCannotBeDeleted`, or `InUseNetworkSecurityGroupCannotBeDeleted` error that occurs when you try to delete a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to delete an AKS cluster, you receive one of the following error messages:

- For the `PublicIPAddressCannotBeDeleted` error code:

  > {
  >
  > message: "Public IP address ...../providers/Microsoft.Network/publicIPAddresses/ can not be deleted since it is still allocated to resource ...../providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/..... . In order to delete the public IP, disassociate/detach the Public IP address from the resource."
  >
  > }

- For the `InUseSubnetCannotBeDeleted` error code:

  > {
  >
  > message: "Subnet aks-subnet is in use by …../Microsoft.Network/networkInterfaces/|providers|Microsoft.Compute|virtualMachineScaleSets|vmss|virtualMachines|1|networkInterfaces|aks-worker-vmss/ipConfigurations/ipconfig1 and cannot be deleted. In order to delete the subnet, delete all the resources within the subnet."
  >
  > }
  
  or
  > {
  > 
  > message: "Subnet aks-subnet is in use by ..../resourceGroups/.../providers/Microsoft.Network/virtualNetworks/.../subnets/.../serviceAssociationLinks/AppServiceLink and cannot be deleted. In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet."
  >
  > }

- For the `InUseNetworkSecurityGroupCannotBeDeleted` error code:

  > {
  >
  > message: "Network security group …../Microsoft.Network/networkSecurityGroups/test cannot be deleted because it is in use by the following resources: ...../Microsoft.Network/virtualNetworks/test/subnets/test. In order to delete the Network security group, remove the association with the resource(s)."
  >
  > }

## Cause

The AKS cluster is associated with a subnet, network security group (NSG), or specific public IP address that's currently being used. This association prevents you from deleting the cluster.

## Solution

- Remove all public IP addresses that are associated with Azure Load Balancer and the resource that's used by the subnet. For more information, see [View, modify settings for, or delete a public IP address](/azure/virtual-network/ip-services/virtual-network-public-ip-address#view-modify-settings-for-or-delete-a-public-ip-address).

- In the load balancer, remove the rules for **Load Balance rules**, **Health probes**, and **Backend pools**.

- For the NSG and subnet, remove all associated rules. For more information, see [Associate or dissociate a network security group to or from a subnet or network interface](/azure/virtual-network/manage-network-security-group#associate-or-dissociate-a-network-security-group-to-or-from-a-subnet-or-network-interface).

- If you're using an App Service plan with a subnet connected to the AKS cluster's VNET, you have to remove the associated App Service plan and its internal resources (such as Function App and SQL Azure database) and then retry deleting the AKS cluster.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
