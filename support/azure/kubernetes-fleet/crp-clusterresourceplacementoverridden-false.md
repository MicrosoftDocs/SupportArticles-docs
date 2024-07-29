---
title: clusterResourcePlacementOverridden is false when using ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager
description: Helps you resolve clusterResourcePlacementOverridden failure when propagating resource by using ClusterResourcePlacement API object in Azure Kubernetes Fleet Manager APIs.
ms.date: 07/22/2024
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Resource propagation failure: clusterResourcePlacementOverridden is false

This article describes how to troubleshoot `clusterResourcePlacementOverridden` issues when propagating resources using `ClusterResourcePlacement` object API in Azure Kubernetes Fleet Manager.

## Symptoms

When using the `ClusterResourcePlacement` API object with Azure Kubernetes Fleet Manager to propagate resources, the deployment fails. The `clusterResourcePlacementOverridden` status shows as false.

## Cause

This issue might occur because the `ClusterResourceOverride` or `ResourceOverride` is created with an invalid field path for the resource.

## Case study

In the following example, an attempt is made to override the cluster role `secret-reader` that is propagated by the `ClusterResourcePlacement` to the selected clusters.
However, the `ClusterResourceOverride` is created with an invalid path for the resource.

### ClusterRole

```YAML
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
annotations:
kubectl.kubernetes.io/last-applied-configuration: |
{"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRole","metadata":{"annotations":{},"name":"secret-reader"},"rules":[{"apiGroups":[""],"resources":["secrets"],"verbs":["get","watch","list"]}]}
creationTimestamp: "2024-05-14T15:36:48Z"
name: secret-reader
resourceVersion: "81334"
uid: 108e6312-3416-49be-aa3d-a665c5df58b4
rules:
- apiGroups:
  - ""
    resources:
  - secrets
    verbs:
  - get
  - watch
  - list
```
The `ClusterRole` `secret-reader` that is propagated to the member clusters by the `ClusterResourcePlacement`.

### ClusterResourceOverride spec
```YAML
spec:
  clusterResourceSelectors:
  - group: rbac.authorization.k8s.io
    kind: ClusterRole
    name: secret-reader
    version: v1
  policy:
    overrideRules:
    - clusterSelector:
        clusterSelectorTerms:
        - labelSelector:
            matchLabels:
              env: canary
      jsonPatchOverrides:
      - op: add
        path: /metadata/labels/new-label
        value: new-value
```
The `ClusterResourceOverride` is created to override the `ClusterRole` `secret-reader` by adding a new label `new-label`
with a value `new-value` for the clusters with the label `env: canary`.

### ClusterResourcePlacement Spec
```YAML
spec:
  resourceSelectors:
    - group: rbac.authorization.k8s.io
      kind: ClusterRole
      name: secret-reader
      version: v1
  policy:
    placementType: PickN
    numberOfClusters: 1
    affinity:
      clusterAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          clusterSelectorTerms:
            - labelSelector:
                matchLabels:
                  env: canary
  strategy:
    type: RollingUpdate
    applyStrategy:
      allowCoOwnership: true
```

### ClusterResourcePlacement Status:
```Output
status:
  conditions:
  - lastTransitionTime: "2024-05-14T16:16:18Z"
    message: found all cluster needed as specified by the scheduling policy, found
      1 cluster(s)
    observedGeneration: 1
    reason: SchedulingPolicyFulfilled
    status: "True"
    type: ClusterResourcePlacementScheduled
  - lastTransitionTime: "2024-05-14T16:16:18Z"
    message: All 1 cluster(s) start rolling out the latest resource
    observedGeneration: 1
    reason: RolloutStarted
    status: "True"
    type: ClusterResourcePlacementRolloutStarted
  - lastTransitionTime: "2024-05-14T16:16:18Z"
    message: Failed to override resources in 1 cluster(s)
    observedGeneration: 1
    reason: OverriddenFailed
    status: "False"
    type: ClusterResourcePlacementOverridden
  observedResourceIndex: "0"
  placementStatuses:
  - applicableClusterResourceOverrides:
    - cro-1-0
    clusterName: kind-cluster-1
    conditions:
    - lastTransitionTime: "2024-05-14T16:16:18Z"
      message: 'Successfully scheduled resources for placement in kind-cluster-1 (affinity
        score: 0, topology spread score: 0): picked by scheduling policy'
      observedGeneration: 1
      reason: Scheduled
      status: "True"
      type: Scheduled
    - lastTransitionTime: "2024-05-14T16:16:18Z"
      message: Detected the new changes on the resources and started the rollout process
      observedGeneration: 1
      reason: RolloutStarted
      status: "True"
      type: RolloutStarted
    - lastTransitionTime: "2024-05-14T16:16:18Z"
      message: 'Failed to apply the override rules on the resources: add operation
        does not apply: doc is missing path: "/metadata/labels/new-label": missing
        value'
      observedGeneration: 1
      reason: OverriddenFailed
      status: "False"
      type: Overridden
  selectedResources:
  - group: rbac.authorization.k8s.io
    kind: ClusterRole
    name: secret-reader
    version: v1
```

When the `ClusterResourcePlacementOverridden` condition is false, check the `placementStatuses` section to get the exact cause of the failure.

In this case, The message indicates that the override failed because the path `/metadata/labels/new-label` and its corresponding value are missing.
Based on the previous example of the cluster role `secret-reader`, it's evident that the path `/metadata/labels/` does not exist, meaning that `labels` does not exist.
Therefore, a new label cannot be added.


### Resolution
To successfully override the ClusterRole `secret-reader`, correct the path and value in the `ClusterResourceOverride` as shown below:
```
jsonPatchOverrides:
  - op: add
    path: /metadata/labels
    value: 
      newlabel: new-value
```

This will add the new label `newlabel` with the value `new-value` to the ClusterRole `secret-reader` by creating the labels field and adding the new value newlabel: new-value.