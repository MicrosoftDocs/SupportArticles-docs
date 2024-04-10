---
title: Unable to mount Azure disk volumes
description: Describes errors that occur when mounting Azure disk volumes fails, and provides solutions.
ms.date: 05/17/2022
author: genlin
ms.author: genli
ms.reviewer: chiragpa, akscsscic
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-azure-storage-issues
---
# Errors when mounting Azure disk volumes

This article provides solutions for errors that cause the mounting of Azure disk volumes to fail.

## Symptoms

You're trying to deploy a Kubernetes resource such as a Deployment or a StatefulSet, in an Azure Kubernetes Service (AKS) environment. The deployment will create a pod that should mount a PersistentVolumeClaim (PVC) referencing an Azure disk.

However, the pod stays in the **ContainerCreating** status. When you run the `kubectl describe pods` command, you may see one of the following errors, which causes the mounting operation to fail:

- [Disk cannot be attached to the VM because it is not in the same zone as the VM](#error1)
- [Client '\<client-ID>' with object id '\<object-ID>' doesn't have authorization to perform action over scope '\<disk name>' or scope is invalid](#error2)
- [Volume is already used by pod](#error3)
- [StorageAccountType UltraSSD_LRS can be used only when additionalCapabilities.ultraSSDEnabled is set](#error4)
- [ApplyFSGroup failed for vol](#error5)

See the following sections for error details, possible causes and solutions.

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

In AKS, the default and other built-in StorageClasses for Azure disks use [locally redundant storage (LRS)](/azure/storage/common/storage-redundancy#locally-redundant-storage). These disks are deployed in [availability zones](/azure/aks/availability-zones). If you use the node pool in AKS with availability zones, and the pod is scheduled on a node that's in another availability zone different from the disk, you may get this error.

To resolve this error, use one of the following solutions:

### Solution 1: Ensure disk and node hosting the pod are in the same zone

To make sure the disk and node that hosts the pod are in the same availability zone, use [node affinity](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/).

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

\<region> is the region of the AKS cluster. `Y` represents the availability zone of the disk, for example, westeurope-3.

### Solution 2: Use zone-redundant storage (ZRS) disks

[ZRS](/azure/storage/common/storage-redundancy#zone-redundant-storage) disk volumes can be scheduled on all zone and non-zone agent nodes. For more information, see [Azure disk availability zone support](/azure/aks/availability-zones#azure-disk-availability-zone-support).

To use a ZRS disk, create a new storage class with `Premium_ZRS` or `StandardSSD_ZRS`, and then deploy the PersistentVolumeClaim (PVC) referencing the storage.

For more information about parameters, see [Driver Parameters](https://github.com/kubernetes-sigs/azuredisk-csi-driver/blob/master/docs/driver-parameters.md)

### Solution 3: Use Azure File

[Azure File](/azure/storage/files/storage-files-introduction) is mounted by using SMB throughout network, so it's not associated with availability zones.

For more information, see the following articles:

- [Dynamically create Azure Files share](/azure/aks/azure-files-dynamic-pv)
- [Manually create Azure Files share](/azure/aks/azure-files-volume)

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

AKS cluster's identity doesn't have the required authorization over the Azure disk. This issue occurs when the disk is created in another resource group other than the infrastructure resource group of the AKS cluster.

### Solution: Create role assignment that includes required authorization

Create a role assignment that includes the authorization required as per the error. We recommend that you use a [Contributor](/azure/role-based-access-control/built-in-roles#contributor) role. If you want to use another built-in role, see [Azure built-in roles](/azure/role-based-access-control/built-in-roles).

To assign a Contributor role, use one of the following methods:

- [Use the az role assignment create command](/azure/role-based-access-control/role-assignments-cli#step-4-assign-role)

    Here's an example:

    ```azurecli
    az role assignment create --assignee <AKS-identity-ID> --role "Contributor" --scope /subscriptions/<subscription-ID>/resourceGroups/<disk-resource-group>/providers/Microsoft.Compute/disks/<disk name>
    ```

- Use the Azure portal

    Refer to detailed steps that are introduced in [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal) to assign a Contributor role. If you assign the Contributor role to a managed identity, use the [control plane identity](/azure/aks/use-managed-identity#summary-of-managed-identities) to manage Azure disks.

## <a id="error3"></a>Volume is already used by pod

Here are details of this error:

> Multi-Attach error for volume "\<PV/disk-name>" Volume is already used by pod(s) \<pod-name>

### Cause: Disk is mounted to multiple pods hosted on different nodes

An Azure disk can be mounted only as [ReadWriteOnce](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes), which makes it available to one node in AKS. That means it can be attached to only one node and mounted only to a pod hosted by that node. If you mount the same disk to a pod on another node, you'll get this error because the disk is already attached to a node.

### Solution: Ensure disk isn't mounted by multiple pods hosted on different nodes

To resolve this error, refer to [Multi-Attach error](https://github.com/andyzhangx/demo/blob/master/issues/azuredisk-issues.md#25-multi-attach-error).

To share a PersistentVolume across multiple nodes, use [Azure Files](/azure/aks/azure-files-dynamic-pv).

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

This error indicates that an [ultra disk](/azure/virtual-machines/disks-enable-ultra-ssd) is trying to be attached to a node pool with ultra disks disabled. By default, an ultra disk is disabled on AKS node pools.

### Solution: Create a node pool that can use ultra disks

To use ultra disks on AKS, create a node pool with ultra disks support by using the `--enable-ultra-ssd` flag. For more information, see [Use Azure ultra disks on Azure Kubernetes Service](/azure/aks/use-ultra-disks).

## <a id="error5"></a>ApplyFSGroup failed for vol

Here are details of this error:

> MountVolume.SetUp failed for volume '\<PV/disk-name>': applyFSGroup failed for vol /subscriptions/\<subscriptionID>/resourceGroups/\<infra/disk-resource-group>/providers/Microsoft.Compute/disks/\<PV/disk-name>: […]: input/output error

### Cause: Changing ownership and permissions for large volume takes much time

When there's a large number of files already present in the volume, if a `securityContext` with `fsGroup` is in place, this error may occur. When there are lots of files and directories under one volume, changing the group ID would consume much time. It's also mentioned in the Kubernetes official documentation [Configure volume permission and ownership change policy for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods):

"By default, Kubernetes recursively changes ownership and permissions for the contents of each volume to match the `fsGroup` specified in a Pod's `securityContext` when that volume is mounted. For large volumes, checking and changing ownership and permissions can take much time, slowing Pod startup. You can use the `fsGroupChangePolicy` field inside a `securityContext` to control the way that Kubernetes checks and manages ownership and permissions for a volume."

### Solution: Set fsGroupChangePolicy field to OnRootMismatch

To resolve this error, we recommend that you set `fsGroupChangePolicy: "OnRootMismatch"` in the `securityContext` of a Deployment, a StatefulSet or a pod.

OnRootMismatch: Only change permissions and ownership if permission and ownership of root directory doesn't match with expected permissions of the volume. This setting could help shorten the time it takes to change ownership and permission of a volume.

For more information, see [Configure volume permission and ownership change policy for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods).

## More information  

For more Azure Disk known issues, see [Azure disk plugin known issues](https://github.com/andyzhangx/demo/blob/master/issues/azuredisk-issues.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
