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

## Complete progression of the ClusterResourcePlacement deployment

Understanding the progression and status of the `ClusterStagedUpdateRun` custom resource is crucial for diagnosing and identifying failures. You can view the status of the `ClusterStagedUpdateRun` custom resource by using the following command:

```bash
kubectl describe clusterstagedupdaterun <name>
```

The complete progression of `ClusterStagedUpdateRun` is as follows:

1. **Initialization**: Validates placement, captures latest strategy snapshot, collects target bindings, generates cluster update sequence, captures specified resource snapshot or latest resource snapshot if unspecified & records override snapshots. Occurs once on creation.
2. **Execution**: Processes stages sequentially, updates clusters within each stage (respecting maxConcurrency), enforces before-stage and after-stage tasks. Only occurs when state is "Run."
3. **Stopping/Stopped**: When state is Stop, the updateRun pauses execution at the current cluster/stage and can be resumed by changing state back to "Run." If there are updating/deleting clusters, we wait after marking updateRun as "Stopping" for the in-progress clusters to reach a deterministic state: succeeded, failed, or stuck before marking updateRun as "Stopped."

### Things to keep in mind when using updateRun

When updateRun is created with Initialized/Stop state, the updateRun doesn't start execution. In both cases, updateRun is `Initialized`.

Set state to "Initialize":

```yaml
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

Set state to "Stop":

```yaml
spec:
  placementName: example-placement
  resourceSnapshotIndex: "0"
  stagedRolloutStrategyName: example-strategy
  state: Stop
status:
  appliedStrategy:
    comparisonOption: PartialComparison
    type: ClientSideApply
    whenToApply: Always
    whenToTakeOver: Always
  conditions:
  - lastTransitionTime: "2026-01-09T01:22:55Z"
    message: The UpdateRun initialized successfully
    observedGeneration: 1
    reason: UpdateRunInitializedSuccessfully
    status: "True"
    type: Initialized
  - lastTransitionTime: "2026-01-09T01:22:55Z"
    message: The update run has been stopped
    observedGeneration: 1
    reason: UpdateRunStopped
    status: "False"
    type: Progressing
```

## Cluster-Scoped Troubleshooting

### ClusterResourcePlacement Status Without Staged Update Run

When a `ClusterResourcePlacement` is created with `spec.strategy.type` set to `External`, the rollout doesn't start immediately.

A sample status of such `ClusterResourcePlacement` is as follows:

```bash
$ kubectl describe clusterrresourceplacement <cluster-resource-placement-name>

...
Status:
  Conditions:
    Last Transition Time:  2026-01-08T00:19:58Z
    Message:               found all cluster needed as specified by the scheduling policy, found 2 cluster(s)
    Observed Generation:   1
    Reason:                SchedulingPolicyFulfilled
    Status:                True
    Type:                  ClusterResourcePlacementScheduled
    Last Transition Time:  2026-01-08T00:19:58Z
    Message:               Rollout is controlled by an external controller and no resource snapshot name is observed across clusters, probably rollout has not started yet
    Observed Generation:   1
    Reason:                RolloutControlledByExternalController
    Status:                Unknown
    Type:                  ClusterResourcePlacementRolloutStarted
  Placement Statuses:
    Cluster Name:  member1
    Conditions:
      Last Transition Time:  2026-01-08T00:19:58Z
      Message:               Successfully scheduled resources for placement in "member1" (affinity score: 0, topology spread score: 0): picked by scheduling policy
      Observed Generation:   1
      Reason:                Scheduled
      Status:                True
      Type:                  Scheduled
      Last Transition Time:  2026-01-08T00:19:58Z
      Message:               In the process of deciding whether to roll out some version of the resources or not
      Observed Generation:   1
      Reason:                RolloutStartedUnknown
      Status:                Unknown
      Type:                  RolloutStarted
    Cluster Name:            member2
    Conditions:
      Last Transition Time:  2026-01-08T00:19:58Z
      Message:               Successfully scheduled resources for placement in "member2" (affinity score: 0, topology spread score: 0): picked by scheduling policy
      Observed Generation:   1
      Reason:                Scheduled
      Status:                True
      Type:                  Scheduled
      Last Transition Time:  2026-01-08T00:19:58Z
      Message:               In the process of deciding whether to roll out some version of the resources or not
      Observed Generation:   1
      Reason:                RolloutStartedUnknown
      Status:                Unknown
      Type:                  RolloutStarted
