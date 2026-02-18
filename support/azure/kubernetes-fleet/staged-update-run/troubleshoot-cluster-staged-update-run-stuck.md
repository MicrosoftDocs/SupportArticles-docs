---
title: Troubleshoot ClusterStagedUpdateRun and StagedUpdateRun stuck errors
description: Troubleshoot errors that occur when ClusterStagedUpdateRun and StagedUpdateRun are stuck.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
zone_pivot_groups: cluster-namespace-scope
---

# Troubleshoot `ClusterStagedUpdateRun` and `StagedUpdateRun` stuck errors

## Summary

This article discusses how to troubleshoot `ClusterStagedUpdateRun` and `StagedUpdateRun` error messages that occur when the update run is stuck while using update run APIs in Microsoft Azure Kubernetes Fleet Manager. 

The following is an example error message:

```yaml
    Last Transition Time:  2026-02-11T22:15:20Z
    Message:               The UpdateRun initialized successfully
    Observed Generation:   2
    Reason:                UpdateRunInitializedSuccessfully
    Status:                True
    Type:                  Initialized
    Last Transition Time:  2026-02-11T22:15:59Z
    Message:               The updateRun is stuck waiting for member2 cluster(s) in stage staging to finish
      updating, please check placement status for potential errors
    Observed Generation:   2
    Reason:                UpdateRunStuck
    Status:                False
    Type:                  Progressing
```

## Investigate update run stuck errors

:::zone target="docs" pivot="cluster-scope"

1. Locate the `ClusterStagedUpdateRun` stuck error by running the following command:

```bash
$ kubectl get csur example-run 

NAME          PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
example-run   example-placement   0                         0                       True          False                     24m

```

The `PROGRESSING` field is `False` indicating the run stopped. Further investigation is needed to determine the cause.

2. Run these commands to get more details about the error:

```bash
$ kubectl get csur example-run -o yaml
```

```yml
Name:         example-run
...
API Version:  placement.kubernetes-fleet.io/v1beta1
Kind:         ClusterStagedUpdateRun
Metadata:
  Creation Timestamp:  2026-02-11T22:15:19Z
  Finalizers:
    kubernetes-fleet.io/clusterstagedupdaterun-finalizer
  Generation:        2
  ...
Spec:
  Placement Name:                example-placement
  Resource Snapshot Index:       0
  Staged Rollout Strategy Name:  example-strategy
  State:                         Run
Status:
  Applied Strategy:
    Comparison Option:  PartialComparison
    Type:               ClientSideApply
    When To Apply:      Always
    When To Take Over:  Always
  Conditions:
    Last Transition Time:  2026-02-11T22:15:20Z
    Message:               The UpdateRun initialized successfully
    Observed Generation:   2
    Reason:                UpdateRunInitializedSuccessfully
    Status:                True
    Type:                  Initialized
    Last Transition Time:  2026-02-11T22:20:59Z
    Message:               The updateRun is stuck waiting for member2 cluster(s) in stage staging to finish
      updating, please check placement status for potential errors
    Observed Generation:   2
    Reason:                UpdateRunStuck
    Status:                False
    Type:                  Progressing
  Deletion Stage Status:
    Clusters:
    Stage Name:                   kubernetes-fleet.io/deleteStage
  Policy Observed Cluster Count:  3
  Policy Snapshot Index Used:     0
  Resource Snapshot Index Used:   0
  Staged Update Strategy Snapshot:
    Stages:
      After Stage Tasks:
        Type:  Approval
      Label Selector:
        Match Labels:
          Environment:  staging
      Max Concurrency:  1
      Name:             staging
  Stages Status:
    After Stage Task Status:
      Approval Request Name:  example-run-after-staging
      Type:                   Approval
    Clusters:
      Cluster Name:  member2
      Conditions:
        Last Transition Time:  2026-02-11T22:15:59Z
        Message:               The updateRun is stuck waiting for member2 cluster(s) in stage staging to finish
          updating, please check placement status for potential errors
        Observed Generation:   2
        Reason:                ClusterUpdatingStarted
        Status:                True
        Type:                  Started
      ...
    Conditions:
      Last Transition Time:  2026-02-11T22:15:59Z
      Message:               Clusters in the stage started updating
      Observed Generation:   2
      Reason:                StageUpdatingStarted
      Status:                True
      Type:                  Progressing
    ...
    Stage Name:              staging
```

