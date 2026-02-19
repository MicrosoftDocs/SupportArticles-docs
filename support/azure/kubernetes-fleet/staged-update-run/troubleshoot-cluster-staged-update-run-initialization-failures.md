---
title: Troubleshoot ClusterStagedUpdateRun and StagedUpdateRun initialization errors
description: Troubleshoot errors that occur when ClusterStagedUpdateRun and StagedUpdateRun don't initialize.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
zone_pivot_groups: cluster-namespace-scope
---

# Troubleshoot ClusterStagedUpdateRun and StagedUpdateRun initialization failures

## Summary

This article discusses how to troubleshoot `ClusterStagedUpdateRun` and `StagedUpdateRun` initialization failures that occur when you propagate resources by using update run APIs in Microsoft Azure Kubernetes Fleet Manager. 

The following is an example error message:

:::zone target="docs" pivot="cluster-scope"

```yaml
    Last Transition Time:  2026-02-11T00:35:09Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a  client error: no resourceSnapshots with index `1` found for placement `/example-placement`
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

The `INITIALIZED` field value is `False`. This value indicates that the initialization failed.

2. To get more details about the error, run the following commands:

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

This status value indicates that the initialization failed. In this case, a nonexistent resource snapshot index `1` is used for `ClusterStagedUpdateRun`.

## Common initialization failures

### Cause

"Aborted" `ClusterStagedUpdateRun` messages are generated because of initialization failures. The initialization process isn't recoverable. 

### Solution

If a failure occurs because of a validation error, fix the issue, and create a new `ClusterStagedUpdateRun` instance.

**Parent placement not found**

### Cause

The `ClusterResourcePlacement` doesn't exist in the namespace. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: parent placement not found
```

### Solution

Create a new `ClusterResourcePlacement` that has the same name that's specified in `ClusterStagedUpdateRun`. Then, create a new `ClusterStagedUpdateRun` instance that references the new `ClusterResourcePlacement`. For more details, see [Placing cluster-scoped resources](/azure/kubernetes-fleet/quickstart-resource-propagation).

You can also create a new `ClusterStagedUpdateRun` instance that references a valid `ClusterResourcePlacement` that already exists. Run the following command:

```bash
kubectl get clusterresourceplacements
```

View the `spec` value, and then verify the strategy for `spec.Strategy.Type: External` deployment by running the following command:

```bash
$ kubectl describe clusterresourceplacement <cluster-resource-placement-name> 
```

For information about how to create a `ClusterStagedUpdateRun` that references one of the existing `ClusterResourceplacement` values, see [Control cluster order for resource placement](/azure/kubernetes-fleet/howto-staged-update-run).

**Selected placement isn't external rollout strategy type**

### Cause

No clear external rollout strategy is specified in `ClusterResourcePlacement`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: The placement does not have an external rollout strategy...
```

### Solution 

To enable staged updates, re-create the `ClusterResourcePlacement` instance by using `spec.Strategy.Type: External`, create a new `ClusterStagedUpdateRun`, and then select the new `ClusterResourcePlacement`.

> [!NOTE]
> You can change a `ClusterResourcePlacement` instance from `spec.Strategy.Type: RolloutStrategy` to `spec.Strategy.Type: External`. This change is allowed. However, the reverse isn't allowed.

You can also find a `ClusterResourcePlacement` instance that has `spec.Strategy.Type: External` set. Then, you can create a `ClusterStagedUpdateRun`, and specify this `ClusterResourcePlacement`.

**Strategy not found**

### Cause 

`ClusterStagedUpdateStrategy` doesn't exist. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
```

### Solution

Create a `ClusterStagedUpdateStrategy` instance within the same name that's specified in `ClusterStagedUpdateRun`. Then, create a `ClusterStagedUpdateRun` instance that references this `ClusterStagedUpdateStrategy`.

You can also create a `ClusterStagedUpdateRun` instance that references a valid `ClusterStagedUpdateStrategy` that already exists.

**Invalid stage tasks**

### Cause

Within a stage in `ClusterStagedUpdateStrategy`, an instance of `beforeStageTask` or `afterStageTask` is incorrectly defined.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...

### Solution

