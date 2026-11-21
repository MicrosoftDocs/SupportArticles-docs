---
title: Troubleshoot mixed multi-instance GPU (MIG) strategy node pool errors in AKS
description: Troubleshoot mixed MIG strategy node pool errors in AKS. Fix create and scale failures and pending pods with the steps in this guide.
ms.date: 11/20/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: sachidesai
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---

# Troubleshoot mixed multi-instance GPU (MIG) strategy node pool errors in Azure Kubernetes Service

## Summary

This article helps you troubleshoot mixed multi-instance GPU (MIG) strategy node pool errors in Azure Kubernetes Service (AKS). Use it to resolve node pool configuration errors and pod scheduling failures quickly.

MIG divides a physical NVIDIA GPU into isolated partitions. A *profile* defines a partition size. A *layout* is the list of partitions configured on each GPU. Mixed strategy lets workloads request different partition sizes from the same node pool.

## Identify MIG node pool failures

The following scenarios indicate common MIG node pool failures:

- **The node pool request fails.** Use the configuration error table in the next section. Read the validation message and, when available, the subcode to identify the cause.
- **The node pool exists, but a pod stays Pending.** Follow the guidance at [Resolve insufficient MIG resources](#resolve-insufficient-mig-resources).

## Resolve MIG node pool configuration errors

Correct the setting identified by the validation message, and then retry the failed create request. If you attempted to change an existing MIG node pool's layout, create a replacement MIG node pool instead.

The following table lists common MIG node pool configuration errors and their resolutions.

| Error subcode | Cause | Resolution |
| --- | --- | --- |
| `InvalidMIGProfileCountForSingleStrategy` | The `Single` strategy received a profile count other than one. | Supply exactly one entry in `--gpu-mig-profiles` for `Single`. To configure different sizes or multiple profile entries, use `Mixed` with a supported layout. |
| `ConflictingGpuInstanceProfile` | The request combines the legacy profile setting with the new profile list. | Remove `--gpu-instance-profile` when using `--gpu-mig-profiles`. In an API request or template, remove the legacy `gpuInstanceProfile` field when supplying `gpuProfile.nvidia.migProfiles`. |
| `MIGNotSupportedForVMSize` | The selected virtual machine (VM) size doesn't support this MIG configuration. | Select a size from the [supported GPU VM sizes](/azure/aks/multi-instance-gpu-overview#supported-gpu-vm-sizes). Not every GPU VM supports MIG. Confirm regional availability and quota before creating a replacement node pool. |
| `InvalidOrNoneMIGProfile` | A profile value is unsupported or is `None`. | Use `MIG1g`, `MIG2g`, `MIG3g`, `MIG4g`, or `MIG7g`, subject to the selected GPU's supported layout. Don't include `None`. To stop using MIG, create a replacement node pool without MIG settings. |
| `InvalidMIGProfileCombination` | The profiles don't form a valid layout for the selected GPU. | Choose a layout that satisfies that GPU's capacity and placement rules. Adding up compute slices or memory alone doesn't establish compatibility. Use a validated layout for your VM size. |
| `MIGProfilesRequired` | `Mixed` was selected without a nonempty profile list. | Supply `--gpu-mig-profiles` with at least one supported profile. Repeat an entry when the validated layout requires multiple partitions of that size. |
| `MIGProfilesNodeImageNotSupported` | The selected node image doesn't support the new profile-list configuration. | Use a supported AKS Linux node image based on Virtual Hard Disk (VHD) version `202609.01.0` or later. Windows isn't supported. If you explicitly pin the image in your deployment, select a supported version before retrying. |
| `PropertyChangeNotAllowed` | The request attempts to change an immutable MIG setting on an existing node pool. | Create a new node pool with the desired strategy and profiles. Migrate workloads and verify application health before deleting the old node pool. Don't update the strategy to `None` to disable MIG. |

### Example of a supported mixed layout

For `Standard_NC24ads_A100_v4`, the example layout `MIG3g MIG2g MIG1g MIG1g` provides one `3g.40gb`, one `2g.20gb`, and two `1g.10gb` partitions per node. Profile memory sizes depend on the NVIDIA GPU model; don't assume the same resource names apply to all GPU types.

After meeting the setup guide's prerequisites, create a new node pool with a unique name and run the following command.

```azurecli
az aks nodepool add \
  --resource-group "<resource-group>" \
  --cluster-name "<cluster-name>" \
  --name "<new-pool-name>" \
  --node-vm-size Standard_NC24ads_A100_v4 \
  --enable-managed-gpu=true \
  --gpu-mig-strategy Mixed \
  --gpu-mig-profiles MIG3g MIG2g MIG1g MIG1g \
  --node-count 1
```

This command creates MIG partitions on a new AKS node pool. It doesn't change an existing MIG node pool.

### Verify the node pool configuration

Inspect the affected node pool after creation, or when investigating an existing node pool with the following command.

```azurecli
az aks nodepool show \
  --resource-group "<resource-group>" \
  --cluster-name "<cluster-name>" \
  --name "<pool-name>" \
  --query "{state:provisioningState,image:nodeImageVersion,vmSize:vmSize,gpu:gpuProfile.nvidia}" \
  --output json
```

Confirm that the state is `Succeeded`, the image meets the minimum version, and the GPU settings show `managementMode: Managed`, `driverMode: DevicePlugin`, `migStrategy: Mixed`, and the intended `migProfiles` list, including repeated entries. If creation failed and no node pool exists, use the original request and validation message instead.

For an existing node pool with an older image, follow the setup guide's [node image maintenance steps](/azure/aks/mixed-gpu-multi-instance#scale-and-maintain-the-node-pool). Plan for workload disruption and replacement-node quota and capacity. Updating the image doesn't change the MIG layout.

## Resolve insufficient MIG resources

A pod with `Pending` status and an event such as `Insufficient nvidia.com/mig-3g.40gb` isn't scheduled because eligible nodes can't satisfy its request for that exact partition type.

Follow these steps to resolve insufficient MIG resources:

1. Inspect the pod's resource requests, node selector, affinity, tolerations, and scheduling events. Run the following command.

   ```bash
   kubectl describe pod "<pod-name>" --namespace "<namespace>"
   ```

1. Inspect the target pool's node readiness, labels, partition resources, and allocated requests. Run the following command.

   ```bash
   kubectl get nodes -l agentpool="<pool-name>" --show-labels
   kubectl describe nodes -l agentpool="<pool-name>"
   ```

1. Use the following table to match the findings to the appropriate action.

   | Finding | Action |
   | --- | --- |
   | The requested `nvidia.com/mig-*` name isn't advertised under `Allocatable`. | Use the exact name advertised by the nodes, if that partition meets your application's validated requirements, or create a node pool with the required layout. Mixed MIG node pools use profile-specific names, not the `nvidia.com/gpu` resource used by single-strategy pools. |
   | The resource exists, but eligible nodes have no remaining partitions of that type. | Compare `Allocatable` with scheduled pods' requests in `Allocated resources` on each node. Scale a node pool that already provides that profile, subject to quota and availability, or wait for existing workloads to release capacity. `Allocatable` is total schedulable GPU resources, not currently free capacity. |
   | The pod selects a different node pool or excludes suitable nodes. | Correct the workload's `agentpool` selector or affinity and ensure its tolerations match the intended node pool's taints. Check the latest scheduling events for CPU, host memory, or other constraints. |
   | Nodes aren't in a `Ready` state or advertise no expected MIG resources. | Check node conditions and the node pool configuration above. If settings are correct but resources remain absent, collect the evidence in the following section for support. Don't install a second device plugin or modify AKS-managed GPU components as a workaround. |

Kubernetes doesn't combine smaller partitions into a larger one. Scaling a node pool adds only its configured partition types. For example, scaling the sample node pool doesn't satisfy a request for `nvidia.com/mig-4g.40gb`, because that resource isn't in its layout. A single pod's request must fit on one eligible node; GPU resources across nodes aren't combined.

After correcting the workload or node configuration, rerun `kubectl describe pod` and check its current status and latest events. A long-running workload should start running, while a short job might already have completed. New image or container errors require separate investigation.