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

2.**Progressing**: Processes stages sequentially, updates clusters within each stage (respecting maxConcurrency), enforces before-stage and after-stage tasks.

  If false, see How To Troubleshoot ClusterStagedUpdateRun Execution Failures.

### Things to keep in mind when using `ClusterStagedUpdateRun`

When `ClusterStagedUpdateRun` is created with no state, the `ClusterStagedUpdateRun` doesn't start execution. The `ClusterStagedUpdateRun` uses the default value in this case.

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

No state defined in a `ClusterStagedUpdateRun` defaults to "Initialize" state. To start execution, patch the `ClusterStagedUpdateRun` to a "Run" state:

```bash
kubectl patch clusterstagedupdaterun example-run --type='merge' -p '{"spec":{"state":"Run"}}'
```
