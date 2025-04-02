---
title: Unable to Mount Azure Disk Volumes
description: Describes errors that occur when mounting Azure disk volumes fails, and provides solutions.
ms.date: 03/22/2025
author: genlin
ms.author: genli
ms.reviewer: chiragpa, akscsscic, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Storage
---
# Errors when mounting Azure disk volumes

This article provides solutions for errors that cause the mounting of Azure disk volumes to fail.

## Symptoms

You're trying to deploy a Kubernetes resource, such as a Deployment or a StatefulSet, in an Azure Kubernetes Service (AKS) environment. The deployment creates a pod that should mount a PersistentVolumeClaim (PVC) that references an Azure disk.

However, the pod stays in the **ContainerCreating** status. When you run the `kubectl describe pods` command, you may see one of the following errors that cause the mounting operation to fail:

- [Disk cannot be attached to the VM because it is not in the same zone as the VM](#error1)
- [Client '\<client-ID>' with object id '\<object-ID>' doesn't have authorization to perform action over scope '\<disk name>' or scope is invalid](#error2)
- [Volume is already used by pod](#error3)
- [StorageAccountType UltraSSD_LRS can be used only when additionalCapabilities.ultraSSDEnabled is set](#error4)
- [ApplyFSGroup failed for vol](#error5)
- [Node(s) exceed max volume count](#error6)

See the following sections for error details, possible causes, and solutions.

## <a id="error1"></a>Disk cannot be attached to the VM because it is not in the same zone as the VM

Here are details of this error:

```output
AttachVolume.Attach failed for volume "<disk/PV name>": 
rpc error: 
code = Unknown 
desc = Attach volume "/subscriptions/<subscription-ID>/resourceGroups/<disk-resource-group>/providers/Microsoft.Compute/disks/<disk/PV name>" to instance "<AKS node name>" failed with Retriable: false, RetryAfter: 0s, HTTPStatusCode: 400, 
RawError: 
{
      "error": 
    {
"code": "BadRequest",
"message": "Disk /subscriptions/<subscription-ID>/resourceGroups/<disk-resource-group>/providers/Microsoft.Compute/disks/<disk/PV name > cannot be attached to the VM because it is not in the same zone as the VM. VM zone: 'X'. Disk zone: 'Y'. "
  }
}
```

### Cause: Disk and node hosting pod are in different zones

In AKS, the default and other built-in storage classes for Azure disks use [locally redundant storage (LRS)](/azure/storage/common/storage-redundancy#locally-redundant-storage). These disks are deployed in [availability zones](/azure/aks/availability-zones). If you use the node pool in AKS together with availability zones, and the pod is scheduled on a node that's in another availability zone that's different from the disk, you might experience this error.

To resolve this error, use one of the following solutions.

### Solution 1: Ensure disk and node hosting the pod are in the same zone

To make sure that the disk and node that host the pod are in the same availability zone, use [node affinity](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/).

Refer to the following script as an example:

```yml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: topology.disk.csi.azure.com/zone
        operator: In
        values:
        - <region>-Y
```

\<region> is the region of the AKS cluster. `Y` represents the availability zone of the disk (for example, westeurope-3).

### Solution 2: Use zone-redundant storage (ZRS) disks

[ZRS](/azure/storage/common/storage-redundancy#zone-redundant-storage) disk volumes can be scheduled on all zone and non-zone agent nodes. For more information, see [Azure disk availability zone support](/azure/aks/availability-zones#azure-disk-availability-zone-support).

To use a ZRS disk, create a storage class by using `Premium_ZRS` or `StandardSSD_ZRS`, and then deploy the PersistentVolumeClaim (PVC) that references the storage.

For more information about parameters, see [Driver Parameters](/azure/aks/azure-csi-files-storage-provision#storage-class-parameters-for-dynamic-persistentvolumes)

### Solution 3: Use Azure Files

[Azure Files](/azure/storage/files/storage-files-introduction) is mounted by using NFS or SMB throughout network. It's not associated with availability zones.

For more information, see the following articles:

- [Dynamically create Azure Files share](/azure/aks/azure-csi-files-storage-provision#dynamically-provision-a-volume)
- [Manually create Azure Files share](/azure/aks/azure-csi-files-storage-provision#statically-provision-a-volume)

## <a id="error2"></a>Client '\<client-ID>' with object id '\<object-ID>' doesn't have authorization to perform action over scope '\<disk name>' or scope is invalid

Here are details of this error:

```output
AttachVolume.Attach failed for volume "pv-azuredisk": 
rpc error: code = NotFound 
desc = Volume not found, failed with error: Retriable: false, RetryAfter: 0s, HTTPStatusCode: 403, 
RawError: 
{
"error":
{"code":"AuthorizationFailed",
"message":"The client '<client-ID>' with object id '<object-ID>' does not have authorization to perform action 'Microsoft.Compute/disks/read' over scope '/subscriptions/<subscription-ID>/resourceGroups/<disk-resource-group>/providers/Microsoft.Compute/disks/<disk name>' or the scope is invalid. If access was recently granted, please refresh your credentials."
}
}
```

### Cause: AKS identity doesn't have required authorization over disk

AKS cluster's identity doesn't have the required authorization over the Azure disk. This issue occurs if the disk is created in a resource group other than the infrastructure resource group of the AKS cluster.

### Solution: Create role assignment that includes required authorization

Create a role assignment that includes the authorization required per the error. We recommend that you use a [Contributor](/azure/role-based-access-control/built-in-roles/general#contributor) role. If you want to use another built-in role, see [Azure built-in roles](/azure/role-based-access-control/built-in-roles).

To assign a Contributor role, use one of the following methods:

- [Use the az role assignment create command](/azure/role-based-access-control/role-assignments-cli#step-4-assign-role)

    Here's an example:

    ```azurecli
    az role assignment create --assignee <AKS-identity-ID> --role "Contributor" --scope /subscriptions/<subscription-ID>/resourceGroups/<disk-resource-group>/providers/Microsoft.Compute/disks/<disk name>
    ```

- Use the Azure portal

    Refer to detailed steps that are introduced in [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal) to assign a Contributor role. If you assign the Contributor role to a managed identity, use the [control plane identity](/azure/aks/use-managed-identity) to manage Azure disks.

## <a id="error3"></a>Volume is already used by pod

Here are details of this error:

> Multi-Attach error for volume "\<PV/disk-name>" Volume is already used by pod(s) \<pod-name>

### Cause: Disk is mounted to multiple pods hosted on different nodes

An Azure disk can be mounted only as [ReadWriteOnce](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes). This makes it available to one node in AKS. That means that it can be attached to only one node and mounted to only a pod that's hosted by that node. If you mount the same disk to a pod on another node, you experience this error because the disk is already attached to a node.

### Solution: Make sure disk isn't mounted by multiple pods hosted on different nodes

To resolve this error, refer to [Multi-Attach error](https://github.com/andyzhangx/demo/blob/master/issues/azuredisk-issues.md#25-multi-attach-error).

To share a PersistentVolume across multiple nodes, use [Azure Files](/azure/aks/azure-csi-files-storage-provision).

## <a id="error4"></a>StorageAccountType UltraSSD_LRS can be used only when additionalCapabilities.ultraSSDEnabled is set

Here are details of this error:

```output
AttachVolume.Attach failed for volume "<Disk/PV name>" : 
rpc error: 
code = Unknown 
desc = Attach volume "/subscriptions/<subscription-ID>/resourceGroups/<disk-resource-group>/providers/Microsoft.Compute/disks/<disk/PV name>" to instance "<AKS node name>" failed with Retriable: false, RetryAfter: 0s, HTTPStatusCode: 400, RawError:
{
  "error": 
{"code": "InvalidParameter",
"message": "StorageAccountType UltraSSD_LRS can be used only when additionalCapabilities.ultraSSDEnabled is set.",
"target": "managedDisk.storageAccountType"
}
}
```

### Cause: Ultra disk is attached to node pool with ultra disks disabled

This error indicates that an [ultra disk](/azure/virtual-machines/disks-enable-ultra-ssd) is trying to be attached to a node pool by having ultra disks disabled. By default, an ultra disk is disabled on AKS node pools.

### Solution: Create a node pool that can use ultra disks

To use ultra disks on AKS, create a node pool that has ultra disks support by using the `--enable-ultra-ssd` flag. For more information, see [Use Azure ultra disks on Azure Kubernetes Service](/azure/aks/use-ultra-disks).

## <a id="error5"></a>ApplyFSGroup failed for vol

Here are details of this error:

> MountVolume.SetUp failed for volume '\<PV/disk-name>': applyFSGroup failed for vol /subscriptions/\<subscriptionID>/resourceGroups/\<infra/disk-resource-group>/providers/Microsoft.Compute/disks/\<PV/disk-name>: […]: input/output error

### Cause: Changing ownership and permissions for large volume takes much time

If there are many files already present in the volume, and if a `securityContext` that uses `fsGroup` exists, this error might occur. If there are lots of files and directories in one volume, changing the group ID would consume excessive time. Additionally, the Kubernetes official documentation [Configure volume permission and ownership change policy for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods) mentions this situation:

"By default, Kubernetes recursively changes ownership and permissions for the contents of each volume to match the `fsGroup` specified in a Pod's `securityContext` when that volume is mounted. For large volumes, checking and changing ownership and permissions can take much time, slowing Pod startup. You can use the `fsGroupChangePolicy` field inside a `securityContext` to control the way that Kubernetes checks and manages ownership and permissions for a volume."

### Solution: Set fsGroupChangePolicy field to OnRootMismatch

To resolve this error, we recommend that you set `fsGroupChangePolicy: "OnRootMismatch"` in the `securityContext` of a Deployment, a StatefulSet, or a pod.

OnRootMismatch: Change permissions and ownership only if permission and ownership of the root directory doesn't match the expected permissions of the volume. This setting could help shorten the time that it takes to change ownership and permission of a volume.

For more information, see [Configure volume permission and ownership change policy for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods).

## <a id="error6"></a>Node(s) exceed max volume count

Here are details of this error:

```output
Events:
Type   Reason      Age  From        Message
----   ------      ---- ----        -------
Warning FailedScheduling 25s  default-scheduler 0/8 nodes are available: 8 node(s) exceed max volume count. preemption: 0/8 nodes are available: 8 No preemption victims found for incoming pod..
```
### Cause: Maximum disk limit is reached

The node has reached its maximum disk capacity. In AKS, the number of disks per node depends on the VM size that's configured for the node pool.

### Solution: Use anotehr VM size with more disk limits

To resolve the issue, we recommend that you use another VM size that supports more disks for the node.

Additionally, make sure that the number of disks per node does not exceed the [Kubernetes default limits](https://kubernetes.io/docs/concepts/storage/storage-limits/#kubernetes-default-limits).

## More information  

For more Azure Disk known issues, see [Azure disk plugin known issues](https://github.com/andyzhangx/demo/blob/master/issues/azuredisk-issues.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
