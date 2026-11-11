---
title: Troubleshoot Azure Managed Lustre CSI Driver extension errors
description: Fix installation, configuration, and mount errors for the Azure Managed Lustre CSI Driver extension on AKS. Follow these steps to resolve issues.
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: jeffbearer, davidbradley
ms.topic: troubleshooting
ms.service: azure-kubernetes-service
ms.date: 11/11/2026
ms.custom: sap:Extensions, Policies and Add-Ons
ai-usage: ai-assisted
---

# Troubleshoot Azure Managed Lustre CSI Driver extension errors

## Summary

This article helps you troubleshoot Azure Managed Lustre CSI Driver extension errors on Azure Kubernetes Service (AKS). Use it to resolve common installation, configuration, and mount errors for the `microsoft.azuremanagedlustre` extension and get your Lustre volumes working.

The Azure Managed Lustre CSI Driver connects Kubernetes workloads to
[Azure Managed Lustre](/azure/azure-managed-lustre/amlfs-overview) file systems
through persistent volumes. The driver supports both static and dynamic
provisioning. With static provisioning, you create each PersistentVolume (PV)
manually and configure it with the connection details of an existing Azure
Managed Lustre file system. With dynamic provisioning, you define a
StorageClass and the driver creates volumes automatically.

For driver v0.7.0, use the
[current compatibility and lifecycle guidance](/azure/aks/azure-managed-lustre-overview).
The driver requires Kubernetes 1.29 or later. Chart and extension versions are
separate from the driver image version. Check the installed versions before
applying version-specific troubleshooting steps.

## Before you begin

Before running a scenario's pod or log commands, find the driver namespace.
Don't assume that an extension-managed installation uses `kube-system`.
Locate its CSI pods:

```bash
kubectl get pods --all-namespaces \
    -l 'app in (csi-azurelustre-controller,csi-azurelustre-node)' -o wide
```

In the shell where you run the diagnostic commands, replace `<driver-namespace>`
with the namespace of the installation you're diagnosing:

```bash
NAMESPACE='<driver-namespace>'
```

The following commands stop with `Set NAMESPACE first` if this variable is empty or
unset. If installation failed before pods were created, check the extension
status in Scenario 1 instead.

## Scenario 1: Extension installation fails with no visible error

You install the Azure Managed Lustre CSI Driver extension, but the installation
doesn't complete successfully. No clear error message appears.

### Solution 1: Inspect the extension status

Run the following command to check the extension status and find the error
message in the `statuses` property:

```azurecli
az k8s-extension show \
    --resource-group <resource-group-name> \
    --cluster-name <cluster-name> \
    --cluster-type managedClusters \
    --name <extension-name>
```

> [!TIP]
> If you don't remember the extension name you used when you installed it, run
> `az k8s-extension list` to see all extensions on the cluster.

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

Record the installed extension version, release train, provisioning state, and
namespace.

If the status shows `InstallationFailed`, try the solutions in the following
scenarios. If your error message doesn't match any of these scenarios, see
[general cluster extension deployment errors](/troubleshoot/azure/azure-kubernetes/extensions/cluster-extension-deployment-errors).

## Scenario 2: Extension version isn't available in the specified region

