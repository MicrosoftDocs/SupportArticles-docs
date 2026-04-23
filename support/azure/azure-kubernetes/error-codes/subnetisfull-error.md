---
title: Troubleshoot SubnetIsFull error during AKS cluster upgrade
description: Resolve the SubnetIsFull error during an AKS cluster upgrade. Learn how to fix IP address capacity issues and complete your upgrade successfully.
ms.date: 04/21/2026
editor: v-jsitser
ms.reviewer: chiragpa, albarqaw, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of a SubnetIsFull error so that I can upgrade the cluster successfully.
---

# Troubleshoot the SubnetIsFull error code during an AKS cluster upgrade

## Summary

This article explains how to identify and resolve the SubnetIsFull error that occurs when you upgrade an Azure Kubernetes Service (AKS) cluster. It helps you complete the upgrade successfully.

Here's an example of the error message:

>Failed to scale node pool \<AGENT POOL NAME>\' in Kubernetes service '\<NAME>\'. Error: VMSSAgentPoolReconciler retry failed: Code='SubnetIsFull' Message='\<SUBNET NAME>\ with address prefix \<PREFIX>\ doesn't have enough capacity for IP addresses.' Details=[]

## Prerequisites

This article requires Azure CLI version 2.0.65 or a later version. To find the version number, run `az --version`. If you need to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

An AKS cluster upgrade fails, and you receive a "SubnetIsFull" error message.

## Cause

This error occurs if your cluster doesn't have enough IP addresses to create a new node.

When you plan an upgrade or scaling operation, consider the number of required IP addresses. If the IP address range that you configured in the cluster supports only a fixed number of nodes, the upgrade or scaling operation fails. For more information, see [IP address planning for your Azure Kubernetes Service (AKS) clusters](/azure/aks/concepts-network-ip-address-planning).

## Check the available IPs in the subnet

Before taking corrective action, verify how many IP addresses are available in the subnet that's associated with your AKS cluster.

To check the available IP addresses in the [Azure portal](https://portal.azure.com):

1. Go to the **Virtual networks** service.
1. Select the virtual network that's associated with your AKS cluster.
1. In the menu, select **Subnets**.
1. Review the **Available IPs** column for the subnet that your cluster uses.

Alternatively, you can run the following Azure CLI commands to check available IPs:

```azurecli
# Get the subnet resource ID for the node pool.
# For clusters that use a custom VNet, the subnet ID is stored in the agent pool profile:
SUBNET_ID=$(az aks show \
    --resource-group <RESOURCE_GROUP> \
    --name <CLUSTER_NAME> \
    --query "agentPoolProfiles[0].vnetSubnetId" \
    --output tsv)

# If the cluster uses a managed VNet (SUBNET_ID is empty),
# retrieve the subnet from the node resource group instead:
if [[ -z "$SUBNET_ID" ]]; then
    NODE_RESOURCE_GROUP=$(az aks show \
        --resource-group <RESOURCE_GROUP> \
        --name <CLUSTER_NAME> \
        --query "nodeResourceGroup" \
        --output tsv)

    SUBNET_ID=$(az network vnet list \
        --resource-group "$NODE_RESOURCE_GROUP" \
        --query "[0].subnets[0].id" \
        --output tsv)
fi

# Display the subnet details and calculate available IPs
az network vnet subnet show \
    --ids "$SUBNET_ID" \
    --query "{SubnetName:name, AddressPrefix:addressPrefix, UsedIPs:length(ipConfigurations || \`[]\`)}" \
    --output json | jq -r '
    .AddressPrefix as $prefix |
    ($prefix | split("/")[1] | tonumber) as $prefixLen |
    pow(2; 32 - $prefixLen) as $totalIPs |
    5 as $reserved |
    (.UsedIPs // 0) as $used |
    ($totalIPs - $reserved - $used) as $available |
    ["SubnetName", "AddressPrefix", "TotalIPs", "UsedIPs", "AzureReserved", "AvailableIPs"],
    [.SubnetName, $prefix, ($totalIPs | tostring), ($used | tostring), ($reserved | tostring), ($available | tostring)]
    | @tsv' | column -t
```

The output resembles the following example:

```output
SubnetName  AddressPrefix  TotalIPs  UsedIPs  AzureReserved  AvailableIPs
aks-subnet  xx.xxx.x.x/16  65536     327      5              65204
```

> [!NOTE]
> This script requires [jq](https://jqlang.github.io/jq/) to be installed. Azure reserves five (5) IP addresses in each subnet. For more information, see [Are there any restrictions on using IP addresses within these subnets?](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets).

If the number of available IPs is low (for example, fewer than the number of nodes you're adding during the upgrade), proceed with the solution in the next section.

## Solution

Reduce the cluster nodes to reserve IP addresses for the upgrade.

If scaling down isn't an option, and your virtual network CIDR has enough IP addresses, try to add a node pool that has a [unique subnet](/azure/aks/use-multiple-node-pools#add-a-node-pool-with-a-unique-subnet-preview):

1. Add a new user node pool in the virtual network on a larger subnet.
1. Switch the original node pool to a system node pool type.
1. Scale up the user node pool.
1. Scale down the original node pool.

## Resources

- [InsufficientSubnetSize error code](../connectivity/insufficientsubnetsize-error-advanced-networking.md)

 
