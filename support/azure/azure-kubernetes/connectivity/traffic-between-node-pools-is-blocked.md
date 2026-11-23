---
title: Traffic between node pools is blocked by a custom NSG in AKS
description: Learn how to resolve traffic blocked between node pools by a custom network security group (NSG) in an AKS cluster, and restore DNS resolution.
ms.date: 11/04/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, rissing, v-leedennis, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to fix a scenario in which traffic between node pools is blocked by a network security group (NSG) so that I don't experience outbound connection issues from an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Connectivity
ai-usage: ai-assisted
---
# Traffic between node pools is blocked by a custom network security group in Azure Kubernetes Service

## Summary

This article helps you resolve traffic between node pools that a custom network security group (NSG) blocks in an Azure Kubernetes Service (AKS) cluster. Follow the steps to restore DNS resolution and pod communication.

## Symptoms

The Domain Name System (DNS) resolution from pods of the user node pool fails.

## Background

In scenarios that involve multiple node pools, you can put the pods in the `kube-system` namespace on one node pool (the system node pool) while you put the application pods on a different node pool (the user node pool). In some scenarios, pods that communicate with one another are in different node pools.

AKS lets you have [node pools in different subnets](/azure/aks/use-multiple-node-pools#add-a-node-pool-with-a-unique-subnet). By using this feature, you can also associate different NSGs with each node pool's subnet.

## Cause 1: The NSG of a node pool blocks inbound traffic

Inbound access on the NSG of a node pool blocks traffic. For example, a custom NSG on the system node pool (that hosts the core DNS pods) blocks inbound traffic on User Datagram Protocol (UDP) port 53 from the subnet of the user node pool.

:::image type="content" source="./media/traffic-between-node-pools-is-blocked/inbound-traffic-blocked.svg" alt-text="Screenshot of a custom NSG blocking inbound UDP 53 traffic between AKS user and system node pools." lightbox="./media/traffic-between-node-pools-is-blocked/inbound-traffic-blocked.svg" border="false":::

### Solution 1: Configure the custom NSG to allow traffic between the node pools

Make sure that your custom NSG allows the required traffic between the node pools, specifically on UDP port 53. AKS doesn't update the custom NSG that's associated with subnets.

## Cause 2: Outbound access on the NSG of a node pool blocks traffic

The NSG on another node pool blocks outbound access to the pod. For example, a custom NSG on the user node pool blocks outbound traffic on UDP port 53 to the system node pool.

:::image type="content" source="./media/traffic-between-node-pools-is-blocked/outbound-traffic-blocked.svg" alt-text="Screenshot of a custom NSG blocking outbound UDP 53 traffic from an AKS user node pool to a system node pool." lightbox="./media/traffic-between-node-pools-is-blocked/outbound-traffic-blocked.svg" border="false":::

### Solution 2: Configure the custom NSG to allow traffic between the node pools

For more information, see [Solution 1: Configure the custom NSG to allow traffic between the node pools](#solution-1-configure-the-custom-nsg-to-allow-traffic-between-the-node-pools).

## Cause 3: TCP port 10250 is blocked

Another common scenario is that Transmission Control Protocol (TCP) port 10250 is blocked between the node pools.

In this situation, a user might receive an error message that resembles the following text.

```console
$ kubectl logs nginx-57cdfd6dd9-xb7hk
Error from server: Get https://<node>:10250/containerLogs/default/nginx-57cdfd6dd9-xb7hk/nginx: net/http: TLS handshake timeout
```

If the communication on TCP port 10250 is blocked, the connection to the Kubelet is affected, and the logs aren't fetched.

### Solution 3: Check for NSG rules that block TCP port 10250

Check whether any NSG rules block node-to-node communication on TCP port 10250.

 
