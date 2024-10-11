---
title: Improve container image pull performance in Azure Kubernetes Service
description: Describes how to improve the performance of parallel or serialized image pulls in Azure Kubernetes Service.
ms.reviewer: slibbing, schaffererin, v-weizhu
ms.service: azure-kubernetes-service
ms.topic: how-to
ms.custom: sap:Node/node pool availability and performance
ms.date: 09/14/2024
---

# Improve container image pull performance in Azure Kubernetes Service

This article provides methods to improve container image pull performance in Azure Kubernetes Service (AKS).

## Serialized and parallel image pulls

There are two types of container image pulls: serialized and parallel image pulls.

In AKS versions earlier than 1.31, AKS enables serialized image pulls by default. Typically, serialized image pulls should be less performant than parallel image pulls. Starting from AKS version 1.31 preview, AKS pulls container images in parallel by default. This change is intended to improve container image pull performance, especially when you deal with large or numerous container images. However, you might still experience decreased performance compared to using serialized image pulls.

## Improve image pull performance in AKS versions earlier than 1.31

Upgrade to AKS 1.31 to switch from serialized image pulls to parallel image pulls. Parallel image pulls generally improve image pull performance.

## Improve image pull performance in AKS 1.31 and later versions

If you notice that parallel image pulls increase the latency of operations compared to serialized image pulls, try one or more methods below to improve performance:

- [Use ephemeral OS disks](#use-ephemeral-os-disks)
- [Increase the size of the OS disk](#increase-the-size-of-the-vm-sku)
- [Use newer VM SKUs](#use-newer-vm-skus)
- [Increase the size of the VM SKU](#increase-the-size-of-the-vm-sku)
- [Switch back to serialized image pulls](#switch-back-to-serialized-image-pulls)

### Use ephemeral OS disks

Change from managed operating system (OS) disks to ephemeral OS disks to reduce disk throughput bottlenecks in image pulls. Ephemeral OS disks provide a dynamic amount of available IOPS, allowing them to scale based on your workload requirements.

### Increase the size of the OS disk

Increase the size of your OS disk to reduce a disk throughput bottleneck in image pulling. Larger managed OS disks increase the available disk bandwidth.

### Use newer VM SKUs

Switch to newer hardware generation virtual machine (VM) stock keeping units (SKUs), such as the V4 and V5 series. This can reduce CPU bottlenecks in image pulling. Newer VM SKUs provide a more performant experience across storage and network throughput.

### Increase the size of the VM SKU

Increase the available CPU cores on your VM SKU to reduce a CPU bottleneck in image pulling. Allocating more cores helps avoid throttling on the VM.

### Switch back to serialized image pulls

Contact support and request to switch back to serialized image pulls.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
