---
title: Troubleshoot ClusterStagedUpdateRun and StagedUpdateRun errors
description: Troubleshoot errors that occur when ClusterStagedUpdateRun and StagedUpdateRun don't run successfully.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
zone_pivot_groups: cluster-namespace-scope
---

# Troubleshoot `ClusterStagedUpdateRun` and `StagedUpdateRun` error messages

## Summary

This article discusses how to troubleshoot the `ClusterStagedUpdateRun` and `StagedUpdateRun` errors that occur when you propagate resources that have update run APIs in Microsoft Azure Kubernetes Fleet Manager. 

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

1. Locate the `ClusterStagedUpdateRun` error message by running the following command:

```bash
$ kubectl get clusterstagedupdaterun example-run 

NAME          PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
example-run   example-placement   0                         0                       True          False         False       24m

```

The `PROGRESSING` and `SUCCEEDED` field values are `False`. This value indicates that the run failed.

2. To get more details about the error, run the following commands:

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

If the `Progressing` condition is `False`, the reason value is `UpdateRunFailed`, and the message is "The stages are aborted due to a nonrecoverable error," these values indicate that the run failed.

## Common run failures

### Validation errors during reconciliation

#### Cause 

During each reconciliation, validation occurs before running. These validation errors are similar to the common validation errors that occur during initialization.

#### Solution

"Aborted" `updateRun` messages are generated by run failures. The runs aren't recoverable. If a failure occurs because of a validation error, fix the issue, and create a new `updateRun` instance.

**Placement not found**

#### Cause 

The `ClusterStagedUpdateRun` run passed initialization. Therefore, the instance of `ClusterResourcePlacement` that it references must have existed previously. A user deleted `ClusterResourcePlacement` while `ClusterStagedUpdateRun` was running.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: parent placement not found
```

#### Solution

Create a new `ClusterResourcePlacement` instance in the same namespace. Then, create a new `ClusterStagedUpdateRun` instance that references that placement.

**Strategy not found**

#### Cause 

`ClusterStagedUpdateRun` passed initialization. Therefore, the `ClusterStagedUpdateStrategy` instance that it references must have existed previously. A user deleted `ClusterStagedUpdateStrategy` while `ClusterStagedUpdateRun` was running.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
```

#### Solution

Create a new `ClusterStagedUpdateStrategy` instance in the same namespace. Then, create a new `ClusterStagedUpdateRun` instance that references that strategy.

**Invalid stage tasks**

#### Cause 

`ClusterStagedUpdateRun` passed initialization. Therefore, the `ClusterStagedUpdateStrategy` instance that it references previously defined the stage tasks correctly. A user updated `ClusterStagedUpdateStrategy`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...
```

#### Solution

See [Staged update strategy (preview)](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview) for guidance to correctly update `ClusterStagedUpdateStrategy`. Then create, a new `ClusterStagedUpdateRun` instance.

**Cluster appears more than one time**

#### Cause 

`ClusterStagedUpdateRun` passed initialization, and the cluster labels were initially valid. The cluster was updated during the `ClusterStagedUpdateRun` run. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
```

#### Solution

Review the cluster labels to make sure that the cluster doesn't have labels for both stages. Verify that the stages in `ClusterStagedUpdateStrategy` select distinct cluster labels. Then, create a new `ClusterStagedUpdateRun` instance that referencies that strategy because this stage is aborted.

### Concurrent update run preemptions

When multiple `updateRun`s target the same `ClusterResourcePlacement`, they conflict with one another.

#### Cause 

The `updateRun` controller triggers an update to the member cluster by updating the corresponding binding specification and setting its status to `RolloutStarted`. Then, the controller waits 15 seconds and checks the binding again to verify that the resource was applied successfully. During the 15-second wait, the current `ClusterStagedUpdateRun` instance detects this change and fails if the following conditions are true:

- Multiple concurrent `ClusterStagedUpdateRun`s exist.
- Another `ClusterStagedUpdateRun` instance preempts and updates the binding by using a new configuration.

Example message:

```text
cannot continue the updateRun: failed to process the request due to a client error: the binding of the updating cluster `member2` in the stage `dev` is not up-to-date with the desired status, please check the status of binding `example-placement-member2-e1a567da` and see if there is a concurrent updateRun referencing the same placement and updating the same cluster
```

In the message, the `member2` cluster gets preempted in the `dev` stage. The user is then prompted to check the `example-placement-member2-e1a567da` binding to verify that a concurrent `ClusterStagedUpdateRun` instance exists, references the same `ClusterResourcePlacement` instance, and updates the same cluster.

#### Solution

1. Investigate the concurrent `ClusterStagedUpdateRun` namespace-scoped resource bindings by running the following command:

```bash
$ kubectl get clusterresourcebindings
NAME                                        WORKSYNCHRONIZED   RESOURCESAPPLIED   AGE
example-placement-member1-9a1ee3a0                                                20m
example-placement-member2-e1a567da          True               True               20m
```

Because the error message specifies `example-placement-member2-e1a567da`, check the binding by running the following commands:

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