The message shows that the `ClusterStagedUpdateRun` is stuck waiting for the `member2` cluster in `Stages Status` to finish updating. 

The controller deploys resources to a member cluster by updating its corresponding binding. It then checks periodically whether the update completes. If the binding still isn't available after the current default of five (5) minutes, the controller determines the rollout is stuck and reports the condition.

A stuck `ClusterStagedUpdateRun` usually indicates an issue with the cluster or resources. 

3. Check the `ClusterResourcePlacement` status:

```bash
$ kubectl describe crp example-placement
```

```yml
Name:         example-placement
...
API Version:  placement.kubernetes-fleet.io/v1beta1
Kind:         ClusterResourcePlacement
Metadata:
    Creation Timestamp:  2026-02-11T21:02:36Z
    Finalizers:
    kubernetes-fleet.io/crp-cleanup
    kubernetes-fleet.io/scheduler-cleanup
    Generation:        1
    ...
Spec:
    Policy:
    Placement Type:  PickAll
    Resource Selectors:
    Group:                 ""
    Kind:                  Namespace
    Name:                  test-namespace
    Selection Scope:       NamespaceWithResources
    Version:               v1
    Revision History Limit:  10
    Status Reporting Scope:  ClusterScopeOnly
    Strategy:
    Type:  External
Status:
    Conditions:
    Last Transition Time:  2026-02-11T21:02:37Z
    Message:               found all cluster needed as specified by the scheduling policy, found 3 cluster(s)
    Observed Generation:   1
    Reason:                SchedulingPolicyFulfilled
    Status:                True
    Type:                  ResourcePlacementScheduled
    Last Transition Time:  2026-02-11T21:02:37Z
    Message:               Rollout is controlled by an external controller and no resource snapshot name is observed across clusters, probably rollout has not started yet
    Observed Generation:   1
    Reason:                RolloutControlledByExternalController
    Status:                Unknown
    Type:                  ResourcePlacementRolloutStarted
    Placement Statuses:
    Cluster Name:            member2
    Conditions:
        Last Transition Time:  2026-01-12T22:37:57Z
        Message:               Successfully scheduled resources for placement in "member2" (affinity score: 0, topology spread score: 0): picked by scheduling policy
        Observed Generation:   1
        Reason:                Scheduled
        Status:                True
        Type:                  Scheduled
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               Detected the new changes on the resources and started the rollout process, resourceSnapshotIndex: 1, updateRun: example-run
        Observed Generation:   1
        Reason:                RolloutStarted
        Status:                True
        Type:                  RolloutStarted
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               No override rules are configured for the selected resources
        Observed Generation:   1
        Reason:                NoOverrideSpecified
        Status:                True
        Type:                  Overridden
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               All of the works are synchronized to the latest
        Observed Generation:   1
        Reason:                AllWorkSynced
        Status:                True
        Type:                  WorkSynchronized
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               All corresponding work objects are applied
        Observed Generation:   1
        Reason:                AllWorkHaveBeenApplied
        Status:                True
        Type:                  Applied
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               Work object example-placement-work is not yet available
        Observed Generation:   1
        Reason:                NotAllWorkAreAvailable
        Status:                False
        Type:                  Available
    Failed Placements:
        Condition:
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               Manifest is not yet available; Fleet will check again later
        Observed Generation:   1
        Reason:                ManifestNotAvailableYet
        Status:                False
        Type:                  Available
        Group:                   apps
        Kind:                    Deployment
        Name:                    nginx-deployment
        Namespace:               test-namespace
        Version:                 v1
...
```

The `Available` condition is `False` and the `Reason` value is `NotAllWorkAreAvailable`. In `Failed Placements`, it shows `nginx-deployment` isn't available.

4. Check the `member2` cluster to see the image pull failure:

```bash
kubectl config use-context member2

kubectl get deployment -n test-namespace
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   0/3     3            0           9m54s

kubectl get pods -n test-namespace
NAME                                READY   STATUS             RESTARTS   AGE
nginx-deployment-5d9874b8b9-gnmm2   0/1     InvalidImageName   0          10m
nginx-deployment-5d9874b8b9-p9zsx   0/1     InvalidImageName   0          10m
nginx-deployment-5d9874b8b9-wxmd7   0/1     InvalidImageName   0          10m
```

