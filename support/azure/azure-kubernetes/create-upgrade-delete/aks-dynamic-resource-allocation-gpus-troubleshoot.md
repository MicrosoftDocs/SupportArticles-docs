---
title: Troubleshoot managed GPU nodes with dynamic resource allocation (DRA) in AKS
description: Diagnose managed GPU DRA configuration, node provisioning, claim allocation, and container GPU access failures in AKS.
ms.date: 11/24/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: sachidesai, wangamanda
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---

# Troubleshoot errors when you create a managed GPU node pool with DRA on Azure Kubernetes Service

This article helps you diagnose configuration, provisioning, scheduling, and NVIDIA GPU access failures when using managed GPU dynamic resource allocation (DRA) in Azure Kubernetes Service (AKS).

With DRA, workloads request GPUs through Kubernetes objects called resource claims rather than requesting only a GPU count. Kubernetes uses each claim's requirements to select a suitable GPU while deciding which node should run the pod. This selection is called allocation; after allocation, the node must prepare the selected GPU and make it accessible to the containers that need it.

The following objects appear throughout this guide:

- A `DeviceClass` defines which devices are suitable for a request, using selection rules called selectors.
- A `ResourceClaim` describes the devices a workload needs and records the devices Kubernetes allocates to it. A pod must reference the claim, and each container that needs GPU access must also reference it.
- A `ResourceClaimTemplate` lets Kubernetes create a separate resource claim for each pod, which is useful when several replicas need independent GPUs.
- A `ResourceSlice` describes GPU devices discovered by the DRA driver and associates them with nodes. It provides device inventory, but it doesn't indicate whether those devices are currently free.

AKS runs the NVIDIA DRA driver as a service directly on the node, you don't need to find a DRA DaemonSet, a Kubernetes component that runs a pod on each eligible node, to confirm that the managed driver is installed.

> [!IMPORTANT]
> Managed GPU DRA is in preview, so review the [feature prerequisites, limitations, and preview support terms](/azure/aks/managed-dra-for-gpus) before making configuration changes. Because AKS manages the GPU components, installing another NVIDIA DRA driver or device plugin, replacing driver packages, or editing managed service configuration can introduce conflicts and shouldn't be used as a troubleshooting workaround.

## Before you begin

Before starting, make sure that you meet the following requirements:

- You have Azure CLI installed with the `aks-preview` extension version `22.0.0b6` or later.
- Your AKS cluster and target node pool run Kubernetes `1.35` or later, and the `ManagedGPUExperiencePreview` feature is registered for the Azure subscription.
- Your account is authorized to read the cluster and node pool configuration, and `kubectl` is connected to the affected cluster with permission to inspect nodes, pods, events, and DRA resources. Access to `DeviceClass` and `ResourceSlice` requires cluster-level permissions because these objects aren't limited to a namespace.

Replace the placeholders in the following sections with the names of the affected resources before running the commands. You only need to set the variables used by the section you're following; for example, configuration checks don't require a pod or claim name. If your workload uses a `ResourceClaimTemplate`, Kubernetes generates the claim name, and the pending-pod section explains where to find it.

```bash
export SUBSCRIPTION_ID="<subscription-id>"
export RESOURCE_GROUP="<resource-group>"
export CLUSTER_NAME="<cluster-name>"
export POOL_NAME="<node-pool-name>"
export GPU_NAMESPACE="<workload-namespace>"
export POD_NAME="<pod-name>"
export CLAIM_NAME="<resource-claim-name>"
export DEVICE_CLASS_NAME="<device-class-name>"
export NODE_NAME="<affected-node-name>"
```

Begin with the read-only checks so that you can understand the failure before changing resources.

## Identify the failure stage

Use the following table to find the section that best matches your symptom. If you're unsure where the failure occurs, start with the node pool configuration and node health checks before moving on to claims and containers. Pod events, which you can view with `kubectl describe pod`, often explain why Kubernetes can't schedule or start a workload.