For information about how to correctly update the `ClusterStagedUpdateStrategy`, see [Staged update strategy (preview)](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview).

**Cluster appears more than one time**

### Cause

View the `ClusterStagedUpdateStrategy` instance:

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

The `ClusterStagedUpdateStrategy` has two labels that are both selected: `Environment: staging` and `Region: west`.

Next, view the `member-1` labels that are referenced in the error message as they appear in multiple stages. Run the following command:

```bash
    $ kubectl get membercluster member-1  --show-labels
    
    NAME             JOINED   AGE   MEMBER-AGENT-LAST-SEEN   NODE-COUNT   AVAILABLE-CPU   AVAILABLE-MEMORY   LABELS
    member-1         True     81m   16s                      2            14750m          48308656Ki         environment=staging,region=west
```

For this cluster, both labels are used in these two stages. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
```

### Solution

Either remove one of the labels or update the stages in `ClusterStagedUpdateStrategy` so that they select distinct cluster labels. Then, create a new `ClusterStagedUpdateRun`.

**Some clusters not assigned a stage**

### Cause

The error message provides a list of clusters (up to 10) that aren't assigned a stage. Examine `ClusterResourcePlacement`, and determine which clusters are targeted. To get this information, run the following commands:

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

`ClusterResourcePlacement` targets the subset clusters (or all the clusters in a Fleet) to assign resources to.

In `ClusterResourcePlacement`, the placement type is `PickAll`. This type means that all the clusters in the Fleet have to be assigned to a stage. If a cluster isn't placed into a stage, the cluster lacks the label for any of the stages that are specified in `ClusterStagedUpdateStrategy`. 

Examine `ClusterStagedUpdateStrategy`:

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

The `Spec` field shows one stage that selects clusters that have the label, `Environment: staging`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: some clusters are not placed in any stage, total 3, showing up to 10: cluster-1, cluster-2, cluster-3
```

### Solution

1. Update the clusters that have an `environment=staging` label:

```bash
    $ az fleet member update -g <resource-group-name> -f <fleet-name> -n <member-cluster-name> --labels "environment=staging"
```

2. Verify that the member cluster has the new label:

```bash
    $ kubectl get membercluster <member-cluster-name> --show-labels

    NAME             JOINED   AGE   MEMBER-AGENT-LAST-SEEN   NODE-COUNT   AVAILABLE-CPU   AVAILABLE-MEMORY   LABELS
    cluster-1        True     62m   3s                       2            14750m          48308656Ki         environment=staging,region=east
```

3. Add labels to the remaining clusters. 

4. Create a `ClusterStagedUpdateRun` instance that references the same `ClusterResourcePlacement` and `ClusterStagedUpdateStrategy` instances.
  
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

The `INITIALIZED` field value is `False`. This value indicates that the initialization failed.

2. To get more details about the error, run the following commands:

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

The condition indicates that the initialization failed. In this case, a nonexistent resource snapshot index value of `1` is used for `StagedUpdateRun`.

## Common initialization failures

### Cause

"Aborted" `StagedUpdateRun` messages are caused by initialization failures. The initialization processes aren't recoverable. 

### Solution

If a failure occurs because of a validation error, fix the issue, and create a new `StagedUpdateRun`.

**Parent placement not found**

### Cause

`ResourcePlacement` doesn't exist in the namespace. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: parent placement not found
```

### Solution

Create a `ResourcePlacement` instance in the same namespace that's specified in `StagedUpdateRun`. Then, create a `StagedUpdateRun` instance that references that `ResourcePlacement`.

For information about how to create a `ResourcePlacement` instance, see [Use Azure Kubernetes Fleet Manager cluster resource placement to deploy workloads across multiple clusters](/azure/kubernetes-fleet/quickstart-resource-propagation).

To create a `StagedUpdateRun` instance that references a valid placement that already exists: 

1. Run the following command:

```bash
    $ kubectl get resourceplacements -n <namespace-name>
```

2. Describe a `ResourcePlacement` strategy in order to view the `Spec` value. Verify the strategy, and make sure that the value is `spec.Strategy.Type: External`.

3. Set the resources to roll out the strategy:

```bash
    $ kubectl describe resourceplacement <cluster-resource-placement-name> -n <namespace-name>
