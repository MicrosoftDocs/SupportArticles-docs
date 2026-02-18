---
title: Troubleshoot ClusterStagedUpdateRun and StagedUpdateRun errors
description: Troubleshoot errors that occur when ClusterStagedUpdateRun and StagedUpdateRun fail to run successfully.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
zone_pivot_groups: cluster-namespace-scope
---

# Troubleshoot `ClusterStagedUpdateRun` and `StagedUpdateRun` error messages

## Summary

This article discusses how to troubleshoot `ClusterStagedUpdateRun` and `StagedUpdateRun` error messages when you propagate resources with update-run APIs in Microsoft Azure Kubernetes Fleet Manager. 

The following is an example error message:

```yaml
    Last Transition Time:  2026-02-11T22:15:20Z
    Message:               The UpdateRun initialized successfully
    Observed Generation:   2
    Reason:                UpdateRunInitializedSuccessfully
    Status:                True
    Type:                  Initialized
    Last Transition Time:  2026-02-11T22:15:59Z
    Message:               The stages are aborted due to a non-recoverable error
    Observed Generation:   2
    Reason:                UpdateRunFailed
    Status:                False
    Type:                  Progressing
    Last Transition Time:  2026-02-11T22:16:59Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: parent placement not found
    Observed Generation:   2
    Reason:                UpdateRunFailed
    Status:                False
    Type:                  Succeeded
```

## Investigate errors

:::zone target="docs" pivot="cluster-scope"

1. Locate the `ClusterStagedUpdateRun` error by running the following command:

```bash
$ kubectl get clusterstagedupdaterun example-run 

NAME          PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
example-run   example-placement   0                         0                       True          False         False       24m

```

The `PROGRESSING` and `SUCCEEDED` fields are `False` indicating the run failed.

2. Run these commands to get more details about the error:

```bash
$ kubectl describe clusterstagedupdaterun example-run
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
    Last Transition Time:  2026-02-11T22:15:59Z
    Message:               The stages are aborted due to a non-recoverable error
    Observed Generation:   2
    Reason:                UpdateRunFailed
    Status:                False
    Type:                  Progressing
    Last Transition Time:  2026-02-11T22:16:59Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: parent placement not found
    Observed Generation:   2
    Reason:                UpdateRunFailed
    Status:                False
    Type:                  Succeeded
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
      Before Stage Tasks:
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
    Before Stage Task Status:
      Approval Request Name:  example-run-before-staging
      Conditions:
        Last Transition Time:  2026-02-11T22:15:59Z
        Message:               ApprovalRequest object is created
        Observed Generation:   2
        Reason:                StageTaskApprovalRequestCreated
        Status:                True
        Type:                  ApprovalRequestCreated
      Type:                    Approval
    Clusters:
      Cluster Name:  cluster-1
      Cluster Name:  cluster-2
      Cluster Name:  cluster-3
    Conditions:
      Last Transition Time:  2026-02-11T22:15:59Z
      Message:               Not all before-stage tasks are completed, waiting for approval
      Observed Generation:   2
      Reason:                StageUpdatingWaiting
      Status:                False
      Type:                  Progressing
    Stage Name:              staging
```

When the `Progressing` condition is `False` with an `UpdateRunFailed` reason and the message is "The stages are aborted due to a nonrecoverable error," the run failed. 

## Common run failures

### Validation errors during reconciliation

#### Cause 

During each reconciliation, validation occurs before running. These validation errors are similar to the common validation errors that occur during initialization.

#### Solution

Aborted `updateRun` messages happen due to run failures and aren't recoverable. If a failure occurs due to a validation error, fix the issue and create a new `updateRun`.

**Placement not found**

#### Cause 

The `ClusterStagedUpdateRun` passed initialization so the `ClusterResourcePlacement` it references existed previously. A user deleted the `ClusterResourcePlacement` while the `ClusterStagedUpdateRun` was running.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: failedto process the request due to a client error: parent placement not found
```

#### Solution

Create a new `ClusterResourcePlacement` in the same namespace. Then create a new `ClusterStagedUpdateRun` referencing that placement.

**Strategy not found**


#### Cause 

The `ClusterStagedUpdateRun` passed initialization so the `ClusterStagedUpdateStrategy` it references existed previously. A user deleted the `ClusterStagedUpdateStrategy` while the `ClusterStagedUpdateRun` was running.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
```