| Symptom | Start with |
| --- | --- |
| Azure CLI rejects a command before sending the request. | Follow [Resolve configuration errors](#resolve-configuration-errors) to check the extension and supported command options. |
| The Azure service rejects the node pool request. | Follow [Resolve configuration errors](#resolve-configuration-errors) to interpret the validation message and check the settings Azure accepted. |
| Node pool provisioning fails, or a node isn't Ready. | Follow [Resolve provisioning and node health failures](#resolve-provisioning-and-node-health-failures) to check whether the nodes were created successfully and are healthy. |
| Nodes are Ready, but their GPUs don't appear in ResourceSlices. | Follow [Resolve missing GPU inventory](#resolve-missing-gpu-inventory) to check whether the driver discovered and published the devices. |
| A pod stays Pending, or Kubernetes hasn't selected devices for its claim. | Follow [Resolve pending pods and unallocated claims](#resolve-pending-pods-and-unallocated-claims) to check device requirements and pod placement constraints. |
| A claim is allocated, but the container fails to start or access its GPU. | Follow [Resolve container startup and GPU access failures](#resolve-container-startup-and-gpu-access-failures) to check how the selected GPU is made accessible to the container. |
| A GPU health or monitoring alert fires without an obvious workload failure. | Follow [Investigate monitoring alerts](#investigate-monitoring-alerts) to determine whether the alert reflects a DRA failure or an outdated monitoring assumption. |

## Resolve configuration errors

Run the following commands to check your tools, confirm preview feature registration, and inspect the configuration Azure accepts for the node pool:

```azurecli
az version
az extension show --name aks-preview \
  --query '{name:name,version:version}' --output json
az aks nodepool add --help
az aks nodepool update --help

az feature show \
  --subscription "$SUBSCRIPTION_ID" \
  --namespace Microsoft.ContainerService \
  --name ManagedGPUExperiencePreview \
  --query properties.state --output tsv

az aks show \
  --subscription "$SUBSCRIPTION_ID" \
  --resource-group "$RESOURCE_GROUP" \
  --name "$CLUSTER_NAME" \
  --query '{id:id,location:location,kubernetesVersion:kubernetesVersion}' \
  --output json

az aks nodepool show \
  --subscription "$SUBSCRIPTION_ID" \
  --resource-group "$RESOURCE_GROUP" \
  --cluster-name "$CLUSTER_NAME" \
  --name "$POOL_NAME" \
  --query '{id:id,provisioningState:provisioningState,kubernetesVersion:orchestratorVersion,osType:osType,osSKU:osSKU,vmSize:vmSize,nodeImageVersion:nodeImageVersion,gpuProfile:gpuProfile}' \
  --output json
```

For a successfully provisioned managed DRA node pool, the output shows `provisioningState: Succeeded`, `gpuProfile.driver: Install`, `gpuProfile.nvidia.managementMode: Managed`, and `gpuProfile.nvidia.driverMode: DRA`. Together, these values indicate that Azure completed the node pool operation and configured AKS-managed GPU installation with DRA as the allocation mode. The feature registration check also returns `Registered`.

If the create request fails before Azure creates a node pool, inspect the original command or deployment template and response.

| Finding | Corrective action |
| --- | --- |
| `aks-preview` is missing, outdated, or doesn't expose the DRA option in command help. | Follow the [feature setup instructions](/azure/aks/managed-dra-for-gpus#set-environment-variables-and-prepare-your-azure-subscription) to install or update the extension, then confirm that command help lists the DRA option. The alias `--managed-gpu-driver-mode` is also accepted. |
| The feature isn't registered, or Kubernetes version is older than `1.35`. | Complete the feature and resource provider registration steps, or plan a supported cluster and node pool upgrade, as described in the feature guide. |
| The command selects DRA without explicitly enabling managed GPU. | When creating a new node pool, specify both `--enable-managed-gpu=true` and `--gpu-driver-mode DRA`, because selecting DRA doesn't enable managed GPU automatically. |
| The pool reports `DevicePlugin`. | Check whether the original request omitted the driver mode, which defaults to `DevicePlugin`. This mode uses GPU requests such as `nvidia.com/gpu` rather than DRA claims, so migration requires a separate DRA node pool and updated workload manifests. |
| The configuration uses `AzureContainerLinux`, node auto provisioning (NAP), or cluster autoscaler. | Choose a configuration that meets the [current DRA limitations](/azure/aks/managed-dra-for-gpus#limitations). |

## Resolve provisioning and node health failures

After checking the node pool provisioning state in the previous section, use the following commands to find the pool's nodes and inspect their health. Set `NODE_NAME` to an affected node from the list before running the final command.

```bash
kubectl version -o yaml
kubectl get nodes -l "kubernetes.azure.com/agentpool=$POOL_NAME" -o wide
kubectl describe nodes -l "kubernetes.azure.com/agentpool=$POOL_NAME"
kubectl get node "$NODE_NAME" -o yaml
```

All expected nodes should have a status of `Ready`, which means that Kubernetes considers them available to run workloads. If a node isn't Ready, review the conditions and recent events in its description for networking, disk pressure, or kubelet failures.

If the Azure operation failed, inspect the node pool operation in the [Azure Activity Log](/azure/azure-monitor/platform/activity-log) and save its status message, timestamp, operation ID, and correlation ID. These details help distinguish GPU setup problems from failures caused by subscription quota or regional GPU availability. Quota and capacity failures must be resolved before Azure can create the required nodes, so changing workload claims won't address them.

## Resolve missing GPU inventory

Before Kubernetes can allocate a GPU, the DRA driver must discover the device and publish its details in a ResourceSlice. The following commands check whether your cluster supports the required Kubernetes resource types and whether the driver has published any devices:

```bash
kubectl api-resources --api-group=resource.k8s.io --output wide
kubectl explain resourceclaim.spec.devices.requests.exactly \
  --api-version=resource.k8s.io/v1
kubectl get resourceslices.resource.k8s.io \
  -o custom-columns='NAME:.metadata.name,DRIVER:.spec.driver,POOL:.spec.pool.name,NODE:.spec.nodeName'
kubectl get resourceslices.resource.k8s.io -o yaml
```

The API listing should include `DeviceClass`, `ResourceClaim`, and `ResourceSlice`. In the ResourceSlice output, look for entries whose `DRIVER` is `gpu.nvidia.com` and whose `NODE` matches a node in your affected AKS node pool. The `POOL` column identifies a group of devices managed by the DRA driver, so its value doesn't necessarily match your AKS node pool name.

- If the DRA resource types aren't listed, recheck the cluster version and documented prerequisites to confirm that the cluster supports them.

Although ResourceSlices show which devices the driver discovered, they don't show whether another workload is already using them. DRA also doesn't rely on the allocatable `nvidia.com/gpu` count used by the older device-plugin allocation method, so the absence of that count doesn't, by itself, indicate a DRA failure.

## Resolve pending pods and unallocated claims

A pod can remain pending when Kubernetes can't find a node that satisfies both the GPU claim and the pod's other requirements. Use the following commands to inspect the pod that references the claim, the claim itself, and the DeviceClass that defines which GPUs are suitable. If the workload uses a `ResourceClaimTemplate`, first inspect the pod's `status.resourceClaimStatuses` field to find the generated claim name and use that value for `CLAIM_NAME`.

```bash
kubectl -n "$GPU_NAMESPACE" describe pod "$POD_NAME"
kubectl -n "$GPU_NAMESPACE" get pod "$POD_NAME" -o yaml
kubectl -n "$GPU_NAMESPACE" describe resourceclaim "$CLAIM_NAME"
kubectl -n "$GPU_NAMESPACE" get resourceclaim "$CLAIM_NAME" -o yaml
kubectl get deviceclass "$DEVICE_CLASS_NAME" -o yaml
kubectl -n "$GPU_NAMESPACE" get events --sort-by=.metadata.creationTimestamp
kubectl get resourceclaims.resource.k8s.io --all-namespaces -o yaml
```

The final command lists claims across all namespaces so that a cluster administrator can check whether other workloads already hold the matching GPUs. If you don't have permission to read across namespaces, omit that command and ask an administrator to investigate device availability. Treat the results as potentially sensitive because claim manifests, which are YAML definitions of the resources, and events can reveal workload information.

| Finding | Corrective action |
| --- | --- |
| The claim exists but no pod references it. | Create the intended workload before treating the empty allocation as a failure, because Kubernetes can wait until a pod needs the claim before selecting a device. |
| The claim is missing, or a named claim is in a different namespace. | Make sure that the pod references a claim in its own namespace; if the claim comes from a template, inspect the generated claim named in the pod's `status.resourceClaimStatuses` field. |
| The class is missing, or its selectors match no published devices. | Compare the claim's `deviceClassName` and selection rules with the actual DeviceClass and ResourceSlices to confirm that suitable devices exist. Before changing a shared class, assess how the change would affect other workloads that use it. |
| The pod still requests `nvidia.com/gpu`. | Follow the [migration guidance](/azure/aks/managed-dra-for-gpus#migrate-from-the-kubernetes-device-plugin-to-dra) to update the workload's pod template to use DRA claims, removing legacy GPU requests and limits while preserving CPU and memory settings. |
| The pod's placement rules exclude the intended DRA nodes. | Review node selectors and affinity, which control where a pod can run, and tolerations, which allow it onto nodes with matching scheduling restrictions called taints. Correct mismatches and resolve other constraints reported in events, but don't add tolerations that bypass node health problems. |
| The pod sets `spec.nodeName` directly. | Replace this direct assignment with a node selector or affinity so that the scheduler can coordinate node placement with DRA allocation; if you need a specific node, select its `kubernetes.io/hostname` label alongside the node selector. |
| Matching devices are already allocated, or the request exceeds eligible capacity. | Ask the workload owners to confirm which allocations are still needed before removing unused workloads and their pods, followed by any standalone claims. If the devices are still needed, add supported capacity manually after confirming quota and regional availability. |
| Replicas that need independent GPUs reference the same standalone claim. | Use a `ResourceClaimTemplate` so that each pod receives its own claim, because referencing one shared claim doesn't create a separate GPU allocation for every replica. |

If your workload needs an entire GPU, the documented example provides a useful comparison: its class selector is `device.driver == 'gpu.nvidia.com' && device.attributes['gpu.nvidia.com'].type == 'gpu'`. This expression selects devices published by the NVIDIA GPU driver whose advertised type is `gpu`. It isn't a general replacement for classes with different requirements, and you shouldn't assume that multi-instance GPU (MIG) partitioning or GPU sharing settings from a device-plugin pool have equivalent DRA settings.

After correcting the workload, inspect its new pod and latest events to see whether scheduling succeeds. When allocation succeeds, the claim's `status.allocation.devices.results` field identifies the selected device by its driver, DRA resource pool, and device identifier, with `gpu.nvidia.com` as the expected driver. The pod should then reach `Running` for a long-running workload, although a short validation job might already have finished with a status of `Completed`.

A completed job doesn't necessarily mean that its GPU is available for another workload, because the consuming pods and claim might still exist. Follow the [claim lifecycle guidance](/azure/aks/managed-dra-for-gpus#manage-resource-claim-lifecycle) to remove the workload and its pods before deleting a standalone claim, and then verify that another workload can allocate the GPU.

## Resolve container startup and GPU access failures

Even after Kubernetes allocates a GPU to a claim, the node must prepare that device and make it accessible inside the appropriate container. If the container doesn't start or can't see its GPU, use the following commands to check the pod's events, its claim references, and any available application logs:

```bash
kubectl -n "$GPU_NAMESPACE" describe pod "$POD_NAME"
kubectl -n "$GPU_NAMESPACE" get pod "$POD_NAME" -o yaml
kubectl -n "$GPU_NAMESPACE" get resourceclaim "$CLAIM_NAME" -o yaml
kubectl -n "$GPU_NAMESPACE" logs "$POD_NAME" --all-containers=true --tail=200
```

If a container restarts, collect its previous logs with `kubectl logs --previous` and the appropriate `--container` name. A container that never started might have no application logs; use pod events instead.

Compare the pod and claim output against the following checks, which trace the connection from the allocated device to the container that needs it:

1. The claim has the expected entry in `status.allocation.devices.results`.
1. The pod's `spec.resourceClaims` references the intended claim in the same namespace, or uses the intended claim template.
1. Each container that needs a GPU references the pod-level claim name through `resources.claims`, because defining the claim at the pod level doesn't automatically grant GPU access to every container.
1. No legacy `nvidia.com/gpu` request or limit remains on a workload intended for DRA.
1. The image and application are compatible with the GPU and installed driver, because successful allocation doesn't rule out an application error or an incompatibility with CUDA, NVIDIA's GPU computing platform.

If you identify a manifest error, correct it in the workload's source or controller template and redeploy through your normal process so that newly created pods receive the fix. When spare GPU capacity is available, run the [example validation workload](/azure/aks/managed-dra-for-gpus#run-a-gpu-workload) with a separate claim to check whether basic GPU access works independently of your application. Successful `nvidia-smi` output confirms GPU visibility on the node where that job ran, but you still need application-level tests to verify CUDA computation, performance, and overall health.

## Investigate monitoring alerts

A monitor designed for the older device-plugin allocation method might look for a device-plugin DaemonSet or an allocatable `nvidia.com/gpu` count that a DRA node pool doesn't require. Before treating the alert as a monitoring mismatch, use the checks in this guide to confirm that the pool uses `DRA`, its nodes and DRA service are healthy, devices appear in ResourceSlices, and a workload can allocate and access a GPU.

If those checks succeed, work with the monitor's owner to determine whether its health criteria need to account for DRA rather than disabling monitoring solely because the node pool uses a different allocation method. If any driver, service, allocation, or validation check fails, continue investigating that failure even when the original alert was designed for device-plugin node pools.

## Create a replacement managed GPU node pool

If you can't recover the existing node pool through a supported resolution, consider creating a new managed DRA node pool after reviewing the failure with your cluster administrator.

Set a unique node pool name and a supported NVIDIA GPU VM size available in your Azure region:

```bash
export NEW_POOL_NAME="<new-pool-name>"
export GPU_VM_SIZE="<supported-gpu-vm-size>"
```

The following command creates a separate Ubuntu node pool with one GPU node, leaving the existing node pool and its driver mode unchanged so that you can validate the replacement before moving workloads.

```azurecli
az aks nodepool add \
  --subscription "$SUBSCRIPTION_ID" \
  --resource-group "$RESOURCE_GROUP" \
  --cluster-name "$CLUSTER_NAME" \
  --name "$NEW_POOL_NAME" \
  --node-vm-size "$GPU_VM_SIZE" \
  --os-sku Ubuntu \
  --enable-managed-gpu=true \
  --gpu-driver-mode DRA \
  --node-count 1
```

After creation completes, set `POOL_NAME` to the replacement node pool and repeat the configuration, node health, and ResourceSlice checks in this guide. Before moving application traffic or processing to the new node pool, verify that workloads can allocate claims, access GPUs, and pass application health checks. If your cluster contains both DRA and DevicePlugin node pools, keep their GPU components and workloads on compatible nodes so that the two allocation mechanisms don't attempt to manage the same GPU.

Follow the [migration procedure](/azure/aks/managed-dra-for-gpus#migrate-from-the-kubernetes-device-plugin-to-dra) for workload changes, rollback, and claim cleanup. Retire the original node pool only after confirming that no workloads still depend on it. If validation fails, stop the replacement workloads and restore the original workload manifests and node pool selection rather than removing the working node pool.