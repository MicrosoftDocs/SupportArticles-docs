---
title: Troubleshooting ClusterResourcePlacementApplied failure when using ClusterResourcePlacement in Azure Kubernetes Fleet Manager APIs
description: Helps you resolve ClusterResourcePlacementApplied failure when propagating resource by using ClusterResourcePlacement in Azure Kubernetes Fleet Manager APIs.
ms.date: 07/22/2024
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance,devx-track-azurecli
---

# Resource propagation failure: ClusterResourcePlacementApplied is false

> Note: In addition, it may be helpful to look into the logs for the [apply work controller](https://github.com/Azure/fleet/blob/main/pkg/controllers/work/apply_controller.go) to get more information on why the resources are not available

### Common scenarios:
- When the CRP is unable to propagate resources to a selected cluster due to the resource already existing on the cluster and not being managed by the fleet controller. 
To remedy, CRP can `AllowCoOwnership` within `ApplyStrategy` to allow the resource to be managed by the fleet controller.
- When the CRP is unable to propagate resource to selected due to another CRP already managing the resource for selected cluster with a different apply strategy.
- When the CRP is unable to propagate resource due to failing to apply manifest due to syntax errors (which can happen when a resource is being propagated through an envelope object) or invalid resource configurations.

### Investigation steps:

1. Check `placementStatuses`: In the `ClusterResourcePlacement` status section, inspect the `placementStatuses` to identify which clusters have the `ResourceApplied` condition set to `false` and note down their `clusterName`.
2. Locate `Work` Object in Hub Cluster: Use the identified `clusterName` to locate the `Work` object associated with the member cluster. Please refer to this [section](#how-and-where-to-find-the-correct-work-resource) to learn how to get the correct `Work` resource.
3. Check `Work` object status: Inspect the status of the `Work` object to understand the specific issues preventing successful resource application.

### Example Scenario:
In this example, the `ClusterResourcePlacement` is attempting to propagate a namespace containing a deployment to two member clusters. However, the namespace already exists on one member cluster, specifically named `kind-cluster-1`.

### CRP spec:
```
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

### CRP status:
```
status:
  conditions:
  - lastTransitionTime: "2024-05-07T23:32:40Z"
    message: could not find all the clusters needed as specified by the scheduling
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
      message: The availability of work object crp-4-work is not trackable
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
      message: Work object crp-4-work is not applied
      observedGeneration: 1
      reason: NotAllWorkHaveBeenApplied
      status: "False"
      type: Applied
    failedPlacements:
    - condition:
        lastTransitionTime: "2024-05-07T23:32:40Z"
        message: 'Failed to apply manifest: failed to process the request due to a
          client error: resource exists and is not managed by the fleet controller
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


In the `ClusterResourcePlacement` status, within the `failedPlacements` section for `kind-cluster-1`, we get a clear message
as to why the resource failed to apply on the member cluster. Immediately preceding this in the conditions section,
the `Applied` condition for `kind-cluster-1` is flagged as false, citing the `NotAllWorkHaveBeenApplied` reason.
This signifies that the Work object intended for the member cluster `kind-cluster-1` has not been applied.

To gain more insights also take a look at the `work` object, please check this [section](#how-and-where-to-find-the-correct-work-resource) for more details,

### Work status of kind-cluster-1:
```
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
        error: resource exists and is not managed by the fleet controller and co-ownernship
        is disallowed'
      reason: ManifestsAlreadyOwnedByOthers
      status: "False"
      type: Applied
    - lastTransitionTime: "2024-05-07T23:32:40Z"
      message: Manifest is not applied yet
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

From looking at the `Work` status and specifically the `manifestConditions` section, we could see that the namespace could not be applied but the deployment within the namespace got propagated from hub to the member cluster.

### Resolution:
In this scenario, a potential solution is to delete the existing namespace on the member cluster. However, it's essential to note that this decision rests with the user, as the namespace might already contain resources.