Events:         <none>
```

`ClusterResourcePlacementScheduled` condition indicates the `ClusterResourcePlacement` is fully scheduled, while `ClusterResourcePlacementRolloutStarted` condition shows that the rollout didn't start due to rollout being controller by external controller.

In the Placement Statuses section, it displays the detailed status of each cluster. Both selected clusters are in the `Scheduled` state, but the `RolloutStarted` condition is still `Unknown` because the rollout didn't kick off yet.

To start kick-off, create a `ClusterStagedUpdateStrategy` and `ClusterStagedUpdateRun` with the state "Run."

### Investigate ClusterStagedUpdateRun Initialization Failure

An updateRun initialization failure can be easily detected by getting the resource:

```bash
$ kubectl get csur example-run 

NAME          PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
example-run   example-placement   1                         0                       False                                   4s
```

The `INITIALIZED` field is `False`, indicating the initialization failed.

Describe the updateRun to get more details:

```bash
$ kubectl describe clusterstagedupdaterun example-run
...
  Applied Strategy:
    Comparison Option:  PartialComparison
    Type:               ClientSideApply
    When To Apply:      Always
    When To Take Over:  Always
  Conditions:
    Last Transition Time:  2026-01-08T00:35:09Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: no resourceSnapshots with index `1` found for placement `/example-placement`
    Observed Generation:   1
    Reason:                UpdateRunInitializedFailed
    Status:                False
    Type:                  Initialized
  Deletion Stage Status:
    Clusters:
    Stage Name:                   kubernetes-fleet.io/deleteStage
  Policy Observed Cluster Count:  2
  Policy Snapshot Index Used:     0