> [!NOTE]
> A similar scenario can occur when the `updateRun`'s state is set to `Stop`.

### Solution

See [Troubleshooting ResourcePlacement API in Azure Kubernetes Fleet Manager (preview)](./../cluster-resource-placement/troubleshoot-clusterresourceplacement-api-issues.md) for guidance on debugging the issue.

After resolving the issue, create a new `ClusterStagedUpdateRun` to restart the rollout. You can then delete the stuck `ClusterStagedUpdateRun` value.

:::zone-end

:::zone target="docs" pivot="namespace-scope"

1. Locate the `StagedUpdateRun` stuck error by running the following command:

```bash
$ kubectl get stagedupdaterun web-app-rollout -n my-app-namespace

NAME              PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
web-app-rollout   web-app-placement   1                         0                       True          False                     24m

```

The `PROGRESSING` field is `False` indicating the run stopped. Further investigation is needed to determine the cause.

2. Run these commands to get more details about the error:

```bash
$ kubectl describe stagedupdaterun <staged-update-run-name> -n <namespace-name>
```

```yml
Name:         web-app-rollout
Namespace:    my-app-namespace
...
API Version:  placement.kubernetes-fleet.io/v1beta1
Kind:         StagedUpdateRun
Metadata:
  Creation Timestamp:  2026-02-11T22:15:19Z
  Finalizers:
    kubernetes-fleet.io/stagedupdaterun-finalizer
  Generation:        2
  ...
Spec:
  Placement Name:                web-app-rollout-placement
  Resource Snapshot Index:       0
  Staged Rollout Strategy Name:  example-strategy
  State:                         Run
Status:
  Applied Strategy:
    Comparison Option:  PartialComparison
    Type:               ClientSideApply
    When To Apply:      Always
    When To Take Over:  Always
  Conditions:
    Last Transition Time:  2026-02-11T22:15:20Z
    Message:               The UpdateRun initialized successfully
    Observed Generation:   2
    Reason:                UpdateRunInitializedSuccessfully
    Status:                True
    Type:                  Initialized
    Last Transition Time:  2026-02-11T22:20:59Z
    Message:               The updateRun is stuck waiting for member2 cluster(s) in stage staging to finish
      updating, please check placement status for potential errors
    Observed Generation:   2
    Reason:                UpdateRunStuck
    Status:                False
    Type:                  Progressing
  Deletion Stage Status:
    Clusters:
    Stage Name:                   kubernetes-fleet.io/deleteStage
  Policy Observed Cluster Count:  3
  Policy Snapshot Index Used:     0
  Resource Snapshot Index Used:   0
  Staged Update Strategy Snapshot:
    Stages:
      After Stage Tasks:
        Type:  Approval
      Label Selector:
        Match Labels:
          Environment:  staging
      Max Concurrency:  1
      Name:             staging
  Stages Status:
    After Stage Task Status:
      Approval Request Name:  web-app-rollout-after-staging
      Type:                   Approval
    Clusters:
      Cluster Name:  member2
      Conditions:
        Last Transition Time:  2026-02-11T22:15:59Z
        Message:               The updateRun is stuck waiting for member2 cluster(s) in stage staging to finish
          updating, please check placement status for potential errors
        Observed Generation:   2
        Reason:                ClusterUpdatingStarted
        Status:                True
        Type:                  Started
      ...
    Conditions:
      Last Transition Time:  2026-02-11T22:15:59Z
      Message:               Clusters in the stage started updating
      Observed Generation:   2
      Reason:                StageUpdatingStarted
      Status:                True
      Type:                  Progressing
    ...
    Stage Name:              staging
```

The message shows that the `StagedUpdateRun` is stuck waiting for the `member2` cluster in `Stages Status` to finish updating. 

The controller deploys resources to a member cluster by updating its corresponding binding. It then checks periodically whether the update completes. If the binding still isn't available after the current default of five (5) minutes, the controller determines the rollout is stuck and reports the condition.

A stuck `StagedUpdateRun` usually indicates an issue with the cluster or resources. 

3. Check the `ClusterResourcePlacement` status:

```bash
$ kubectl describe rp web-app-placement -n my-app-namespace
```

