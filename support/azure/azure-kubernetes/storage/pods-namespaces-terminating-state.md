---
title: Troubleshoot pods and namespaces stuck in the Terminating state
description: Troubleshoot pods and namespaces stuck in the Terminating state in AKS by identifying unhealthy nodes, remaining resources, API discovery failures, and finalizers.
ms.date: 09/25/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: v-rekhanain, v-leedennis, skatkar, shuyingqin, pihe
ms.service: azure-kubernetes-service
ms.topic: troubleshooting
#Customer intent: As an Azure Kubernetes user, I want to fix a scenario in which pods and namespaces remain stuck in the Terminating state (or an unknown state) so that I can successfully use my Azure Kubernetes Service cluster.
ms.custom: sap:Storage
ai-usage: ai-assisted
---
# Troubleshoot pods and namespaces stuck in the Terminating state

## Summary

This article helps you troubleshoot and resolve issues with pods and namespaces that are stuck in the `Terminating` state in Azure Kubernetes Service (AKS). Use this guidance to find what's blocking deletion before you consider force deletion.

## Prerequisites

Ensure you have the following prerequisites:

- Install the Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install `kubectl` by using Azure CLI, run [az aks install-cli](/cli/azure/aks#az-aks-install-cli).
- Have permissions to get and list the resources you inspect, watch namespaces, and patch or delete the affected objects. The inventory requires list access to every discovered namespaced resource type. Force-finalizing requires permission to update `namespaces/finalize`.
- For CustomResourceDefinition (CRD) checks, permission to get cluster-scoped `customresourcedefinitions`.
- Install Bash or Azure PowerShell 7.3 or later. In Azure PowerShell, use the default native argument-passing mode (`Windows` or `Standard`), not `Legacy`. Replace placeholders such as `<pod-name>` and `<namespace-name>` with your resource names.

## Troubleshoot a pod stuck in the Terminating state

### Step 1: Inspect the pod and its node

A pod shown as `Terminating` already has a deletion request in progress. Investigate what is preventing deletion from completing instead of repeating a normal delete request.

Run the following command.

```bash
kubectl get pod --all-namespaces --output wide
kubectl describe pod <pod-name> --namespace <namespace-name>
kubectl get pod <pod-name> --namespace <namespace-name> --output yaml --show-managed-fields
```

If you get `Error from server (NotFound): pods "<pod-name>" not found`, there's no pod with that name in that namespace and therefore nothing to force delete. Recheck the name and namespace, list the pods again, and check whether the workload controller created a replacement pod.

Check the output for the following items:

- **Node health** - If the pod is scheduled to a node (`spec.nodeName`), run `kubectl get node <node-name>`. If the node is `NotReady` or unreachable, follow [Node Not Ready troubleshooting](../availability-performance/node-not-ready-basic-troubleshooting.md). If the node is permanently unavailable, confirm that the pod process can no longer run before you force delete the pod.
- **Pod shutdown** - Check `spec.terminationGracePeriodSeconds`, container `preStop` hooks, and events. Allow graceful shutdown to finish when possible.
- **Finalizers** - Check `metadata.finalizers`. The finalizer names and `metadata.managedFields` can point you to the controller responsible for cleanup, but a field manager's name doesn't tell you what that cleanup involves. Check the controller's health and logs, and fix whatever is preventing cleanup.
- **Workload owner** - Check `metadata.ownerReferences`. The owning controller might create a replacement pod. Before removing finalizers or force deleting the pod, review the process-safety and StatefulSet warning in [Step 2](#step-2-force-delete-the-pod-as-a-last-resort).

Remove finalizers manually only if the pod already has `metadata.deletionTimestamp` set. If its controller is unavailable or can't finish cleanup, first find out what each finalizer does and complete that cleanup another way. The following command removes all finalizers from the pod. Skipping their cleanup can leave orphaned resources or inconsistent state.

Run the following command.

```bash
kubectl patch pod <pod-name> --namespace <namespace-name> --type=json --patch='[{"op":"remove","path":"/metadata/finalizers"}]'
```

> [!IMPORTANT]
> Force deleting a pod doesn't bypass finalizers. The API object remains until they are removed.

If deletion or finalizer removal returns a webhook error, see [Scenario 1: Admission webhook errors](#scenario-1-an-admission-webhook-blocks-deletion-or-finalizer-updates).

### Step 2: Force delete the pod as a last resort

If graceful shutdown fails and the API object remains after you address the blockers in [Step 1](#step-1-inspect-the-pod-and-its-node), review these risks before forcing deletion.

> [!WARNING]
> Force deleting doesn't wait for the node to confirm that the pod's processes have stopped. If the original pod keeps running alongside a replacement, duplicate writers can cause data corruption. For a [StatefulSet pod](https://kubernetes.io/docs/tasks/run-application/force-delete-stateful-set-pod/), confirm that the original pod can never run or communicate with the application again. 

Run the following command.

```bash
kubectl delete pod <pod-name> --namespace <namespace-name> --grace-period=0 --force --wait=false
```

Check the pod again with `kubectl get pod <pod-name> --namespace <namespace-name>`. `NotFound` means that the API object is gone. It doesn't mean that the pod's processes have stopped. If a pod with the same name exists, compare its `metadata.uid` with the original pod's UID to tell whether it's a replacement.

## Troubleshoot a namespace stuck in the Terminating state

### Step 1: Inspect the namespace conditions

Run the following command to inspect the namespace.

```bash
kubectl get namespace <namespace-name> --output yaml
kubectl describe namespace <namespace-name>
```

Check `status.conditions`. For the five conditions in the following table, `True` means that the namespace controller found a problem or remaining content. `False` means that it didn't report that issue in its last check. Read each condition's `message` for details about that check.

The following table summarizes the common namespace conditions and what to investigate for each.

| Condition type | What to investigate |
| --- | --- |
| `NamespaceDeletionDiscoveryFailure` | Investigate the discovery error. If it identifies an aggregated API, use `kubectl get apiservice` and `kubectl describe apiservice <api-service-name>` to inspect the matching APIService. Restore access to the server that provides that API; delete the APIService object only if the API is no longer required. If that server runs on pods reached through Konnectivity, also see [Scenario 3: Konnectivity failures](#scenario-3-a-konnectivity-failure-blocks-calls-to-in-cluster-services). |
| `NamespaceDeletionGroupVersionParsingFailure` | Check the malformed group-version value in the discovery response. If it comes from an aggregated API, inspect the server that provides that API. |
| `NamespaceDeletionContentFailure` | Investigate the reported API, authorization, or admission error. For custom-resource or conversion errors, see [Scenario 2: Custom-resource cleanup](#scenario-2-a-custom-resource-cannot-finish-cleanup). For admission webhook errors, see [Scenario 1](#scenario-1-an-admission-webhook-blocks-deletion-or-finalizer-updates). |
| `NamespaceContentRemaining` | The message lists the remaining resource types and how many of each remain. Use the [Step 2](#step-2-find-all-remaining-namespaced-resources) inventory to find these objects, then inspect them in Step 3. |
| `NamespaceFinalizersRemaining` | Find the objects that have the listed finalizers. Then use [Step 3](#step-3-identify-and-resolve-the-resource-deletion-blocker) to restore the controller's cleanup or, if necessary, remove the finalizers manually. |

If all five conditions are `False` but the namespace still exists, inspect its `spec.finalizers` and `metadata.finalizers` in the YAML output. `NamespaceFinalizersRemaining` refers to finalizers on resources inside the namespace, not the namespace's own finalizers.

### Step 2: Find all remaining namespaced resources

`kubectl get all` doesn't list every resource type. The following read-only script first checks the namespace's discovery conditions. It then lists objects for every namespaced resource type that the API server reports, including custom resources (CRs). The script stops if any check or request fails.

Use Bash or Azure PowerShell to inventory all remaining namespaced resources.

# [Bash](#tab/bash)

Run the following commands.

```bash
namespace="<namespace-name>"

inventory_namespace() {
  local resources condition
  for condition in NamespaceDeletionDiscoveryFailure NamespaceDeletionGroupVersionParsingFailure; do
    kubectl wait "namespace/$namespace" --for="condition=$condition=false" --timeout=5s --request-timeout=10s >/dev/null || return 1
  done
  resources=$(kubectl api-resources --verbs=list --namespaced --output name --request-timeout=30s) || return 1
  if [ -z "$resources" ]; then
    echo "No resource types were discovered. Stop and investigate." >&2
    return 1
  fi
  while IFS= read -r resource; do
    kubectl get "$resource" --namespace "$namespace" --output name --request-timeout=30s || return 1
  done <<< "$resources"
}

inventory_namespace
```

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```powershell
$namespace = "<namespace-name>"

foreach ($condition in @("NamespaceDeletionDiscoveryFailure", "NamespaceDeletionGroupVersionParsingFailure")) {
  kubectl wait "namespace/$namespace" --for="condition=$condition=false" --timeout=5s --request-timeout=10s | Out-Null
  if ($LASTEXITCODE -ne 0) {
    throw "$condition isn't False. Return to Step 1."
  }
}
$resources = kubectl api-resources --verbs=list --namespaced --output name --request-timeout=30s
if ($LASTEXITCODE -ne 0 -or -not $resources) {
  throw "API discovery failed or returned no resource types. Stop and investigate."
}
foreach ($resource in $resources) {
  kubectl get $resource --namespace $namespace --output name --request-timeout=30s
  if ($LASTEXITCODE -ne 0) {
    throw "Unable to list $resource. Stop and investigate."
  }
}
```

---

Each line of output, such as `configmap/example`, is a remaining object. No output means that the namespace has no remaining objects only if **all condition checks, discovery, and list requests succeeded**. If a condition check times out, go back to Step 1. Fix `Forbidden` and any other errors before you continue.

For CR listing or conversion webhook errors, see [Scenario 2: Custom-resource cleanup](#scenario-2-a-custom-resource-cannot-finish-cleanup). For suspected Konnectivity failures affecting in-cluster services, see [Scenario 3](#scenario-3-a-konnectivity-failure-blocks-calls-to-in-cluster-services).

### Step 3: Identify and resolve the resource deletion blocker

Use the namespace conditions, inventory errors, and remaining resources to find the matching scenario in the following sections. For an object you can read, inspect its finalizers, owner, deletion timestamp, and events.

Run the following command.

```bash
kubectl get <resource-type> <resource-name> --namespace <namespace-name> --output yaml --show-managed-fields
kubectl describe <resource-type> <resource-name> --namespace <namespace-name>
```

#### Scenario 1: An admission webhook blocks deletion or finalizer updates

An [admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) can reject deletion (`DELETE`) or finalizer removal (`UPDATE`). Use the error in the namespace conditions or an existing failed request to identify the webhook. Its name matches a `webhooks[].name` entry in a `ValidatingWebhookConfiguration` or `MutatingWebhookConfiguration` object, and might differ from that object's name.

The following scenarios describe common issues and their resolutions:

- **The webhook denies the request** - Review the denial message, rules, and selectors with the team that maintains the webhook.
- **The webhook call fails or times out** - Check the configured endpoint and TLS. For a Service-backed webhook, also check the Service, EndpointSlices, and pods. If the API server reaches those pods through Konnectivity, also use [Scenario 3](#scenario-3-a-konnectivity-failure-blocks-calls-to-in-cluster-services).

Keep the service that processes webhook requests available while the webhook is required. Remove the webhook's entry from its configuration only after the team that maintains it confirms that the webhook is no longer needed. Don't disable unrelated webhooks or use `failurePolicy: Ignore` as a general workaround; it doesn't bypass explicit rejections.

#### Scenario 2: A custom resource cannot finish cleanup

If a CR remains or its API reports errors, inspect the matching [CRD](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/), named `<plural>.<group>`, and check `spec.scope` and `spec.versions`.

Run the following command.

```bash
kubectl get crd <crd-name> --output yaml
```

The following situations can occur when a custom resource cannot finish cleanup:

- **The CR has finalizers** - Identify the responsible operator or controller and inspect its logs and dependencies. Follow the product's supported recovery steps. A `Terminating` namespace rejects new pods. If recovery requires new controller pods, run them in a supported active namespace and make sure that they can still manage the affected CRs.
- **Reading or listing CRs reports conversion errors** - Check `spec.conversion` in the CRD. [Version conversion](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definition-versioning/#webhook-conversion) can call a webhook during these operations. Check the conversion webhook's endpoint and TLS, and restore the service that handles conversion requests. If that service runs on pods reached through Konnectivity, also use [Scenario 3](#scenario-3-a-konnectivity-failure-blocks-calls-to-in-cluster-services). Conversion webhooks aren't configured in admission webhook configurations.
- **The CRD is also being deleted** - Inspect its `status.conditions` and `metadata.finalizers`. Work with the product owner to resolve reported cleanup failures rather than bypassing its finalizers.

Don't delete a CRD to unblock one namespace. Deleting it removes its CRs across the cluster, including those in other namespaces.

#### Scenario 3: A Konnectivity failure blocks calls to in-cluster services

A tunnel failure can interrupt admission or conversion webhook calls, or aggregated API discovery, when the service handling those requests runs on pods reached through the tunnel.

Check the `konnectivity-agent` pods in `kube-system` and follow the tunnel troubleshooting articles linked in this section. Failures of `kubectl logs`, `kubectl exec`, or `kubectl port-forward` are additional clues, not proof of a tunnel failure. Resolve a confirmed tunnel failure before changing the affected admission webhook configuration, CRD conversion settings, or APIService object.

See the following resources for more information:

- [Tunnel connectivity issues](../connectivity/tunnel-connectivity-issues.md)
- ["Error from server: error dialing backend: dial tcp" message](../connectivity/error-from-server-error-dialing-backend-dial-tcp.md#cause-3-konnectivity-or-tunnel-failure)

#### Scenario 4: Foreground deletion is waiting for dependent resources

If an object has the `foregroundDeletion` finalizer, check its dependent resources. During [foreground cascading deletion](https://kubernetes.io/docs/concepts/architecture/garbage-collection/#foreground-deletion), dependents known to the garbage collector with `blockOwnerDeletion: true` can keep the owner from being deleted.

Inspect the expected dependent resource types from the inventory. Match their `metadata.ownerReferences[].uid` to the owner's `metadata.uid`, then check their deletion state and finalizers. Resolve the dependent's blocker using the relevant scenario above or below. Removing the owner's finalizer doesn't complete the dependent's cleanup.

The namespace's `kubernetes` finalizer is separate from this owner-dependent mechanism.

#### Scenario 5: Pod termination or PVC protection delays cleanup

If pods remain, follow [Troubleshoot a pod stuck in the Terminating state](#troubleshoot-a-pod-stuck-in-the-terminating-state).

If a PVC has `kubernetes.io/pvc-protection`, inspect its `Used By` entries in `kubectl describe pvc <pvc-name> --namespace <namespace-name>` and the listed pods. [PVC protection](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#storage-object-in-use-protection) delays deletion while a pod uses the claim. Resolve the pod's termination or cleanup issue rather than removing the protection finalizer while the claim is in use.

#### If the responsible controller cannot complete cleanup

For other finalizers, use their names, owner references, and field managers to help identify the controller. Restore it or fix its failing dependency.

If the object is already being deleted and its controller can't finish cleanup, find out what each finalizer does. Complete all required in-cluster and external cleanup another way before using this patch. For pods, first review the [process-safety and StatefulSet warning](#step-2-force-delete-the-pod-as-a-last-resort).

The patch removes all finalizers. Skipping their cleanup can orphan resources or leave inconsistent state. For more information, see [Finalizers](https://kubernetes.io/docs/concepts/overview/working-with-objects/finalizers/).

Run the following command.

```bash
kubectl patch <resource-type> <resource-name> --namespace <namespace-name> --type=json --patch='[{"op":"remove","path":"/metadata/finalizers"}]'
```

When resource cleanup succeeds, the namespace controller removes its `kubernetes` finalizer. Other finalizers on the namespace can still prevent deletion.

### Step 4: Force-finalize the namespace only as a last resort

For a namespace still in `Terminating`, confirm the following before using the `finalize` subresource:

- Discovery and every list request in [Step 2](#scenario-2-a-custom-resource-cannot-finish-cleanup) succeed.
- The inventory is empty, and you rechecked the namespace conditions.
- You understand each remaining namespace finalizer and completed its required cleanup.

> [!WARNING]
> Force-finalizing can delete the namespace while leaving resource objects in etcd. Don't use it to bypass discovery or listing errors.

The following examples clear only `spec.finalizers`. They keep the namespace's metadata, including `resourceVersion` and `metadata.finalizers`.

If only `metadata.finalizers` remain, restore the responsible controller's cleanup. Remove a finalizer from the namespace's `metadata.finalizers` only after its required cleanup is complete.

Use Bash or Azure PowerShell to force-finalize the namespace.

# [Bash](#tab/bash)

Run the following commands.

```bash
namespace="<namespace-name>"

kubectl get namespace "$namespace" --output json > "$namespace.json" &&
kubectl patch --local --filename "$namespace.json" --type=merge --patch '{"spec":{"finalizers":[]}}' --output json > "$namespace-finalize.json" &&
kubectl replace --raw "/api/v1/namespaces/${namespace}/finalize" -f "$namespace-finalize.json"
```

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```powershell
$namespace = "<namespace-name>"

$namespaceObject = kubectl get namespace $namespace --output json | ConvertFrom-Json -ErrorAction Stop
if ($LASTEXITCODE -ne 0) {
  throw "Unable to read the namespace. Stop and investigate."
}
$namespaceObject.spec.finalizers = @()
$namespaceObject | ConvertTo-Json -Depth 100 | kubectl replace --raw "/api/v1/namespaces/$namespace/finalize" -f -
if ($LASTEXITCODE -ne 0) {
  throw "Namespace finalization failed. Inspect the API error."
}
```

---

For a `Conflict` error, reread the namespace and repeat the checks before retrying. Don't remove `resourceVersion` to bypass the conflict.

Verify that the namespace no longer exists.

Run the following command.

```bash
kubectl get namespace <namespace-name>
```

`Error from server (NotFound): namespaces "<namespace-name>" not found` confirms only that the namespace object is gone. Other errors don't confirm deletion. If the namespace still exists, check its conditions, `spec.finalizers`, and `metadata.finalizers` again.