You try to install the extension and receive the following error message:

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
   kubectl get pods -n "${NAMESPACE:?Set NAMESPACE first}" -l app=csi-azurelustre-controller -o wide
   ```

1. Check the node DaemonSet pod status.

   ```bash
   kubectl get pods -n "${NAMESPACE:?Set NAMESPACE first}" -l app=csi-azurelustre-node -o wide
   ```

1. If pods are in `CrashLoopBackOff` or `Error` state, check the logs.

   ```bash
   # Controller logs
   kubectl logs -n "${NAMESPACE:?Set NAMESPACE first}" -l app=csi-azurelustre-controller \
       -c azurelustre --tail=100

   # Node logs (from the specific node pod)
   kubectl logs -n "${NAMESPACE:?Set NAMESPACE first}" <node-pod-name> -c azurelustre --tail=100
   kubectl logs -n "${NAMESPACE:?Set NAMESPACE first}" <node-pod-name> -c lustre-loader --tail=100
   ```

   For v0.7.0, a node pod is ready only when all four containers are ready.
   The `lustre-loader` native sidecar installs client packages, loads kernel
   modules, and checks LNet readiness. A `Running` pod alone isn't proof of
   readiness.

1. Verify that the required RBAC resources exist:

   ```bash
   kubectl get clusterrole,clusterrolebinding | grep azurelustre
   ```

   If resources are missing, capture the extension status and pod events,
   and contact Microsoft Support to restore the expected managed resources.
   Don't uninstall and reinstall solely to repair RBAC while volumes remain.
   Don't grant broad cluster permissions as a troubleshooting shortcut.

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

Run PVC commands in the workload's namespace. Use the driver namespace only
for CSI controller and node logs.

1. Check for events on the PVC.

   ```bash
   kubectl describe pvc <pvc-name>
   ```

1. For static provisioning, verify that a PersistentVolume (PV) exists and is
   bound to the PVC. The PV must have the following volume attributes:

   - `mgs-ip-address` — the MGS IP address of your Azure Managed Lustre file system
   - `fs-name` — the filesystem name of your Azure Managed Lustre file system
   - `sub-dir` (optional) — a subdirectory path within the Lustre filesystem.
     If you include this parameter, provide a valid, non-empty subpath.

   You find these values in the Azure portal on the Azure Managed Lustre
   resource under **Client connection**.

1. Check the CSI controller logs for the specific error:

   ```bash
   kubectl logs -n "${NAMESPACE:?Set NAMESPACE first}" -l app=csi-azurelustre-controller \
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

1. For static provisioning, verify that the PVC references a PV that exists
   and has the correct name:

   ```bash
   kubectl get pv
   kubectl get pvc <pvc-name> -o jsonpath='{.spec.volumeName}'
   ```

   If the PVC references a PV name that doesn't exist or is misspelled, the
   PVC stays in `Pending` state. Correct the `volumeName` in the PVC spec to
   match the actual PV name.

