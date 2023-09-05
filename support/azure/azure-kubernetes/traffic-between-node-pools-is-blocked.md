---
title: Traffic between node pools is blocked by a custom NSG
description: Resolve blocked traffic between node pools by a custom network security group (NSG) within an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/04/2022
ms.reviewer: chiragpa, rissing, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-outbound-connections
#Customer intent: As an Azure Kubernetes user, I want to fix a scenario in which traffic between node pools is blocked by a network security group (NSG) so that I don't experience outbound connection issues from an Azure Kubernetes Service (AKS) cluster.
---
# Traffic between node pools is blocked by a custom network security group

This article discusses how to resolve a scenario in which a custom network security group (NSG) blocks traffic between node pools in a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

The Domain Name System (DNS) resolution from pods of the User node pool fails.

## Background

In scenarios that involve multiple node pools, the pods in the `kube-system` namespace can be put on one node pool (the System node pool) while the application pods are put on a different node pool (the User node pool). In some scenarios, pods that communicate with one another can be in different node pools.

AKS lets customers have [node pools in different subnets](/azure/aks/use-multiple-node-pools#add-a-node-pool-with-a-unique-subnet). This feature means that customers can also associate different NSGs with each node pool's subnet.

## Cause 1: The NSG of a node pool blocks inbound traffic

Inbound access on the NSG of a node pool blocks traffic. For example, a custom NSG on the System node pool (that hosts the core DNS pods) blocks inbound traffic on User Datagram Protocol (UDP) port 53 from the subnet of the User node pool.

:::image type="content" source="./media/traffic-between-node-pools-is-blocked/inbound-traffic-blocked.svg" alt-text="Diagram of a custom network security group that blocks inbound traffic on UDP port 53 in the User node pool of an Azure Kubernetes Service cluster." lightbox="./media/traffic-between-node-pools-is-blocked/inbound-traffic-blocked.svg" border="false":::

### Solution 1: Configure the custom NSG to allow traffic between the node pools

Make sure that your custom NSG allows the required traffic between the node pools, specifically on UDP port 53. AKS won't update the custom NSG that's associated with subnets.

## Cause 2: Outbound access on the NSG of a node pool blocks traffic

The NSG on another node pool blocks outbound access to the pod. For example, a custom NSG on the User node pool blocks outbound traffic on UDP port 53 to the System node pool.

:::image type="content" source="./media/traffic-between-node-pools-is-blocked/outbound-traffic-blocked.svg" alt-text="Diagram of a custom network security group that blocks outbound traffic on UDP port 53 in the System node pool of an Azure Kubernetes Service cluster." lightbox="./media/traffic-between-node-pools-is-blocked/outbound-traffic-blocked.svg" border="false":::

### Solution 2: Configure the custom NSG to allow traffic between the node pools

See [Solution 1: Configure the custom NSG to allow traffic between the node pools](#solution-1-configure-the-custom-nsg-to-allow-traffic-between-the-node-pools).

## Cause 3: TCP port 10250 is blocked

Another common scenario is that Transmission Control Protocol (TCP) port 10250 is blocked between the node pools.

In this situation, a user might receive an error message that resembles the following text:

```console
$ kubectl logs nginx-57cdfd6dd9-xb7hk
Error from server: Get https://<node>:10250/containerLogs/default/nginx-57cdfd6dd9-xb7hk/nginx: net/http: TLS handshake timeout
```

If the communication on TCP port 10250 is blocked, the connection to the Kubelet will be affected, and the logs won't be fetched.

### Solution 3: Check for NSG rules that block TCP port 10250

Check whether any NSG rules block node-to-node communication on TCP port 10250.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
