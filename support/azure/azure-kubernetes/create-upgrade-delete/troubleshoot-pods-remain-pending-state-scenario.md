---
title: Troubleshoot Pods Remain in a Pending State Scenario
description: This article helps you troubleshoot a scenario in which pods remain in a pending state.
ms.date: 01/12/2026
ms.author: jarrettr
ms.editor: v-jsitser
ms.reviewer: chiragpa, rorylen, v-ryanberg 
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot a scenario in which pods remain in the Pending state in Azure Kubernetes Service (AKS).
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---

# Troubleshoot pods that remain in the Pending state

This article helps you troubleshoot a scenario in which pods remain in the **Pending** state.

## Symptoms

You run `kubectl describe pod` for a pod, and the pod remains in the **Pending** state. When this issue occurs, the **Event** section displays **pod didn't trigger scale-up (it wouldn't fit if a new node is added)**. Additionally, the cluster-autoscaler doesn’t scale up the node count.

## Cause

These symptoms indicate one or more of the following situations:

- Even if the cluster-autoscaler adds a node, the pod can’t be put onto the new node. This condition occurs because the pod's resource requests exceed the maximum resources that are available on the node.

- The node is missing a resource that the pod requires (such as a Graphics Processing Unit (GPU)).

- The pod has affinity or topology constraints, and the new nodes don’t meet these requirements.

## Resolution

Review the pod resource request configuration (for example CPU, memory, or GPU), and compare it with the node size. To make sure that pod placement can occur, you might have to adjust the node size or type, or adjust the resource request configuration for the pod.

If you rule out a resource constraint, make sure that affinity or taints aren't preventing scheduling.
