---
title: How To Troubleshoot ClusterStagedUpdateRun Initialization Failures
description: Troubleshoot errors that occur when ClusterStagedUpdateRun failed to initialize.
author: britaniar
ms.author: britaniar
ms.service: azure-kubernetes-fleet-manager
ms.date: 01/20/2026
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Intialization Failure: Initialized is False

## Summary

This article discusses how to troubleshoot initialization failures when you propagate resources by using update run APIs in Microsoft Azure Kubernetes Fleet Manager. This issue applies to both `ClusterStageUpdateRun` and `StagedUpdateRun`.

Sample error messages:

# [ClusterStagedUpdateRun](#tab/clusterstagedupdaterun)

```yaml
    Last Transition Time:  2026-01-08T00:35:09Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: no resourceSnapshots with index `1` found for placement `/example-placement`
    Observed Generation:   1
    Reason:                UpdateRunInitializedFailed
    Status:                False
    Type:                  Initialized
```

# [StagedUpdateRun](#tab/stagedupdaterunt)

```yaml
    Last Transition Time:  2026-01-08T00:35:09Z
    Message:               cannot continue the updateRun: failed to validate the updateRun: failed to process the request due to a client error: no resourceSnapshots with index `1` found for placement `test-namespace/example-placement`
    Observed Generation:   1
    Reason:                UpdateRunInitializedFailed
    Status:                False
    Type:                  Initialized
```

---

### Investigate Initialization Failure

# [ClusterStagedUpdateRun](#tab/clusterstagedupdaterunfailure)

An `ClusterStagedUpdateRun` initialization failure can be detected by getting the resource:

```bash
$ kubectl get csur example-run 

NAME          PLACEMENT           RESOURCE-SNAPSHOT-INDEX   POLICY-SNAPSHOT-INDEX   INITIALIZED   PROGRESSING   SUCCEEDED   AGE
example-run   example-placement   1                         0                       False                                   4s
```

The `INITIALIZED` field is `False`, indicating the initialization failed.

Describe the `ClusterStagedUpdateRun` to get more details:

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

The condition indicates the initialization failed. The condition message gives more details about the failure. In this case, a nonexisting resource snapshot index 1 was used for the `ClusterStagedUpdateRun`.

#### Common Initialization Failures

1. Parent Placement Not Found

    Example Message:

    ```text
    cannot continue the updateRun: failed to validate the updateRun: parent placement not found
    ```

    Remediate by creating a new placement specified with the same name specified in `ClusterStagedUpdateRun` and create a new `ClusterStagedUpdateRun` as this instance is aborted.

    Refer to [Placing cluster-scoped resources](/azure/kubernetes-fleet/quickstart-resource-propagation) to create a `ClusterResourcePlacement`.

    Or, create a new `ClusterStagedUpdateRun` with referencing a valid placement that already exists.

    ```bash
    kubectl get clusterresourceplacements 
    ```

    Describe a `ClusterResourcePlacement` to view the spec and double check the strategy to ensure `spec.Strategy.Type: External`.

    ```bash
    kubectl describe clusterresourceplacement <cluster-resource-placement-name>
    ```

    Refer to [Control cluster order for resource placement](/azure/kubernetes-fleet/howto-staged-update-run) to create a `ClusterStagedUpdateRun` referencing one of the existing `ClusterResourceplacement`.

2. The Placement Selected Isn't External Rollout Strategy Type

    Example Message:

    ```text
    cannot continue the updateRun: failed to validate the updateRun: The placement does not have an external rollout strategy...
    ```

    Re-create the placement with `spec.Strategy.Type: External` and create a new `ClusterStagedUpdateRun` selecting that placement as this instance is aborted.

    Or, find a placement that has `spec.Strategy.Type: External` and create a `ClusterStagedUpdateRun` specifying the new placement.

3. Strategy Not Found

    Example Message:

    ```text
    cannot continue the updateRun: failed to validate the updateRun: referenced updateStrategy not found: ...
    ```

    Remediate by creating a new `ClusterUpdateStrategy` specified with the same name specified in `ClusterStagedUpdateRun` and create a new `ClusterStagedUpdateRun` as this instance is aborted.

    Or, create a new `ClusterStagedUpdateRun` with referencing a valid `ClusterUpdateStrategy` that already exists.

4. Invalid Stage Tasks

    Within a stage in `ClusterUpdateStrategy`, a beforeStageTask or afterStageTask was incorrectly defined.

    Example Message:

    ```text
    cannot continue the updateRun: failed to validate the updateRun: the before stage tasks are invalid, updateStrategy: ...
    ```

    Refer to [Staged Update Strategy](/azure/kubernetes-fleet/concepts-rollout-strategy#staged-update-strategy-preview) to correctly update the `ClusterUpdateStrategy`.

5. Cluster Appearing More Than Once

    Cluster is selected in multiple stages of a `ClusterUpdateRun`.

    Example Message:

    ```text
    cannot continue the updateRun: failed to validate the updateRun: cluster `member-1` appears in more than one stage
    ```

    Update the stages in `ClusterUpdateStrategy` to select distinct cluster labels, then create a new `ClusterStagedUpdateRun` as this instance is aborted.

---
