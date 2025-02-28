---
title: Take basic troubleshooting steps to avoid Node Not Ready issues
description: Learn about basic troubleshooting steps to avoid Node Not Ready issues in Azure Kubernetes Service (AKS) cluster nodes.
ms.date: 09/26/2024
ms.reviewer: rissing, chiragpa, momajed, v-leedennis, wonkilee, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to take basic troubleshooting steps so that I can avoid Node Not Ready issues in Azure Kubernetes Service (AKS) cluster nodes.
ms.custom: sap:Node/node pool availability and performance
---
# Basic troubleshooting of Node Not Ready failures

This article provides troubleshooting steps to recover Microsoft Azure Kubernetes Service (AKS) cluster nodes after a failure. This article specifically addresses the most common error messages that are generated when a Node Not Ready failure occurs, and explains how node repair functionality can be done for both Windows and Linux nodes.

## Before you begin

Read the [official guide for troubleshooting Kubernetes clusters](https://kubernetes.io/docs/tasks/debug/debug-cluster/_print/). Also, read the [Microsoft engineer's guide to Kubernetes troubleshooting](https://github.com/feiskyer/kubernetes-handbook/blob/master/en/troubleshooting/index.md). This guide contains commands for troubleshooting pods, nodes, clusters, and other features.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.31 or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

## Basic troubleshooting

AKS continuously monitors the health state of worker nodes, and [automatically repairs](/azure/aks/node-auto-repair) the nodes if they become unhealthy. The Azure Virtual Machine (VM) platform [maintains VMs](/azure/virtual-machines/maintenance-and-updates) that experience issues. AKS and Azure VMs work together to reduce service disruptions for clusters.

For nodes, there are two forms of heartbeats:

- Updates to the *.status* of a `Node` object.

- [Lease](https://kubernetes.io/docs/reference/kubernetes-api/cluster-resources/lease-v1/) objects within the [kube-node-lease](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) namespace. Each `Node` has an associated `Lease` object.

Compared to updates to the *.status* of a `Node`, a `Lease` is a lightweight resource. Using `Lease` objects for heartbeats reduces the performance impact of these updates for large clusters.

The [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) is responsible for creating and updating the *.status* for `Node` objects. It's also responsible for updating the `Lease` objects that are related to the `Node` objects.

- The kubelet updates the node `.status` when there's a change in status or if there has been no update for a configured interval. The default interval for `.status` updates to nodes is five minutes, which is much longer than the 40-second default time-out for unreachable nodes.
- The kubelet creates and then updates its `Lease` object every 10 seconds (the default update interval). `Lease` updates occur independently from updates to the node `.status`. If the `Lease` update fails, the kubelet retries, using an exponential backoff that starts at 200 milliseconds and is capped at seven seconds.

You can't schedule a pod on a node that has a status of `NotReady` or `Unknown`. You can schedule a pod only on nodes that are in the `Ready` state.

If your node is in the `MemoryPressure`, `DiskPressure`, or `PIDPressure` state, you must manage your resources in order to schedule extra pods on the node. If your node is in `NetworkUnavailable` mode, you must configure the network on the node correctly. 

AKS manages the lifecycle and operations of agent nodes for you. Modifying the IaaS resources associated with the agent nodes isn't supported. For example, customizing a node through SSH connections, updating packages, or changing the network configuration on a node isn't supported. For more information, see [AKS support coverage for agent nodes](/azure/aks/support-policies#user-customization-of-agent-nodes).

Make sure that the following conditions are met:

- Your cluster is in **Succeeded (Running)** state. To check the cluster status on the [Azure portal](https://portal.azure.com), search for and select **Kubernetes services**, and select the name of your AKS cluster. Then, on the cluster's **Overview** page, look in **Essentials** to find the **Status**. Or, enter the [az aks show](/cli/azure/aks#az-aks-show) command in Azure CLI.

  :::image type="content" source="./media/node-not-ready-basic-troubleshooting/aks-cluster-overview-page-essentials-status.png" alt-text="Azure portal screenshot of an Azure Kubernetes Service (A K S) cluster Overview page. In the Essentials section, the Status is 'Succeeded (Running)'." border="true":::

- Your node pool has a **Provisioning state** of **Succeeded** and a **Power state** of **Running**. To check the node pool status on the Azure portal, return to your AKS cluster's page, and then select **Node pools**. Alternatively, enter the [az aks nodepool show](/cli/azure/aks/nodepool#az-aks-nodepool-show) command in Azure CLI.

  :::image type="content" source="./media/node-not-ready-basic-troubleshooting/aks-cluster-node-pools.png" alt-text="Azure portal screenshot of an Azure Kubernetes Service (A K S) cluster Node pools. The Provisioning state is Succeeded. The Power state is Running." border="true":::

- The required egress ports are open in your network security groups (NSGs) and firewall so that the API server's IP address can be reached. For more information, see [Required outbound network rules and FQDNs for AKS clusters](/azure/aks/limit-egress-traffic#required-outbound-network-rules-and-fqdns-for-aks-clusters).

- Your nodes [have deployed the latest node images](/azure/aks/node-image-upgrade).

- Your nodes are in the `Running` state instead of `Stopped` or `Deallocated`.

- Your cluster is running an [AKS-supported version of Kubernetes](/azure/aks/supported-kubernetes-versions).

## More information

To troubleshoot the `Not Ready` status of a node, see [Troubleshoot a change in a healthy node to Not Ready status](node-not-ready-after-being-healthy.md).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
