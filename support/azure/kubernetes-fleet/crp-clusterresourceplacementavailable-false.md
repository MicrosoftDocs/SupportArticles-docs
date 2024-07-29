---
title: ClusterResourcePlacementAvailable is false when using ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager
description: Helps you resolve ClusterResourcePlacementAvailable  failure when propagating resource by using ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager APIs.
ms.date: 07/22/2024
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Resource propagation failure: ClusterResourcePlacementAvailable is false

This article describes how to troubleshoot `ClusterResourcePlacementAvailable` issues when propagating resources using `ClusterResourcePlacement` object API in Azure Kubernetes Fleet Manager.

## Symptoms

When using the `ClusterResourcePlacement` API object with Azure Kubernetes Fleet Manager to propagate resources, the deployment fails. The `ClusterResourcePlacementAvailable` status shows as false.

## Cause

This issue might occur because of one of the following reasons:

- The member cluster doesn't have enough resource availability.
- The deployment contains an invalid image name.

## Case study

The example below shows how ClusterResourcePlacement can fail to propagate a deployment to a member cluster due to an invalid image name.

#### ClusterResourcePlacement spec

```YAML
apiVersion: placement.kubernetes-fleet.io/v1beta1
kind: ClusterResourcePlacement
metadata:
  name: crp
spec:
  resourceSelectors:
    - group: ""
      kind: Namespace
      name: test-ns
      version: v1
  policy:
    placementType: PickN
    numberOfClusters: 1
  strategy:
    type: RollingUpdate
```

#### CRP status:

```
status:
  conditions:
  - lastTransitionTime: "2024-05-14T18:52:30Z"
    message: found all cluster needed as specified by the scheduling policy, found
      1 cluster(s)
    observedGeneration: 1
    reason: SchedulingPolicyFulfilled
    status: "True"
    type: ClusterResourcePlacementScheduled
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: All 1 cluster(s) start rolling out the latest resource
    observedGeneration: 1
    reason: RolloutStarted
    status: "True"
    type: ClusterResourcePlacementRolloutStarted
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: No override rules are configured for the selected resources
    observedGeneration: 1
    reason: NoOverrideSpecified
    status: "True"
    type: ClusterResourcePlacementOverridden
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: Works(s) are succcesfully created or updated in 1 target cluster(s)'
      namespaces
    observedGeneration: 1
    reason: WorkSynchronized
    status: "True"
    type: ClusterResourcePlacementWorkSynchronized
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: The selected resources are successfully applied to 1 cluster(s)
    observedGeneration: 1
    reason: ApplySucceeded
    status: "True"
    type: ClusterResourcePlacementApplied
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: The selected resources in 1 cluster(s) are still not available yet
    observedGeneration: 1
    reason: ResourceNotAvailableYet
    status: "False"
    type: ClusterResourcePlacementAvailable
  observedResourceIndex: "0"
  placementStatuses:
  - clusterName: kind-cluster-1
    conditions:
    - lastTransitionTime: "2024-05-14T18:52:30Z"
      message: 'Successfully scheduled resources for placement in kind-cluster-1 (affinity
        score: 0, topology spread score: 0): picked by scheduling policy'
      observedGeneration: 1
      reason: Scheduled
      status: "True"
      type: Scheduled
    - lastTransitionTime: "2024-05-14T18:52:31Z"
      message: Detected the new changes on the resources and started the rollout process
      observedGeneration: 1
      reason: RolloutStarted
      status: "True"
      type: RolloutStarted
    - lastTransitionTime: "2024-05-14T18:52:31Z"
      message: No override rules are configured for the selected resources
      observedGeneration: 1
      reason: NoOverrideSpecified
      status: "True"
      type: Overridden
    - lastTransitionTime: "2024-05-14T18:52:31Z"
      message: All of the works are synchronized to the latest
      observedGeneration: 1
      reason: AllWorkSynced
      status: "True"
      type: WorkSynchronized
    - lastTransitionTime: "2024-05-14T18:52:31Z"
      message: All corresponding work objects are applied
      observedGeneration: 1
      reason: AllWorkHaveBeenApplied
      status: "True"
      type: Applied
    - lastTransitionTime: "2024-05-14T18:52:31Z"
      message: Work object crp1-work is not available
      observedGeneration: 1
      reason: NotAllWorkAreAvailable
      status: "False"
      type: Available
    failedPlacements:
    - condition:
        lastTransitionTime: "2024-05-14T18:52:31Z"
        message: Manifest is trackable but not available yet
        observedGeneration: 1
        reason: ManifestNotAvailableYet
        status: "False"
        type: Available
      group: apps
      kind: Deployment
      name: my-deployment
      namespace: test-ns
      version: v1
  selectedResources:
  - kind: Namespace
    name: test-ns
    version: v1
  - group: apps
    kind: Deployment
    name: my-deployment
    namespace: test-ns
    version: v1
 ```
In the `failedPlacements` section for `kind-cluster-1`, the `message` field explains why the resource failed to apply on the member cluster. In the preceding `conditions` section, the `Applied` condition for `kind-cluster-1` is flagged as `false` with the `NotAllWorkHaveBeenApplied` reason. This indicates that the `Work` object intended for the member cluster `kind-cluster-1` has not been applied. For more information, see [How to find the correct Work resource associated with `ClusterResourcePlacement`](troubleshoot-clusterresourceplacement-api-issues.md#find-work).

### Work status of kind-cluster-1:
```
status:
conditions:
- lastTransitionTime: "2024-05-14T18:52:31Z"
  message: Work is applied successfully
  observedGeneration: 1
  reason: WorkAppliedCompleted
  status: "True"
  type: Applied
- lastTransitionTime: "2024-05-14T18:52:31Z"
  message: Manifest {Ordinal:1 Group:apps Version:v1 Kind:Deployment Resource:deployments
  Namespace:test-ns Name:my-deployment} is not available yet
  observedGeneration: 1
  reason: WorkNotAvailableYet
  status: "False"
  type: Available
  manifestConditions:
- conditions:
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: Manifest is already up to date
    reason: ManifestAlreadyUpToDate
    status: "True"
    type: Applied
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: Manifest is trackable and available now
    reason: ManifestAvailable
    status: "True"
    type: Available
    identifier:
    kind: Namespace
    name: test-ns
    ordinal: 0
    resource: namespaces
    version: v1
- conditions:
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: Manifest is already up to date
    observedGeneration: 1
    reason: ManifestAlreadyUpToDate
    status: "True"
    type: Applied
  - lastTransitionTime: "2024-05-14T18:52:31Z"
    message: Manifest is trackable but not available yet
    observedGeneration: 1
    reason: ManifestNotAvailableYet
    status: "False"
    type: Available
    identifier:
    group: apps
    kind: Deployment
    name: my-deployment
    namespace: test-ns
    ordinal: 1
    resource: deployments
    version: v1
```

Check the `Available` status for `kind-cluster-1`, and you can see that the `my-deployment` deployment is not yet available on the member cluster. This suggests there may be an issue with the deployment manifest.

### Resolution

In this scenario, a potential solution is to check the deployment in the member cluster, as the message indicates that the root cause of the issue is a bad image name. Once this image name is identified, you can correct the deployment manifest and update it. After fixing and updating the resource manifest, the `ClusterResourcePlacement` object API will automatically propagate the corrected resource to the member cluster.

For all other scenarios, ensure the propagated resource is configured correctly. Additionally, verify that the selected cluster has sufficient available capacity to accommodate the new resources.