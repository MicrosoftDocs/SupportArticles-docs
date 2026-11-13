---
title: Troubleshoot Pod snapshot cluster extension errors in AKS
description: Troubleshoot Pod snapshot cluster extension errors in AKS. Learn how to resolve snapshot capture, restore, storage, and cleanup failures today.
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: wangamanda
ms.topic: troubleshooting
ms.date: 11/13/2026
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
ai-usage: ai-assisted
---

# Troubleshoot Pod snapshot cluster extension errors in Azure Kubernetes Service (preview)

## Summary

This article helps you troubleshoot Pod snapshot cluster extension errors (`Microsoft.PodSnapshot`) in Azure Kubernetes Service (AKS) so you can quickly resolve failures. It covers extension installation, component availability, policy and storage readiness, snapshot capture, restore authorization, runtime compatibility, and deletion.

> [!IMPORTANT]
> Use this article for an installation managed through the AKS cluster extension, not a self-managed Helm installation.

[!INCLUDE [preview features callout](~/reusable-content/ce-skilling/azure/includes/aks/includes/preview/preview-callout.md)]

The Pod snapshot cluster extension manages its installed Kubernetes resources. Don't repair an extension-managed installation through direct Helm upgrades, webhook changes, extra permissions for managed components, finalizer removal, or changes to the managed node runtime. Correct customer-managed policy, storage, and workload settings through your normal configuration management process. Contact Azure support if an extension-managed resource needs repair.

The Pod snapshot cluster extension doesn't create or default a workload's RuntimeClass. A successful extension installation doesn't verify that compatible runtime and node capacity, storage access, or restore authorization are available.

## Error 1: Extension installation fails or managed components are missing

### Symptoms

- The extension provisioning state isn't `Succeeded`.
- The extension reports success, but its release namespace or managed components are missing.
- Snapshot resources don't progress after an extension installation or update.

### Cause

Installation or extension reconciliation didn't complete. A namespace or custom resource definition (CRD) left over from an earlier installation doesn't prove that the extension is currently installed.

### Solution

1. Find the installed extension name. Don't assume that its instance name matches its extension type:

   ```bash
   az k8s-extension list \
     --resource-group "$RESOURCE_GROUP" \
     --cluster-name "$CLUSTER_NAME" \
     --cluster-type managedClusters \
     --query "[?extensionType=='Microsoft.PodSnapshot' || extensionType=='microsoft.podsnapshot'].{name:name,type:extensionType,state:provisioningState}" \
     --output table
   ```

1. If an entry exists, set `EXTENSION_NAME` to the returned name and inspect a filtered view of its status:

   ```bash
   EXTENSION_NAME="<installed-extension-name>"

   az k8s-extension show \
     --resource-group "$RESOURCE_GROUP" \
     --cluster-name "$CLUSTER_NAME" \
     --cluster-type managedClusters \
     --name "$EXTENSION_NAME" \
     --query '{name:name,extensionType:extensionType,provisioningState:provisioningState,currentVersion:currentVersion,releaseTrain:releaseTrain,scope:scope,extensionState:extensionState,errorInfo:errorInfo,statuses:statuses}' \
     --output json
   ```

   Preserve the error, operation or correlation ID, and time of the failure before retrying. Don't share unfiltered `az k8s-extension show` output because it can contain protected configuration settings.

