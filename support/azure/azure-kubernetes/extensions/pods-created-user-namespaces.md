---
title: Pods are created in the user namespaces
description: Learn why AKS allows pods in user namespaces with system-critical priority classes, and use this guide to confirm your cluster isn't at risk.
ms.date: 05/13/2024
author: mosbahmajed
ms.author: momajed
editor: v-jsitser
ms.reviewer: cssakscic, v-rekhanain, v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to learn why pods can be created in user namespaces so that I can be assured that there isn't a security risk to my Azure Kubernetes Service (AKS) cluster.
---
# Pods are created in user namespaces in AKS

## Summary

This article explains why AKS can create pods in user namespaces when system-critical priority classes are used, and clarifies why this behavior isn't a security risk.

## Symptoms

When you use the Azure Policy Add-on for AKS and try to create pods by adding the `system-cluster-critical` and `system-node-critical` priority class names in the pod manifests, AKS unexpectedly accepts these names and creates the pods in the user namespaces.

## Cause

This is expected behavior. The two system-critical priority classes, `system-cluster-critical` and `system-node-critical`, already exist in the system. Creating pods that have these priority class names in the pod manifests is allowed, even in user namespaces.

## Solution

No action is required. The ability to specify the `system-cluster-critical` and `system-node-critical` priority class names is user namespaces is intentional. This ability isn't a security risk by design.

If you have concerns about security, consider reviewing other aspects of your cluster's configuration to enhance security measures.

## Resources

- [Pod priority and preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/)

 
