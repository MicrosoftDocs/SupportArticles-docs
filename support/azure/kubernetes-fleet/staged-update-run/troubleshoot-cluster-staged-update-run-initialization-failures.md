---
title: Troubleshoot ClusterStagedUpdateRun and StagedUpdateRun initialization errors
description: Troubleshoot errors that occur when ClusterStagedUpdateRun and StagedUpdateRun fail to initialize.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
zone_pivot_groups: cluster-namespace-scope
---

# Troubleshoot `ClusterStagedUpdateRun` and `StagedUpdateRun` initialization failures

## Summary

This article discusses how to troubleshoot `ClusterStagedUpdateRun` and `StagedUpdateRun` initialization failures when you propagate resources by using update-run APIs in Microsoft Azure Kubernetes Fleet Manager. 

The following is an example error message:

:::zone target="docs" pivot="cluster-scope"


```yaml
    Last Transition Time:  2026-02-11T00:35:09Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to     a  client error: no resourceSnapshots with index `1` found for placement `/example-placement`
    Observed Generation:   1
    Reason:                UpdateRunInitializedFailed
    Status:                False
    Type:                  Initialized
```

## Investigate initialization errors

1. Locate the `ClusterStagedUpdateRun` initialization error by running the following command:

```bash
$ kubectl get clusterstagedupdaterun example-run
NAME              PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
example-run       example-placement   1                         0                       False                                   2s

```

The `INITIALIZED` field is `False` indicating the initialization failed.

2. Run these commands to get more details about the error:

```bash
$ kubectl describe clusterstagedupdaterun example-run
```

```yaml
Name:         example-run
..
API Version:  placement.kubernetes-fleet.io/v1beta1
Kind:         ClusterStagedUpdateRun
Metadata:
  Creation Timestamp:  2026-02-11T21:05:17Z
  Finalizers:
    kubernetes-fleet.io/clusterstagedupdaterun-finalizer
  Generation:        1
  ...
Spec:
  Placement Name:                example-placement
  Resource Snapshot Index:       0
  Staged Rollout Strategy Name:  example-strategy
  State:                         Initialize
Status:
  Applied Strategy:
    Comparison Option:  PartialComparison
    Type:               ClientSideApply
    When To Apply:      Always
    When To Take Over:  Always
  Conditions:
    Last Transition Time:         2026-02-11T21:05:17Z
    Message:                      cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: some clusters are not placed in any stage, total 3, showing up to 10: cluster-1, cluster-2, cluster-3
    Observed Generation:          1
    Reason:                       UpdateRunInitializedFailed
    Status:                       False
    Type:                         Initialized
  Policy Observed Cluster Count:  3
  Policy Snapshot Index Used:     0
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
    Stage Name:  staging

```

This indicates the initialization failed. In this case, a nonexistent resource snapshot index `1` is used for `ClusterStagedUpdateRun`.

## Common initialization failures

### Cause

Aborted `ClusterStagedUpdateRun` messages happen due to initialization failures and aren't recoverable. 

### Solution

If a failure occurs due to a validation error, fix the issue and create a new `ClusterStagedUpdateRun`.

**Parent placement not found**

### Cause

The `ClusterResourcePlacement` doesn't exist in the namespace. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: parent placement not found
```

### Solution

Create a new `ClusterResourcePlacement` with the same name specified in `ClusterStagedUpdateRun`. Then create a new `ClusterStagedUpdateRun` referencing the new `ClusterResourcePlacement`. See [Placing cluster-scoped resources](/azure/kubernetes-fleet/quickstart-resource-propagation) for more details.

You can also create a new `ClusterStagedUpdateRun` that references a valid `ClusterResourcePlacement` that already exists. Run the following command:

```bash
kubectl get clusterresourceplacements
```

View the `spec` and then verify the strategy for `spec.Strategy.Type: External` deployment with the following command:

```bash
$ kubectl describe clusterresourceplacement <cluster-resource-placement-name> 
```

See [Control cluster order for resource placement](/azure/kubernetes-fleet/howto-staged-update-run) for guidance on creating a `ClusterStagedUpdateRun` that references one of the existing `ClusterResourceplacement` values.

**Selected placement isn't external rollout strategy type**

### Cause

There's no clear external rollout strategy specified in `ClusterResourcePlacement`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: The placement does not have an external rollout strategy...
```

