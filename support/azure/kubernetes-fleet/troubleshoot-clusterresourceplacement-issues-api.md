---
title:  Troubleshooting ClusterResourcePlacement in Azure Fleet Manager
description: Helps you resolve `ClusterResourcePlacement` related issues when you use Azure Kubernetes Fleet Manager APIs.
ms.date: 07/22/2024
ms.reviewer: 
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance,devx-track-azurecli
---
# Troubleshooting ClusterResourcePlacement in Azure Fleet Manager

This troubleshooting guide helps you resolve `ClusterResourcePlacement` related issues when you use Azure Kubernetes Fleet Manager APIs. When troubleshooting these errors on the hub cluster, knowledge of the following internal objects is required:

- `ClusterResourceSnapshot`
- `ClusterSchedulingPolicySnapshot`
- `ClusterResourceBinding`
- `Work`

For more details about each object, see the [API reference](https://github.com/Azure/fleet/blob/main/docs/api-references.md).

## Complete progress of the ClusterResourcePlacement deployment

Understanding the progress and the status of the `ClusterResourcePlacement` deployment is crucial for diagnosing and identifying failures. You can view the status of the `ClusterResourcePlacement` deployment using the following command:

```bash
kubectl describe clusterresourceplacement <name>
```

For more information, see [Use the ClusterResourcePlacement API to propagate resources to member clusters](https://learn.microsoft.com/azure/kubernetes-fleet/quickstart-resource-propagation#use-the-clusterresourceplacement-api-to-propagate-resources-to-member-clusters).

The complete progress of `ClusterResourcePlacement` is as follows:

1. **ClusterResourcePlacementScheduled**: Indicates a resource has been scheduled for placement.

    If false, see [How to debug ClusterResourcePlacementScheduled condition status set to false]().
1. **ClusterResourcePlacementRolloutStarted**: Indicates the rollout process has begun.

    If false, see [How to debug ClusterResourcePlacementRolloutStarted condition status set to false]().
1. **ClusterResourcePlacementOverridden**: Indicates the resource has been overridden.

    If false, see [How to debug ClusterResourcePlacementOverridden condition status set to false]().
1. **ClusterResourcePlacementWorkSynchronized**: Indicates work objects have been synchronized.

    If false, see [How to debug ClusterResourcePlacementWorkSynchronized condition status set to false]().
1. **ClusterResourcePlacementApplied**: Indicates the resource has been applied.

    If false, see [How to debug ClusterResourcePlacementApplied condition status set to false]().
1. **ClusterResourcePlacementAvailable**: Indicates the resource is available.

    If false, see [How to debug ClusterResourcePlacementAvailable condition status set to false]().

## FAQ

### How can I debug when some clusters aren't selected as expected?

Check the status of the `ClusterSchedulingPolicySnapshot` to determine which clusters were selected and the reason for their selection.

### How can I debug when a selected cluster that doesn't have the expected resources or if ClusterResourcePlacement doesn't pick up the latest changes?

1. Verify if the `ClusterResourcePlacementRolloutStarted` condition in the `ClusterResourcePlacement` status is set to true or false.
    - If false, see [How to debug ClusterResourcePlacementScheduled condition status set to false]().
    - If true, proceed to step 2.
2. Verify if the `ClusterResourcePlacementApplied` condition is set to **unknown**, **false**, or **true**.
    - If **unknown**, wait as the resources are still being applied to the member cluster. If the state remains unknown for a while, create a GitHub issue, as this is an unusual behavior.
    - If **false**, see [How to debug ClusterResourcePlacementApplied condition status set to false]().
    - If **true**, verify if the resource exists on the hub cluster.
3. Check the `placementStatuses` section in the `ClusterResourcePlacement` status for the particular cluster. The `ailedPlacements` section should provide reasons for any resource application failures.

### How to find and verify the latest ClusterSchedulingPolicySnapshot for a ClusterResourcePlacement deployment?

To find the latest `ClusterSchedulingPolicySnapshot` for the `ClusterResourcePlacement` API deployment, run the following command. Replace `{CRPName}` in the following command with your `ClusterResourcePlacement` name.

    ```bash
    kubectl get clusterschedulingpolicysnapshot -l kubernetes-fleet.io/is-latest-snapshot=true,kubernetes-fleet.io/parent-CRP={CRPName}
    ```

And then:

1. Compare the `ClusterSchedulingPolicySnapshot` with the `ClusterResourcePlacement` policy to ensure they match, excluding the `numberOfClusters` field from the `ClusterResourcePlacement spec. 
1. If the placement type is `PickN`, check if the number of clusters requested in the `ClusterResourcePlacement` policy matches the value for the label called number-of-clusters.

### How to find the latest ClusterResourceBinding resource?

The following command lists all `ClusterResourceBindings` associated with `ClusterResourcePlacement`. Replace `{CRPName}` in the following command with your `ClusterResourcePlacement` name.

    ```bash
    Kubectl get clusterresourcebinding -l kubernetes-fleet.io/parent-CRP={CRPName}
    ```

**Example**

1. Run the folllwing to view the status of the `ClusterResourcePlacement` deployment. In this case, the `ClusterResourcePlacement` name is called **test-crp**:

    ```bash
    kubectl describe clusterresourceplacement test-crp
    ```

2. Here's an example output. From the `placementStatuses` section of the `test-crp` status, observe that it has been propagated resources to two member clusters and hence has two `ClusterResourceBindings`,

    ```output
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

3. Run the following commanad to get the `ClusterResourceBindings`:

```bash
kubectl get clusterresourcebinding -l kubernetes-fleet.io/parent-CRP=test-crp 
```

```output
NAME                               WORKCREATED   RESOURCESAPPLIED   AGE
test-crp-kind-cluster-1-be990c3e   True          True               33s
test-crp-kind-cluster-2-ec4d953c   True          True               33s
```

The output lists all `ClusterResourceBindings` associated with `test-crp`. The `ClusterResourceBinding` resource name follows this format `{CRPName}-{clusterName}-{suffix}`.

### How to find the latest ClusterResourceSnapshot resource?

To find the latest ClusterResourceSnapshot resource, run the following command. Replace `{CRPName}` in the following command with your `ClusterResourcePlacement` name.

```bash
kubectl get clusterresourcesnapshot -l kubernetes-fleet.io/is-latest-snapshot=true,kubernetes-fleet.io/parent-CRP={CRPName}
```

### How and where to find the correct Work resource?

To find the correct Work resource

Record the member cluster's namespace, which follows this format `fleet-member-{clusterName}` and `ClusterResourcePlacement` name `{CRPName}`.

```bash
kubectl get work -n fleet-member-{clusterName} -l kubernetes-fleet.io/parent-CRP={CRPName}
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]