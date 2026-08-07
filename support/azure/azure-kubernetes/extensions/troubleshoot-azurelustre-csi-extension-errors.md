---
title: Troubleshoot Azure Managed Lustre CSI Driver extension errors
description: Fix common installation, configuration, and mount errors for the Azure Managed Lustre CSI Driver extension on Azure Kubernetes Service (AKS).
author: kaushika-msft
ms.author: kaushika
ms.reviewer: jeffbearer, davidbradley
ms.topic: troubleshooting
ms.service: azure-kubernetes-service
ms.date: 08/03/2026
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshoot Azure Managed Lustre CSI Driver extension errors

## Summary

This article helps you resolve common installation, configuration, and mount
errors for the Azure Managed Lustre CSI Driver extension
(`microsoft.azuremanagedlustre`) on Azure Kubernetes Service (AKS).

The Azure Managed Lustre CSI Driver connects Kubernetes workloads to
[Azure Managed Lustre](/azure/azure-managed-lustre/amlfs-overview) file systems
through persistent volumes. The driver supports both static and dynamic
provisioning. With static provisioning, you create each PersistentVolume (PV)
manually and configure it with the connection details of an existing Azure
Managed Lustre file system. With dynamic provisioning, you define a
StorageClass and the driver creates volumes automatically.

## Scenario 1: Extension installation fails with no visible error

You install the Azure Managed Lustre CSI Driver extension, but the installation
doesn't complete successfully. No clear error message appears.

### Solution 1: Inspect the extension status

Run the following command to inspect the extension status and find the error
message in the `statuses` property:

```azurecli
az k8s-extension show \
    --resource-group <resource-group-name> \
    --cluster-name <cluster-name> \
    --cluster-type managedClusters \
    --name <extension-name>
```

> [!TIP]
> If you don't remember the extension name you used at install time, run
> `az k8s-extension list` to discover all extensions on the cluster.

Look for the `statuses` array in the output. The `message` property shows
the specific error. For example:

```json
"statuses": [
  {
    "code": "InstallationFailed",
    "message": "Error: {failed to install chart from path [] ...} occurred while doing the operation : {Installing the extension} on the config"
  }
]
```

If the status shows `InstallationFailed`, try the solutions in the following
scenarios. If your error message doesn't match any of these scenarios, see
[general cluster extension deployment errors](/troubleshoot/azure/azure-kubernetes/extensions/cluster-extension-deployment-errors).

## Scenario 2: Extension version is not available in the specified region

You try to install the extension and receive the following error:

> (ExtensionTypeRegistrationGetFailed) Extension type microsoft.azuremanagedlustre
> is not registered in region \<regionname>.
>
> Code: ExtensionTypeRegistrationGetFailed
>
> Message: Extension type microsoft.azuremanagedlustre is not registered in
> region \<regionname>.

### Solution 2: Use a supported region

