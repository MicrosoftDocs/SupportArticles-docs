---
title: Troubleshoot managed Kueue extension errors in AKS (preview)
description: Troubleshoot managed Kueue extension errors on Azure Kubernetes Service (AKS), including installation, controller, admission, and removal failures.
ms.topic: troubleshooting
ms.date: 10/22/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: lichen5, josebl
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons
ai-usage: ai-generated
# Customer intent: "As a platform engineer or cluster administrator, I want to diagnose managed Kueue extension failures so I can restore workload admission without losing queue configuration."
---

# Troubleshoot the managed Kueue extension on Azure Kubernetes Service (preview)

## Summary

This article helps you troubleshoot the managed Kueue extension (`microsoft.kueue`) on Azure Kubernetes Service (AKS). It covers installation and updates, controller health, managed Kueue objects, workload admission, cluster autoscaler integration, and failed removal.

Use this article for an Azure-managed extension, not a self-hosted, open-source Kueue installation.

For installation and management instructions, see [Install the managed Kueue extension on AKS](/azure/aks/configure-queues-with-automatic-resource-flavors).

[!INCLUDE [preview features callout](~/reusable-content/ce-skilling/azure/includes/aks/includes/preview/preview-callout.md)]

> [!WARNING]
> Don't uninstall and reinstall managed Kueue as a controller-health workaround. Uninstalling deletes Kueue custom resources, including customer-created queues, Workloads, and other Kueue configuration, and clears blocking finalizers. Surviving Kubernetes Jobs and pods don't preserve queue policy or admission state. See [Uninstall the managed Kueue extension](/azure/aks/kueue-overview#uninstall-the-managed-kueue-extension) before planning removal.

## Choose the matching symptom

The following table helps you choose the troubleshooting section that matches the symptom you're experiencing.

| Symptom | Troubleshooting section |
| --- | --- |
| The CLI rejects an option, or installation or update can't find a version | [Installation or update can't resolve a version](#installation-or-update-cant-resolve-a-version) |
| Installation detects another Kueue controller | [Installation detects an existing Kueue controller](#installation-detects-an-existing-kueue-controller) |
| Installation reports a namespace, image, or chart configuration error | [Installation reports a chart configuration error](#installation-reports-a-chart-configuration-error) |
| Azure reports success, but a controller or Kueue API isn't ready | [Controllers or Kueue APIs aren't ready](#controllers-or-kueue-apis-arent-ready) |
| A create, update, or delete request for a Kueue object is forbidden | [Changes to an AKS-managed object are denied](#changes-to-an-aks-managed-object-are-denied) |
| A managed ResourceFlavor or Topology is missing or can't be updated | [Managed ResourceFlavors or Topology are missing or invalid](#managed-resourceflavors-or-topology-are-missing-or-invalid) |
| A Job remains suspended, or its pods remain pending | [A workload isn't admitted or its pods aren't scheduled](#a-workload-isnt-admitted-or-its-pods-arent-scheduled) |
| An autoscaling admission check is inactive, or capacity provisioning doesn't finish | [Autoscaling admission checks or ProvisioningRequests don't progress](#autoscaling-admission-checks-or-provisioningrequests-dont-progress) |
| Extension deletion fails or appears incomplete | [Extension removal fails or is incomplete](#extension-removal-fails-or-is-incomplete) |

## Diagnose the extension

### Confirm the subscription, cluster, and extension name

Set the resource group and cluster name. Confirm that the Azure subscription and Kubernetes context refer to the intended cluster:

```bash
RESOURCE_GROUP="<resource-group>"
CLUSTER_NAME="<aks-cluster-name>"
RELEASE_TRAIN="preview"

az account show --query '{name:name,id:id}' --output table
kubectl config current-context

az aks show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$CLUSTER_NAME" \
  --query '{id:id,location:location,kubernetesVersion:kubernetesVersion,currentKubernetesVersion:currentKubernetesVersion,provisioningState:provisioningState}' \
  --output json

az k8s-extension list \
  --resource-group "$RESOURCE_GROUP" \
  --cluster-name "$CLUSTER_NAME" \
  --cluster-type managedClusters \
  --query '[].{name:name,type:extensionType,state:provisioningState,version:currentVersion}' \
  --output table
```

Find the extension whose type is `microsoft.kueue`. Use its actual resource name in the remaining examples. The installation guide uses `aks-kueue`; don't assume that an existing extension is named `kueue` or that the Azure resource name is the Kubernetes deployment name.

```bash
EXTENSION_NAME="<extension-resource-name-from-list>"

az k8s-extension show \
  --resource-group "$RESOURCE_GROUP" \
  --cluster-name "$CLUSTER_NAME" \
  --cluster-type managedClusters \
  --name "$EXTENSION_NAME" \
  --query '{name:name,type:extensionType,requestedVersion:version,currentVersion:currentVersion,releaseTrain:releaseTrain,autoUpgradeMode:autoUpgradeMode,provisioningState:provisioningState,extensionState:extensionState,errorInfo:errorInfo,statuses:statuses}' \
  --output json
```

For a successful installation, expect `provisioningState` to be `Succeeded` and the extension to report availability. For an exact-version update, also check that `currentVersion` reaches the requested target. Preserve any `errorInfo`, `statuses`, operation ID, and correlation ID before another lifecycle operation.

### Examine controllers, events, and image versions

The default managed installation uses the `kueue-system` namespace:

| Component | Deployment | Container | Responsibility |
| --- | --- | --- | --- |
| Kueue controller manager | `kueue-controller-manager` | `manager` | Workload admission, queue accounting, and Kueue webhooks |
| AKS Kueue extension controller | `kueue-extension` | `kueue-extension-controller` | Node classification and managed ResourceFlavor and Topology generation |

```bash
kubectl get deployment,pods --namespace kueue-system --output wide
kubectl get events --namespace kueue-system --sort-by=.metadata.creationTimestamp

kubectl get deployment --namespace kueue-system \
  --output custom-columns='NAME:.metadata.name,DESIRED:.spec.replicas,AVAILABLE:.status.availableReplicas,GENERATION:.metadata.generation,OBSERVED:.status.observedGeneration,IMAGE:.spec.template.spec.containers[*].image'

kubectl get pods --namespace kueue-system \
  --output custom-columns='POD:.metadata.name,NODE:.spec.nodeName,CONTAINER:.status.containerStatuses[*].name,RESTARTS:.status.containerStatuses[*].restartCount,IMAGE_ID:.status.containerStatuses[*].imageID'
```

Read the actual deployment and pod names from the cluster. If you intentionally disable managed-object automation for your supported configuration, confirm which components are expected rather than treating the absent extension controller as a failure.

Record both the installed extension version and the resolved container image digests. Error wording and behavior can differ between releases. A source-code change or an upstream fix doesn't prove that the installed managed package contains it.

## Installation or update can't resolve a version

**Symptom:** The command rejects an option, can't resolve a version, returns no compatible versions, or doesn't reach the requested version.

**Cause:** Possible causes include an outdated CLI extension, an unsupported cluster prerequisite, package availability for the cluster and release train, an incompatible version-policy combination, or an unfinished extension operation.

**Resolution:**

1. If the CLI doesn't recognize `--auto-upgrade-mode`, update the local CLI extension and check its version:

    ```bash
    az extension add --name k8s-extension --upgrade
    az extension show --name k8s-extension --query version --output tsv
    ```

1. Check the [managed Kueue prerequisites](/azure/aks/kueue-overview#managed-extension-prerequisites). List versions for the exact cluster and the customer-facing `preview` release train:

    ```bash
    az k8s-extension extension-types list-versions-by-cluster \
      --resource-group "$RESOURCE_GROUP" \
      --cluster-name "$CLUSTER_NAME" \
      --cluster-type managedClusters \
      --extension-type microsoft.kueue \
      --release-train "$RELEASE_TRAIN" \
      --output table
    ```

1. Use a version returned for your cluster. If you specify an exact `--version`, use `--auto-upgrade-mode none`. Don't combine an exact version with automatic upgrades.
1. For an update, select a supported forward version. A suffix alone doesn't establish version precedence. If there's no compatible package or you can't identify a safe target, contact Azure support instead of changing the release train or installing an arbitrary chart.
1. After correcting the cause and confirming that no other extension operation is in progress, use the supported forward update:

    ```bash
    TARGET_EXTENSION_VERSION="<supported-forward-version-from-discovery>"

    az k8s-extension update \
      --resource-group "$RESOURCE_GROUP" \
      --cluster-name "$CLUSTER_NAME" \
      --cluster-type managedClusters \
      --name "$EXTENSION_NAME" \
      --release-train "$RELEASE_TRAIN" \
      --version "$TARGET_EXTENSION_VERSION" \
      --auto-upgrade-mode none \
      --yes \
      --query '{name:name,provisioningState:provisioningState,currentVersion:currentVersion}' \
      --output json
    ```

1. Recheck extension status, the installed version, controller readiness, and required Kueue APIs. A healthy previous version doesn't prove that the requested update completed.

Don't use a downgrade, `helm rollback`, or uninstall and reinstall of an older package as a troubleshooting workaround. If forward recovery fails, preserve the operation details and request Azure support before further changes.

## Installation detects an existing Kueue controller

**Symptom:** Installation fails with a message that starts with `managed Kueue preflight failed: detected existing Kueue controller-manager Deployment`.

**Cause:** Kueue is a cluster singleton. The managed extension rejects an unmanaged controller or one owned by a different release, including a controller in another namespace. Installing the managed extension isn't an in-place adoption or ownership-transfer procedure for an existing installation.

**Resolution:**

1. Stop managed-extension retries on the affected cluster.
1. Record the deployment and namespace named in the error. With the cluster administrator, inspect the existing controller, its image, and its Helm ownership metadata:

    ```bash
    EXISTING_NAMESPACE="<namespace-from-error>"
    EXISTING_CONTROLLER="<deployment-from-error>"

    kubectl get deployment "$EXISTING_CONTROLLER" \
      --namespace "$EXISTING_NAMESPACE" --output yaml
    ```

1. Choose one of the following installation paths:

    - Uninstall the existing Kueue controller first, then install the managed Kueue extension. Use the supported removal procedure for the existing installation. Before removal, preserve the Kueue configuration and review active and queued workloads with the queue owner.
    - Install the managed Kueue extension on a new, clean AKS cluster that has no existing Kueue controller.

1. If the failed managed operation affects the existing installation, collect the extension error, controller state, CRD state, and operation IDs, and contact Azure support before another lifecycle request.

Don't add AKS management labels, rewrite Helm ownership annotations, delete Kueue CRDs, or delete the failed extension merely to bypass the conflict. Deleting a Kueue CRD also deletes its custom resources. The rejection alone doesn't prove that every part of the previous installation is unchanged.

## Installation reports a chart configuration error

**Symptom:** A supported extension operation fails during chart rendering or installation.

**Cause and resolution:** Preserve the complete error, including the outer Azure extension error. The following fragments identify different boundaries:

| Error fragment | Next action |
| --- | --- |
| `the Kueue extension must be installed into the 'kueue-system' namespace` | Confirm the namespace in the failed operation. Managed Kueue requires `kueue-system`. Use the documented managed installation settings. If a supported request still targets another namespace, contact Azure support. Don't move the controller or change its service account manually. |
| `image.repository is required`, `image.digest is required`, or `image.digest must be sha256:` | These fragments identify a managed-package image configuration problem. Contact Azure support with the extension version and full error. Don't supply a mutable image tag or patch the deployment. |
| `managedObjectsLifecycle.kubectlImage` or a rejected controller flag or `extraArgs` value | These fragments identify managed chart or image compatibility errors. Request a corrected managed package through Azure support, not a direct Helm override. |
| `provisioningrequests.autoscaling.x-k8s.io already exists but does not serve v1` | The operation detected an incompatible shared API. Preserve the CRD definition and contact Azure support or its owning platform administrator. Don't delete the shared CRD or another component's requests. |

If the Azure API rejects an unsupported setting, remove that setting from the request according to the managed installation guide. Don't try to bypass API validation by applying Helm values directly.

## Controllers or Kueue APIs aren't ready

**Symptom:** The extension reports `Succeeded`, but a controller has no available replica, a pod isn't ready, or Kueue API discovery fails.

**Resolution:**

1. Check the expected deployment rollouts and core CRDs. These checks are read-only and have finite timeouts. Omit the `kueue-extension` check only if your supported configuration intentionally disables managed-object automation:

    ```bash
    kubectl rollout status deployment/kueue-controller-manager \
      --namespace kueue-system --timeout=5m
    kubectl rollout status deployment/kueue-extension \
      --namespace kueue-system --timeout=5m

    kubectl wait --for=condition=Established \
      crd/workloads.kueue.x-k8s.io \
      crd/localqueues.kueue.x-k8s.io \
      crd/clusterqueues.kueue.x-k8s.io \
      crd/resourceflavors.kueue.x-k8s.io \
      crd/topologies.kueue.x-k8s.io \
      --timeout=2m
    ```

1. If a check fails, use deployment status and events to identify the affected pod. Collect its description, current logs, and, if the container restarted, previous logs:

    ```bash
    CONTROLLER_POD="<affected-controller-pod>"
    CONTROLLER_CONTAINER="<manager-or-kueue-extension-controller>"

    kubectl describe pod "$CONTROLLER_POD" --namespace kueue-system
    kubectl logs "$CONTROLLER_POD" --namespace kueue-system \
      --container "$CONTROLLER_CONTAINER" --timestamps --tail=1000
    kubectl logs "$CONTROLLER_POD" --namespace kueue-system \
      --container "$CONTROLLER_CONTAINER" --previous --timestamps --tail=1000
    ```

    `--previous` reads the previous instance of a container in the same pod. It doesn't retrieve a deleted pod's logs. If there was no previous container, that command can return an error without indicating another Kueue failure.

1. Choose the next action from the observed evidence:

    | Evidence | Investigation and next action |
    | --- | --- |
    | `ErrImagePull` or `ImagePullBackOff` | Read the exact event for a missing image, denied registry access, DNS, TLS, or timeout failure. Preserve the image reference and node architecture. Resolve a customer-controlled network restriction if identified; request Azure support for a managed image or package problem. Don't replace the pinned image. |
    | Pending controller pod | Inspect node readiness, available CPU and memory, affinity, taints, tolerations, and admission events. Don't assume the controller can run only on a system pool. Don't patch managed placement rules to hide the cause. |
    | `CrashLoopBackOff` | Read previous logs and the termination reason. Messages such as `unable to start manager` or `unable to create controller` require the underlying flag, API, configuration, or permission error. A restart doesn't correct that cause. |
    | `OOMKilled` | Correlate the affected controller's memory limit, workload and object scale, and recent version changes. Node memory pressure and another workload's OOM aren't the same problem. Contact Azure support before changing managed resource limits. |
    | Running but unready, or webhook calls fail | Inspect probe failures, service endpoints, API connectivity, certificate errors, and permissions. Don't disable the webhook, its failure policy, or managed-object admission protection. |

If the deployment or Helm configuration was deleted or changed, a pod restart can't reconstruct it. An earlier `Succeeded` operation isn't proof of current configuration health, and automatic version upgrades don't guarantee periodic Helm drift repair. Request a supported extension recovery operation through Azure support.

Before resuming workload changes, verify both controller readiness and the required APIs. Process health alone doesn't prove that the extension can write managed objects.

## Changes to an AKS-managed object are denied

**Symptom:** A Kueue create, update, or delete returns `Forbidden` and identifies policy `kueue-extension-managed-object-guard`. The message can include `is managed by the AKS Kueue extension and may not be modified` or `objects managed by the AKS Kueue extension are not user-modifiable`.

**Cause:** The request targets a protected object or a reserved name. Managed releases protect objects with the `kueue-extension.aks.azure.com/vap-protected: "true"` label. Reserved names are specific to each resource type, not a blanket ban on every `aks-*` name:

| Resource type | Reserved names in releases that install these defaults |
| --- | --- |
| ResourceFlavor | Names that start with `aks-` |
| Topology | `aks-default` |
| WorkloadPriorityClass | `aks-high-priority`, `aks-medium-priority`, `aks-low-priority` |
| ProvisioningRequestConfig | `aks-provisioning-config` |
| AdmissionCheck | `aks-provisioning-check` |

**Resolution:**

1. Preserve the complete denial, timestamp, operation, caller, object kind and name, and extension version. Check the installed policy if you have read access:

    ```bash
    kubectl get validatingadmissionpolicy kueue-extension-managed-object-guard \
      --output yaml
    ```

1. For customer-owned configuration, create a separate user-managed object with a permitted name and no AKS protection marker. Don't copy a managed object's ownership metadata or protection label. Review queue references and workload impact with the queue owner before changing them.
1. If an AKS-managed object needs repair, contact Azure support. Don't remove its protection marker, disable the policy, broaden RBAC, or remove queue references and recreate the object as a generic workaround.
1. If the denied caller is a platform controller or lifecycle hook, changing a customer's object name isn't the fix. Preserve the full API cause and ask Azure support to investigate the owning identity, RBAC, and admission contract. A generic 403 alone doesn't identify which policy or permission denied the write.

Verify that the intended user-managed operation succeeds, or that the supported platform repair restores the required managed write. A successful unrelated request doesn't prove recovery.

## Managed ResourceFlavors or Topology are missing or invalid

**Symptom:** An expected managed ResourceFlavor is absent, a ClusterQueue reports `Active=False` with `TopologyNotFound`, or the extension repeatedly fails to write a ResourceFlavor or Topology.

**Resolution:**

1. Inspect the objects, affected queue, and current node labels:

    ```bash
    CLUSTER_QUEUE="<affected-clusterqueue>"

    kubectl get resourceflavors.kueue.x-k8s.io,topologies.kueue.x-k8s.io
    kubectl describe clusterqueue "$CLUSTER_QUEUE"
    kubectl get nodes \
      --label-columns=kubernetes.azure.com/mode,node.kubernetes.io/instance-type,kubernetes.azure.com/node-type,kubernetes.azure.com/sku-series,kubernetes.azure.com/sku-gpu-name
    kubectl logs deployment/kueue-extension --namespace kueue-system \
      --container kueue-extension-controller --timestamps --tail=1000
    ```

1. Distinguish missing eligible inventory from a failed object write:

    - System nodes aren't classified as user workload capacity. Excluded FlexNode inventory isn't automatically a controller failure.
    - A new node can be waiting for its instance-type label during registration. If that label remains absent, record the node and pool and investigate the platform label-writing path.
    - An unknown GPU SKU or an incomplete SKU-series and GPU-name label pair can exclude a GPU node from generated inventory. Don't relabel GPU hardware as CPU or manually write protected AKS labels. Contact Azure support with the instance type and current labels.
    - GPU flavor generation depends on supported GPU classification and device-plugin resource discovery. Investigate the actual GPU driver or plugin state; don't assume every GPU provisioning mechanism is supported by the installed version.
    - For `TopologyNotFound`, inspect the referenced Topology and the extension's write error. An available controller doesn't prove that the Topology write succeeded.

1. If logs report `flavor_write_denied` or `topology_write_denied`, preserve the full API error and follow [managed-object denial troubleshooting](#changes-to-an-aks-managed-object-are-denied). Don't bypass the guard.
1. If logs report `apply_immutable_rejected`, inspect the full validation cause. This historical token can represent any Kubernetes API `Invalid` response, not only an immutable-field rejection. Older images can say `managed object rejected as immutable; manual repair required`. That text isn't authorization for manual object repair.
1. For a confirmed immutable-field failure or another invalid managed desired state, contact Azure support with the object kind, name, spec, affected queue references, extension version, image digest, and original field-level error. Repeating the same invalid update won't correct it. The managed release or desired state needs an owner-directed fix.

Don't delete and recreate managed objects, clear their finalizers, or repeatedly restart the controller to force regeneration. Generated objects and Helm release configuration don't have the same reconciliation behavior. Admission protection prevents unsupported edits; it isn't a guarantee of immediate drift repair.

## A workload isn't admitted or its pods aren't scheduled

**Symptom:** A Job remains suspended, a Workload isn't admitted, or admitted workload pods remain pending.

**Cause:** Normal queueing, quota exhaustion, an inactive admission check, topology constraints, or Kubernetes scheduling failures can occur while the managed extension is healthy.

**Resolution:**

1. Inspect the affected namespace and select the Workload associated with the Job or other workload resource. Use owner references rather than assuming that their names are identical:

    ```bash
    WORKLOAD_NAMESPACE="<workload-namespace>"
    WORKLOAD_NAME="<kueue-workload-name>"
    LOCAL_QUEUE="<localqueue-name>"
    CLUSTER_QUEUE="<clusterqueue-name>"

    kubectl get workloads.kueue.x-k8s.io --namespace "$WORKLOAD_NAMESPACE"
    kubectl get workload "$WORKLOAD_NAME" \
      --namespace "$WORKLOAD_NAMESPACE" --output yaml
    kubectl describe localqueue "$LOCAL_QUEUE" --namespace "$WORKLOAD_NAMESPACE"
    kubectl describe clusterqueue "$CLUSTER_QUEUE"
    kubectl get events --namespace "$WORKLOAD_NAMESPACE" \
      --sort-by=.metadata.creationTimestamp
    ```

1. Check the workload's `kueue.x-k8s.io/queue-name` label. It must identify a LocalQueue in the workload's namespace. That LocalQueue must reference the intended ClusterQueue. Confirm that the installed managed version supports the workload integration.
1. Read the Workload's conditions and admission-check status. Check queue readiness, configured quota, flavor references, topology requirements, and the workload's resource requests. Quota reservation isn't the same as completed admission.
1. If an autoscaling admission check is blocking progress, continue with [ProvisioningRequest troubleshooting](#autoscaling-admission-checks-or-provisioningrequests-dont-progress).
1. If the workload is admitted but its pods are pending, inspect the affected pod's events. Compare the selected flavor's node labels with node selectors, taints and tolerations, available resources, and topology constraints. Kueue admission doesn't guarantee that the Kubernetes scheduler can immediately place every pod.
1. Correct customer-owned queue or workload configuration with its owner. Don't increase quota, remove an admission check, or unsuspend the Job just to bypass the observed constraint.

After correcting the cause, verify the intended workload's admission and pod scheduling. A healthy extension status or a cleared old Workload isn't sufficient evidence.

## Autoscaling admission checks or ProvisioningRequests don't progress

**Symptom:** An autoscaling admission check is inactive, a Workload waits for capacity, or a ProvisioningRequest doesn't become provisioned.

**Resolution:**

1. Confirm the actual check, config, and provisioning class. Releases with the managed native defaults use `aks-provisioning-check`, `aks-provisioning-config`, and class `best-effort-atomic-scale-up.autoscaling.x-k8s.io`:

    ```bash
    kubectl get admissioncheck aks-provisioning-check --output yaml
    kubectl get provisioningrequestconfig aks-provisioning-config --output yaml
    kubectl get crd provisioningrequests.autoscaling.x-k8s.io --output yaml

    az aks nodepool list \
      --resource-group "$RESOURCE_GROUP" \
      --cluster-name "$CLUSTER_NAME" \
      --query '[].{name:name,autoscaling:enableAutoScaling,min:minCount,max:maxCount,count:count,vmSize:vmSize,state:provisioningState}' \
      --output table
    ```

    If your ClusterQueue uses another check, inspect that check and its referenced config instead. The mere presence of a ProvisioningRequest doesn't identify its provider or retry policy.

1. Verify that the shared ProvisioningRequest CRD exists, serves `v1`, and is established. Verify cluster autoscaler support and that the intended node pool has autoscaling enabled. Don't delete or replace a shared CRD as a troubleshooting step.
1. Require the admission check to report `Active=True` before using it to gate workloads. Kueue discovers the ProvisioningRequest API at process startup. If the API became available only after the manager started, ask Azure support to arrange supported controller recovery; waiting for node scale-up alone won't register the missing controller.
1. Check that the ClusterQueue references the intended check, including any flavor-specific selection in `admissionChecksStrategy`. Don't edit an AKS-managed check or config to bypass readiness.
1. If a request exists, preserve its conditions, provisioning class, owner references, UID, and related events:

    ```bash
    WORKLOAD_NAMESPACE="<workload-namespace>"
    PROVISIONING_REQUEST="<provisioningrequest-name>"

    kubectl get provisioningrequests.autoscaling.x-k8s.io \
      --namespace "$WORKLOAD_NAMESPACE"
    kubectl describe provisioningrequest "$PROVISIONING_REQUEST" \
      --namespace "$WORKLOAD_NAMESPACE"
    kubectl get events --namespace "$WORKLOAD_NAMESPACE" \
      --sort-by=.metadata.creationTimestamp
    ```

1. Use the observed request and autoscaler errors to distinguish a pool size limit, Azure quota or capacity issue, scheduling constraint, template error, or API failure. Empty conditions can mean that the provider hasn't processed the request yet. A timeout alone doesn't establish a capacity or quota root cause.
1. Follow the current request associated with the Workload. A retry can create another request, and terminal requests or placeholder pods might already be cleaned up. Don't recreate or delete requests to recover missing diagnostic evidence, and don't assume the same retry delay across providers.

For the native provisioning flow, see [Configure Kueue with the cluster autoscaler](/azure/aks/configure-kueue-with-cluster-autoscaler#troubleshooting). On a managed cluster, use the installed controllers and managed defaults; don't follow the self-hosted Helm installation step or install a second Kueue controller.

Verify a successful current provisioning attempt, Workload admission, and actual pod scheduling before declaring recovery.

## Extension removal fails or is incomplete

**Symptom:** Extension deletion fails, a cleanup hook fails or times out, or Azure and the cluster show different removal states.

**Cause:** Managed Kueue removal is destructive and can fail after some cleanup steps have completed. A missing Azure extension resource doesn't prove that cleanup finished in the cluster.

**Resolution:**

1. Stop further customer-initiated lifecycle requests. Don't rerun cleanup manually, bypass the Helm hook, force-delete CRDs, or remove finalizers.
1. Preserve the Azure operation and correlation IDs, installed version, actual Helm release identity, and remaining controller, Job, and pod state:

    ```bash
    kubectl get deployment,job,pods --namespace kueue-system --output wide
    kubectl get events --namespace kueue-system --sort-by=.metadata.creationTimestamp
    ```

1. If the failed cleanup Job and pod remain, collect their events, logs, exit information, and termination message before another operation replaces the evidence:

    ```bash
    CLEANUP_JOB="<failed-cleanup-job>"
    CLEANUP_POD="<failed-cleanup-pod>"

    kubectl describe job "$CLEANUP_JOB" --namespace kueue-system
    kubectl describe pod "$CLEANUP_POD" --namespace kueue-system
    kubectl logs "$CLEANUP_POD" --namespace kueue-system \
      --all-containers=true --timestamps --tail=1000
    kubectl get pod "$CLEANUP_POD" --namespace kueue-system \
      --output jsonpath='{range .status.containerStatuses[*]}{.name}{"\n"}{.state.terminated.message}{"\n"}{end}'
    ```

1. Distinguish a hook that never started from a cleanup process that failed. For versions that emit a JSON cleanup summary, preserve `result`, `phase`, `lastErrors`, duration, resource and storage versions, and any `remaining` object identities and finalizers. An early failure can omit remaining inventory; that omission doesn't prove that no resources remain.

    | Failed phase or evidence | What to preserve for Azure support |
    | --- | --- |
    | Hook pod can't start | Image, scheduling, admission, or identity error from pod and Job events |
    | `parse-options`, `validate-options`, `configure-client` | Rejected argument or client configuration cause; these are managed-package settings |
    | `preflight` | API discovery and CRD served and storage versions, with the exact API or schema error |
    | `stop-extension-controller`, `stop-kueue-manager` | Controller deletion state and API cause; don't assume both controllers stopped |
    | `delete-admission-webhooks`, `delete-provisioning-runtime`, `remove-conversion-service` | Named resource, hook identity, and original API error |
    | `delete-kueue-resources` or `Kueue resource cleanup did not converge` | Remaining objects, deletion timestamps, finalizers, and underlying API or deadline error |

1. Contact Azure support to review partial cleanup and plan the next supported operation. Include whether workloads are running or queued and which customer configuration is preserved.

The shared ProvisioningRequest CRD can remain by design; its presence alone isn't failed cleanup. Don't delete it or unrelated requests. For Kueue resources, verify the intended lifecycle state with support rather than using a missing hook pod or process exit alone as proof of completion.

## Collect diagnostics and get support

Collect diagnostics before another retry, pod restart, ownership change, or extension deletion. Keep the collection scoped to the affected cluster and resources.

Save extension status without configuration values:

```bash
az k8s-extension show \
  --resource-group "$RESOURCE_GROUP" \
  --cluster-name "$CLUSTER_NAME" \
  --cluster-type managedClusters \
  --name "$EXTENSION_NAME" \
  --query '{name:name,type:extensionType,requestedVersion:version,currentVersion:currentVersion,releaseTrain:releaseTrain,autoUpgradeMode:autoUpgradeMode,provisioningState:provisioningState,extensionState:extensionState,errorInfo:errorInfo,statuses:statuses}' \
  --output json > kueue-extension-status.json

kubectl get deployment,pods --namespace kueue-system \
  --output wide > kueue-controller-status.txt
kubectl get events --namespace kueue-system \
  --sort-by=.metadata.creationTimestamp > kueue-events.txt
```

Include the following information in the support request:

- Cluster resource ID, subscription, resource group, region, Kubernetes version, and incident timestamps with time zone.
- Extension resource name and type, requested and current versions, release train, auto-upgrade mode, and controller image references and resolved digests.
- Exact failed command, full error code and message, operation and correlation IDs, and whether the operation is still in progress.
- Customer-initiated attempt count, changes between attempts, and observation period or timeout.
- Relevant deployment and pod status, current and previous logs, events, restart counts, and termination reasons.
- For managed-object issues, the named resource, original API validation or admission cause, and affected queue references.
- For workload or autoscaling issues, relevant Workload and queue conditions, ProvisioningRequest class, UID and owner references, and scheduling or autoscaler events.
- For a failed installation over an existing controller, that controller's namespace, image, installation method, and ownership metadata.
- For failed removal, retained hook logs and cleanup summary, remaining resources, and customer workload impact.

Diagnostic logs, object manifests, and error messages can contain sensitive values. Review and redact them before sharing. Don't include Secrets, protected extension settings, credentials, tokens, kubeconfig files, or unrelated workload data. Share diagnostic files only through the approved support channel, not a public issue.

For an unresolved managed-extension problem, [create an Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request).

## References

- [Install the managed Kueue extension on AKS](/azure/aks/configure-queues-with-automatic-resource-flavors)
- [Deploy and manage cluster extensions by using the Azure CLI](/azure/aks/deploy-extensions-az-cli)
- [Troubleshoot cluster extension deployment errors](cluster-extension-deployment-errors.md)
- [Cluster autoscaler overview](/azure/aks/cluster-autoscaler-overview)