2. If the `RolloutStarted` condition appears, verify that the `ClusterStagedUpdateRun` instance that's referenced is the `ClusterStagedUpdateRun` instance that you're working with. If another `ClusterStagedUpdateRun` is referenced, wait for that `ClusterStagedUpdateRun` to finish.

3. Verify that `ClusterStagedUpdateRun` is what you want to roll out. If not, stop this `ClusterStagedUpdateRun` instance and create another.

:::zone-end

:::zone target="docs" pivot="namespace-scope"

1. Locate the `StagedUpdateRun` initialization failure by getting the resource:

```bash
$ kubectl get stagedupdaterun web-app-rollout -n my-app-namespace
NAME              PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
web-app-rollout   web-app-placement   1                         0                       True          False         False       24m

```

The `PROGRESSING` and `SUCCEEDED` fields are `False` indicating the run failed.

2. To get more details about the error, run the following commands:

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

If the `Progressing` condition is `False`, the reason value is `UpdateRunFailed`, and the message is, "The stages are aborted due to a nonrecoverable error," the run failed.

## Common run failures

### Validation errors during reconciliation

#### Cause 

During each reconciliation, validation occurs before running. These validation errors are similar to the common validation errors that occur during initialization.

#### Solution

"Aborted" `updateRun` messages are generated because of run failures. The runs aren't recoverable. If a failure occurs because of a validation error, fix the issue, and create a new `updateRun` instance.

**Parent placement not found**

#### Cause

`StagedUpdateRun` passed initialization. Therefore, the `ResourcePlacement` instance that it references must have existed previously. A user deleted `ResourcePlacement` while the `StagedUpdateRun` instance was running.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: failedto process the request due to a client error: parent placement not found
```

#### Solution

Create a new `ResourcePlacement instance in the same namespace. Then, create a new `StagedUpdateRun` instance that references that placement because this stage is aborted.

**Strategy not found**

#### Cause 

`StagedUpdateRun` passed initialization. Therefore, the `StagedUpdateStrategy` instance that it references must have existed previously. A user deleted the `StagedUpdateStrategy` instance while `StagedUpdateRun` was running.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
```

#### Solution

Create a new `StagedUpdateStrategy` instance in the same namespace. Then, create a new `StagedUpdateRun` instance that references that strategy.

**Invalid stage tasks**

#### Cause

The `StagedUpdateRun` passed initialization. Therefore, the `StagedUpdateStrategy` instance that it references previously defined the stage tasks correctly. A user updated the `StagedUpdateStrategy`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...
```

#### Soution

See [Staged update strategy (preview)](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview) for guidance to correctly update the  `StagedUpdateStrategy` instance. Then, create a new `StagedUpdateRun` instance.

**Cluster appears more than one time**

#### Cause 

The `StagedUpdateRun` passed initialization, and the cluster labels were initially valid. The cluster was updated during `StagedUpdateRun` run. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
```

#### Solution

Review the cluster labels to make sure that the cluster doesn't have labels for both stages. Verify that the stages in `StagedUpdateStrategy` select distinct cluster labels, and then create a new `StagedUpdateRun` instance that references that strategy.

### Concurrent Update Run Preemption

If multiple `updateRun`s target the same `ClusterResourcePlacement`, they conflict with one another.

#### Cause 

The `updateRun` controller triggers an update to the member cluster by updating the corresponding binding `spec` and setting its status to `RolloutStarted`. The controller then waits 15 seconds and checks the binding again to determine whether the resource applied successfully. During the 15-second wait, if multiple concurrent `StagedUpdateRun` instances exist, another `StagedUpdateRun` instance preempts and updates the binding by using a new configuration, and the current `StagedUpdateRun` instance detects this change and fails.

Example message:

```text
cannot continue the updateRun: failed to process the request due to a client error: the binding of the updating cluster `member2` in the stage `dev` is not up-to-date with the desired status, please check the status of binding `my-app-namespace/web-app-placement-member2-43991b15` and see if there is a concurrent updateRun referencing the same placement and updating the same cluster
```

In the message, the `member2` cluster gets preempted in the `dev` stage. The user is then prompted to check the `my-app-namespace/web-app-placement-member2-43991b15` binding to verify that a concurrent `StagedUpdateRun` instance references the same `ResourcePlacement` instance and updates the same cluster.

#### Solution

1. Investigate the concurrent `StagedUpdateRun` namespace-scoped resource bindings by running the following command:

```bash
$ kubectl get resourcebindings -n my-app-namespace
NAME                                 WORKSYNCHRONIZED   RESOURCESAPPLIED   AGE
web-app-placement-member1-2afc7d7f                                         51m
web-app-placement-member2-43991b15   True               True               51m
```

Because the error message specifies `web-app-placement-member2-43991b15`, check the binding by running the following commands:

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

2. If the `RolloutStarted` condition appears, verify that the `StagedUpdateRun` instance that's referenced is the one that you're working with. If another `StagedUpdateRun` instance is referenced, wait for that instance to finish.

3. Verify that the `StagedUpdateRun` instance is what you want to roll out. If not, stop this `StagedUpdateRun` instance and create another.

:::zone-end
