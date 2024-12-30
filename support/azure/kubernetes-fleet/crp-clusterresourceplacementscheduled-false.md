---
title: ClusterResourcePlacementScheduled failure when using ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager
description: Helps you resolve the ClusterResourcePlacementScheduled failure when you propagate resources using the ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager.
ms.date: 08/05/2024
ms.reviewer: zhangryan, chiragpa, shasb, ericlucier, arfallas, sachidesai, v-weizhu
ms.service: azure-kubernetes-fleet-manager
ms.custom: sap:Other issue or questions related to Fleet manager
---
# Resource propagation failure: ClusterResourcePlacementScheduled is false

This article describes how to troubleshoot `ClusterResourcePlacementScheduled` issues when you propagate resources using the `ClusterResourcePlacement` API object in Azure Kubernetes Fleet Manager.

## Symptoms

When using the `ClusterResourcePlacement` API object in Azure Kubernetes Fleet Manager to propagate resources, the scheduler for Fleet workloads can't find all the required clusters specified by the scheduling policy, and the `ClusterResourcePlacementScheduled` condition status shows as `False`.

> [!NOTE]
> To get more information about why the scheduling fails, you can check the [scheduler](https://github.com/Azure/fleet/blob/main/pkg/scheduler/scheduler.go) logs.

## Cause

This issue might occur for one of the following reasons:

- The placement policy is set to `PickFixed`, but the specified cluster names don't match any joined member cluster name in the fleet, or the specified cluster is no longer connected to the fleet.
- The placement policy is set to `PickN`, and N clusters are specified, but fewer than N clusters have joined the fleet or satisfied the placement policy.
- The `ClusterResourcePlacement` resource selector selects a reserved namespace.

> [!NOTE]
> When the placement policy is set to `PickAll`, the `ClusterResourcePlacementScheduled` condition is set to `True`.

## Case study

In the following example, the `ClusterResourcePlacement` with a `PickN` placement policy is trying to propagate resources to two clusters labeled `env:prod`. The two clusters, named `kind-cluster-1` and `kind-cluster-2`, have joined the fleet. However, only one member cluster, `kind-cluster-1`, has the label `env:prod`.

### ClusterResourcePlacement specification

```yaml
spec:
  policy:
    affinity:
      clusterAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          clusterSelectorTerms:
          - labelSelector:
              matchLabels:
                env: prod
    numberOfClusters: 2
    placementType: PickN
  resourceSelectors:
  ...
  revisionHistoryLimit: 10
  strategy:
    type: RollingUpdate
```

### ClusterResourcePlacement status

```output
status:
  conditions:
  - lastTransitionTime: "2024-05-07T22:36:33Z"
    message: could not find all the clusters needed as specified by the scheduling
      policy
    observedGeneration: 1
    reason: SchedulingPolicyUnfulfilled
    status: "False"
    type: ClusterResourcePlacementScheduled
  - lastTransitionTime: "2024-05-07T22:36:33Z"
    message: All 1 cluster(s) start rolling out the latest resource
    observedGeneration: 1
    reason: RolloutStarted
    status: "True"
    type: ClusterResourcePlacementRolloutStarted
  - lastTransitionTime: "2024-05-07T22:36:33Z"
    message: No override rules are configured for the selected resources
    observedGeneration: 1
    reason: NoOverrideSpecified
    status: "True"
    type: ClusterResourcePlacementOverridden
  - lastTransitionTime: "2024-05-07T22:36:33Z"
    message: Works(s) are successfully created or updated in the 1 target clusters'
      namespaces
    observedGeneration: 1
    reason: WorkSynchronized
    status: "True"
    type: ClusterResourcePlacementWorkSynchronized
  - lastTransitionTime: "2024-05-07T22:36:33Z"
    message: The selected resources are successfully applied to 1 clusters
    observedGeneration: 1
    reason: ApplySucceeded
    status: "True"
    type: ClusterResourcePlacementApplied
  - lastTransitionTime: "2024-05-07T22:36:33Z"
    message: The selected resources in 1 cluster are available now
    observedGeneration: 1
    reason: ResourceAvailable
    status: "True"
    type: ClusterResourcePlacementAvailable
  observedResourceIndex: "0"
  placementStatuses:
  - clusterName: kind-cluster-1
    conditions:
    - lastTransitionTime: "2024-05-07T22:36:33Z"
      message: 'Successfully scheduled resources for placement in kind-cluster-1 (affinity
        score: 0, topology spread score: 0): picked by scheduling policy'
      observedGeneration: 1
      reason: Scheduled
      status: "True"
      type: Scheduled
    - lastTransitionTime: "2024-05-07T22:36:33Z"
      message: Detected the new changes on the resources and started the rollout process
      observedGeneration: 1
      reason: RolloutStarted
      status: "True"
      type: RolloutStarted
    - lastTransitionTime: "2024-05-07T22:36:33Z"
      message: No override rules are configured for the selected resources
      observedGeneration: 1
      reason: NoOverrideSpecified
      status: "True"
      type: Overridden
    - lastTransitionTime: "2024-05-07T22:36:33Z"
      message: All of the works are synchronized to the latest
      observedGeneration: 1
      reason: AllWorkSynced
      status: "True"
      type: WorkSynchronized
    - lastTransitionTime: "2024-05-07T22:36:33Z"
      message: All corresponding work objects are applied
      observedGeneration: 1
      reason: AllWorkHaveBeenApplied
      status: "True"
      type: Applied
    - lastTransitionTime: "2024-05-07T22:36:33Z"
      message: All corresponding work objects are available
      observedGeneration: 1
      reason: AllWorkAreAvailable
      status: "True"
      type: Available
  - conditions:
    - lastTransitionTime: "2024-05-07T22:36:33Z"
      message: 'kind-cluster-2 is not selected: ClusterUnschedulable, cluster does not
        match with any of the required cluster affinity terms'
      observedGeneration: 1
      reason: ScheduleFailed
      status: "False"
      type: Scheduled
  selectedResources:
  ...
```

In the `ClusterResourcePlacement` status, the `ClusterResourcePlacementScheduled` condition status shows as `False`. To figure out why the scheduler can't schedule the resource for the specified placement policy, check the `ClusterSchedulingPolicySnapshot` specification and status. To learn how to get the latest `ClusterSchedulingPolicySnapshot`, see [How can I find and verify the latest ClusterSchedulingPolicySnapshot for a ClusterResourcePlacement deployment?](troubleshoot-clusterresourceplacement-api-issues.md#how-can-i-find-and-verify-the-latest-clusterschedulingpolicysnapshot-for-a-clusterresourceplacement-deployment)

### Latest ClusterSchedulingPolicySnapshot

```yaml
apiVersion: placement.kubernetes-fleet.io/v1
kind: ClusterSchedulingPolicySnapshot
metadata:
  annotations:
    kubernetes-fleet.io/CRP-generation: "1"
    kubernetes-fleet.io/number-of-clusters: "2"
  creationTimestamp: "2024-05-07T22:36:33Z"
  generation: 1
  labels:
    kubernetes-fleet.io/is-latest-snapshot: "true"
    kubernetes-fleet.io/parent-CRP: crp-2
    kubernetes-fleet.io/policy-index: "0"
  name: crp-2-0
  ownerReferences:
  - apiVersion: placement.kubernetes-fleet.io/v1beta1
    blockOwnerDeletion: true
    controller: true
    kind: ClusterResourcePlacement
    name: crp-2
    uid: 48bc1e92-a8b9-4450-a2d5-c6905df2cbf0
  resourceVersion: "10090"
  uid: 2137887e-45fd-4f52-bbb7-b96f39854625
spec:
  policy:
    affinity:
      clusterAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          clusterSelectorTerms:
          - labelSelector:
              matchLabels:
                env: prod
    placementType: PickN
  policyHash: ZjE0Yjk4YjYyMTVjY2U3NzQ1MTZkNWRhZjRiNjQ1NzQ4NjllNTUyMzZkODBkYzkyYmRkMGU3OTI3MWEwOTkyNQ==
status:
  conditions:
  - lastTransitionTime: "2024-05-07T22:36:33Z"
    message: could not find all the clusters needed as specified by the scheduling
      policy
    observedGeneration: 1
    reason: SchedulingPolicyUnfulfilled
    status: "False"
    type: Scheduled
  observedCRPGeneration: 1
  targetClusters:
  - clusterName: kind-cluster-1
    clusterScore:
      affinityScore: 0
      priorityScore: 0
    reason: picked by scheduling policy
    selected: true
  - clusterName: kind-cluster-2
    reason: ClusterUnschedulable, cluster does not match with any of the required
      cluster affinity terms
    selected: false
```

### Resolution

In this scenario, to resolve this issue, add the `env:prod` label to the member cluster resource for `kind-cluster-2` as well, so that the scheduler can select the cluster to propagate resources.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
