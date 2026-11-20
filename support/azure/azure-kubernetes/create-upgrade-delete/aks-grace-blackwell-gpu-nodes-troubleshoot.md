---
title: Troubleshoot NVIDIA Grace Blackwell GPU nodes in AKS
description: Troubleshoot Grace Blackwell GPU nodes in AKS. Diagnose deployment and GPU device allocation issues on NVIDIA GB200 and GB300 node pools.
ms.date: 11/20/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: sachidesai
ms.service: azure-kubernetes-service
ai-usage: ai-assisted
---
# Troubleshoot Grace-Blackwell GPU nodes in Azure Kubernetes Service

## Summary

This article helps you troubleshoot Grace-Blackwell GPU nodes in Azure Kubernetes Service (AKS) by diagnosing deployment and GPU device allocation errors with managed GPU node pools. Start with the symptom that matches your failure, run the checks, and verify the result before retrying your workload.

For important concepts, see [GPU concepts for NVIDIA Grace-Blackwell nodes](/azure/aks/grace-blackwell-series-gpu-concepts). For deployment steps and sample workloads, see [Use NVIDIA Grace-Blackwell GPUs on AKS](/azure/aks/use-grace-blackwell-series-gpus).

## Before you begin

Use a Bash environment with Azure CLI, the `aks-preview` extension version `22.0.0b12` or later, and `kubectl`. The deployment guide requires an existing AKS cluster running Kubernetes `1.36` or later with Azure Container Networking Interface (CNI) networking. GB-series GPU nodes require compatible ARM64 node and container images.

In a rack-style architecture, Grace-Blackwell GPUs are connected over the same high-speed physical network. Kubernetes resource claims allocate devices to workloads; they don't create VMs or increase rack capacity.

Set the following environment variables to the affected resources. Use the namespace and pod from the failing workload.

```bash
export SUBSCRIPTION_ID="<subscription-id>"
export RESOURCE_GROUP="<aks-resource-group>"
export CLUSTER_NAME="<aks-cluster-name>"
export GPU_NODEPOOL_NAME="<gpu-node-pool-name>"
export WORKLOAD_NAMESPACE="<workload-namespace>"
export POD_NAME="<affected-pod-name>"

az account set --subscription "$SUBSCRIPTION_ID"
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME"
kubectl cluster-info
```

Confirm that the Azure subscription and Kubernetes context identify the intended deployment. The checks in the following sections don't change resources unless a resolution explicitly says to do so.

> [!WARNING]
> Don't install a second NVIDIA device plugin or DRA driver on managed GPUs, delete shared device classes or custom resource definitions, or restart managed components as a first troubleshooting step. These actions can affect other applications. Review the impact before changing workloads or GPU node pools.

## Identify the failure stage