### Solution 

To enable staged updates, recreate the `ClusterResourcePlacement` with `spec.Strategy.Type: External`, create a new `ClusterStagedUpdateRun`, and then select the new `ClusterResourcePlacement`.

> [!NOTE]
> Changing a `ClusterResourcePlacement` from `spec.Strategy.Type: RolloutStrategy` to `spec.Strategy.Type: External` is allowed, but the reverse isn't.

You can also find a `ClusterResourcePlacement` that has `spec.Strategy.Type: External` set and then create a `ClusterStagedUpdateRun` and specify this `ClusterResourcePlacement`.

**Strategy not found**

#### Cause 

`ClusterStagedUpdateStrategy` doesn't exist. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
```

### Solution

Create a new `ClusterStagedUpdateStrategy` within the same name specified in `ClusterStagedUpdateRun` and then create a new `ClusterStagedUpdateRun` referencing this `ClusterStagedUpdateStrategy`.

You can also create a new `ClusterStagedUpdateRun` that references a valid `ClusterStagedUpdateStrategy` that already exists.

**Invalid stage tasks**

### Cause

Within a stage in `ClusterStagedUpdateStrategy`, a `beforeStageTask` or `afterStageTask` is incorrectly defined.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...

### Solution

See [Staged update strategy (preview)](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview) for guidance on how to correctly update the `ClusterStagedUpdateStrategy`.

**Cluster appears more than once**

### Cause

Let's take a look at `ClusterStagedUpdateStrategy`:

```bash
    $ kubectl describe clusterstagedupdatestrategy <cluster-staged-update-strategy-name>
```

```yml
    Name:         example-strategy
    ...
    API Version:  placement.kubernetes-fleet.io/v1beta1
    Kind:         ClusterStagedUpdateStrategy
    Metadata:
      Creation Timestamp:  2026-02-11T21:01:41Z
      Generation:          2
      ...
    Spec:
      Stages:
        After Stage Tasks:
          Type:  Approval
        Label Selector:
          Match Labels:
            Environment:  staging
        Max Concurrency:  1
        Name:             staging
        After Stage Tasks:
          Type:  Approval
        Label Selector:
          Match Labels:
            Region:       west
        Max Concurrency:  1
        Name:             west
```

The `ClusterStagedUpdateStrategy` has two labels that are both selected: the `Environment: staging` and `Region: west` labels.

Now let's take a look at the labels `member-1` referenced in the error as they appear in multiple stages. Use the following command:

```bash
    $ kubectl get membercluster member-1  --show-labels
    
    NAME             JOINED   AGE   MEMBER-AGENT-LAST-SEEN   NODE-COUNT   AVAILABLE-CPU   AVAILABLE-MEMORY   LABELS
    member-1         True     81m   16s                      2            14750m          48308656Ki         environment=staging,region=west
```

The cluster has both labels used in these two stages. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
```

### Solution

Either remove one of the labels or update the stages in `ClusterStagedUpdateStrategy` so they select distinct cluster labels. You then create a new `ClusterStagedUpdateRun`.

**Some clusters not assigned a stage**

### Cause

The error provides a list of clusters (up to 10) that aren't assigned a stage. Let's take a look at `ClusterResourcePlacement` and verify what clusters are targeted using the following commands:

```bash
    $ kubectl get clusterresourceplacement <cluster-resource-placement-name>
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
      Resource Version:  11468
      UID:               d268e4c0-b614-408c-bdc0-b2670194587b
    Spec:
      Policy:
        Placement Type:  PickAll
      Resource Selectors:
        Group:                 ""
        Kind:                  Namespace
        Name:                  test
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
        Cluster Name:            cluster-1
        Conditions:
          ...
        Cluster Name:            cluster-2
        Conditions:
          ...
        Cluster Name:            cluster-3
        Conditions:
          ...
```

