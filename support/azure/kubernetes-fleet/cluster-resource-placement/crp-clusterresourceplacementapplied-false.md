---
title: ClusterResourcePlacementApplied / ResourcePlacementApplied failure when using placement APIs in Azure Kubernetes Fleet Manager
description: Helps you resolve ClusterResourcePlacementApplied or ResourcePlacementApplied failure when you propagate resources by using the ClusterResourcePlacement or ResourcePlacement API object in Azure Kubernetes Fleet Manager APIs.
ms.date: 12/09/2025
ms.reviewer: zhangryan, chiragpa, shasb, ericlucier, arfallas, sachidesai
ms.service: azure-kubernetes-fleet-manager
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Resource propagation failure: ClusterResourcePlacementApplied / ResourcePlacementApplied is False

This article discusses how to troubleshoot `ClusterResourcePlacementApplied` (for ClusterResourcePlacement) or `ResourcePlacementApplied` (for ResourcePlacement) issues when you propagate resources by using placement APIs in Microsoft Azure Kubernetes Fleet Manager.

## Symptoms

When you use the `ClusterResourcePlacement` or `ResourcePlacement` API object in Azure Kubernetes Fleet Manager to propagate resources, the deployment fails. The `ClusterResourcePlacementApplied` (for ClusterResourcePlacement) or `ResourcePlacementApplied` (for ResourcePlacement) status shows as `False`.

> [!NOTE]
> To get more information about why the resources aren't applied, you can check the [work applier controller](https://github.com/Azure/fleet/blob/main/pkg/controllers/workapplier) logs.

## Cause

One of the following reasons might cause the issue:

- The resource already exists on the cluster and the fleet controller doesn't manage it.
- Another placement (ClusterResourcePlacement or ResourcePlacement) already manages the resource for the selected cluster by using a different apply strategy.
- The placement doesn't apply the manifest because of syntax errors or invalid resource configurations. A resource propagated through an envelope object might also cause the issue.

## Troubleshooting steps

