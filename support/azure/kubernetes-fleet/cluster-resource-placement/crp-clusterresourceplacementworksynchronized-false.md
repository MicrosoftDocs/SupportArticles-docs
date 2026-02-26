---
title: WorkSynchronized failure when using placement APIs in Azure Kubernetes Fleet Manager
description: Helps you resolve the ClusterResourcePlacementWorkSynchronized or ResourcePlacementWorkSynchronized failure when you propagate resources using the ClusterResourcePlacement or ResourcePlacement API object in Azure Kubernetes Fleet Manager.
ms.date: 12/09/2025
ms.reviewer: zhangryan, chiragpa, shasb, ericlucier, arfallas, sachidesai, v-weizhu
ms.service: azure-kubernetes-fleet-manager
ms.custom: sap:Other issue or questions related to Fleet manager
---
# Resource propagation failure: WorkSynchronized is false

## Summary

This article describes how to troubleshoot work synchronization failures when you propagate resources using placement APIs in Azure Kubernetes Fleet Manager. This issue applies to both `ClusterResourcePlacement` and `ResourcePlacement`, each with their own dedicated custom resource condition types:

- `ClusterResourcePlacementWorkSynchronized` for ClusterResourcePlacement
- `ResourcePlacementWorkSynchronized` for ResourcePlacement

Sample error messages:

# [ClusterResourcePlacement](#tab/clusterresourceplacement)

```yaml
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: Failed to synchronize work(s) for 1 clusters, please check the `failedPlacements` status
    observedGeneration: 1
    reason: WorkNeedSyncedOrUpdated
    status: "False"
    type: ClusterResourcePlacementWorkSynchronized
```

# [ResourcePlacement](#tab/resourceplacement)

```yaml
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: Failed to synchronize work(s) for 1 clusters, please check the `failedPlacements` status
    observedGeneration: 1
    reason: WorkNeedSyncedOrUpdated
    status: "False"
    type: ResourcePlacementWorkSynchronized
```

---

## Symptoms

When using the `ClusterResourcePlacement` or `ResourcePlacement` API object in Azure Kubernetes Fleet Manager to propagate resources, if the placement was recently updated, the associated work objects aren't synchronized with the latest selected resources, and the `ClusterResourcePlacementWorkSynchronized` (for ClusterResourcePlacement) or `ResourcePlacementWorkSynchronized` (for ResourcePlacement) condition status shows as `False`.

> [!NOTE]
> To get more information about why the work object synchronization fails, you can check the work generator controller logs. For more information about viewing Fleet agent logs, see [View agent logs in Azure Kubernetes Fleet Manager](/azure/kubernetes-fleet/view-fleet-agent-logs).

## Cause

This issue might occur for one of the following reasons:

- The controller encounters an error while trying to generate the corresponding work object.
- The enveloped object isn't well formatted.

## Case study: ClusterResourcePlacement

In the following example, the `ClusterResourcePlacement` is trying to propagate a resource to a selected cluster, but the work object isn't updated to reflect the latest changes because the selected cluster was terminated.

### ClusterResourcePlacement specification

```yaml
spec:
  resourceSelectors:
    - group: rbac.authorization.k8s.io
      kind: ClusterRole
      name: secret-reader
      version: v1
  policy:
    placementType: PickN
    numberOfClusters: 1
  strategy:
    type: RollingUpdate
 ```

### ClusterResourcePlacement status

```output
spec:
  policy:
    numberOfClusters: 1
    placementType: PickN
  resourceSelectors:
  - group: ""
    kind: Namespace
    name: test-ns
    version: v1
  revisionHistoryLimit: 10
  strategy:
    type: RollingUpdate
status:
  conditions:
  - lastTransitionTime: "2024-05-14T18:05:04Z"
    message: found all cluster needed as specified by the scheduling policy, found
      1 cluster(s)
    observedGeneration: 1
    reason: SchedulingPolicyFulfilled
    status: "True"
    type: ClusterResourcePlacementScheduled
  - lastTransitionTime: "2024-05-14T18:05:05Z"
    message: All 1 cluster(s) start rolling out the latest resource
    observedGeneration: 1
    reason: RolloutStarted
    status: "True"
    type: ClusterResourcePlacementRolloutStarted
  - lastTransitionTime: "2024-05-14T18:05:05Z"
    message: No override rules are configured for the selected resources
    observedGeneration: 1
    reason: NoOverrideSpecified
    status: "True"
    type: ClusterResourcePlacementOverridden
  - lastTransitionTime: "2024-05-14T18:05:05Z"
    message: There are 1 cluster(s) which didn't finish creating or updating work(s)
      yet
    observedGeneration: 1
    reason: WorkNotSynchronizedYet
    status: "False"
    type: ClusterResourcePlacementWorkSynchronized
  observedResourceIndex: "0"
  placementStatuses:
  - clusterName: kind-cluster-1
    conditions:
    - lastTransitionTime: "2024-05-14T18:05:04Z"
      message: 'Successfully scheduled resources for placement in kind-cluster-1 (affinity
        score: 0, topology spread score: 0): picked by scheduling policy'
      observedGeneration: 1
      reason: Scheduled
      status: "True"
      type: Scheduled
    - lastTransitionTime: "2024-05-14T18:05:05Z"
      message: Detected the new changes on the resources and started the rollout process
      observedGeneration: 1
      reason: RolloutStarted
      status: "True"
      type: RolloutStarted
    - lastTransitionTime: "2024-05-14T18:05:05Z"
      message: No override rules are configured for the selected resources
      observedGeneration: 1
      reason: NoOverrideSpecified
      status: "True"
      type: Overridden
    - lastTransitionTime: "2024-05-14T18:05:05Z"
      message: 'Failed to synchronize the work to the latest: works.placement.kubernetes-fleet.io
        "crp1-work" is forbidden: unable to create new content in namespace fleet-member-kind-cluster-1
        because it is terminating'
      observedGeneration: 1
      reason: SyncWorkFailed
      status: "False"
      type: WorkSynchronized
  selectedResources:
  - kind: Namespace
    name: test-ns
    version: v1
```

In the `ClusterResourcePlacement` status, the `ClusterResourcePlacementWorkSynchronized` condition status shows as `False`. The message for it indicates that the work object `crp1-work` is prohibited from generating new content within the namespace `fleet-member-kind-cluster-1` because it's currently terminating.

### Resolution

In this situation, here are several potential solutions:

- Modify the `ClusterResourcePlacement` with a newly selected cluster. 
- Delete the `ClusterResourcePlacement` to remove the work through garbage collection.
- Rejoin the member cluster. The namespace can only be regenerated after rejoining the cluster.

In other situations, you might opt to wait for the work to finish propagating.

## General notes

For ResourcePlacement, the investigation is identical—inspect `.status.placementStatuses[*].conditions` for `WorkSynchronized` and check the associated Work in the `fleet-member-{clusterName}` namespace.

