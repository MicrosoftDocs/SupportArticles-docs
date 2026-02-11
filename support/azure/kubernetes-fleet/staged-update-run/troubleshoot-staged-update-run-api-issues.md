---
title: Troubleshoot Azure Kubernetes Fleet Manager StagedUpdateRun
description: Troubleshoot errors that occur when using the StagedUpdateRun API in Azure Kubernetes Fleet Manager.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Troubleshooting StagedUpdateRun API in Azure Kubernetes Fleet Manager (preview)

## Summary

This troubleshooting guide helps you resolve `StagedUpdateRun` API object-related issues when you use Azure Kubernetes Fleet Manager. Troubleshooting these errors on the hub cluster requires knowledge of the following objects:

- `ResourceSnapshot`
- `SchedulingPolicySnapshot`
- `ResourceBinding`

For more information about each object, see the [KubeFleet API reference](https://kubefleet-dev.github.io/website/docs/api-reference/).

## Complete progression of the StagedUpdateRun deployment

Understanding the progression and status of the `StagedUpdateRun` custom resource is crucial for diagnosing and identifying failures. You can view the status of the `StagedUpdateRun` custom resource by using the following command:

```bash
kubectl describe stagedupdaterun <name>
```

The complete progression of `StagedUpdateRun` is as follows:

1. **Initialized**: Indicates if the `StagedUpdateRun` and its corresponding resources (`ResourcePlacement`, `StagedUpdateStrategy`) are set up correctly to start rollout.

  If false, see [How To Troubleshoot StagedUpdateRun Initialization Failures](./troubleshoot-cluster-staged-update-run-initialization-failures.md).

2. **Progressing**: Processes stages sequentially, updates clusters within each stage (respecting maxConcurrency), enforces before-stage and after-stage tasks.

  If false with "UpdateRunStuck," see [How To Troubleshoot StagedUpdateRun Stuck](./troubleshoot-cluster-staged-update-run-stuck.md).

  Otherwise, see [How To Troubleshoot StagedUpdateRun Execution Failures](./troubleshoot-cluster-staged-update-run-execution-failures.md).

### Things to keep in mind when using `StagedUpdateRun`

1. `StagedUpdateRun` doesn't execute automatically.

When you create `StagedUpdateRun` with no state, the `StagedUpdateRun` doesn't start execution. The `StagedUpdateRun` uses the default value in this case.

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

No state defined in a `StagedUpdateRun` defaults to "Initialize" state. To start execution, patch the `StagedUpdateRun` to "Run" state:

```bash
kubectl patch stagedupdaterun web-app-rollout -n my-app-namespace --type='merge' -p '{"spec":{"state":"Run"}}'
```

2. `StagedUpdateRun` not progressing after user approves `ApprovalRequest`

Check the `StagedUpdateRun` for insights:

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

The `StagedUpdateRun` is still waiting for approval from the user. Check the `ApprovalRequest` to verify:

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

Notice that the user approved the request (status: "True," type: "Approved"), but the approval isn't accepted. The issue is that the `observedGeneration` for the `Approved` condition is 0, but the object's generation is 1. This mismatch applies to both before and after stage tasks.

Update the `observedGeneration` for the Approved condition. Or, reapprove with the correct `observedGeneration`:

```bash
kubectl patch approvalrequests web-app-rollout-before-dev -n my-app-namespace --type='merge' \
  -p '{"status":{"conditions":[{"type":"Approved","status":"True","reason":"approved","message":"approved","lastTransitionTime":"'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'","observedGeneration":1}]}}' \
  --subresource=status
```
