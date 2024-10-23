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

In AKS versions earlier than 1.31, AKS enables serialized image pulls by default. Starting from AKS version 1.31 preview, AKS pulls container images in parallel by default. Typically, serialized image pulls should be less performant than parallel image pulls, particularly when attempting to pull large or numerous container images.

However, you might still experience decreased performance with parallel compared to using serial image pulls. There is possibility to throttle the disk when trying to pull large or numerous images in parallel fashion, especially with unoptimized disk and VM resources. In this situation, you may notice that the time to complete the pull of the first images is faster with serial, but the time to pull all images is faster with parallel. Depending on your workload needs, consider following the steps below to scale your disk and VM resources or toggle the image pull type.

## Improve image pull performance in AKS versions earlier than 1.31

Upgrade to AKS 1.31 to switch from serialized image pulls to parallel image pulls. Parallel image pulls generally improve image pull performance.

## Improve image pull performance in AKS 1.31 and later versions

If you notice that parallel image pulls increase the latency of operations compared to serialized image pulls, try one or more methods below to improve performance:

- [Use ephemeral OS disks](#use-ephemeral-os-disks)
- [Increase the size of the OS disk](#increase-the-size-of-the-vm-sku)
- [Use newer VM SKUs](#use-newer-vm-skus)
- [Increase the size of the VM SKU](#increase-the-size-of-the-vm-sku)
- [Toggle image pull type](#toggle-image-pull-type)

### Use ephemeral OS disks

Change from managed operating system (OS) disks to ephemeral OS disks to reduce disk throughput bottlenecks in image pulls. Ephemeral OS disks provide a dynamic amount of available IOPS, allowing them to scale based on your workload requirements.

### Increase the size of the OS disk

Increase the size of your OS disk to reduce a disk throughput bottleneck in image pulling. Larger managed OS disks increase the available disk bandwidth.

### Use newer VM SKUs

Switch to newer hardware generation virtual machine (VM) stock keeping units (SKUs), such as the V4 and V5 series. This can reduce CPU bottlenecks in image pulling. Newer VM SKUs provide a more performant experience across storage and network throughput.

### Increase the size of the VM SKU

Increase the available CPU cores on your VM SKU to reduce a CPU bottleneck in image pulling. Allocating more cores helps avoid throttling on the VM.

### Toggle image pull type

Use the following AFEC flag instructions to toggle parallel image on or off. 

When you run az feature list --namespace Microsoft.ContainerService, you should see the following feature appear:

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

You can register to the feature as follows:

`az feature register --namespace Microsoft.ContainerService --name DisableParallelImagePulls`

Behavior expectation if a subscription is registered to the feature:

- Upgrading any nodepool or cluster to Kubernetes 1.31 from a version below 1.31 will result in serial image pulling, in contrast to the parallel pulling default in Kubernetes 1.31 and above.
- Nodepools or clusters already running Kubernetes 1.31, but created before the subscription registration, will initially have parallel image pulling. However, any subsequent node image upgrade or Kubernetes version upgrade will switch the nodepool/cluster to serial image pulling.
- For any new clusters or nodepools created or upgraded to Kubernetes versions below 1.31, registering for this feature will have no effect as parallel image pulling only applies to versions 1.31 and above.
- Performing an empty PUT on existing Kubernetes 1.31 nodepools or clusters (created before subscription registration) will not immediately switch parallel image pulling to serial pulling. To trigger the change, the node must undergo a reimage, which only happens during a Kubernetes or node image upgrade. However, the PUT operation will update the flag in the database, and the change will take effect during the next upgrade.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