...
```

The condition clearly indicates the initialization failed. The condition message gives more details about the failure. In this case, a nonexisting resource snapshot index 1 was used for the updateRun.

### Investigate ClusterStagedUpdateRun Execution Failure

An updateRun execution failure can be easily detected by getting the resource:

```bash
$ kubectl get clusterstagedupdaterun example-run
NAME          PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   SUCCEEDED   AGE
example-run   example-placement   0                         0                       True          False       24m
```

The `SUCCEEDED` field is `False`, indicating the execution failure.

Two main scenarios cause updateRun execution failures:

1. When the updateRun controller is triggered to reconcile an in-progress updateRun, it starts by doing a bunch of validations including retrieving the `ClusterResourcePlacement` and checking its rollout strategy, gathering all the bindings and regenerating the execution plan. If any failure happens during validation, the updateRun execution fails with the corresponding validation error.

    ```yaml
    status:
      appliedStrategy:
        comparisonOption: PartialComparison
        type: ClientSideApply
        whenToApply: Always
        whenToTakeOver: Always
      conditions:
      - lastTransitionTime: "2026-01-08T00:40:53Z"
        message: The UpdateRun initialized successfully
        observedGeneration: 2
        reason: UpdateRunInitializedSuccessfully
        status: "True"
        type: Initialized
      - lastTransitionTime: "2026-01-08T00:41:34Z"
        message: The stages are aborted due to a non-recoverable error
        observedGeneration: 2
        reason: UpdateRunFailed
        status: "False"
        type: Progressing
      - lastTransitionTime: "2026-01-08T00:41:34Z"
        message: "cannot continue the updateRun: failed to validate the updateRun: failed
          to process the request due to a client error: parent placement not found"
        observedGeneration: 2
        reason: UpdateRunFailed
        status: "False"
        type: Succeeded
    ```

    In this scenario, the `ClusterResourcePlacement` referenced by the updateRun is deleted during the execution. The updateRun controller detects and aborts the release.  

2. The updateRun controller triggers update to a member cluster by updating the corresponding binding spec and setting its status to `RolloutStarted`. It then waits for default 15 seconds and checks whether the resources are successfully applied by checking the binding again. If multiple updateRuns run concurrently, another updateRun might update the binding with a new configuration during this 15-second wait. When this preemption happens, the current updateRun detects the change and fails with a clear error message.

    ```yaml
    status:
      appliedStrategy:
        comparisonOption: PartialComparison
        type: ClientSideApply
        whenToApply: Always
        whenToTakeOver: Always
      conditions:
      - lastTransitionTime: "2026-01-08T00:57:38Z"
        message: The UpdateRun initialized successfully
        observedGeneration: 1
        reason: UpdateRunInitializedSuccessfully
        status: "True"
        type: Initialized
      - lastTransitionTime: "2026-01-08T00:57:53Z"
        message: The stages are aborted due to a non-recoverable error
        observedGeneration: 1
        reason: UpdateRunFailed
        status: "False"
        type: Progressing
      - lastTransitionTime: "2026-01-08T00:57:53Z"
        message: 'cannot continue the updateRun: failed to process the request due to
          a client error: the binding of the updating cluster `member2` in the
          stage `staging` is not up-to-date with the desired status, please check the
          status of binding `example-placement-member2-e1a567da` and see if there
          is a concurrent updateRun referencing the same placement and
          updating the same cluster'
        observedGeneration: 1
        reason: UpdateRunFailed
        status: "False"
        type: Succeeded
    ```

    The Succeeded condition is set to False with reason `UpdateRunFailed`. The message shows that the member2 cluster in the staging stage was preempted. The user should check the example-placement-member2-e1a567da binding to verify if another concurrent updateRun is referencing the same `ClusterResourcePlacement` and updating the same cluster.

    ```bash
    $ kubectl get clusterresourcebindings
    NAME                                        WORKSYNCHRONIZED   RESOURCESAPPLIED   AGE
    example-placement-member1-9a1ee3a0                                                20m
    example-placement-member2-e1a567da          True               True               20m
    ```

    Since the error message specifies example-placement-member2-e1a567da, we can check the binding:

    ```bash
    $ kubectl get clusterresourcebinding example-placement-member2-e1a567da -o yaml
    ...
    spec:
      applyStrategy:
        comparisonOption: PartialComparison
        type: ClientSideApply
        whenToApply: Always
        whenToTakeOver: Always
      clusterDecision:
        clusterName: member2
        clusterScore:
          affinityScore: 0
          priorityScore: 0
        reason: 'Successfully scheduled resources for placement in "member2" (affinity
          score: 0, topology spread score: 0): picked by scheduling policy'
        selected: true
      resourceSnapshotName: example-placement-1-snapshot
      schedulingPolicySnapshotName: example-placement-0
      state: Bound
      targetCluster: member2
    status:
      conditions:
      - lastTransitionTime: "2026-01-08T00:57:39Z"
        message: 'Detected the new changes on the resources and started the rollout process,
          resourceSnapshotIndex: 1, updateRun: example-run-1'
        observedGeneration: 3
        reason: RolloutStarted
        status: "True"
        type: RolloutStarted
    ...
    ```

    As the binding RolloutStarted condition shows, another updateRun example-run-1 updated it.
    The updateRun abortion due to execution failures isn't recoverable at the moment. If failure happens due to validation error, one can fix the issue and create a new updateRun. If preemption happens, in most cases the user is releasing a new resource version, and they can just let the new updateRun run to complete.

### Investigate ClusterStagedUpdateRun Rollout Stuck

A `ClusterStagedUpdateRun` can get stuck when resource placement fails on some clusters. Getting the updateRun shows the cluster name and stage that is in stuck state:

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
  - lastTransitionTime: "2026-01-12T22:42:52Z"
    message: The UpdateRun initialized successfully
    observedGeneration: 2
    reason: UpdateRunInitializedSuccessfully
    status: "True"
    type: Initialized
  - lastTransitionTime: "2026-01-12T22:49:51Z"
    message: The updateRun is stuck waiting for member2 cluster(s) in stage staging to finish
      updating, please check placement status for potential errors
    observedGeneration: 2
    reason: UpdateRunStuck
    status: "False"
    type: Progressing
  ...
  stagesStatus:
  - clusters:
    - clusterName: member2
      conditions:
      - lastTransitionTime: "2026-01-12T22:44:08Z"
        message: Cluster update started
        observedGeneration: 2
        reason: ClusterUpdatingStarted
        status: "True"
        type: Started
    conditions:
    - lastTransitionTime: "2026-01-12T22:44:08Z"
      message: Clusters in the stage started updating
      observedGeneration: 2
      reason: StageUpdatingStarted
      status: "True"
      type: Progressing
    stageName: staging # stage name mentioned in message.
    startTime: "2026-01-12T22:44:08Z"
  - clusters:
    - clusterName: member1
    stageName: canary
...
```

