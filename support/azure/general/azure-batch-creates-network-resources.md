---
title: Azure Batch creates network resources such as NSG, PublicIP, Load balancer in the subscription.
description: This article provides the cause and some suggestions to identify the Azure Batch Account and pool that is associated to a specific network related resource created in the Azure Subscription.
autor: cabermu
---

# Azure Batch creates network resources such as NSG, PublicIP and Load balancer in the subscription.

This article provides the cause and some suggestions to identify the Azure Batch Account and pool that is associated to a specific network related resource created in the Azure Subscription.

## Symptoms

Azure Batch creates resources at the subscription level, and it is necessary to identify the Azure Batch Account and pool associated to them. 

> [!NOTE]
> The resources created use the following format.
-An Azure load balancer, with the name (Guid)-Azurebatch-cloudserviceloadbalancer
-A network security group, with the name (Guid)-Azurebatch-cloudservicenetworksecuritygroup
-An Azure public IP address, with the name (Guid)-Azurebatch-cloudservicepublicip

## Cause: Azure Batch VNET integration  

As described in the symptom, when a Batch pool is created using VNET Integration, the Azure Batch service automatically creates all necessary network resources for the operation of the pool. These resources are created in the same resource group where the VNET in use is located.

:::image type="content" source="media/azure-batch-network-resources/network-resources-created-by-batch.png" alt-text="Screenshot of network resources created by batch." border="false":::

## Solution: Access the resource Tag to access the Batch Account/ Pool details 

To identify the Batch resources attached to a specific network resource (NSG/LB/PublicIP), it is necessary to access the resource and check the Tags section, it will show information about the Batch Account Name and Pool Name. It is important to note that once the pool is resized to 0 or deleted, the associated network resources will also be deleted.

:::image type="content" source="media/azure-batch-network-resources/batch-network-resources-tags.png" alt-text="Screenshot of Tags information that contains information of the batch account and pool." border="false":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