#### Solution

Create a new `ClusterStagedUpdateStrategy` in the same namespace. Then create a new `ClusterStagedUpdateRun` referencing that strategy.

**Invalid stage tasks**

#### Cause 

The `ClusterStagedUpdateRun` passed initialization so the `ClusterStagedUpdateStrategy` it references correctly defined the stage tasks previously. A user updated the `ClusterStagedUpdateStrategy`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...
```

#### Solution

See [Staged update strategy (preview)](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview) for guidance on how to correctly update the `ClusterStagedUpdateStrategy`. Then create a new `ClusterStagedUpdateRun`.

**Cluster appears more than once**

#### Cause 

The `ClusterStagedUpdateRun` passed initialization and the cluster labels were initially valid. The cluster was updated during the `ClusterStagedUpdateRun` run. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
```

#### Solution

Review the cluster labels and ensure the cluster doesn't have labels for both stages. Validate that the stages in `ClusterStagedUpdateStrategy` select distinct cluster labels, and then create a new `ClusterStagedUpdateRun` referencing that strategy since this instance is aborted.

### Concurrent update run preemptions

When multiple `updateRun`s target the same `ClusterResourcePlacement`, they come into conflict.

#### Cause 

The `updateRun` controller triggers an update to the member cluster by updating the corresponding binding specification and setting its status to `RolloutStarted`. The controller then waits 15 seconds to verify whether the resource applied successfully by checking the binding again. When multiple concurrent `ClusterStagedUpdateRun`s exist and during the 15-second wait, another `ClusterStagedUpdateRun` preempts and updates the binding with a new configuration. The current `ClusterStagedUpdateRun` detects this change and fails.

Example message:

```text
cannot continue the updateRun: failed to process the request due to a client error: the binding of the updating cluster `member2` in the stage `dev` is not up-to-date with the desired status, please check the status of binding `example-placement-member2-e1a567da` and see if there is a concurrent updateRun referencing the same placement and updating the same cluster
```

In the message, the `member2` cluster gets preempted in the `dev` stage. The user is then prompted to check the `example-placement-member2-e1a567da` binding to verify if there's a concurrent `ClusterStagedUpdateRun` referencing the same `ClusterResourcePlacement` and updating the same cluster.

#### Solution

1. Investigate the concurrent `ClusterStagedUpdateRun` namespace-scoped resource bindings with the following command:

```bash
$ kubectl get clusterresourcebindings
NAME                                        WORKSYNCHRONIZED   RESOURCESAPPLIED   AGE
example-placement-member1-9a1ee3a0                                                20m
example-placement-member2-e1a567da          True               True               20m
```

Since the error message specifies `example-placement-member2-e1a567da`, check the binding with the following commands:

```bash
    $ kubectl get clusterresourcebinding example-placement-member2-e1a567da -o yaml
```

```yml
    Name:         example-placement-member2-e1a567da
    Labels:       kubernetes-fleet.io/parent-CRP=example-placement
    ...
    API Version:  placement.kubernetes-fleet.io/v1beta1
    Kind:         ResourceBinding
    Metadata:
      Creation Timestamp:  2026-02-11T22:23:21Z
      Finalizers:
        kubernetes-fleet.io/scheduler-crb-cleanup
        kubernetes-fleet.io/work-cleanup
      Generation:        2
      ...
    Spec:
      Apply Strategy:
        Comparison Option:  PartialComparison
        Type:               ClientSideApply
        When To Apply:      Always
        When To Take Over:  Always
      Cluster Decision:
        Cluster Name:  member2
        Cluster Score:
          Affinity Score:               0
          Priority Score:               0
        Reason:                         Successfully scheduled resources for placement in "member2" (affinity score: 0, topology spread score: 0): picked by scheduling policy
        Selected:                       true
      Resource Snapshot Name:           example-placement-0-snapshot
      Scheduling Policy Snapshot Name:  example-placement-0
      State:                            Bound
      Target Cluster:                   member2
    Status:
      Conditions:
        Last Transition Time:  2026-02-11T22:23:48Z
        Message:               Detected the new changes on the resources and started the rollout process,
          resourceSnapshotIndex: 1, updateRun: example-run-1
        Observed Generation:   2
        Reason:                RolloutStarted
        Status:                True
        Type:                  RolloutStarted
        ...
```

