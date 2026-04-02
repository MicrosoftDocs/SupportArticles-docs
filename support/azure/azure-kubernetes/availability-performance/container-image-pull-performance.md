---
title: Improve container image pull performance in Azure Kubernetes Service
description: Learn how to improve container image pull performance in AKS for parallel or serialized pulls, reduce latency, and optimize node startup. Get started now.
ms.reviewer: slibbing, schaffererin, v-weizhu
ms.service: azure-kubernetes-service
ms.topic: how-to
ms.custom: sap:Node/node pool availability and performance
ms.date: 09/14/2024
---

# Improve container image pull performance in Azure Kubernetes Service (AKS)

## Summary

This article provides methods to improve container image pull performance in Azure Kubernetes Service (AKS).

## Compare serialized and parallel image pulls

Two types of container image pulls exist: serialized and parallel image pulls.

In AKS versions earlier than 1.31, AKS enables serialized image pulls by default. Starting in AKS version 1.31 preview, AKS pulls container images in parallel by default. Typically, serialized image pulls are less performant than parallel image pulls, particularly when the service tries to pull large or numerous container images.

However, you might still experience decreased performance when using parallel image pulls compared to using serial image pulls. Trying to pull large or numerous images in a parallel manner might throttle the disk. This throttling is especially true when you use unoptimized disk and VM resources. In this situation, you might notice that the time to pull the first images is faster in a serial setup, but the time to pull all images is faster in a parallel setup. Depending on your workload needs, consider using the following steps to scale your disk and VM resources or toggle the image pull type.

## Improve image pull performance in AKS versions earlier than 1.31

Upgrade to AKS 1.31 to switch from serialized image pulls to parallel image pulls. Parallel image pulls generally improve image pull performance.

## Improve image pull performance in AKS 1.31 and later versions

If you notice that parallel image pulls increase the latency of operations compared to serialized image pulls, try one or more methods in the following list to improve performance:

- [Use ephemeral OS disks](#use-ephemeral-os-disks)
- [Increase the size of the OS disk](#increase-the-size-of-the-vm-sku)
- [Use newer VM SKUs](#use-newer-vm-skus)
- [Increase the size of the VM SKU](#increase-the-size-of-the-vm-sku)
- [Toggle image pull type](#toggle-image-pull-type)

### Use ephemeral OS disks

Change from managed operating system (OS) disks to ephemeral OS disks to reduce disk throughput bottlenecks in image pulls. Ephemeral OS disks provide a dynamic amount of available IOPS, so they scale based on your workload requirements.

### Increase the size of the OS disk

Increase the size of your OS disk to reduce a disk throughput bottleneck in image pulling. Larger managed OS disks increase the available disk bandwidth.

### Use newer VM SKUs

Switch to newer hardware generation virtual machine (VM) stock keeping units (SKUs), such as the V4 and V5 series. This change reduces CPU bottlenecks in image pulling. Newer VM SKUs provide a more performant experience across storage and network throughput.

### Increase the size of the VM SKU

Increase the available CPU cores on your VM SKU to reduce a CPU bottleneck in image pulling. Allocating more cores helps avoid throttling on the VM.

### Toggle image pull type

Use the following AFEC flag instructions to toggle parallel images on or off. 

When you run `az feature list --namespace Microsoft.ContainerService`, you should see the following feature appear:

`
{
    "id": "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/providers/Microsoft.Features/providers/microsoft.ContainerService/features/DisableParallelImagePulls",
    "name": "microsoft.ContainerService/DisableParallelImagePulls",
    "properties": {
      "state": "NotRegistered"
    },
    "type": "Microsoft.Features/providers/features"
}
`

Register the feature on your Azure subscription by running the following command:

`az feature register --namespace Microsoft.ContainerService --name DisableParallelImagePulls`

Behavior expectation if the feature is registered:

- By default, upgrading any node pool or cluster to Kubernetes 1.31 from a version that's earlier than 1.31 causes serial image pulling. Upgrading in Kubernetes 1.31 or a later version causes parallel pulling.
- Node pools or clusters that are already running Kubernetes 1.31 but were created before the subscription registration initially use parallel image pulling. However, any subsequent node image upgrade or Kubernetes version upgrade causes the node pool or cluster to use serial image pulling.
- For any new clusters or node pools that are created or upgraded to Kubernetes versions earlier than 1.31, registering for this feature has no effect. This limitation exists because parallel image pulling applies only to versions 1.31 and later.
- Performing an empty `PUT` on existing Kubernetes 1.31 node pools or clusters (that were created before subscription registration) doesn't immediately switch parallel image pulling to serial pulling. To trigger the change, the node must undergo a reimage. A reimage occurs only during a Kubernetes or node image upgrade. However, the `PUT` operation updates the flag in the database, and the change takes effect during the next upgrade.

 