1. To identify clusters with the `ClusterResourcePlacementApplied` (for ClusterResourcePlacement) or `ResourcePlacementApplied` (for ResourcePlacement) condition set to `False`, inspect the `placementStatuses` in the placement status section and note down their `clusterName`.
2. To locate the `Work` object associated with the member cluster, use the identified `clusterName`.
   - For ClusterResourcePlacement, see [How to find the correct Work resource associated with `ClusterResourcePlacement`](troubleshoot-clusterresourceplacement-api-issues.md#find-work)
   - For ResourcePlacement, see [How to find the correct Work resource associated with `ResourcePlacement`](troubleshoot-resourceplacement-api-issues.md#find-work)
3. To understand the specific issues preventing successful resource application, inspect the status of the `Work` object.

## Case study: ClusterResourcePlacement

In the following example, a `ClusterResourcePlacement` is trying to propagate a namespace that contains a deployment to two member clusters. However, the namespace already exists on one member cluster, specifically `kind-cluster-1`.

### ClusterResourcePlacement specifications

```YAML
apiVersion: placement.kubernetes-fleet.io/v1beta1
kind: ClusterResourcePlacement
metadata:
  name: crp
spec:
  policy:
    clusterNames:
    - kind-cluster-1
    - kind-cluster-2
    placementType: PickFixed
  resourceSelectors:
  - group: ""
    kind: Namespace
    name: test-ns
    version: v1
  revisionHistoryLimit: 10
  strategy:
    type: RollingUpdate
```

### ClusterResourcePlacement status

```output
status:
  conditions:
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message:couldn't find all the clusters needed as specified by the scheduling
      policy
    observedGeneration: 1
    reason: SchedulingPolicyUnfulfilled
    status: "False"
    type: ClusterResourcePlacementScheduled
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: All 2 cluster(s) start rolling out the latest resource
    observedGeneration: 1
    reason: RolloutStarted
    status: "True"
    type: ClusterResourcePlacementRolloutStarted
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: No override rules are configured for the selected resources
    observedGeneration: 1
    reason: NoOverrideSpecified
    status: "True"
    type: ClusterResourcePlacementOverridden
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: Works(s) are succcesfully created or updated in the 2 target clusters'
      namespaces
    observedGeneration: 1
    reason: WorkSynchronized
    status: "True"
    type: ClusterResourcePlacementWorkSynchronized
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: Failed to apply resources to 1 clusters, please check the `failedPlacements`
      status
    observedGeneration: 1
    reason: ApplyFailed
    status: "False"
    type: ClusterResourcePlacementApplied
  observedResourceIndex: "0"
  placementStatuses:
  - clusterName: kind-cluster-2
    conditions:
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: 'Successfully scheduled resources for placement in kind-cluster-2 (affinity
        score: 0, topology spread score: 0): picked by scheduling policy'
      observedGeneration: 1
      reason: Scheduled
      status: "True"
      type: Scheduled
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: Detected the new changes on the resources and started the rollout process
      observedGeneration: 1
      reason: RolloutStarted
      status: "True"
      type: RolloutStarted
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: No override rules are configured for the selected resources
      observedGeneration: 1
      reason: NoOverrideSpecified
      status: "True"
      type: Overridden
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: All of the works are synchronized to the latest
      observedGeneration: 1
      reason: AllWorkSynced
      status: "True"
      type: WorkSynchronized
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: All corresponding work objects are applied
      observedGeneration: 1
      reason: AllWorkHaveBeenApplied
      status: "True"
      type: Applied
    - lastTransitionTime: "2024-05-07T23:32:49Z"
      message: The availability of work object crp-4-work isn't trackable
      observedGeneration: 1
      reason: WorkNotTrackable
      status: "True"
      type: Available
  - clusterName: kind-cluster-1
    conditions:
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: 'Successfully scheduled resources for placement in kind-cluster-1 (affinity
        score: 0, topology spread score: 0): picked by scheduling policy'
      observedGeneration: 1
      reason: Scheduled
      status: "True"
      type: Scheduled
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: Detected the new changes on the resources and started the rollout process
      observedGeneration: 1
      reason: RolloutStarted
      status: "True"
      type: RolloutStarted
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: No override rules are configured for the selected resources
      observedGeneration: 1
      reason: NoOverrideSpecified
      status: "True"
      type: Overridden
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: All of the works are synchronized to the latest
      observedGeneration: 1
      reason: AllWorkSynced
      status: "True"
      type: WorkSynchronized
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: Work object crp-4-work isn't applied
      observedGeneration: 1
      reason: NotAllWorkHaveBeenApplied
      status: "False"
      type: Applied
    failedPlacements:
    - condition:
        lastTransitionTime: "2024-05-07T23:32:40Z"
        message: 'Failed to apply manifest: failed to process the request due to a
          client error: resource exists and isn't managed by the fleet controller
          and co-ownernship is disallowed'
        reason: ManifestsAlreadyOwnedByOthers
        status: "False"
        type: Applied
      kind: Namespace
      name: test-ns
      version: v1
  selectedResources:
  - kind: Namespace
    name: test-ns
    version: v1
  - group: apps
    kind: Deployment
    name: test-nginx
    namespace: test-ns
    version: v1
```

In the `failedPlacements` section for `kind-cluster-1`, the `message` fields explain why the resource wasn't applied on the member cluster. In the preceding `conditions` section, the `Applied` condition for `kind-cluster-1` is flagged as `false` and shows the `NotAllWorkHaveBeenApplied` reason. The `Work` object intended for the member cluster `kind-cluster-1` wasn't applied. For more information, see [How to find the correct Work resource associated with `ClusterResourcePlacement`](troubleshoot-clusterresourceplacement-api-issues.md#find-work).

### Work status of kind-cluster-1

```output
 status:
  conditions:
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: 'Apply manifest {Ordinal:0 Group: Version:v1 Kind:Namespace Resource:namespaces
      Namespace: Name:test-ns} failed'
    observedGeneration: 1
    reason: WorkAppliedFailed
    status: "False"
    type: Applied
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: ""
    observedGeneration: 1
    reason: WorkAppliedFailed
    status: Unknown
    type: Available
  manifestConditions:
  - conditions:
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: 'Failed to apply manifest: failed to process the request due to a client
        error: resource exists and isn't managed by the fleet controller and co-ownernship
        is disallowed'
      reason: ManifestsAlreadyOwnedByOthers
      status: "False"
      type: Applied
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: Manifest isn't applied yet
      reason: ManifestApplyFailed
      status: Unknown
      type: Available
    identifier:
      kind: Namespace
      name: test-ns
      ordinal: 0
      resource: namespaces
      version: v1
  - conditions:
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: Manifest is already up to date
      observedGeneration: 1
      reason: ManifestAlreadyUpToDate
      status: "True"
      type: Applied
    - lastTransitionTime: "2024-05-07T23:32:51Z"
      message: Manifest is trackable and available now
      observedGeneration: 1
      reason: ManifestAvailable
      status: "True"
      type: Available
    identifier:
      group: apps
      kind: Deployment
      name: test-nginx
      namespace: test-ns
      ordinal: 1
      resource: deployments
      version: v1
```

Check the `Work` status, particularly the `manifestConditions` section. You can see that the namespace couldn't be applied but the deployment within the namespace got propagated from the hub to the member cluster.

### Resolution

In the situation, set the `AllowCoOwnership` to `true` in the ApplyStrategy policy. However, the user must make the decision because the resources might not be shared.

## General Troubleshooting Notes

The troubleshooting process and Work object inspection are identical for both placement types:
- Both use the same underlying Work API to apply resources to member clusters.
- The Work object status and manifestConditions have the same structure regardless of the placement type that created them.
- The main difference is the scope: the cluster-scoped placement can select both cluster-scoped and namespace-scoped resources, while the namespace-scoped placement can only select namespace-scoped resources within its own namespace.

For ResourcePlacement-specific considerations:
- Ensure the target namespace exists on member clusters before the ResourcePlacement tries to apply resources to it
- ResourcePlacement can only select resources within the same namespace where the ResourcePlacement object itself resides

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