2. If the `RolloutStarted` condition displays, validate that the `ClusterStagedUpdateRun` referenced is the `ClusterStagedUpdateRun` you're working with. If another `ClusterStagedUpdateRun` is referenced, wait for that `ClusterStagedUpdateRun` to finish.

3. Verify the `ClusterStagedUpdateRun` is what you want to roll out. If not, stop this `ClusterStagedUpdateRun` and create a new one.

:::zone-end

:::zone target="docs" pivot="namespace-scope"

1. Locate the `StagedUpdateRun` initialization failure by getting the resource:

```bash
$ kubectl get stagedupdaterun web-app-rollout -n my-app-namespace
NAME              PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
web-app-rollout   web-app-placement   1                         0                       True          False         False       24m

```

The `PROGRESSING` and `SUCCEEDED` fields are `False` indicating the run failed.

2. Run these commands to get more details about the error:

```bash
$ kubectl describe stagedupdaterun web-app-rollout -n my-app-namespace
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
    Last Transition Time:  2026-02-11T22:15:59Z
    Message:               The stages are aborted due to a non-recoverable error
    Observed Generation:   2
    Reason:                UpdateRunFailed
    Status:                False
    Type:                  Progressing
    Last Transition Time:  2026-02-11T22:16:59Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: parent placement not found
    Observed Generation:   2
    Reason:                UpdateRunFailed
    Status:                False
    Type:                  Succeeded
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
      Before Stage Tasks:
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
    Before Stage Task Status:
      Approval Request Name:  web-app-rollout-before-staging
      Conditions:
        Last Transition Time:  2026-02-11T22:15:59Z
        Message:               ApprovalRequest object is created
        Observed Generation:   2
        Reason:                StageTaskApprovalRequestCreated
        Status:                True
        Type:                  ApprovalRequestCreated
      Type:                    Approval
    Clusters:
      Cluster Name:  cluster-1
      Cluster Name:  cluster-2
      Cluster Name:  cluster-3
    Conditions:
      Last Transition Time:  2026-02-11T22:15:59Z
      Message:               Not all before-stage tasks are completed, waiting for approval
      Observed Generation:   2
      Reason:                StageUpdatingWaiting
      Status:                False
      Type:                  Progressing
    Stage Name:              staging
```

When the `Progressing` condition is `False` with an `UpdateRunFailed` reason and the message is "The stages are aborted due to a nonrecoverable error," the run failed.

## Common run failures

### Validation errors during reconciliation

#### Cause 

During each reconciliation, validation occurs before running. These validation errors are similar to the common validation errors that occur during initialization.

#### Solution

Aborted `updateRun` messages happen due to run failures and aren't recoverable. If a failure occurs due to a validation error, fix the issue and create a new `updateRun`.

**Parent placement not found**

#### Cause

The `StagedUpdateRun` passed initialization so the `ResourcePlacement` it references existed previously. A user deleted the `ResourcePlacement` while the `StagedUpdateRun` was running.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: failedto process the request due to a client error: parent placement not found
```

#### Solution

Create a new `ResourcePlacement` in the same namespace. Then create a new `StagedUpdateRun` referencing that placement since this instance is aborted.

**Strategy not found**

#### Cause 

The `StagedUpdateRun` passed initialization so the `StagedUpdateStrategy` it references existed previously. A user deleted the `StagedUpdateStrategy` while the `StagedUpdateRun` was running.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
```

#### Solution

Create a new `StagedUpdateStrategy` in the same namespace. Then create a new `StagedUpdateRun` referencing that strategy.

**Invalid stage tasks**

#### Cause

The `StagedUpdateRun` passed initialization so the `StagedUpdateStrategy` it references correctly defined the stage tasks previously. A user updated the `StagedUpdateStrategy`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...
```

#### Soution

See [Staged update strategy (preview)](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview) for guidance on how to correctly update the  `StagedUpdateStrategy`. Then create a new `StagedUpdateRun`.

**Cluster appears more than once**

#### Cause 

The `StagedUpdateRun` passed initialization and the cluster labels were initially valid. The cluster was updated during `StagedUpdateRun` run. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
```