The Azure Managed Lustre CSI Driver extension requires a region that supports
both the AKS extension platform and the Azure Managed Lustre service. Install
the extension on an AKS cluster in a
[supported Azure Managed Lustre region](/azure/azure-managed-lustre/amlfs-overview#region-availability).

## Scenario 3: CSI driver pods are in CrashLoopBackOff or not ready

After installation, the CSI driver controller or node pods aren't in a
`Running` state.

### Solution 3: Check pod status and logs

1. Check the controller pod status.

   ```bash
   kubectl get pods -n kube-system -l app=csi-azurelustre-controller -o wide
   ```

1. Check the node DaemonSet pod status.

   ```bash
   kubectl get pods -n kube-system -l app=csi-azurelustre-node -o wide
   ```

1. If pods are in `CrashLoopBackOff` or `Error` state, check the logs.

   ```bash
   # Controller logs
   kubectl logs -n kube-system -l app=csi-azurelustre-controller \
       -c azurelustre --tail=100

   # Node logs (from the specific node pod)
   kubectl logs -n kube-system <node-pod-name> -c azurelustre --tail=100
   ```

1. Verify that the required RBAC resources exist:

   ```bash
   kubectl get clusterrole,clusterrolebinding | grep azurelustre
   ```

   If no results appear, the RBAC resources might be missing or corrupted.
   Try uninstalling and reinstalling the extension.

Common causes include:

- Azure Managed Lustre client packages aren't available for the node OS's
  kernel. The CSI driver supports Ubuntu 22.04 (Jammy), Ubuntu 24.04 (Noble),
  and AzureLinux 3 nodes. Nodes running a different OS or version don't get a
  CSI driver pod. See
  [Scenario 7](#scenario-7-extension-installs-successfully-but-csi-pods-dont-appear-on-some-nodes).
- Someone deleted or modified the RBAC ClusterRole or ClusterRoleBinding resources.

## Scenario 4: PersistentVolumeClaim stays in Pending state

You create a PersistentVolumeClaim (PVC) that references the Azure Managed Lustre
CSI driver, but it stays in the `Pending` state and the workload pod can't start.

The Azure Managed Lustre CSI driver supports two provisioning modes, and a PVC
can stay `Pending` in either one:

- **Static provisioning** — you create a PersistentVolume (PV) manually with the
  connection details (`mgs-ip-address`, `fs-name`, and optional `sub-dir`) of an
  *existing* Azure Managed Lustre file system, and the PVC binds to that PV. A
  `Pending` PVC usually means no matching PV exists, or the PV's parameters are
  missing or incorrect.
- **Dynamic provisioning** — you define a StorageClass (provisioner
  `azurelustre.csi.azure.com`) with parameters such as `sku-name`, `zone`, and a
  maintenance window, and the driver *creates a new* Azure Managed Lustre file
  system for the claim. A `Pending` PVC usually means the driver couldn't create
  the file system — most commonly the kubelet identity is missing the required
  permissions, or a StorageClass parameter (or the storage-class quota) is
  invalid.

Identify which mode you're using, then follow the matching steps below.

### Solution 4: Verify the PersistentVolume and its parameters

1. Check for events on the PVC.

   ```bash
   kubectl describe pvc <pvc-name>
   ```

1. Verify that a PersistentVolume (PV) exists and is bound to the PVC. The PV
   must have the following required volume attributes:

   - `mgs-ip-address` — the MGS IP address of your Azure Managed Lustre file system
   - `fs-name` — the filesystem name of your Azure Managed Lustre file system
   - `sub-dir` (optional) — a subdirectory path within the Lustre filesystem.
     If you include this parameter, provide a valid, non-empty subpath.

   You can find these values in the Azure portal on the Azure Managed Lustre
   resource under **Client connection**.

1. Check the CSI controller logs for the specific error:

   ```bash
   kubectl logs -n kube-system -l app=csi-azurelustre-controller \
       -c azurelustre --tail=100
   ```

   Common error messages include:

   - `"CreateVolume Parameter mgs-ip-address must be provided"` — the PV is
     missing the MGS IP address parameter.
   - `"CreateVolume Parameter fs-name must be provided"` — the PV is missing
     the filesystem name parameter.
   - `"CreateVolume Parameter sub-dir must not be empty if provided"` — you
     included the `sub-dir` parameter but left it empty.
   - `"Invalid parameter(s) {…} in storage class"` — the StorageClass contains
     unrecognized parameters.

1. Verify that the PVC references a PV that exists and has the correct name:

   ```bash
   kubectl get pv
   kubectl get pvc <pvc-name> -o jsonpath='{.spec.volumeName}'
   ```

   If the PVC references a PV name that doesn't exist or is misspelled, the
   PVC stays in `Pending` state. Correct the `volumeName` in the PVC spec to
   match the actual PV name.

1. **If you use dynamic provisioning**, confirm the kubelet identity has the
   permissions required to create an Azure Managed Lustre file system (see the
   driver's dynamic-provisioning prerequisites), then check the CSI controller
   logs for the file-system creation error:

   ```bash
   kubectl logs -n kube-system -l app=csi-azurelustre-controller \
       -c azurelustre --tail=100
   ```

## Scenario 5: Volume mount fails on the node

The PVC is bound, but the workload pod fails to start with a mount error. Events
on the pod show messages like:

> MountVolume.MountDevice failed: rpc error: code = Internal desc = Could not
> mount "172.x.x.x@tcp:/lustrefs" at "/var/lib/kubelet/...": mount failed

### Solution 5: Verify network connectivity and Lustre client availability

1. **Verify network connectivity.** The AKS cluster nodes need network
   access to the Azure Managed Lustre file system's MGS IP address on
   TCP port 988. Confirm the following conditions:

   - The AKS cluster VNet is
     [peered](/azure/virtual-network/virtual-network-peering-overview) with the
     Azure Managed Lustre file system's VNet, or both are in the same VNet.
   - Network security group (NSG) rules on both the AKS node subnet and the
     Azure Managed Lustre subnet allow TCP traffic on port 988.
   - If you use Azure Firewall or a network virtual appliance, ensure it
     permits TCP 988 traffic between the AKS nodes and the AMLFS MGS IP.

1. **Check the Lustre kernel module.** The CSI node pod requires the Lustre
   kernel module on the host node. Verify that the module is loaded:

   ```bash
   kubectl exec -it <node-pod-name> -n kube-system -c azurelustre -- \
       lsmod | grep lustre
   ```

   If this command produces no output, the Lustre client kernel module isn't
   loaded. The node OS likely doesn't include Lustre client support for the
   running kernel version.

   You can also check for existing Lustre mounts on the node:

   ```bash
   kubectl exec -it <node-pod-name> -n kube-system -c azurelustre -- \
       mount | grep lustre
   ```

1. **Check node OS compatibility.** The Azure Managed Lustre CSI driver
   supports Ubuntu 22.04, Ubuntu 24.04, and AzureLinux 3 nodes. Verify the
   node's OS:

   ```bash
   kubectl get nodes -o wide
   ```

   The `OS-IMAGE` column should show a supported OS: `Ubuntu` 22.04 or 24.04,
   or `Azure Linux` 3. If it shows a different OS or version, see
   [Scenario 7](#scenario-7-extension-installs-successfully-but-csi-pods-dont-appear-on-some-nodes).

1. **Check the node pod logs** for detailed mount error output:

   ```bash
   kubectl logs -n kube-system <node-pod-name> -c azurelustre --tail=100
   ```

## Scenario 6: Existing Lustre CSI driver conflicts with extension installation

You try to install the Azure Managed Lustre CSI Driver as an AKS extension, but
you already have the open-source CSI driver installed through Helm or kubectl.
The installation fails because resources already exist:

> (ExtensionOperationFailed) The extension operation failed with the following
> error: Error: {failed to install chart from path [] for release
> [azurelustre-csi]: err [rendered manifests contain a resource that already
> exists. Unable to continue with install: ...]} occurred while doing the
> operation : {Installing the extension} on the config

### Solution 6: Uninstall the existing driver first

1. Identify the existing installation. If you installed it via Helm, find the release
   name:

   ```bash
   helm list -n kube-system | grep lustre
   ```

1. Uninstall the existing driver:

   ```bash
   # If installed via Helm (use the release name from step 1)
   helm uninstall <release-name> -n kube-system

   # If installed via kubectl apply
   kubectl delete -f deploy/
   ```

1. After you remove the existing driver, retry the extension installation:

   ```azurecli
   az k8s-extension create \
       --resource-group <resource-group-name> \
       --cluster-name <cluster-name> \
       --cluster-type managedClusters \
       --name azurelustre-csi \
       --extension-type microsoft.azuremanagedlustre
   ```

> [!IMPORTANT]
> Uninstalling the CSI driver doesn't delete existing PersistentVolumes or
> PersistentVolumeClaims. However, workloads that use Lustre volumes are
> disrupted during the driver swap. Restart pods that use Lustre mounts after
> you install the new extension. The underlying volumes and data remain intact.

## Scenario 7: Extension installs successfully but CSI pods don't appear on some nodes

The extension installs without error, but some AKS nodes don't have a CSI
driver node pod (`csi-azurelustre-node`) running on them. Workloads scheduled on
those nodes fail to mount Lustre volumes.

### Solution 7: Verify node OS compatibility

The Azure Managed Lustre CSI Driver ships a separate node DaemonSet for each
supported node OS: Ubuntu 22.04 (Jammy), Ubuntu 24.04 (Noble), and AzureLinux 3.
Nodes whose OS or version isn't one of these don't get a CSI driver pod. This
failure is silent - the extension reports success even though CSI driver
coverage is incomplete.

1. Compare the number of node pods to the number of nodes:

   ```bash
   kubectl get pods -n kube-system -l app=csi-azurelustre-node --no-headers | wc -l
   kubectl get nodes --no-headers | wc -l
   ```

   If the pod count is less than the node count, some nodes aren't covered.

1. Check the OS of each node:

   ```bash
   kubectl get nodes -o wide
   ```

   The `OS-IMAGE` column shows the node OS. Nodes running an OS or version
   outside the supported set (Ubuntu 22.04/24.04 or AzureLinux 3) don't have a
   CSI driver pod.

1. To use Azure Managed Lustre with your cluster, ensure your Lustre workloads
   are scheduled on node pools running a supported OS (Ubuntu 22.04/24.04 or
   AzureLinux 3). Use
   [node selectors](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector)
   or [taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
   to constrain workloads to compatible nodes.

## Next steps

- [Use the Azure Managed Lustre CSI driver with AKS](/azure/azure-managed-lustre/use-csi-driver-kubernetes)
- [Azure Managed Lustre file system overview](/azure/azure-managed-lustre/amlfs-overview)
- [General cluster extension deployment errors](/troubleshoot/azure/azure-kubernetes/extensions/cluster-extension-deployment-errors)
- [CSI driver troubleshooting guide](https://github.com/kubernetes-sigs/azurelustre-csi-driver/blob/main/docs/csi-debug.md) — advanced debugging commands for driver developers

If you continue to experience issues,
[create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot)
for Microsoft to investigate and resolve.