`ClusterResourcePlacement` targets subset clusters (or all the clusters in a Fleet) to roll resources out to.

In `ClusterResourcePlacement`, the placement type is `PickAll`. This means all the clusters in the Fleet need to be assigned to a stage.

If a cluster isn't placed in a stage, the cluster lacks the label for any of the stages specified in `ClusterStagedUpdateStrategy`. 

Let's take a look at `ClusterStagedUpdateStrategy`:

```bash
    $  kubectl describe clusterstagedupdatestrategy <cluster-staged-update-strategy-name>
```

```yaml
    Name:         example-strategy
    ...
    API Version:  placement.kubernetes-fleet.io/v1beta1
    Kind:         ClusterStagedUpdateStrategy
    Metadata:
      Creation Timestamp:  2026-02-11T21:01:41Z
      Generation:          1
      ...
    Spec:
      Stages:
        After Stage Tasks:
          Type:  Approval
        Label Selector:
          Match Labels:
            Environment:  staging
        Max Concurrency:  1
        Name:             staging
```

From `Spec`, there's one stage that selects clusters with the label `Environment: staging`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: some clusters are not placed in any stage, total 3, showing up to 10: cluster-1, cluster-2, cluster-3
```

### Solution

1. Update the clusters with a `environment=staging` label:

```bash
    $ az fleet member update -g <resource-group-name> -f <fleet-name> -n <member-cluster-name> --labels "environment=staging"
```

2. Verify the member cluster has the new label:

```bash
    $ kubectl get membercluster <member-cluster-name> --show-labels

    NAME             JOINED   AGE   MEMBER-AGENT-LAST-SEEN   NODE-COUNT   AVAILABLE-CPU   AVAILABLE-MEMORY   LABELS
    cluster-1        True     62m   3s                       2            14750m          48308656Ki         environment=staging,region=east
```

3. Add labels to the remaining clusters. 

4. Create a new `ClusterStagedUpdateRun` referencing the same `ClusterResourcePlacement` and `ClusterStagedUpdateStrategy`.
  
:::zone-end

:::zone target="docs" pivot="namespace-scope"

```yaml
    Last Transition Time:  2026-02-11T00:35:09Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to     a         client error: no resourceSnapshots with index `1` found for placement `test-namespace/example-placement`
    Observed Generation:   1
    Reason:                UpdateRunInitializedFailed
    Status:                False
    Type:                  Initialized
```

### Investigate initialization failures

1. Locate the `StagedUpdateRun` initialization error by running the following command:

```bash
$ kubectl get stagedupdaterun web-app-rollout -n my-app-namespace
NAME              PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
web-app-rollout   web-app-placement   1                         0                       False                                   2s

```

The `INITIALIZED` field is `False` indicating the initialization failed.

2. Run these commands to get more details about the error:

```bash
$ kubectl describe stagedupdaterun web-app-rollout -n my-app-namespace
```

```yaml
Name:         web-app-rollout
Namespace:    my-app-namespace
..
API Version:  placement.kubernetes-fleet.io/v1beta1
Kind:         StagedUpdateRun
Metadata:
  Creation Timestamp:  2026-02-11T21:05:17Z
  Finalizers:
    kubernetes-fleet.io/stagedupdaterun-finalizer
  Generation:        1
  ...
Spec:
  Placement Name:                web-app-rollout-placement
  Resource Snapshot Index:       0
  Staged Rollout Strategy Name:  example-strategy
  State:                         Initialize
Status:
  Applied Strategy:
    Comparison Option:  PartialComparison
    Type:               ClientSideApply
    When To Apply:      Always
    When To Take Over:  Always
  Conditions:
    Last Transition Time:         2026-02-11T21:05:17Z
    Message:                      cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: some clusters are not placed in any stage, total 3, showing up to 10: cluster-1, cluster-2, cluster-3
    Observed Generation:          1
    Reason:                       UpdateRunInitializedFailed
    Status:                       False
    Type:                         Initialized
  Policy Observed Cluster Count:  3
  Policy Snapshot Index Used:     0
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
    Stage Name:  staging