#### Solution

Review the cluster labels and ensure the cluster doesn't have labels for both stages. Validate that the stages in `StagedUpdateStrategy` select distinct cluster labels, and then create a new `StagedUpdateRun` referencing that strategy.

### Concurrent Update Run Preemption

When multiple `updateRun`s target the same `ClusterResourcePlacement`, they come into conflict.

#### Cause 

The `updateRun` controller triggers an update to the member cluster by updating the corresponding binding `spec` and setting its status to `RolloutStarted`. The controller then waits 15 seconds to verify whether the resource applied successfully by checking the binding again. When multiple concurrent `StagedUpdateRun`s exist and during the 15-second wait, another `StagedUpdateRun` preempts and updates the binding with new configuration, the current `StagedUpdateRun` detects this change and fails.

Example message:

```text
cannot continue the updateRun: failed to process the request due to a client error: the binding of the updating cluster `member2` in the stage `dev` is not up-to-date with the desired status, please check the status of binding `my-app-namespace/web-app-placement-member2-43991b15` and see if there is a concurrent updateRun referencing the same placement and updating the same cluster
```

In the message, the `member2` cluster gets preempted in the `dev` stage. The user is then prompted to check the `my-app-namespace/web-app-placement-member2-43991b15` binding to verify if there's a concurrent `StagedUpdateRun` referencing the same `ResourcePlacement` and updating the same cluster.

#### Solution

1. Investigate the concurrent `StagedUpdateRun` namespace-scoped resource bindings with the following command:

```bash
$ kubectl get resourcebindings -n my-app-namespace
NAME                                 WORKSYNCHRONIZED   RESOURCESAPPLIED   AGE
web-app-placement-member1-2afc7d7f                                         51m
web-app-placement-member2-43991b15   True               True               51m
```

Since the error message specifies `web-app-placement-member2-43991b15`, check the binding with the following commands:

```bash
    $ kubectl describe resourcebinding web-app-placement-member2-43991b15 -n my-app-namespace
```

```yml
    Name:         web-app-placement-member2-43991b15
    Namespace:    my-app-namespace
    Labels:       kubernetes-fleet.io/parent-CRP=web-app-rollout-placement
    ...
    API Version:  placement.kubernetes-fleet.io/v1beta1
    Kind:         ResourceBinding
    Metadata:
      Creation Timestamp:  2026-02-11T22:23:21Z
      Finalizers:
        kubernetes-fleet.io/scheduler-crb-cleanup
        kubernetes-fleet.io/work-cleanup
      Generation:        2
      ...
    Spec:
      Apply Strategy:
        Comparison Option:  PartialComparison
        Type:               ClientSideApply
        When To Apply:      Always
        When To Take Over:  Always
      Cluster Decision:
        Cluster Name:  member2
        Cluster Score:
          Affinity Score:               0
          Priority Score:               0
        Reason:                         Successfully scheduled resources for placement in "member2" (affinity score: 0, topology spread score: 0): picked by scheduling policy
        Selected:                       true
      Resource Snapshot Name:           web-app-rollout-placement-0-snapshot
      Scheduling Policy Snapshot Name:  web-app-rollout-placement-0
      State:                            Bound
      Target Cluster:                   member2
    Status:
      Conditions:
        Last Transition Time:  2026-02-11T22:23:48Z
        Message:               Detected the new changes on the resources and started the rollout process,
          resourceSnapshotIndex: 1, updateRun: app-rollout-placement
        Observed Generation:   2
        Reason:                RolloutStarted
        Status:                True
        Type:                  RolloutStarted
        ...
```

2. If the `RolloutStarted` condition displays, validate that the`StagedUpdateRun` referenced is the one you're working with. If another `StagedUpdateRun` is referenced, wait for that `StagedUpdateRun` to finish.

3. Verify the `StagedUpdateRun` is what you want to roll out. If not, stop this `StagedUpdateRun` and create a new one.

:::zone-end
