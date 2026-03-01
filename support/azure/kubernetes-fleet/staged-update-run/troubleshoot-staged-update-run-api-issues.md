---
title: Troubleshoot ClusterStagedUpdateRun and StagedUpdateRun API object-related errors for Azure Kubernetes Fleet Manager (preview)
description: Troubleshoot issues that occur when you use the ClusterStagedUpdateRun or StagedUpdateRun API in Azure Kubernetes Fleet Manager.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
zone_pivot_groups: cluster-namespace-scope
---

# Troubleshoot ClusterStagedUpdateRun and StagedUpdateRun API object-related errors for Azure Kubernetes Fleet Manager (preview)

:::zone target="docs" pivot="cluster-scope"

## Summary

This article helps you resolve `ClusterStagedUpdateRun` API and `StagedUpdateRun` API object-related errors that occur when you use Azure Kubernetes Fleet Manager. Troubleshooting these errors on the hub cluster requires knowledge of the following objects:

**ClusterStagedUpdateRun**
- `ClusterResourceSnapshot`
- `ClusterSchedulingPolicySnapshot`
- `ClusterResourceBinding`

**StagedUpdateRun**
- `ResourceSnapshot`
- `SchedulingPolicySnapshot`
- `ResourceBinding`

For more information about each object, see [KubeFleet API reference](https://kubefleet-dev.github.io/website/docs/api-reference/).

## Complete progression of `ClusterStagedUpdateRun` deployment

Understanding the progression and status of the `ClusterStagedUpdateRun` custom resource is crucial to be able to diagnose and identify failures. You can view the status of the `ClusterStagedUpdateRun` deployment by running the following command:

```bash
kubectl describe clusterstagedupdaterun <name>
```

The progression of `ClusterStagedUpdateRun` is as follows:

- **Initialized**: Indicates whether the `ClusterStagedUpdateRun` and its corresponding resources (`ClusterResourcePlacement`, `ClusterStagedUpdateStrategy`) are set up correctly to start the rollout.

For more information, see [How To Troubleshoot ClusterStagedUpdateRun Initialization Failures](./troubleshoot-cluster-staged-update-run-initialization-failures.md).

- **Progressing**: Indicates that the deployment is processing each stage sequentially, updating clusters within each stage (respecting `maxConcurrency`), and enforcing before-stage and after-stage tasks.

If `UpdateRunStuck` is set to 'False`, see [How To Troubleshoot ClusterStagedUpdateRun Stuck](./troubleshoot-cluster-staged-update-run-stuck.md) Otherwise, see [How To Troubleshoot ClusterStagedUpdateRun Execution Failures](./troubleshoot-cluster-staged-update-run-execution-failures.md).

### Troubleshooting when using `ClusterStagedUpdateRun`

- **`ClusterStagedUpdateRun` doesn't run automatically**

#### Cause

If you create a `ClusterStagedUpdateRun` instance without indicating a state, `ClusterStagedUpdateRun` doesn't start the run. `ClusterStagedUpdateRun` uses the default value instead.

```yaml
apiVersion: placement.kubernetes-fleet.io/v1beta1
kind: ClusterStagedUpdateRun
metadata:
  ...
  generation: 1
  name: example-run
  ...
spec:
  placementName: example-placement
  resourceSnapshotIndex: "0"
  stagedRolloutStrategyName: example-strategy
  state: Initialize
status:
  appliedStrategy:
    comparisonOption: PartialComparison
    type: ClientSideApply
    whenToApply: Always
    whenToTakeOver: Always
  conditions:
  - lastTransitionTime: "2026-01-09T01:21:18Z"
    message: The UpdateRun initialized successfully
    observedGeneration: 1
    reason: UpdateRunInitializedSuccessfully
    status: "True"
    type: Initialized
```

In this case, `ClusterStagedUpdateRun` defaults to `Initialize`. 

#### Solution

Update `ClusterStagedUpdateRun` to the `Run` state by running the following command:

```bash
kubectl patch clusterstagedupdaterun example-run --type='merge' -p '{"spec":{"state":"Run"}}'
```

- **`ClusterStagedUpdateRun` doesn't progress after user approves `ClusterApprovalRequest`**

Check `ClusterStagedUpdateRun` to investigate:

```bash
$ kubectl get clusterstagedupdaterun example-run -o yaml

...
status:
  appliedStrategy:
    comparisonOption: PartialComparison
    type: ClientSideApply
    whenToApply: Always
    whenToTakeOver: Always
  conditions:
  - lastTransitionTime: "2026-01-09T01:49:06Z"
    message: The UpdateRun initialized successfully
    observedGeneration: 1
    reason: UpdateRunInitializedSuccessfully
    status: "True"
    type: Initialized
  - lastTransitionTime: "2026-01-09T01:55:36Z"
    message: The updateRun is waiting for after-stage tasks in stage staging to complete
    observedGeneration: 1
    reason: UpdateRunWaiting
    status: "False"
    type: Progressing
...
```

#### Cause 

`ClusterStagedUpdateRun` is still waiting for approval from the user. Examine `ClusterApprovalRequest` to verify:

```bash
$ kubectl get clusterapprovalrequest example-run-after-staging -o yaml

apiVersion: placement.kubernetes-fleet.io/v1beta1
kind: ClusterApprovalRequest
metadata:
  creationTimestamp: "2026-01-09T01:49:36Z"
  generation: 1
  labels:
    kubernetes-fleet.io/isLatestUpdateRunApproval: "true"
    kubernetes-fleet.io/targetUpdateRun: example-run
    kubernetes-fleet.io/targetUpdatingStage: staging
    kubernetes-fleet.io/taskType: afterStage
  name: example-run-after-staging
  resourceVersion: "20752"
  uid: 9eae4ea0-3c4c-4182-a1d6-b7f1761caa6a
spec:
  parentStageRollout: example-run
  targetStage: staging
status:
  conditions:
  - lastTransitionTime: "2026-01-09T01:53:53Z"
    message: approved
    observedGeneration: 0
    reason: approved
    status: "True"
    type: Approved
```

Notice that the user approved the request (`status: "True"`, `type: Approved`). However, the approval isn't accepted because the `observedGeneration` value for `Approved` is set to `0`, but `observedGeneration` is set to `1`. This mismatch applies to both before-stage and after-stage tasks.

#### Solution

Update `observedGeneration` to `Approved`. You can also reapprove by using the correct `observedGeneration` value:

```bash
kubectl patch clusterapprovalrequests example-run-before-canary --type='merge' \
  -p '{"status":{"conditions":[{"type":"Approved","status":"True","reason":"approved","message":"approved","lastTransitionTime":"'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'","observedGeneration":1}]}}' \
  --subresource=status
```

:::zone-end

:::zone target="docs" pivot="namespace-scope"

## Complete progression of `StagedUpdateRun` deployment

It's crucial to understand the progression and status of the `StagedUpdateRun` custom resource in order to diagnose and identify failures. To view the status of `StagedUpdateRun`, run the following command:

```bash
kubectl describe stagedupdaterun <name>
```

The progression of `StagedUpdateRun` is as follows:

1. **Initialized**: Indicates whether the `StagedUpdateRun` and its corresponding resources (`ResourcePlacement`, `StagedUpdateStrategy`) are set up correctly to start the rollout.

For more information, see [How To Troubleshoot StagedUpdateRun Initialization Failures](./troubleshoot-cluster-staged-update-run-initialization-failures.md).

2. **Progressing**: Indicates that the deployment is processing each stage sequentially, updating clusters within each stage (respecting `maxConcurrency`), and enforcing before-stage and after-stage tasks.

If `UpdateRunStuck` is set to `False`, see [How To Troubleshoot StagedUpdateRun Stuck](./troubleshoot-cluster-staged-update-run-stuck.md). Otherwise, see [How To Troubleshoot StagedUpdateRun Execution Failures](./troubleshoot-cluster-staged-update-run-execution-failures.md).

### Troubleshooting when using `StagedUpdateRun`

- **`StagedUpdateRun` doesn't execute automatically**

#### Cause

If you create `StagedUpdateRun` without indicating a state, `StagedUpdateRun` doesn't start the run. `StagedUpdateRun` uses the default value instead.

```yaml
apiVersion: placement.kubernetes-fleet.io/v1beta1
kind: StagedUpdateRun
metadata:
  ...
  generation: 1
  name: web-app-rollout
  namespace: my-app-namespace
  ...
spec:
  placementName: web-app-rollout-placement
  resourceSnapshotIndex: "0"
  stagedRolloutStrategyName: example-strategy
  state: Initialize
status:
  appliedStrategy:
    comparisonOption: PartialComparison
    type: ClientSideApply
    whenToApply: Always
    whenToTakeOver: Always
  conditions:
  - lastTransitionTime: "2026-01-09T01:21:18Z"
    message: The UpdateRun initialized successfully
    observedGeneration: 1
    reason: UpdateRunInitializedSuccessfully
    status: "True"
    type: Initialized
```

In this case, `StagedUpdateRun` defaults to `Initialize`. 

#### Solution

Update `StagedUpdateRun` to the `Run` state by running the following command:

```bash
kubectl patch stagedupdaterun web-app-rollout -n my-app-namespace --type='merge' -p '{"spec":{"state":"Run"}}'
```

- **`StagedUpdateRun` doesn't progress after user approves `ApprovalRequest`**

Examine `StagedUpdateRun` to investigate:

```bash
$ kubectl get stagedupdaterun web-app-rollout -n my-app-namespace -o yaml

...
status:
  appliedStrategy:
    comparisonOption: PartialComparison
    type: ClientSideApply
    whenToApply: Always
    whenToTakeOver: Always
  conditions:
  - lastTransitionTime: "2026-01-09T01:49:06Z"
    message: The UpdateRun initialized successfully
    observedGeneration: 1
    reason: UpdateRunInitializedSuccessfully
    status: "True"
    type: Initialized
  - lastTransitionTime: "2026-01-09T01:55:36Z"
    message: The updateRun is waiting for after-stage tasks in stage staging to complete
    observedGeneration: 1
    reason: UpdateRunWaiting
    status: "False"
    type: Progressing
...
```

#### Cause

`StagedUpdateRun` is still waiting for approval from the user. Examine `ApprovalRequest` to verify:

```bash
$ kubectl get approvalrequests web-app-rollout-before-dev -n my-app-namespace -o yaml

apiVersion: placement.kubernetes-fleet.io/v1beta1
kind: ApprovalRequest
metadata:
  creationTimestamp: "2026-01-09T02:31:57Z"
  generation: 1
  labels:
    kubernetes-fleet.io/isLatestUpdateRunApproval: "true"
    kubernetes-fleet.io/targetUpdateRun: web-app-rollout
    kubernetes-fleet.io/targetUpdatingStage: dev
    kubernetes-fleet.io/taskType: beforeStage
  name: web-app-rollout-before-dev
  namespace: my-app-namespace
  resourceVersion: "25386"
  uid: 6442e1ef-b694-4d59-8691-a3f5200c29ad
spec:
  parentStageRollout: web-app-rollout
  targetStage: dev
status:
  conditions:
  - lastTransitionTime: "2026-01-09T02:33:15Z"
    message: approved
    observedGeneration: 0
    reason: approved
    status: "True"
    type: Approved

```

Notice that the user approved the request (`status: "True"`, `type: Approved`). However, the approval isn't accepted because `observedGeneration` for `Approved` is set to `0`, but `observedGeneration` is set to `1`. This mismatch applies to both before-stage and after-stage tasks.

#### Solution

Update `observedGeneration` to `Approved`. You can also reapprove by using the correct `observedGeneration` value:

```bash
kubectl patch approvalrequests web-app-rollout-before-dev -n my-app-namespace --type='merge' \
  -p '{"status":{"conditions":[{"type":"Approved","status":"True","reason":"approved","message":"approved","lastTransitionTime":"'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'","observedGeneration":1}]}}' \
  --subresource=status
```

:::zone-end