| Symptom | Start here |
| --- | --- |
| Node pool creation returns `VMSizeDoesNotSupportGPU`. | [Check GPU preview registration](#node-pool-creation-fails-with-vmsizedoesnotsupportgpu). |
| The node pool can't allocate nodes on the rack. | [Check the placement and capacity](#nodes-dont-allocate-on-the-rack). |
| A GPU claim has no allocation and its pod stays pending. | [Check GPU discovery and claim references](#a-gpu-claim-doesnt-allocate). |
| A compute domain has no participating nodes. | [Check channel consumers and placement](#a-compute-domain-remains-empty). |
| A network device claim has no allocation. | [Check managed DRANET](#a-dranet-claim-doesnt-allocate). |
| No GPU DRA driver pod appears. | [Verify advertised GPU devices](#no-gpu-dra-pod-appears-in-kubernetes). |

A pod in `Pending` doesn't by itself mean node pool provisioning failed. Check the Azure provisioning state separately from Kubernetes scheduling and resource claim allocation.

## Node pool creation fails with VMSizeDoesNotSupportGPU

**Symptom:** A node pool create request returns `VMSizeDoesNotSupportGPU` for an [ND GB200-v6 sizes series](/azure/virtual-machines/sizes/gpu-accelerated/nd-gb200-v6-series) or [ND GB300-v6 sizes series](/azure/virtual-machines/sizes/gpu-accelerated/nd-gb300-v6-series) VM size.

### Check

Verify that you're using the intended Azure subscription and that both AKS GPU preview features are registered:

```azurecli
az account show --query '{subscription:name,id:id}' --output table
az feature show --namespace Microsoft.ContainerService --name GraceBlackwellManagedGPUPreview --query properties.state --output tsv
az feature show --namespace Microsoft.ContainerService --name ManagedGPUExperiencePreview --query properties.state --output tsv
```

### Resolve and verify

If a feature isn't registered, register it by using the following steps:

```azurecli
az feature register --namespace Microsoft.ContainerService --name GraceBlackwellManagedGPUPreview
az feature register --namespace Microsoft.ContainerService --name ManagedGPUExperiencePreview
```

Repeat the feature checks until both return `Registered`, then run:

```azurecli
az provider register --namespace Microsoft.ContainerService
```

Before retrying, also confirm that the GB-series VM size matches your allocated rack capacity and is supported in the deployment region. Registration doesn't reserve hardware or make an unsupported VM size available. If registration is already correct, retain the full error and request correlation ID for Azure support rather than repeatedly recreating the node pool.

## Nodes don't allocate on the rack

**Symptom:** Pool provisioning reports an allocation failure, fewer nodes provision than requested, or the expected rack nodes don't appear.

### Check

```azurecli
az aks show --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME" \
    --query '{location:location,state:provisioningState}' --output json

az aks nodepool show --resource-group "$RESOURCE_GROUP" \
    --cluster-name "$CLUSTER_NAME" --name "$GPU_NODEPOOL_NAME" \
    --query '{state:provisioningState,vmSize:vmSize,zones:availabilityZones,count:count}' --output json
```

If the node pool object wasn't created, compare the capacity allocation details with the failed node pool create request instead. For a node pool that exists, list the registered nodes:

```bash
kubectl get nodes -l "agentpool=${GPU_NODEPOOL_NAME}" -o wide
```

### Resolve and verify

Confirm that the AKS cluster and GPU capacity regions match. The Azure VM size must match the rack allocation. Confirm healthy, unallocated capacity with your capacity administrator; `sku.capacity` and the VM association list alone aren't a count of healthy free nodes.

Request no more nodes than the rack can supply. Increasing the node pool count doesn't expand your allocated capacity. A partial failure can leave some nodes provisioned, so inspect the existing pool before retrying or changing its count.

After correcting capacity or placement, verify that the node pool reaches `Succeeded` and the intended node count is present and `Ready`. Escalate persistent allocation failures with the available capacity, requested node count, and full Azure error.

## A GPU claim doesn't allocate

**Symptom:** A GPU `ResourceClaim` has no `status.allocation`, and the consuming pod remains `Pending`.

### Check

```bash
kubectl -n "$WORKLOAD_NAMESPACE" describe pod "$POD_NAME"
kubectl -n "$WORKLOAD_NAMESPACE" get resourceclaims -o yaml
kubectl get deviceclass gpu.nvidia.com -o yaml
kubectl get resourceslices.resource.k8s.io \
    -o custom-columns='NAME:.metadata.name,DRIVER:.spec.driver,POOL:.spec.pool.name,NODE:.spec.nodeName'
```

Read pod scheduling events first. Confirm that the claim references the intended class, and that slices with driver `gpu.nvidia.com` advertise devices for the target node pool. A claim can remain unallocated until a consuming pod is scheduled; claim creation alone isn't a successful allocation check.

### Resolve and verify

The preview feature advertises GPU devices without creating the `gpu.nvidia.com` DeviceClass. **Only if the class lookup returns `NotFound`**, and your claim references that class, create it:

```bash
kubectl apply -f - <<'EOF'
apiVersion: resource.k8s.io/v1
kind: DeviceClass
metadata:
  name: gpu.nvidia.com
spec:
  selectors:
  - cel:
      expression: device.driver == 'gpu.nvidia.com'
EOF
```

Don't apply this workaround for a permissions or connection error, or replace an existing class without reviewing its ownership and selectors. For profile-specific requests, use the supported selectors described in your deployment configuration.

If the class exists, use pod events to correct mismatched selectors, missing tolerations, or insufficient matching devices. Verify that the pod and named resource claim are in the same namespace and that both the pod and consuming container reference the claim. Use `resources.claims`, not legacy `nvidia.com/gpu` limits, for this managed DRA procedure.

Verify that `status.allocation.devices.results` contains the expected device and that the pod starts. If no GPU devices are advertised, check [GPU node health](#check-gpu-node-health) and collect the node pool and resource details for support.

## A compute domain remains empty

**Symptom:** A `ComputeDomain` exists but has no participating nodes, or its application remains in `Pending` or `ContainerCreating`.

A compute domain groups participating nodes for cross-node NVLink communication. Its channel is the resource an application claims to join the domain. Creating the domain alone doesn't form an application group, also called a clique.

### Check

```bash
kubectl -n "$WORKLOAD_NAMESPACE" get computedomains.resource.nvidia.com -o yaml
kubectl -n "$WORKLOAD_NAMESPACE" get resourceclaimtemplates,resourceclaims -o yaml
kubectl -n "$WORKLOAD_NAMESPACE" get pods -o wide
kubectl -n "$WORKLOAD_NAMESPACE" describe pod "$POD_NAME"
kubectl get computedomaincliques.resource.nvidia.com -A -o wide
kubectl get pods -n kube-system -l app.kubernetes.io/name=compute-domain
kubectl logs -n kube-system -l app.kubernetes.io/name=compute-domain --all-containers=true --tail=100
```

### Resolve and verify

Confirm that the application references the channel claim template named in the domain's `spec.channel.resourceClaimTemplate.name`, and that its container references that claim. The domain, template, and consuming workload must use the appropriate namespace.

For the guide's two-node example, ensure that two replicas can schedule on distinct, ready nodes in the same rack. Check pool selectors, anti-affinity, taints, and available resources. Confirm that the compute-domain controller and its device classes are present; use the [deployment guide](/azure/aks/use-grace-blackwell-series-gpus#configure-cross-node-nvlink-with-a-compute-domain) to check the managed configuration rather than installing a duplicate controller.

After correcting the workload, verify that the replicas are ready and the domain and clique show the intended participating nodes. This verifies formation, not GPU computation or NVLink performance.

## A DRANET claim doesn't allocate

**Symptom:** A workload can't allocate InfiniBand or Remote Direct Memory Access (RDMA) devices through DRANET, the DRA support for network devices.

### Check

```azurecli
az aks show --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME" \
    --query '{version:currentKubernetesVersion,networkPlugin:networkProfile.networkPlugin}' --output json
az aks nodepool show --resource-group "$RESOURCE_GROUP" \
    --cluster-name "$CLUSTER_NAME" --name "$GPU_NODEPOOL_NAME" \
    --query '{state:provisioningState,dranet:networkProfile.dranet.mode}' --output json
```

```bash
kubectl get nodes -l "agentpool=${GPU_NODEPOOL_NAME}" -L network-dra
kubectl get daemonset -n kube-system -l app.kubernetes.io/name=dranet
kubectl get pods -n kube-system -l app.kubernetes.io/name=dranet -o wide
kubectl logs -n kube-system -l app.kubernetes.io/name=dranet --all-containers=true --tail=100
kubectl get deviceclass dranet.azure.com -o yaml
kubectl get resourceslices.resource.k8s.io -o yaml
kubectl -n "$WORKLOAD_NAMESPACE" get resourceclaims -o yaml
kubectl -n "$WORKLOAD_NAMESPACE" describe pod "$POD_NAME"
```

### Resolve and verify

Confirm Kubernetes `1.36` or later, `networkPlugin: azure`, and pool configuration `dranet: Managed`. If the node pool wasn't configured for managed DRANET, follow the deployment guide rather than installing a second network DRA driver.

Check that each intended node has the `network-dra` label and a healthy DRANET pod. The `dranet.azure.com` class must select driver `dranet.dra.azure.com`, and matching network devices must be advertised. Don't add the label manually to hide missing managed configuration.

Correct claim selectors or device counts that don't match the advertised devices. The guide's request for eight InfiniBand devices is an example, not a universal count. A pod requesting both GPU and network devices needs compatible allocations on the same node; check both claims and pod events.

Verify that the claims allocate and the application can access the expected network devices. If managed components or their classes are missing or unhealthy, collect their status and logs for Azure support instead of recreating them manually.

## No GPU DRA pod appears in Kubernetes

**Symptom:** You search for the managed DRA driver with `kubectl get pods` but find no driver pod.

This absence is expected for managed GPU DRA. The driver runs as a service `dra-driver-nvidia-gpu.service`, not a Kubernetes pod. This condition doesn't apply to the compute-domain controller or DRANET, which have Kubernetes pods.

### Verify

```bash
kubectl get resourceslices.resource.k8s.io \
    -o custom-columns='NAME:.metadata.name,DRIVER:.spec.driver,NODE:.spec.nodeName'
kubectl -n "$WORKLOAD_NAMESPACE" get resourceclaims -o yaml
```

Check that slices with driver `gpu.nvidia.com` include the intended nodes, then verify allocation and GPU access with the guide's sample workload. Don't install another DRA driver because a driver pod is absent. If slices are missing, continue with the health checks in the following section.

## Check GPU node health

Inspect node conditions and events for NVIDIA, NVIDIA Data Center GPU Manager (DCGM), and GPU-related errors. Node Problem Detector (NPD) reports managed GPU health through node conditions.

```bash
kubectl describe nodes -l "agentpool=${GPU_NODEPOOL_NAME}"
kubectl get nodes -l "agentpool=${GPU_NODEPOOL_NAME}" -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{range .status.conditions[*]}{.type}{"="}{.status}{" reason="}{.reason}{" message="}{.message}{"\n"}{end}{end}'
```

All intended nodes should be `Ready`. For a condition named `UnhealthyNvidiaDCGMServices`, the healthy status is `False` while `True` indicates an issue. Interpret each condition by its name, reason, and message rather than assuming that every `True` value is unhealthy.

Record the affected node names, condition timestamps, and messages. Resolve node health issues before treating a pending claim as a capacity-only problem. Don't add tolerations for node health failures to force a GPU workload onto an unhealthy node.

## Collect information for Azure support

If the checks don't resolve the issue, [create an Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request). Include:

- The exact error text and Azure operation or correlation ID, if available.
- Azure subscription, AKS cluster, and node pool; region, zone, VM size, and requested versus provisioned node count.
- CLI and extension versions, preview registration states, Kubernetes version, network plugin, and pool GPU and DRANET configuration.
- Affected node conditions, device classes, resource slices, claim specifications and allocation status, pod scheduling events, and relevant workload or managed-component logs.
- Whether the failure affects every node or one node, and whether it began after creation, scaling, maintenance, or a workload change.