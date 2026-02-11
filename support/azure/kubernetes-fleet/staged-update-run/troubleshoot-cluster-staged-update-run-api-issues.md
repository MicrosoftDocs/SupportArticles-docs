---
title: Troubleshoot Azure Kubernetes Fleet Manager ClusterStagedUpdateRun
description: Troubleshoot errors that occur when using the ClusterStagedUpdateRun API in Azure Kubernetes Fleet Manager.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Troubleshooting ClusterStagedUpdateRun API in Azure Kubernetes Fleet Manager (preview)

## Summary

This troubleshooting guide helps you resolve `ClusterStagedUpdateRun` API object-related issues when you use Azure Kubernetes Fleet Manager. Troubleshooting these errors on the hub cluster requires knowledge of the following objects:

- `ClusterResourceSnapshot`
- `ClusterSchedulingPolicySnapshot`
- `ClusterResourceBinding`

For more information about each object, see the [KubeFleet API reference](https://kubefleet-dev.github.io/website/docs/api-reference/).

## Complete progression of the ClusterStagedUpdateRun deployment

Understanding the progression and status of the `ClusterStagedUpdateRun` custom resource is crucial for diagnosing and identifying failures. You can view the status of the `ClusterStagedUpdateRun` custom resource by using the following command:

```bash
kubectl describe clusterstagedupdaterun <name>
```

The complete progression of `ClusterStagedUpdateRun` is as follows:

1. **Initialized**: Indicates if the `ClusterStagedUpdateRun` and its corresponding resources (`ClusterResourcePlacement`, `ClusterStagedUpdateStrategy`) are set up correctly to start rollout.

  If false, see [How To Troubleshoot ClusterStagedUpdateRun Initialization Failures](./troubleshoot-cluster-staged-update-run-initialization-failures.md).

2. **Progressing**: Processes stages sequentially, updates clusters within each stage (respecting maxConcurrency), enforces before-stage and after-stage tasks.

  If false with "UpdateRunStuck," see [How To Troubleshoot ClusterStagedUpdateRun Stuck](./troubleshoot-cluster-staged-update-run-stuck.md).

  Otherwise, see [How To Troubleshoot ClusterStagedUpdateRun Execution Failures](./troubleshoot-cluster-staged-update-run-execution-failures.md).

### Things to keep in mind when using `ClusterStagedUpdateRun`

1. `ClusterStagedUpdateRun` doesn't execute automatically.

When you create `ClusterStagedUpdateRun` with no state, the `ClusterStagedUpdateRun` doesn't start execution. The `ClusterStagedUpdateRun` uses the default value in this case.

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

No state defined in a `ClusterStagedUpdateRun` defaults to "Initialize" state. To start execution, patch the `ClusterStagedUpdateRun` to "Run" state:

```bash
kubectl patch clusterstagedupdaterun example-run --type='merge' -p '{"spec":{"state":"Run"}}'
```

2. `ClusterStagedUpdateRun` not progressing after user approves `ClusterApprovalRequest`

Check the `ClusterStagedUpdateRun` for insights:

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

The `ClusterStagedUpdateRun` is still waiting for approval from the user. Check the `ClusterApprovalRequest` to verify:

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

Notice that the user approved the request (status: "True," type: "Approved"), but the approval isn't accepted. The issue is that the `observedGeneration` for the `Approved` condition is 0, but the object's generation is 1. This mismatch applies to both before and after stage tasks.

Update the `observedGeneration` for the Approved condition. Or, reapprove with the correct `observedGeneration`:

```bash
kubectl patch clusterapprovalrequests example-run-before-canary --type='merge' \
  -p '{"status":{"conditions":[{"type":"Approved","status":"True","reason":"approved","message":"approved","lastTransitionTime":"'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'","observedGeneration":1}]}}' \
  --subresource=status
```