```yml
Name:         web-app-placement
Namespace:    my-app-namespace
...
API Version:  placement.kubernetes-fleet.io/v1beta1
Kind:         ReourcePlacement
Metadata:
    Creation Timestamp:  2026-02-11T21:02:36Z
    Finalizers:
    kubernetes-fleet.io/crp-cleanup
    kubernetes-fleet.io/scheduler-cleanup
    Generation:        1
    ...
Spec:
    Policy:
    Placement Type:  PickAll
    Resource Selectors:
    Group:                 apps
    Kind:                  Deployment
    Name:                  nginx-deployment
    Selection Scope:       NamespaceWithResources
    Version:               v1
    Revision History Limit:  10
    Status Reporting Scope:  ClusterScopeOnly
    Strategy:
    Type:  External
Status:
    Conditions:
    Last Transition Time:  2026-02-11T21:02:37Z
    Message:               found all cluster needed as specified by the scheduling policy, found 3 cluster(s)
    Observed Generation:   1
    Reason:                SchedulingPolicyFulfilled
    Status:                True
    Type:                  ResourcePlacementScheduled
    Last Transition Time:  2026-02-11T21:02:37Z
    Message:               Rollout is controlled by an external controller and no resource snapshot name is observed across clusters, probably rollout has not started yet
    Observed Generation:   1
    Reason:                RolloutControlledByExternalController
    Status:                Unknown
    Type:                  ResourcePlacementRolloutStarted
    Placement Statuses:
    Cluster Name:            member2
    Conditions:
        Last Transition Time:  2026-01-12T22:37:57Z
        Message:               Successfully scheduled resources for placement in "member2" (affinity score: 0, topology spread score: 0): picked by scheduling policy
        Observed Generation:   1
        Reason:                Scheduled
        Status:                True
        Type:                  Scheduled
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               Detected the new changes on the resources and started the rollout process, resourceSnapshotIndex: 1, updateRun: example-run
        Observed Generation:   1
        Reason:                RolloutStarted
        Status:                True
        Type:                  RolloutStarted
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               No override rules are configured for the selected resources
        Observed Generation:   1
        Reason:                NoOverrideSpecified
        Status:                True
        Type:                  Overridden
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               All of the works are synchronized to the latest
        Observed Generation:   1
        Reason:                AllWorkSynced
        Status:                True
        Type:                  WorkSynchronized
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               All corresponding work objects are applied
        Observed Generation:   1
        Reason:                AllWorkHaveBeenApplied
        Status:                True
        Type:                  Applied
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               Work object example-placement-work is not yet available
        Observed Generation:   1
        Reason:                NotAllWorkAreAvailable
        Status:                False
        Type:                  Available
    Failed Placements:
        Condition:
        Last Transition Time:  2026-01-12T22:44:08Z
        Message:               Manifest is not yet available; Fleet will check again later
        Observed Generation:   1
        Reason:                ManifestNotAvailableYet
        Status:                False
        Type:                  Available
        Group:                   apps
        Kind:                    Deployment
        Name:                    nginx-deployment
        Namespace:               my-app-namespace
        Version:                 v1
...
```

The `Available` condition is `False` and the `Reason` value is `NotAllWorkAreAvailable`. In `Failed Placements`, it shows `nginx-deployment` isn't available.

4. Check the `member2` cluster to see the image pull failure:


```bash
kubectl config use-context member2

kubectl get deployment -n test-namespace
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   0/3     3            0           9m54s

kubectl get pods -n test-namespace
NAME                                READY   STATUS             RESTARTS   AGE
nginx-deployment-5d9874b8b9-gnmm2   0/1     InvalidImageName   0          10m
nginx-deployment-5d9874b8b9-p9zsx   0/1     InvalidImageName   0          10m
nginx-deployment-5d9874b8b9-wxmd7   0/1     InvalidImageName   0          10m
```

> [!NOTE]
> A similar scenario can occur when the `updateRun`'s state is set to `Stop`.

### Solution

See [Troubleshooting ResourcePlacement API in Azure Kubernetes Fleet Manager (preview)](./../cluster-resource-placement/troubleshoot-clusterresourceplacement-api-issues.md) for guidance on debugging the issue.

After resolving the issue, create a new `StagedUpdateRun` to restart the rollout. You can then delete the stuck `StagedUpdateRun` value.

:::zone-end
