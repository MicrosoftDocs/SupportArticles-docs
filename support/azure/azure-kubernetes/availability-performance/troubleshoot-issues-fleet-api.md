---
title:  Troubleshooting ClusterResourcePlacement in Azure Fleet Manager
description: Helps you resolve `ClusterResourcePlacement` related issues when you use Azure Kubernetes Fleet Manager APIs.
ms.date: 07/22/2024
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance,devx-track-azurecli
---
# Troubleshooting ClusterResourcePlacement in Azure Fleet Manager

This troubleshooting guide helps you resolve `ClusterResourcePlacement` related issues when you use Azure Kubernetes Fleet Manager APIs. When troubleshooting these errors on the hub cluster, keep in mind the following internal objects:

- `ClusterResourceSnapshot`
- `ClusterSchedulingPolicySnapshot`
- `ClusterResourceBinding`
- `Work`

For more details about each object, see the [API reference](https://github.com/Azure/fleet/blob/main/docs/api-references.md).

## Overall progress of the ClusterResourcePlacement deployment

Understanding the progress and the status of the `ClusterResourcePlacement` deployment is crucial for diagnosing and identifying failures. You can view the status of the `ClusterResourcePlacement` deployment using the `kubectl describe clusterresourceplacement <name>` command. For more information, see [Use the ClusterResourcePlacement API to propagate resources to member clusters](https://learn.microsoft.com/azure/kubernetes-fleet/quickstart-resource-propagation#use-the-clusterresourceplacement-api-to-propagate-resources-to-member-clusters)

The overall progress of `ClusterResourcePlacement` is as follows:

1. **ClusterResourcePlacementScheduled**: Indicates a resource has been scheduled for placement.

    If false, see How to debug ClusterResourcePlacementScheduled condition status set to false.
1. **ClusterResourcePlacementRolloutStarted**: Indicates the rollout process has begun.

    If false, see How to debug ClusterResourcePlacementRolloutStarted condition status set to false.
1. **ClusterResourcePlacementOverridden**: Indicates the resource has been overridden.

    If false, see How to debug ClusterResourcePlacementOverridden condition status set to false.
1. **ClusterResourcePlacementWorkSynchronized**: Indicates work objects have been synchronized.

    If false, see How to debug ClusterResourcePlacementWorkSynchronized condition status set to false.
1. **ClusterResourcePlacementApplied**: Indicates the resource has been applied.

    If false, see How to debug ClusterResourcePlacementApplied condition status set to false.
1. **ClusterResourcePlacementAvailable**: Indicates the resource is available.

    If false, see How to debug ClusterResourcePlacementAvailable condition status set to false.

## FAQ

### How can I debug when some clusters aren't selected as expected?

Check the status of the `ClusterSchedulingPolicySnapshot` to determine which clusters were selected and the reason for their selection.

### How can I debug when a selected cluster that doesn't have the expected resources or if  `ClusterResourcePlacement` doesn't pick up the latest changes?**

1. Verify if the `ClusterResourcePlacementRolloutStarted` condition in the ClusterResourcePlacement status is set to true or false.
    - If false, refer to the appropriate troubleshooting question.
    - If true, proceed to the step 2.
2. Verify if the `ClusterResourcePlacementApplied` condition is set to **unknown**, **false**, or **true**.
    - If **unknown**, wait as the resources are still being applied to the member cluster. If the state remains unknown for a while, create a GitHub issue, as this is an unusual behavior.
    - If **false**, refer to the appropriate troubleshooting question.
    - If **true**, verify if the resource exists on the hub cluster.
3. Check the **placementStatuses** section in the **ClusterResourcePlacement** status for the particular cluster. The **failedPlacements** section should provide reasons for any resource application failures.

### How to find and verify the latest ClusterSchedulingPolicySnapshot for a ClusterResourcePlacement API deployment?

To find the latest ClusterSchedulingPolicySnapshot for a ClusterResourcePlacement API deployment, you need the ClusterResourcePlacement name. Replace {CRPName} in the following command with your ClusterResourcePlacement name:

    ```bash
    kubectl get clusterschedulingpolicysnapshot -l kubernetes-fleet.io/is-latest-snapshot=true,kubernetes-fleet.io/parent-CRP={CRPName}

    ```

And then:

1. Compare the ClusterSchedulingPolicySnapshot with the ClusterResourcePlacement policy to ensure they match, excluding the numberOfClusters field from the ClusterResourcePlacement spec. 
1. If the placement type is PickN, check if the number of clusters requested in the ClusterResourcePlacement policy matches the value for the label called number-of-clusters.

The command below lists all `ClusterResourceBindings` associated with `ClusterResourcePlacement`. Replace `{CRPName}` with your ClusterResourcePlacement name in the command below.

```bash
kubectl get clusterresourcebinding -l kubernetes-fleet.io/parent-CRP={CRPName}
```

**Example**:

In this case, we have `ClusterResourcePlacement` called test-crp,

```bash
kubectl get crp test-crp
NAME       GEN   SCHEDULED   SCHEDULEDGEN   APPLIED   APPLIEDGEN   AGE
test-crp   1     True        1              True      1            15s
```

From the `placementStatuses` section of the `test-crp` status, we can observe that it has been propagated resources to two member clusters and hence has two `ClusterResourceBindings`,

```bash
status:
  conditions:
  - lastTransitionTime: "2023-11-23T00:49:29Z"
    ...
  placementStatuses:
  - clusterName: kind-cluster-1
    conditions:
      ...
      type: ResourceApplied
  - clusterName: kind-cluster-2
    conditions:
      ...
      reason: ApplySucceeded
      status: "True"
      type: ResourceApplied
```

Output we receive after running the command listed above to get the `ClusterResourceBindings`,

```bash
kubectl get clusterresourcebinding -l kubernetes-fleet.io/parent-CRP=test-crp 
NAME                               WORKCREATED   RESOURCESAPPLIED   AGE
test-crp-kind-cluster-1-be990c3e   True          True               33s
test-crp-kind-cluster-2-ec4d953c   True          True               33s
```

The `ClusterResourceBinding` name follows this format `{CRPName}-{clusterName}-{suffix}`, so once we have all ClusterResourceBindings listed find the `ClusterResourceBinding` for the target cluster you're looking for based on the `clusterName`.

### How to find the latest ClusterResourceSnapshot resource?

Replace `{CRPName}` in the command below with name of `ClusterResourcePlacement`:

```bash
kubectl get clusterresourcesnapshot -l kubernetes-fleet.io/is-latest-snapshot=true,kubernetes-fleet.io/parent-CRP={CRPName}
```

### How and where to find the correct Work resource?

We need to have the member cluster's namespace, which follows this format `fleet-member-{clusterName}` and `ClusterResourcePlacement` name `{CRPName}`.

```bash
kubectl get work -n fleet-member-{clusterName} -l kubernetes-fleet.io/parent-CRP={CRPName}
```