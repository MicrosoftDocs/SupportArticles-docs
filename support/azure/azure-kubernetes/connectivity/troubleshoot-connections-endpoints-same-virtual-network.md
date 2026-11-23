---
title: Troubleshoot connections to endpoints in the same virtual network in AKS
description: Troubleshoot connections to endpoints in the same virtual network from an AKS cluster. Learn how to identify egress blockers and restore connectivity today.
ms.date: 11/05/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, rissing, v-leedennis, andbar, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot connections to endpoints in the same virtual network so that I don't experience outbound connection issues from an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Connectivity
ai-usage: ai-assisted
---
# Troubleshoot connections to endpoints in the same virtual network in Azure Kubernetes Service

## Summary

This article helps you troubleshoot connections to endpoints in the same virtual network from an Azure Kubernetes Service (AKS) cluster so you can identify and fix outbound connectivity issues faster.

## Troubleshooting checklist

The troubleshooting checklist covers connections to the following items:

- Virtual machines (VMs) or endpoints in the same subnet or a different subnet
- VMs or endpoints in a peered virtual network
- Private endpoints

### Step 1: Do basic troubleshooting

Ensure that you can connect to endpoints. For instructions, see [Basic troubleshooting of outbound AKS cluster connections](basic-troubleshooting-outbound-connections.md).

### Step 2: Check for private endpoints

If the connection goes through a private endpoint, follow the instructions in [Troubleshoot private endpoint connectivity failures](../../private-link/troubleshoot-private-endpoint-connectivity-failure.md).

### Step 3: Check for virtual network peering

If the connection uses virtual network peering, follow the instructions in [Troubleshoot a connectivity issue between two peered virtual networks](/azure/virtual-network/virtual-network-troubleshoot-peering-issues#troubleshoot-a-connectivity-issue-between-two-peered-virtual-networks).

### Step 4: Check whether the AKS network security group blocks traffic in the outbound scenario

To use AKS to check the network security groups (NSGs) and their associated rules, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machine scale sets**.
1. In the list of scale set instances, select the instance that you're using.
1. In the menu pane of your scale set instance, select **Networking**.

   The **Networking** page for the scale set instance appears. In the **Outbound port rules** tab, two sets of rules are displayed. These rule sets are based on the two NSGs that act on the scale set instance. The following table describes the rule sets.

   | NSG rule level | NSG rule name | Attached to | Notes |
   |--|--|--|--|
   | Subnet | *\<my-aks-nsg>* | The *\<my-aks-subnet>* subnet | This is a common arrangement if the AKS cluster uses a custom virtual network and a custom subnet. |
   | Network adapter | **aks-agentpool-***\<agentpool-number>***-nsg** | The **aks-agentpool-***\<vm-scale-set-number>***-vmss** network interface | This NSG is applied by the AKS cluster and managed by AKS. |

By default, the NSGs allow egress traffic. However, in some scenarios, the custom NSG that you associate with the AKS subnet has a **Deny** rule with a higher priority. This rule stops traffic to some endpoints.

AKS doesn't modify the egress rules in an NSG. If AKS uses a custom NSG, verify that it allows egress traffic for the endpoints on the correct port and protocol. To ensure that the AKS cluster functions as expected, verify that the egress for custom NSGs allows [Required outbound network rules for AKS clusters](/azure/aks/outbound-rules-control-egress).

Custom NSGs can directly affect the egress traffic by blocking the outbound rules. They can also affect egress traffic indirectly. For more information, see [A custom network security group blocks traffic](./custom-nsg-blocks-traffic.md).