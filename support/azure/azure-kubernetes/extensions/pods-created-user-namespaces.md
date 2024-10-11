---
title: Pods are created in the user namespaces
description: Troubleshoot a security risk scenario in which pods can be created in the user namespaces in Azure Kubernetes Service (AKS).
ms.date: 05/13/2024
author: mosbahmajed
ms.author: momajed
editor: v-jsitser
ms.reviewer: cssakscic, v-rekhanain, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure Kubernetes user, I want to learn why pods can be created in user namespaces so that I can be assured that there isn't a security risk to my Azure Kubernetes Service (AKS) cluster.
---
# Pods are created in the user namespaces

This article discusses a scenario in which pods in Microsoft Azure Kubernetes Service (AKS) are created in the user namespaces. This scenario is generally considered to be a security risk.

## Symptoms

When you use the Azure Policy Add-on for AKS and try to create pods by adding the `system-cluster-critical` and `system-node-critical` priority class names in the pod manifests, AKS unexpectedly accepts these names and creates the pods in the user namespaces.

## Cause

This is expected behavior. The two system-critical priority classes, `system-cluster-critical` and `system-node-critical`, already exist in the system. Creating pods that have these priority class names in the pod manifests is allowed, even in user namespaces.

## Solution

No action is required. The ability to specify the `system-cluster-critical` and `system-node-critical` priority class names is user namespaces is intentional. This ability isn't a security risk by design.

If you have concerns about security, consider reviewing other aspects of your cluster's configuration to enhance security measures.

## Resources

- [Pod priority and preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