1. **If you use dynamic provisioning**, confirm the configured controller
   identity has the
   [required provisioning permissions](/azure/aks/azure-managed-lustre-dynamic-provisioning-reference#permissions).
   For v0.7.0, subscription-wide SKU and subnet-capacity discovery permissions
   are optional, not prerequisites for creating a file system. Don't add
   `mgs-ip-address` to a dynamic StorageClass to work around an unrelated
   validation error. Check the CSI controller logs for the creation error:

   ```bash
   kubectl logs -n "${NAMESPACE:?Set NAMESPACE first}" -l app=csi-azurelustre-controller \
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
   kubectl exec -it <node-pod-name> -n "${NAMESPACE:?Set NAMESPACE first}" -c lustre-loader -- \
       lsmod | grep lustre
   ```

   If this command produces no output, the Lustre client kernel module isn't
   loaded. Inspect the `lustre-loader` logs for package-installation or module
   load errors. Confirm that matching Lustre client and required OS packages
   are available for the running kernel, and that nodes can reach
   `packages.microsoft.com` and the OS package repositories.

   You can also check for existing Lustre mounts on the node:

   ```bash
   kubectl exec -it <node-pod-name> -n "${NAMESPACE:?Set NAMESPACE first}" -c azurelustre -- \
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
   kubectl logs -n "${NAMESPACE:?Set NAMESPACE first}" <node-pod-name> -c azurelustre --tail=100
   kubectl logs -n "${NAMESPACE:?Set NAMESPACE first}" <node-pod-name> -c lustre-loader --tail=100
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

<a id="solution-6-uninstall-the-existing-driver-first"></a>

### Solution 6: Identify the existing installation before migrating

1. Identify the existing installation. If you installed it by using Helm, find the release
   name:

   ```bash
   helm list --all --all-namespaces | grep lustre
   ```

1. Stop before changing ownership or deleting resources. Don't install a
   second driver alongside the existing one. For an existing Helm release
   that needs replacement with v0.7.0, use the
   [remove-and-replace procedure](/azure/aks/azure-managed-lustre-uninstall#upgrade-the-csi-driver),
   not an in-place Helm upgrade.
   Changing from Helm or manifests to a managed extension is a separate
   migration. Contact Microsoft Support if you need to preserve existing
   volumes.

1. If you intend to remove the driver permanently, follow the
   [safe uninstall procedure](/azure/aks/azure-managed-lustre-uninstall#uninstall-the-driver)
   for the actual installation method and namespace. Stop workloads and
   provisioning, wait for unmounts, and decide which file systems to retain
   before deleting claims. Keep the driver running until cleanup completes.

1. After verifying safe removal, follow the
   [installation guide](/azure/aks/azure-managed-lustre-install) for the chosen
   installation method. Confirm the installed extension and driver versions,
   namespace, and node readiness before resuming workloads.

> [!IMPORTANT]
> Driver v0.7.0 blocks removal by default while driver-owned PVs remain,
> including static and retained PVs, or if it can't query the inventory.
> Don't delete live PVs, remove finalizers, force-delete the extension, or
> bypass hooks to clear an installation conflict. With a `Delete` reclaim
> policy, deleting a dynamically provisioned claim can delete the backing
> file system and its data.

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

1. Compare CSI node placement with the nodes intended to run Lustre workloads:

   ```bash
   kubectl get pods -n "${NAMESPACE:?Set NAMESPACE first}" -l app=csi-azurelustre-node -o wide
   kubectl get nodes -L kubernetes.azure.com/os-sku-effective
   ```

   Every intended Lustre workload node needs a ready CSI node pod. A system
   pool excluded by its taints isn't a coverage failure if workloads don't run
   there. Don't compare the pod count with every node in the cluster.

1. Check the OS of each node:

   ```bash
   kubectl get nodes -L kubernetes.azure.com/os-sku-effective -o wide
   ```

   For v0.7.0, scheduling uses `kubernetes.azure.com/os-sku-effective`:
   `Ubuntu2204`, `Ubuntu2404`, or `AzureLinux3`. The Jammy DaemonSet also
   targets `Ubuntu2004` Confidential VM pools as a deprecated compatibility
   path. Inspect architecture and taints as well as the label. AKS manages
   this label; don't set it manually to force a driver onto an unsupported OS.

1. To use Azure Managed Lustre with your cluster, ensure your Lustre workloads
   are scheduled on node pools running a supported OS (Ubuntu 22.04/24.04 or
   AzureLinux 3). Use
   [node selectors](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector)
   or [taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
   to constrain workloads to compatible nodes.

## Scenario 8: Uninstall is blocked by the volume guard

Driver v0.7.0 adds a default pre-delete guard for Helm-based removal and a
volume check in the manifest cleanup script. A remaining PV blocks removal
even when its workload is stopped and its file system is unmounted.

### Solution 8: Inspect the guard and complete safe cleanup

Capture the extension status if the resource still exists, Helm hook Job events,
and guard logs before retrying. Failed Jobs expire and retries replace them. Use the installed
release's namespace and labels, not an assumed `kube-system` namespace.

Follow the
[blocked-uninstall reference](https://github.com/kubernetes-sigs/azurelustre-csi-driver/blob/v0.7.0/charts/README.md#troubleshoot-a-blocked-uninstall).
Resolve remaining PVs through the safe retention and deletion procedure, or restore
the guard's cluster-wide permission to list PVs if the inventory query fails.
An API error isn't proof that no volumes remain. Don't use broad RBAC grants,
remove Helm release secrets, or bypass hooks to clear the error.

For managed extensions, complete volume cleanup before requesting removal.
The guard can't preserve an Azure extension resource that you already deleted
while its Helm release is removed asynchronously. Also verify retained file
systems separately; they remain billable. Replacing an earlier extension with
v0.7.0 requires removal and reinstallation, not an in-place upgrade. Stop and
contact Microsoft Support if a guarded installation blocks replacement while
volumes must be preserved. Use the
[managed-extension precautions](https://github.com/kubernetes-sigs/azurelustre-csi-driver/blob/v0.7.0/charts/README.md#azure-managed-extensions)
and the removal path that matches how the extension was installed. For the
preview AKS CLI enable option, use the separate
[CLI lifecycle guide](/azure/aks/azure-managed-lustre-upgrade-uninstall-cli-preview).

If the Azure extension resource is gone but CSI pods remain, preserve their
events and logs and contact Microsoft Support for recovery. Don't recreate the
extension or run Helm directly against its remaining resources.

## Next steps

- [Use the Azure Managed Lustre CSI driver with AKS](/azure/aks/azure-managed-lustre-overview)
- [Azure Managed Lustre file system overview](/azure/azure-managed-lustre/amlfs-overview)
- [General cluster extension deployment errors](/troubleshoot/azure/azure-kubernetes/extensions/cluster-extension-deployment-errors)
- [CSI driver troubleshooting guide](https://github.com/kubernetes-sigs/azurelustre-csi-driver/blob/main/docs/csi-debug.md) — advanced debugging commands for driver developers

If you continue to experience issues,
[create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot)
for Microsoft to investigate and resolve.
