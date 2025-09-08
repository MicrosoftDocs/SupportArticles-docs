---
title: ClusterResourcePlacementWorkSynchronized failure when using ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager
description: Helps you resolve the ClusterResourcePlacementWorkSynchronized failure when you propagate resources using the ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager.
ms.date: 08/05/2024
ms.reviewer: zhangryan, chiragpa, shasb, ericlucier, arfallas, sachidesai, v-weizhu
ms.service: azure-kubernetes-fleet-manager
ms.custom: sap:Other issue or questions related to Fleet manager
---
# Resource propagation failure: ClusterResourcePlacementWorkSynchronized is false

This article describes how to troubleshoot `ClusterResourcePlacementWorkSynchronized` issues when you propagate resources using the `ClusterResourcePlacement` API object in Azure Kubernetes Fleet Manager.

## Symptoms

When using the `ClusterResourcePlacement` API object in Azure Kubernetes Fleet Manager to propagate resources, if the `ClusterResourcePlacement` is updated, the associated work objects aren't synchronized with the changes, and the `ClusterResourcePlacementWorkSynchronized` condition status shows as `False`.

> [!NOTE]
> To get more information about why the work object synchronization fails, you can check the [work generator controller](https://github.com/Azure/fleet/blob/main/pkg/controllers/workgenerator/controller.go) logs.

## Cause

This issue might occur for one of the following reasons:

- The controller encounters an error while trying to generate the corresponding work object.
- The enveloped object isn't well formatted.

## Case study

In the following example, the `ClusterResourcePlacement` is trying to propagate a resource to a selected cluster, but the work object isn't updated to reflect the latest changes because the selected cluster has been terminated.

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
    message: There are 1 cluster(s) which have not finished creating or updating work(s)
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
        because it is being terminated'
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

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