The message shows that the updateRun is stuck waiting for member2 cluster in stage staging to finish releasing. From the stagesStatus, we see member2 is the cluster in stage staging. The updateRun controller rolls resources to a member cluster by updating its corresponding binding. It then checks periodically whether the update completed or not. If the binding is still not available after current default 5 minutes, updateRun controller decides the rollout is stuck and reports the condition.

This scenario usually indicates something wrong happened on the cluster or the resources have some issue. To further investigate, you can check the `ClusterResourcePlacement` status:

```bash
$ kubectl describe clusteresourcerplacement example-placement
...
 Placement Statuses:
    ...
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

The `Available` condition is False and we show reason as `NotAllWorkAreAvailable`. And in the "failed placements" section, it shows the nginx-deployment deployment isn't available. Check from member2 cluster and we can see there’s image pull failure:

```bash
$ kubectl config use-context member2

$ kubectl get deployment -n test-namespace
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   0/3     3            0           9m54s

$ kubectl get pods -n test-namespace
NAME                                READY   STATUS             RESTARTS   AGE
nginx-deployment-5d9874b8b9-gnmm2   0/1     InvalidImageName   0          10m
nginx-deployment-5d9874b8b9-p9zsx   0/1     InvalidImageName   0          10m
nginx-deployment-5d9874b8b9-wxmd7   0/1     InvalidImageName   0          10m
```

> Note: A similar scenario can occur when updateRun’s state is set to Stop since we allow ongoing resource placement on a cluster to continue even when State is Stop.

For more debugging instructions, you can refer to [ClusterResourcePlacement Troubleshooting Guide](../cluster-resource-placement/troubleshoot-clusterresourceplacement-api-issues.md).

After resolving the issue, create a new updateRun to restart the rollout. Stuck updateRuns can be deleted.

### ClusterApprovalRequest Troubleshooting

A `ClusterStagedUpdateRun` isn't progressing after approval from user as expected.

Getting the `ClusterStagedUpdateRun` should give us some insight,

```bash
$ kubectl get clusterstagedupdaterun example-run

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
```

Looks like updateRun is still waiting for approval from user. Lets get the corresponding `ClusterApprovalRequest` to verify:

```bash
$ kubectl get clusterapprovalrequest example-run-after-staging

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

We can notice that user approved the request but we don’t see the `ApprovalAccepted` Condition set on the object. Taking a closer look we can clearly see that the observedGeneration for the `Approved` condition doesn’t match the object’s generation (that is, is 0 instead of 1). To remedy, update the condition with the correct observedGeneration. This scenario applies to both before and after stage tasks.

Refer to [Approve the Staged Update Run](/azure/kubernetes-fleet/howto-staged-update-run?branch=main&pivots=cluster-scope#approve-the-staged-update-run) to update `ClusterApprovalRequest`.