```

The condition indicates the initialization failed. In this case, a nonexistent resource snapshot index `1` is used for `StagedUpdateRun`.

## Common initialization failures

### Cause

Aborted `StagedUpdateRun` messages happen due to initialization failures and aren't recoverable. 

### Solution

If a failure occurs due to a validation error, fix the issue and create a new `StagedUpdateRun`.

**Parent placement not found**

### Cause

`ResourcePlacement` doesn't exist in the namespace. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: parent placement not found
```

### Solution

Create a new `ResourcePlacement` in the same namespace with the same name specified in `StagedUpdateRun`. Then create a new `StagedUpdateRun` referencing that `ResourcePlacement`.

See [Use Azure Kubernetes Fleet Manager cluster resource placement to deploy workloads across multiple clusters](/azure/kubernetes-fleet/quickstart-resource-propagation) for guidance on how to create a `ResourcePlacement`.

You can also create a new `StagedUpdateRun` that references a valid placement that already exists. 

1. Use the following command:

```bash
    $ kubectl get resourceplacements -n <namespace-name>
```

2. Describe a `ResourcePlacement` to view the `spec`. Verify the strategy and ensure `spec.Strategy.Type: External` is the value.

3. Set the resources to roll it out:

```bash
    $ kubectl describe resourceplacement <cluster-resource-placement-name> -n <namespace-name>
```

For more information, see [Control cluster order for resource placement](/azure/kubernetes-fleet/howto-staged-update-run).

**Placement selected isn't external rollout strategy type**

### Cause

There's no clear external rollout strategy specified in `ClusterResourcePlacement`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: The placement does not have an external rollout strategy...
```

### Solution

To enable staged updates, recreate the `ClusterResourcePlacement` with `spec.Strategy.Type: External`, create a new `ClusterStagedUpdateRun`, and select the new `ClusterResourcePlacement`.
    
> [!NOTE]
> Changing a `ResourcePlacement` from `spec.Strategy.Type: RolloutStrategy` to `spec.Strategy.Type: External` is allowed, but the reverse isn't.

You can also locate a `ResourcePlacement` that has a `spec.Strategy.Type: External` value and then create a `StagedUpdateRun` specifying the `ResourcePlacement` you located.

**Strategy not found**

### Cause

The `StagedUpdateStrategy` doesn't exist in the same namespace. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
```

### Solution

Create a new `StagedUpdateStrategy` within the same namespace specified in `StagedUpdateRun` and create a new `StagedUpdateRun` referencing that strategy.

You can also create a new `StagedUpdateRun` that references a valid `StagedUpdateStrategy` that already exists.

**Invalid stage tasks**

### Cause

Within a stage in `StagedUpdateStrategy`, a `beforeStageTask` or `afterStageTask` is incorrectly defined.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...
```

### Solution

See [Staged Update Strategy](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview) for guidance on how to correctly update `StagedUpdateStrategy`.

**Cluster appears more than once**

### Cause 

A cluster is selected in multiple stages of a `StagedUpdateRun`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
```

Let's take a look at `StagedUpdateStrategy`:

```bash
    $ kubectl describe stagedupdatestrategy <staged-update-strategy-name> -n <namespace-name>
```

```yml
    Name:         example-strategy
    Namespace:    my-app-namespace
    ...
    API Version:  placement.kubernetes-fleet.io/v1beta1
    Kind:         StagedUpdateStrategy
    Metadata:
      Creation Timestamp:  2026-02-11T21:01:41Z
      Generation:          2
      ...
    Spec:
      Stages:
        After Stage Tasks:
          Type:  Approval
        Label Selector:
          Match Labels:
            Environment:  staging
        Max Concurrency:  1
        Name:             staging
        After Stage Tasks:
          Type:  Approval
        Label Selector:
          Match Labels:
            Region:       west
        Max Concurrency:  1
        Name:             west
```

