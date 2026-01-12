---
title: Troubleshoot Pods Remain in a Pending State Scenario
description: This article helps you troubleshoot the pods remain in a Pending state scenario.
ms.date: 01/12/2026
ms.author: jarrettr
ms.editor: v-jsitser
ms.reviewer: chiragpa, rorylen, v-ryanberg 
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the pods remain in a Pending state scenario in Azure Kubernetes Service (AKS).
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---

# Troubleshoot pods remain in a Pending state scenario

This article helps you troubleshoot the pods remain in a **Pending** state scenario.

## Symptoms

You run `kubectl describe pod` for a pod and the pod remains in a **Pending** state. The **Event** section displays **pod didn't trigger scale-up (it wouldn't fit if a new node is added)** and the cluster-autoscaler doesn’t scale up the node count.

## Cause

This indicates one or more of the following:

- Even if a new node was added by the cluster-autoscaler, the pod can’t be placed on the new node due to the pod's resource requests exceeding the maximum resources available on the node.

- The node might be missing a resource which the pod requires (like a Graphics Processing Unit (GPU)).

- The pod has affinity or topology constraints and a new node doesn’t meet these requirements.

## Resolution

Review the pod resource request configuration (for example CPU, memory, or GPU) and compare it with the node size. You might need to adjust the node size or type or adjust the resource request configuration for the pod to ensure that pod placement can occur.

If you rule out a resource constraint, ensure node affinity or taints aren’t preventing scheduling.