1. For package, Helm, or extension deployment errors, follow the **Standard extension or Kubernetes application: Helm-based deployment** guidance in [Troubleshoot errors when deploying AKS cluster extensions](cluster-extension-deployment-errors.md#identifying-the-extension-category).
1. Set `EXTENSION_NAMESPACE` to the release namespace reported by the extension's `scope`. The default is `pod-snapshot-system`:

   ```bash
   EXTENSION_NAMESPACE="pod-snapshot-system"
   ```

1. Check the in-cluster resources:

   ```bash
   kubectl get namespace "$EXTENSION_NAMESPACE"
   kubectl get deployment,daemonset,pod,service \
     --namespace "$EXTENSION_NAMESPACE" --output wide
   ```

   The `pod-snapshot-manager` deployment must be ready. For Kata workloads that use Azure Blob Storage, the `pod-snapshot-node-worker` DaemonSet must be ready on eligible nodes, and the `pod-snapshot-broker` deployment must be ready. Not every installation uses these storage and execution components.

1. If no extension entry exists, confirm that the Pod snapshot cluster extension was installed on the intended cluster through the supported cluster extension installation process. Don't create a separate Helm installation to repair it.
1. If Azure reports success but managed resources remain missing, [contact Azure support](#collect-diagnostics-and-contact-support). Don't manually recreate managed components or their permissions.

## Error 2: Extension components are unavailable or keep restarting

### Symptoms

- An extension deployment has fewer ready or available replicas than desired.
- Node-worker pods aren't ready on eligible Kata nodes.
- Extension pods are `Pending`, `ImagePullBackOff`, or `CrashLoopBackOff`.
- Snapshot capture, restore preparation, or cleanup stops progressing.

### Cause

Possible causes include insufficient cluster resources, scheduling restrictions, image pull failures, failed readiness probes, memory exhaustion, or Kubernetes API access errors. A node failure can also prevent the node worker from running.

### Solution

1. Inspect the component status and events in the extension's release namespace:

   ```bash
   kubectl get deployment,daemonset,pod \
     --namespace "$EXTENSION_NAMESPACE" --output wide
   kubectl get events --namespace "$EXTENSION_NAMESPACE" \
     --sort-by=.metadata.creationTimestamp
   ```

1. Describe an affected pod. Check scheduling events, container waiting messages, termination reasons, and restart counts:

   ```bash
   EXTENSION_POD="<extension-pod-name>"

   kubectl describe pod "$EXTENSION_POD" \
     --namespace "$EXTENSION_NAMESPACE"
   kubectl logs "$EXTENSION_POD" \
     --namespace "$EXTENSION_NAMESPACE" \
     --all-containers=true --timestamps --since=30m
   ```

   If a container restarted, also collect its previous logs. Set `EXTENSION_CONTAINER` to that container's name:

   ```bash
   EXTENSION_CONTAINER="<restarted-container-name>"

   kubectl logs "$EXTENSION_POD" \
     --namespace "$EXTENSION_NAMESPACE" \
     --container "$EXTENSION_CONTAINER" \
     --previous --timestamps --tail=1000
   ```

1. Resolve the specific cluster dependency identified by events, such as insufficient node capacity or blocked access to the image registry. If the assigned node isn't ready, see [Basic troubleshooting of a node that's not ready](../availability-performance/node-not-ready-basic-troubleshooting.md).
1. If logs report forbidden operations or managed configuration errors, contact Azure support. Don't grant `cluster-admin`, edit managed Kubernetes roles, or patch managed deployments or DaemonSets as a workaround.
1. After resolving the reported failure, verify that the required components are ready and that the affected capture, restore, or cleanup progresses.

## Error 3: A policy or storage configuration isn't ready

### Symptoms

- A PodSnapshotPolicy or PodSnapshotStorageConfig reports `Ready=False`.
- A trigger reports `PolicyNotReady`.

### Cause

The policy contains unsupported settings, or its referenced storage configuration is missing or invalid. The policy's aggregate `Ready` message doesn't identify which detailed check failed.

### Solution

1. Inspect the policy and its referenced storage configuration:

   ```bash
   POLICY_NAME="<policy-name>"
   STORAGE_CONFIG_NAME="<storage-configuration-name>"

   kubectl get podsnapshotpolicy "$POLICY_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" --output yaml
   kubectl get podsnapshotstorageconfig "$STORAGE_CONFIG_NAME" --output yaml
   ```

1. Check the policy's `PolicySpecSupported` and `StorageConfigValid` conditions. Read the `message` for each condition that's false. Compare `status.observedGeneration`, where present, with `metadata.generation` to determine whether the controller processed your latest changes.
1. Correct the customer-managed configuration identified by the message:
   - For `PolicySpecSupported`, check the selector, trigger, schedule, `postCheckpoint`, and retention settings.
   - For `StorageConfigValid`, verify that the referenced storage configuration exists and is ready. Configure exactly one supported storage backend. For Azure Blob Storage, specify a nonempty account and container.
1. Recheck the conditions. The policy's aggregate `Ready` condition becomes true only when both detailed checks pass.

A valid storage configuration confirms structural validation, not live access to Azure Blob Storage. If capture or restore still fails with an authorization error, use the [storage access checks](#error-4-snapshot-storage-access-fails).

## Error 4: Snapshot storage access fails

### Symptoms

- A capture or restore reports an Azure Blob Storage authorization error.
- Upload or download fails.
- Restore reports a missing or incompatible snapshot archive.

### Cause

Possible causes include an incorrect account or container, a managed identity configuration error, missing Blob data permissions, or an unavailable snapshot archive. A successful configuration validation doesn't verify storage connectivity or authorization.

### Solution

For an installation that uses Azure Blob Storage:

1. Confirm the account and container in the referenced `PodSnapshotStorageConfig`. The account must match the broker's configured `broker.storageAccount`; the broker rejects a mismatch even when Azure permissions are correct. For restore or deletion, check the snapshot's recorded `status.storageStatus.azureBlob` location. Changing the storage configuration doesn't move existing snapshots.
1. Inspect the identity associated with the broker's service account:

   ```bash
   kubectl get serviceaccount pod-snapshot-broker \
     --namespace "$EXTENSION_NAMESPACE" --output yaml
   ```

1. Verify that the configured identity has the **Storage Blob Data Contributor** role at storage account scope. If that role is scoped only to the container, also grant **Storage Blob Delegator** at account scope: the broker needs an account-level user-delegation key. Check its workload identity configuration, including the tenant and federated identity subject for the actual release namespace. For background, see [Microsoft Entra Workload ID on AKS](/azure/aks/workload-identity-overview) and [Assign an Azure role for access to blob data](/azure/storage/blobs/assign-azure-role-data-access).
1. Inspect the broker and node-worker logs for the failure interval:

   ```bash
   kubectl logs --namespace "$EXTENSION_NAMESPACE" \
     --selector app.kubernetes.io/name=pod-snapshot-broker \
     --all-containers=true --prefix --timestamps \
     --since=30m --tail=1000 --max-log-requests=20
   kubectl logs --namespace "$EXTENSION_NAMESPACE" \
     --selector app.kubernetes.io/name=pod-snapshot-node-worker \
     --all-containers=true --prefix --timestamps \
     --since=30m --tail=1000 --max-log-requests=20
   ```

   Adjust the time range and line limit to include the failure. If a container restarted, also collect its previous logs by using the [component availability checks](#error-2-extension-components-are-unavailable-or-keep-restarting).
1. Correct the customer-managed storage or identity settings identified by the error. Don't edit extension-managed deployments or add credentials to node-worker pods.

A storage command that returns `403` for your own signed-in identity doesn't establish whether the extension's identity has access. Diagnose the identity used by the Pod snapshot cluster extension.

If a snapshot archive is missing or incompatible, use another ready snapshot or create a new snapshot from an available source workload. Don't rename or manually convert stored archives. If an extension update is still rolling out, let it complete before retrying.

## Error 5: A manual or scheduled snapshot doesn't complete

### Symptoms

- A `PodSnapshotManualTrigger` doesn't complete.
- A `PodSnapshot` doesn't report `Ready=True`.
- A schedule doesn't produce a usable snapshot.

### Cause

The policy isn't ready, no eligible source pod is available, the workload contains unsupported containers, or capture or storage processing fails.

### Solution

1. List the snapshot resources in the affected namespace:

   ```bash
   kubectl get podsnapshotpolicies,podsnapshotmanualtriggers,podsnapshots \
     --namespace "$WORKLOAD_NAMESPACE" --output wide
   ```

1. Inspect the affected trigger, snapshot, source pod, and events. Also inspect the corresponding `Snapshot` [node operation](#inspect-node-operations):

   ```bash
   TRIGGER_NAME="<trigger-name>"
   SNAPSHOT_NAME="<snapshot-name>"
   SOURCE_POD="<source-pod-name>"

   kubectl get podsnapshotmanualtrigger "$TRIGGER_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" --output yaml
   kubectl get podsnapshot "$SNAPSHOT_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" --output yaml
   kubectl describe pod "$SOURCE_POD" --namespace "$WORKLOAD_NAMESPACE"
   kubectl get events --namespace "$WORKLOAD_NAMESPACE" \
     --sort-by=.metadata.creationTimestamp
   ```

1. Use the reported reason to choose the next action:

   | Reason or condition | Action |
   | --- | --- |
   | `PolicyNotReady` | Correct the policy's detailed conditions. |
   | `PrerequisiteNotReady` | Read the condition message and warning event. Resolve the identified source, node, policy, or storage prerequisite. |
   | `PodSnapshotUnsupportedContainers` | Use a supported workload. Incomplete init containers, native sidecars that use `restartPolicy: Always`, and ephemeral containers aren't supported. Completed one-shot init containers are supported. |
   | `PodSnapshotInstanceTypeUnsupported` | For Kata capture, use an eligible x86 D, E, or F family v6 or v7 VM SKU. |
   | `PodSnapshotSourcePodUnavailable` | Check whether the original source pod was deleted or replaced. A replacement pod has a different UID. |
   | `NoEligiblePod` | Check the policy's selector and whether a matching pod is ready. |
   | `ConcurrencyForbidden` | Let the active capture finish before expecting another scheduled capture. |
   | `TooManyMissedTimes` | Review the schedule and the policy's `Scheduled` condition. Collect diagnostics if scheduling doesn't recover. |

1. For a scheduled capture, also inspect the policy's `Scheduled` condition and `status.active`. Each schedule occurrence captures one representative ready pod, not every matching replica.
1. Verify completion. A successful manual trigger has `Triggered=True` with reason `Complete`. A usable snapshot has `Checkpoint=True`, `StorageReplicated=True`, and `Ready=True`, and capture emits an `AKSPodSnapshotted` event.

If you configure `postCheckpoint: stop`, also inspect the snapshot's `PostCheckpointStop` condition and the `AKSPodStoppedAfterCheckpoint` event. `Ready=True` alone doesn't prove that source-pod deletion is finished. `PostCheckpointStopPending` means source-stop protection is still pending.

Don't delete triggers or retry an uncertain capture merely to force progress. A readiness-probe warning while the source workload is temporarily frozen doesn't, by itself, establish capture failure. The Pod snapshot cluster extension doesn't make external services or volume contents transactionally consistent with captured memory; validate your application's storage recovery and reconnection behavior.

## Error 6: Restore pod creation is denied

### Symptoms

- Kubernetes rejects a restore pod during admission.
- Admission reports missing restore permissions or an unavailable snapshot.
- Admission reports a template mismatch or unsupported workload configuration.

### Cause

The caller lacks the custom `restore` permission, the selected snapshot isn't usable, or the restore pod doesn't satisfy compatibility checks.

### Solution

1. Read the full admission error and confirm that the selected snapshot exists in the workload's namespace, isn't being deleted, and has `Ready=True`:

   ```bash
   SNAPSHOT_NAME="<snapshot-name>"

   kubectl get podsnapshot "$SNAPSHOT_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" --output yaml
   ```

1. If admission reports `dry-run is not supported for Azure Blob restore staging`, check whether your deployment tool uses a server-side dry run. Azure Blob restores reject these requests, including `kubectl diff`, even with asynchronous staging enabled. Use a normal create or apply only when you're ready to perform the restore.
1. Check the identity that creates the pod. For a direct request, check your current identity:

   ```bash
   kubectl auth can-i restore \
     "podsnapshots.podsnapshot.aks.azure.com/$SNAPSHOT_NAME" \
     --namespace "$WORKLOAD_NAMESPACE"
   ```

   Restoring through Deployments, ReplicaSets, and Jobs isn't supported in this preview. Create a raw Pod or use the Agent Sandbox cluster extension restore workflow instead. Don't grant the `restore` verb to built-in Kubernetes controllers to bypass this restriction.

   For a Sandbox pod, check the Agent Sandbox controller's restore permission. Using `--as` requires impersonation permission.

   ```bash
   SERVICE_ACCOUNT_NAMESPACE="agent-sandbox-system"
   SERVICE_ACCOUNT_NAME="agent-sandbox-controller"

   kubectl auth can-i restore \
     "podsnapshots.podsnapshot.aks.azure.com/$SNAPSHOT_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" \
     --as="system:serviceaccount:$SERVICE_ACCOUNT_NAMESPACE:$SERVICE_ACCOUNT_NAME"
   ```

   An impersonation permission error doesn't establish whether restore access is granted. If restore authorization is missing, ask your cluster administrator to grant the required access at the appropriate scope. The extension provides the `pod-snapshot-restorer` ClusterRole but doesn't create a restore binding by default. Don't grant `cluster-admin` as a workaround.

   Authorizing a shared controller delegates restore capability to workloads that can cause it to create restore pods. Review workload write permissions and snapshot isolation before granting access.

1. Verify the restore opt-in label and, for explicit selection, the snapshot annotation in the pod manifest:

   ```yaml
   metadata:
     labels:
       podsnapshot.aks.azure.com/restore: "true"
     annotations:
       podsnapshot.aks.azure.com/restore-from: <snapshot-name>
   ```

   This example is a manifest fragment. For a Sandbox, restore intent belongs in `spec.podTemplate.metadata`, not the Sandbox's top-level metadata.

1. Compare the authored container template with the snapshot's source workload. For implicit Kata restore, container names, images, commands, and arguments must match exactly. Completed init containers must also match in identity, order, and restart policy. Resource requests and limits aren't part of snapshot selection, but must be sufficient to run the restored workload. Don't add native sidecars or ephemeral containers.
1. For asynchronous Kata restore, don't preassign `spec.nodeName`. Allow the extension to select a compatible node. If the error reports no compatible node, use the [Kata placement checks](#error-7-no-compatible-node-is-available-for-kata-restore).
1. For a controller-created Sandbox pod, also follow the [Agent Sandbox restore checks](troubleshoot-agent-sandbox-cluster-extension.md#error-10-a-sandbox-restore-is-denied-doesnt-progress-or-uses-the-wrong-snapshot). Verify the controller's restore permission and the selected same-namespace snapshot. Suspend the Sandbox and wait for its old backing pod to be deleted before changing restore selection.

Don't bypass an admission denial by changing webhooks, disabling admission policies, or adding runtime-private annotations.

## Error 7: No compatible node is available for Kata restore

### Symptoms

- Restore admission reports that no compatible node exists.
- The cluster has ready nodes, but none satisfy restore placement requirements.

### Cause

Kata restore requires the exact source Azure VM SKU recorded in the snapshot. A matching VM family or generation isn't sufficient. Other scheduling constraints can also exclude a matching node.

### Solution

1. Read the recorded source SKU.

   ```bash
   SNAPSHOT_NAME="<snapshot-name>"

   kubectl get podsnapshot "$SNAPSHOT_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" \
     --output jsonpath='{.status.sourceInstanceType}{"\n"}'
   ```

1. Compare it with the cluster's nodes.

   ```bash
   kubectl get nodes --output wide \
     --label-columns node.kubernetes.io/instance-type,kubernetes.azure.com/agentpool
   ```

1. Provide ready, eligible Kata node capacity with the exact source SKU. Confirm that the restore pod's node selector, required affinity, tolerations, and resource requests allow placement on that capacity. For general placement errors, see [Troubleshoot pod scheduler errors](../availability-performance/troubleshoot-pod-scheduler-errors.md).
1. Verify that the intended RuntimeClass is present:

   ```bash
   kubectl get runtimeclass
   ```

   The Pod snapshot cluster extension doesn't create or default a workload's RuntimeClass. Don't change the recorded source SKU or choose a different runtime merely to bypass compatibility checks.

## Error 8: A restore pod remains SchedulingGated

### Symptoms

- A Kata restore pod stays in a `SchedulingGated` state.
- The pod has the `podsnapshot.aks.azure.com/awaiting-restore` scheduling gate.
- Pod events report `AKSPodRestoreStaging`, possibly with preparation warnings.

### Cause

For asynchronous Azure Blob restore, the system must download and verify the snapshot on the selected node before scheduling. You can expect this gate during preparation. Storage access, archive validation, or node availability failures can prevent preparation from completing.

### Solution

1. Check the pod's scheduling gates and events:

   ```bash
   RESTORE_POD="<restore-pod-name>"

   kubectl describe pod "$RESTORE_POD" --namespace "$WORKLOAD_NAMESPACE"
   ```

1. If preparation is progressing without warnings, wait for it to finish. The Pod snapshot cluster extension removes the gate after preparation succeeds.
1. If warnings indicate a storage or archive failure, follow [Snapshot storage access fails](#error-4-snapshot-storage-access-fails). Check whether the selected node and its node-worker pod are ready.
1. If preparation remains blocked, inspect the corresponding `PrepareRestore` [node operation](#inspect-node-operations). Collect the pod events and the manager, node-worker, and broker logs for the same time interval.

Don't remove the gate manually or repeatedly delete and recreate the pod to bypass preparation. A failed preparation doesn't cause the Pod snapshot cluster extension to start the workload from scratch.

## Error 9: A running pod doesn't have a confirmed restore

### Symptoms

- A restore pod becomes ready, but no `AKSPodRestored` event appears.
- Events report `AKSPodRestoreFailed` with `RestoreBackendUnconfirmed` or `RestoreBackendUnsupported`.
- Pod readiness doesn't establish that the expected application state was restored.

### Cause

Pod readiness isn't proof that the expected application state was restored. For Kata, the Pod snapshot cluster extension uses a `ConfirmRestore` node operation to check the destination runtime.

### Solution

1. Inspect events for the restored pod:

   ```bash
   RESTORE_POD="<restore-pod-name>"

   kubectl get events --namespace "$WORKLOAD_NAMESPACE" \
     --field-selector involvedObject.kind=Pod,involvedObject.name="$RESTORE_POD" \
     --sort-by=.metadata.creationTimestamp
   ```

1. Check the snapshot's last access time as supporting evidence:

   ```bash
   SNAPSHOT_NAME="<snapshot-name>"

   kubectl get podsnapshot "$SNAPSHOT_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" \
     --output jsonpath='{.status.lastAccessTime}{"\n"}'
   ```

   Correlate this timestamp with the specific restore attempt. A timestamp from another restore doesn't confirm this pod's result.

1. If a failure event reports an unconfirmed or unsupported backend, treat the restore as failed even if the pod is running. Inspect the `ConfirmRestore` [node operation](#inspect-node-operations) for Kata. Preserve the pod and snapshot details, events, node image version, RuntimeClass, and relevant extension logs for Azure support.
1. Verify that restore events include `AKSPodRestored` and check application-level state continuity. Pod readiness or a snapshot access timestamp alone doesn't prove that the expected in-memory state was restored.

For supported Kata runtimes, the workload resumes from the prepared snapshot or fails to start; it doesn't silently start from scratch. Don't modify managed `containerd` settings to force confirmation.

## Error 10: CreateContainerError reports a missing image content digest

### Symptoms

A source or restore pod enters `CreateContainerError`. Its events contain messages similar to these:

```text
failed to extract layer (...) to erofs
failed to get reader from content store: content digest sha256:...: not found
```

### Cause

The node runtime fails while preparing the image for Kata. This failure happens before the workload can participate in capture or restore and isn't caused by the Pod snapshot cluster extension.

### Solution

1. Collect the pod's full waiting-state message and events with `kubectl describe pod`.
1. Record the exact image digest, RuntimeClass, node image, and container runtime version.

   ```bash
   kubectl get nodes \
     --output custom-columns='NAME:.metadata.name,NODE_IMAGE:.metadata.labels.kubernetes\.azure\.com/node-image-version,RUNTIME:.status.nodeInfo.containerRuntimeVersion'
   ```

1. Determine whether the same image digest starts on an equivalent Kata node. A successful image pull on a non-Kata node doesn't verify that the image can start with Kata.
1. Contact Azure support if the runtime error persists. Plan any node replacement or reimage through supported AKS node-management procedures and account for workload disruption.

Don't directly modify the node's image content store, restart `containerd`, or alter the node filesystem as a repair.

## Error 11: Snapshot retention or deletion doesn't complete

### Symptoms

- A policy reports `RetentionSatisfied=False` with reason `RetentionQuota`.
- A PodSnapshot remains terminating with the `podsnapshot.aks.azure.com/storage` finalizer.
- Snapshot deletion doesn't complete before planned extension removal.

### Cause

The `maxSnapshots` setting limits usable ready snapshots per policy, not per pod or per failed attempt. Retention can temporarily exceed that limit when active capture, restore, or source-stop work protects snapshots.

Deletion also waits for coordinated storage cleanup. An unavailable execution component or a storage deletion error can block that cleanup. `Ready=False` or missing public storage status doesn't prove that no stored data needs cleanup.

### Solution

1. Inspect the policy, affected snapshot, and namespace events.

   ```bash
   POLICY_NAME="<policy-name>"
   SNAPSHOT_NAME="<snapshot-name>"

   kubectl get podsnapshotpolicy "$POLICY_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" --output yaml
   kubectl get podsnapshot "$SNAPSHOT_NAME" \
     --namespace "$WORKLOAD_NAMESPACE" --output yaml
   kubectl get events --namespace "$WORKLOAD_NAMESPACE" \
     --sort-by=.metadata.creationTimestamp
   ```

1. Allow active capture, restore, and pending source-stop work to complete. Check the `PostCheckpointStop` condition if applicable.
1. Verify that the manager and the execution components required by your installation are healthy. For Azure Blob cleanup, also verify storage access.
1. For a stuck snapshot, record its deletion timestamp, finalizers, conditions, and relevant pod events. If it has an active restore consumer, let staging and restore observation finish before expecting cleanup to complete. For a restored Sandbox that's no longer needed, delete it through your normal workload management process and wait for its backing pod to be removed.
1. If cleanup doesn't progress, inspect the `DeleteSnapshot` [node operations](#inspect-node-operations) and collect the affected resources and logs for Azure support.
1. Verify that the snapshot object is deleted after cleanup completes. Before extension removal, inventory snapshots in every namespace you manage. An all-namespace inventory requires cluster-wide read permission:

   ```bash
   kubectl get podsnapshots.podsnapshot.aks.azure.com --all-namespaces
   ```

Don't remove finalizers, edit resource status, or manually delete storage artifacts to force completion. These actions can leave stored snapshots or staged data behind.

Before uninstalling the Pod snapshot cluster extension, delete scheduled policies to stop new captures and wait for active captures to finish. Deleting a policy preserves its snapshots. Delete snapshots you no longer need while the Pod snapshot cluster extension is healthy. Wait for their deletion to complete before uninstalling.

If the Pod snapshot cluster extension has already been removed and snapshots remain terminating, contact Azure support for help restoring reconciliation through the same AKS extension management path. Don't create a separate Helm installation. Verify removal through the Azure extension resource; retained CRDs don't establish that cleanup succeeded or failed.

## Inspect node operations

Capture, staging, confirmation, and cleanup run as `PodSnapshotNodeOperation` objects. List them across namespaces if you have cluster-wide read permission:

```bash
kubectl get podsnapshotnodeoperations.internal.podsnapshot.aks.azure.com \
  --all-namespaces
```

For namespace-scoped checks, replace `--all-namespaces` with `--namespace "$WORKLOAD_NAMESPACE"` for capture, staging, and confirmation, or `--namespace "$EXTENSION_NAMESPACE"` for deletion.

Inspect the relevant operation in the namespace returned above:

```bash
OPERATION_NAMESPACE="<operation-namespace>"
OPERATION_NAME="<operation-name>"

kubectl get podsnapshotnodeoperation.internal.podsnapshot.aks.azure.com \
  "$OPERATION_NAME" --namespace "$OPERATION_NAMESPACE" --output yaml
```

Match `spec.snapshotRef` to the snapshot's namespace, name, and UID. Check `spec.action`, `spec.nodeName`, `spec.deadline`, `status.phase`, `status.workerID`, `status.reason`, and `status.message`. The actions are `Snapshot`, `PrepareRestore`, `ConfirmRestore`, and `DeleteSnapshot`. A running operation or uploaded artifact alone doesn't establish completion. Don't edit or delete node operations to force progress.

## Collect diagnostics and contact support

If the issue persists, [create an Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request).

Provide the smallest relevant, sanitized evidence set:

- The cluster resource ID, region, installed extension name and version, release namespace, and failure time range in UTC.
- Filtered extension status, error messages, and operation or correlation IDs.
- Component deployment, DaemonSet, and pod status, deployed image references, restart counts, and relevant events.
- The affected policy, storage configuration, trigger, snapshot, and node operations, including names, namespaces, generations, conditions, and owner references.
- Source and restore pod names, UIDs, RuntimeClasses, node names, and UTC timestamps.
- The exact admission error and the identity that creates the restore pod.
- For Kata, the source and destination VM SKUs, node image versions, and container runtime versions.
- Current manager logs and, when applicable, node-worker and broker logs for the same interval. Include previous container logs only for containers that restarted.
- Whether `AKSPodSnapshotted`, `AKSPodRestoreStaging`, `AKSPodRestored`, or `AKSPodRestoreFailed` occurred.
- For deletion issues, the snapshot's deletion timestamp, finalizers, pending source-stop condition, and active restore consumers.

Collect logs from the manager component of the Pod snapshot cluster extension across the relevant replicas. Adjust the time range and line limit to include the failure:

```bash
kubectl logs --namespace "$EXTENSION_NAMESPACE" \
  --selector app.kubernetes.io/name=pod-snapshot-manager \
  --all-containers=true --prefix --timestamps \
  --since=30m --tail=1000 --max-log-requests=20
```

Don't include Secrets, access tokens, projected tokens, private keys, kubeconfig files, registry credentials, signed storage URLs, protected extension settings, or snapshot contents. Review environment values, commands, arguments, labels, annotations, logs, event messages, DNS names, and storage identifiers for sensitive data before sharing. Preserve the timestamps, condition reasons, image digests, runtime details, and correlation data needed to diagnose the failure.
