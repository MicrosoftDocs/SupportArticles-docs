---
title: Identify CPU saturation in AKS clusters
description: Identify and resolve issues causing excessive Linux kernel memory usage in pods
ms.date: 05/10/2025
ms.reviewer: claudiogodoy, 
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot High Linux Kernel Memory Consumption on Pods

Some Kernel operations might increase the memory consumption of a given `pod` which can lead to a lot of problems such as `node` availability issues. High memory consumption is a common problem that the [Azure Kubernetes Service (AKS)](/azure/aks/intro-kubernetes) cluster administrators are always aware.

This article helps you identify when the some *Kernel behavior* leads to a high memory consumption patter on a `pod`.

