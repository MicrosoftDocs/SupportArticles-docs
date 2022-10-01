---
title: Troubleshoot connections to endpoints in the same virtual network
description: Troubleshoot connections to endpoints in the same virtual network from an Azure Kubernetes Service (AKS) cluster.
ms.date: 9/30/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa
editor: v-jsitser
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot connections to endpoints in the same virtual network so that I don't experience outbound connection issues from an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot connections to endpoints in the same virtual network

This article discusses how to troubleshoot connections to endpoints in the same virtual network from a Microsoft Azure Kubernetes Service (AKS) cluster.

## Troubleshooting checklist

The troubleshooting checklist covers connections to the following items:

- Virtual machines (VMs) or endpoints in the same or different subnet
- VMs or endpoints in a peered virtual network
- Private endpoints

### Step 1: Do basic troubleshooting

The first step is to make sure that you can connect to endpoints. For instructions, see [Basic troubleshooting of outbound AKS cluster connections](basic-troubleshooting-outbound-connections.md).

### Step 2: Check for private endpoints

If the connection goes through a private endpoint, follow the instructions in [Troubleshoot Azure Private Endpoint connectivity problems](/azure/private-link/troubleshoot-private-endpoint-connectivity).

### Step 3: Check for virtual network peering

If the connection uses virtual network peering, follow the instructions in [Troubleshoot a connectivity issue between two peered virtual networks](/azure/virtual-network/virtual-network-troubleshoot-peering-issues#troubleshoot-a-connectivity-issue-between-two-peered-virtual-networks).

### Step 4: Check whether the AKS network security group blocks traffic in the outbound scenario

To check the network security groups (NSGs) and their associated rules by using AKS, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machine scale sets**.

1. In the list of scale set instances, select the one that you're using.

1. In the menu pane of your scale set instance, select **Networking**.

   The **Networking** page for the scale set instance appears. In the **Outbound port rules** tab, two sets of rules are displayed. These rule sets are based on the two NSGs that act on the scale set instance. The following table describes the rule sets.

   | NSG rule level | NSG rule name | Attached to | Notes |
   |--|--|--|--|
   | Subnet | *\<my-aks-nsg>* | The *\<my-aks-subnet>* subnet | A common arrangement if the AKS cluster uses a custom virtual network and a custom subnet. |
   | Network adapter | **aks-agentpool-***\<agentpool-number>***-nsg** | The **aks-agentpool-***\<vm-scale-set-number>***-vmss** network interface | An NSG that's applied by the AKS cluster and managed by AKS. |

By default, the egress traffic is allowed on the NSGs. However, in some scenarios, the custom NSG that's associated with the AKS subnet might have a **Deny** rule that has a more urgent priority. This rule stops traffic to some endpoints.

AKS doesn't modify the egress rules in an NSG. If AKS uses a custom NSG, verify that it allows egress traffic for the endpoints on the correct port and protocol. To ensure the expected functioning of the AKS cluster, make sure that the egress for custom NSGs allows [Required outbound network rules for AKS clusters](/azure/aks/limit-egress-traffic#required-outbound-network-rules-and-fqdns-for-aks-clusters).

Custom NSGs can directly affect the egress traffic by blocking the outbound rules, and they can also affect egress traffic indirectly. For more information, see [Custom NSG can block DNS traffic between pods in 2 different node pools](./custom-nsg-blocks-traffic.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