The `StagedUpdateStrategy` has two labels that are both selected: the `Environment: staging` and `Region: west` labels.

Now let's take a look at the labels `member-1` referenced in the error as they appear in multiple stages. Use the following command:

```bash
    $ kubectl get membercluster member-1  --show-labels
    
    NAME             JOINED   AGE   MEMBER-AGENT-LAST-SEEN   NODE-COUNT   AVAILABLE-CPU   AVAILABLE-MEMORY   LABELS
    member-1         True     81m   16s                      2            14750m          48308656Ki         environment=staging,region=east
```

The cluster has both labels used in these two stages. 

### Solution

Either remove one of the labels or update the stages in  `StagedUpdateStrategy` so they select distinct cluster labels. You then create a new `StagedUpdateRun`.

**Some clusters not assigned a stage**

### Cause

The error provides a list of clusters (up to 10) that aren't assigned a stage. Let's take a look at `ResourcePlacement` and verify what clusters are targeted.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: some clusters are not placed in any stage, total 3, showing up to 10: cluster-1, cluster-2, cluster-3
```text

Run the following commands:

```bash
    $ kubectl get resourceplacement web-app-rollout-placement -n my-app-namespace
```

```yml
    Name:         web-app-rollout-placement
    Namespace:    my-app-namespace
    ...
    API Version:  placement.kubernetes-fleet.io/v1beta1
    Kind:         ResourcePlacement
    Metadata:
      Creation Timestamp:  2026-02-11T21:02:36Z
      Finalizers:
        kubernetes-fleet.io/crp-cleanup
        kubernetes-fleet.io/scheduler-cleanup
      Generation:        1
      Resource Version:  11468
      UID:               d268e4c0-b614-408c-bdc0-b2670194587b
    Spec:
      Policy:
        Placement Type:  PickAll
      Resource Selectors:
        Group:                 apps
        Kind:                  Deployment
        Name:                  test
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
        Cluster Name:            cluster-1
        Conditions:
          ...
        Cluster Name:            cluster-2
        Conditions:
          ...
        Cluster Name:            cluster-3
        Conditions:
          ...
```

`ResourcePlacement` targets subset clusters (or all the clusters in a Fleet) to roll out the resources to.

In the `ResourcePlacement`, the placement type is `PickAll`. This means all the clusters in the Fleet need to be assigned to a stage.

If a cluster isn't placed in a stage, the cluster lacks the label for any of the stages specified in`StagedUpdateStrategy`. 

Let's take a look at the `StagedUpdateStrategy`:

```bash
    $  kubectl describe stagedupdatestrategy example-strategy -n my-app-namespace
```

```yaml
    Name:         example-strategy
    Namespace:    my-app-namespace
    ...
    API Version:  placement.kubernetes-fleet.io/v1beta1
    Kind:         StagedUpdateStrategy
    Metadata:
      Creation Timestamp:  2026-02-11T21:01:41Z
      Generation:          1
      ...
    Spec:
      Stages:
        After Stage Tasks:
          Type:  Approval
        Label Selector:
          Match Labels:
            Environment:  staging
        Max Concurrency:  1
        Name:             staging
```

From `Spec`, there's one stage that selects clusters with the label `Environment: staging`.

### Solution

1. Update the clusters with a `environment=staging` label:

```bash
    $ az fleet member update -g <resource-group-name> -f <fleet-name> -n <member-cluster-name> --labels "environment=staging"
```

2. Verify the member cluster has the new label:

```bash
    $ kubectl get membercluster <member-cluster-name> --show-labels

    NAME             JOINED   AGE   MEMBER-AGENT-LAST-SEEN   NODE-COUNT   AVAILABLE-CPU   AVAILABLE-MEMORY   LABELS
    cluster-1        True     62m   3s                       2            14750m          48308656Ki         environment=staging,region=east
```

3. Add labels to the remaining clusters. 

4. Create a new `StagedUpdateRun` referencing the same `ResourcePlacement` and `StagedUpdateStrategy`.
  
:::zone-end
