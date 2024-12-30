---
title: ClusterResourcePlacementApplied failure when using ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager
description: Helps you resolve ClusterResourcePlacementApplied failure when you propagate resources by using the ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager APIs.
ms.date: 08/05/2024
ms.reviewer: zhangryan, chiragpa, shasb, ericlucier, arfallas, sachidesai
ms.service: azure-kubernetes-fleet-manager
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Resource propagation failure: ClusterResourcePlacementApplied is False

This article discusses how to troubleshoot `ClusterResourcePlacementApplied` issues when you propagate resources by using the `ClusterResourcePlacement` object API in Microsoft Azure Kubernetes Fleet Manager.

## Symptoms

When you use the `ClusterResourcePlacement` API object in Azure Kubernetes Fleet Manager to propagate resources, the deployment fails. The `ClusterResourcePlacementApplied` status shows as `False`.

## Cause

This issue might occur because of one of the following reasons:

- The resource already exists on the cluster and isn't managed by the fleet controller. To resolve this issue, update the `ClusterResourcePlacement` manifest YAML file to use `AllowCoOwnership` within `ApplyStrategy` to allow the fleet controller to manage the resource.
- Another `ClusterResourcePlacement` deployment is already managing the resource for the selected cluster by using a different apply strategy.
- The `ClusterResourcePlacement` deployment doesn't apply the manifest because of syntax errors or invalid resource configurations. This might also occur if a resource is propagated through an envelope object.

## Troubleshooting steps

1. View the `ClusterResourcePlacement` status and locate the `placementStatuses` section. Check the `placementStatuses` value to identify which clusters have the `ResourceApplied` condition set to `False`, and note their `clusterName` value.
2. Locate the `Work` object in the hub cluster. Use the identified `clusterName` to locate the `Work` object that's associated with the member cluster. For more information, see [How to find the correct Work resource associated with `ClusterResourcePlacement`](troubleshoot-clusterresourceplacement-api-issues.md#find-work).
3. Check the status of the `Work` object to understand the specific issues that are preventing successful resource application.

## Case study

In the following example, `ClusterResourcePlacement` is trying to propagate a namespace that contains a deployment to two member clusters. However, the namespace already exists on one member cluster, specifically `kind-cluster-1`.

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

In the `failedPlacements` section for `kind-cluster-1`, the `message` fields explain why the resource wasn't applied on the member cluster. In the preceding `conditions` section, the `Applied` condition for `kind-cluster-1` is flagged as `false` and shows the `NotAllWorkHaveBeenApplied` reason. This indicates that the `Work` object that's intended for the member cluster `kind-cluster-1` wasn't applied. For more information, see [How to find the correct Work resource associated with `ClusterResourcePlacement`](troubleshoot-clusterresourceplacement-api-issues.md#find-work).

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

In this situation, a potential solution is to set the `AllowCoOwnership` to `true` in the ApplyStrategy policy. However, it's important to notice that this decision should be made by the user because the resources might not be shared.

Additionally, you can review the logs for the [Apply Work Controller](https://github.com/Azure/fleet/blob/main/pkg/controllers/work/apply_controller.go) for more insights into why the resources are unavailable.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