```

For more information, see [Control cluster order for resource placement](/azure/kubernetes-fleet/howto-staged-update-run).

**Placement selected isn't external rollout strategy type**

### Cause

No clear external rollout strategy is specified in `ClusterResourcePlacement`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: The placement does not have an external rollout strategy.
```

### Solution

To enable staged updates, re-create the `ClusterResourcePlacement` instance by using the `spec.Strategy.Type: External` value, create a `ClusterStagedUpdateRun` instance, and then select the new `ClusterResourcePlacement`.
    
> [!NOTE]
> You can change a `ResourcePlacement` instance from `spec.Strategy.Type: RolloutStrategy` to `spec.Strategy.Type: External`. This change is allowed, but the reverse isn't allowed.

You can also locate a `ResourcePlacement` that has a `spec.Strategy.Type: External` value, and then create a `StagedUpdateRun` by specifying the `ResourcePlacement` that you located.

**Strategy not found**

### Cause

The `StagedUpdateStrategy` doesn't exist in the same namespace. 

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
```

### Solution

Create a `StagedUpdateStrategy` instance within the same namespace that's specified in `StagedUpdateRun`, and then create a `StagedUpdateRun` instance that references that strategy.

You can also create a `StagedUpdateRun` instance that references a valid `StagedUpdateStrategy` that already exists.

**Invalid stage tasks**

### Cause

Within a stage in `StagedUpdateStrategy`, a `beforeStageTask` or `afterStageTask` instance is defined incorrectly.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...
```

### Solution

For information about how to correctly update `StagedUpdateStrategy`, see [Staged Update Strategy](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview).

**Cluster appears more than one time**

### Cause 

A cluster is selected in multiple stages of a `StagedUpdateRun`.

Example message:

```text
cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
```

Examine `StagedUpdateStrategy`:

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

The `StagedUpdateStrategy` instance has two labels that are both selected: the `Environment: staging` and `Region: west` labels.

Examine the `member-1` labels that are referenced in the error message because they appear in multiple stages. Run the following command:

```bash
    $ kubectl get membercluster member-1  --show-labels
    
    NAME             JOINED   AGE   MEMBER-AGENT-LAST-SEEN   NODE-COUNT   AVAILABLE-CPU   AVAILABLE-MEMORY   LABELS
    member-1         True     81m   16s                      2            14750m          48308656Ki         environment=staging,region=east
```

For this cluster, both labels are used in these two stages. 

### Solution

Either remove one of the labels or update the stages in  `StagedUpdateStrategy` so that they select distinct cluster labels. Then, create a new `StagedUpdateRun` instance.

**Some clusters not assigned a stage**

### Cause

The error message provides a list of clusters (up to 10) that aren't assigned a stage. Examine `ResourcePlacement`, and determine which clusters are targeted.

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

`ResourcePlacement` targets the subset clusters (or all the clusters in a Fleet) to assign resources to.

In the `ResourcePlacement`, the placement type is `PickAll`. This means all the clusters in the Fleet need to be assigned to a stage.

If a cluster isn't placed into a stage, the cluster lacks the label for any of the stages that are specified in`StagedUpdateStrategy`. 

Examine `StagedUpdateStrategy`:

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

The `Spec` field shows one stage that selects clusters that have the label, `Environment: staging`.

### Solution

1. Update the clusters that have an `environment=staging` label:

```bash
    $ az fleet member update -g <resource-group-name> -f <fleet-name> -n <member-cluster-name> --labels "environment=staging"
```

2. Verify that the member cluster has the new label:

```bash
    $ kubectl get membercluster <member-cluster-name> --show-labels

    NAME             JOINED   AGE   MEMBER-AGENT-LAST-SEEN   NODE-COUNT   AVAILABLE-CPU   AVAILABLE-MEMORY   LABELS
    cluster-1        True     62m   3s                       2            14750m          48308656Ki         environment=staging,region=east
```

3. Add labels to the remaining clusters. 

4. Create a `StagedUpdateRun` instance that references the same `ResourcePlacement` and `StagedUpdateStrategy` instances.
  
:::zone-end
