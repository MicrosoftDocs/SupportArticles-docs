---
title: Troubleshooting ClusterResourcePlacement API in Azure Kubernetes Fleet Manager
description: Helps you resolve ClusterResourcePlacement-related issues when you use Azure Kubernetes Fleet Manager APIs.
ms.date: 08/05/2024
ms.reviewer: zhangryan, chiragpa, shasb, ericlucier, arfallas, sachidesai
ms.service: azure-kubernetes-fleet-manager
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Troubleshooting ClusterResourcePlacement API in Azure Kubernetes Fleet Manager

This troubleshooting guide helps you resolve `ClusterResourcePlacement` API object-related issues when you use Azure Kubernetes Fleet Manager. Troubleshooting these errors on the hub cluster requires knowledge of the following objects:

- `ClusterResourceSnapshot`
- `ClusterSchedulingPolicySnapshot`
- `ClusterResourceBinding`
- `Work`

For more details about each object, see the [KubeFleet API reference](https://kubefleet-dev.github.io/website/docs/api-reference/).

## Complete progression of the ClusterResourcePlacement deployment

Understanding the progression and status of the `ClusterResourcePlacement` custom resource is crucial for diagnosing and identifying failures. You can view the status of the `ClusterResourcePlacement` custom resource by using the following command:

```bash
kubectl describe clusterresourceplacement <name>
```

For more information, see [Use the ClusterResourcePlacement API to propagate resources to member clusters](/azure/kubernetes-fleet/quickstart-resource-propagation#use-the-clusterresourceplacement-api-to-propagate-resources-to-member-clusters).

The complete progression of `ClusterResourcePlacement` is as follows:

1. **ClusterResourcePlacementScheduled**: Indicates that a resource has been scheduled for placement.

    If false, see [How to troubleshoot when the ClusterResourcePlacementScheduled condition status is false](crp-clusterresourceplacementscheduled-false.md).
1. **ClusterResourcePlacementRolloutStarted**: Indicates that the rollout process has begun.

    If false, see [How to troubleshoot when the ClusterResourcePlacementRolloutStarted condition status is false](crp-clusterresourceplacementrolloutstarted-false.md).
1. **ClusterResourcePlacementOverridden**: Indicates that the resource has been overridden.

    If false, see [How to troubleshoot when the ClusterResourcePlacementOverridden condition status is false](crp-clusterresourceplacementoverridden-false.md).
1. **ClusterResourcePlacementWorkSynchronized**: Indicates that work objects were synchronized.

    If false, see [How to troubleshoot when the ClusterResourcePlacementWorkSynchronized condition status is false](crp-clusterresourceplacementworksynchronized-false.md).
1. **ClusterResourcePlacementApplied**: Indicates the resource was applied.

    If false, see [How to troubleshoot when the ClusterResourcePlacementApplied condition status is false](crp-clusterresourceplacementapplied-false.md).
1. **ClusterResourcePlacementAvailable**: Indicates that the resource is available.

    If false, see [How to troubleshoot when the ClusterResourcePlacementAvailable condition status is false](crp-clusterresourceplacementavailable-false.md).

## FAQ

### How can I debug if some clusters aren't selected as expected?

Check the status of `ClusterSchedulingPolicySnapshot` to determine which clusters were selected and the reason for their selection.

### How can I debug if a selected cluster doesn't have the expected resources or if ClusterResourcePlacement doesn't pick up the latest changes?

1. Check whether the `ClusterResourcePlacementRolloutStarted` condition in the `ClusterResourcePlacement` status is set to **true** or **false**.
    - If **false**, see [How to debug ClusterResourcePlacementScheduled condition status set to false]().
    - If **true**, go to step 2.
2. Check whether the `ClusterResourcePlacementApplied` condition is set to **unknown**, **false**, or **true**.
    - If **unknown**, wait for the process to finish because the resources are still being applied to the member cluster. If the status remains **unknown** for a while, open an [issue](https://github.com/Azure/fleet/issues) because this is unusual behavior.
    - If **false**, see [How to debug ClusterResourcePlacementApplied condition status set to false]().
    - If **true**, verify that the resource exists on the hub cluster.
3. Check the `placementStatuses` section in the `ClusterResourcePlacement` status for the particular cluster. The `FailedPlacements` section should provide reasons for any resource application failures.

### How can I find and verify the latest ClusterSchedulingPolicySnapshot for a ClusterResourcePlacement deployment?

To find the latest `ClusterSchedulingPolicySnapshot` for the `ClusterResourcePlacement` API deployment, run the following command:

```bash
kubectl get clusterschedulingpolicysnapshot -l kubernetes-fleet.io/is-latest-snapshot=true,kubernetes-fleet.io/parent-CRP={CRPName}
```

> [!NOTE]
> In this command, replace `{CRPName}` with your `ClusterResourcePlacement` name.

Then, compare the `ClusterSchedulingPolicySnapshot` with the `ClusterResourcePlacement` policy to make sure that they match, excluding the `numberOfClusters` field from the `ClusterResourcePlacement' spec.

If the placement type is `PickN`, check whether the number of clusters that's requested in the `ClusterResourcePlacement` policy matches the value of the `number-of-clusters` label.

### How can I find the latest ClusterResourceBinding resource?

The following command lists all `ClusterResourceBindings` instances that are associated with `ClusterResourcePlacement`:

```bash
Kubectl get clusterresourcebinding -l kubernetes-fleet.io/parent-CRP={CRPName}
```

> [!NOTE]
> In this command, replace `{CRPName}` with your `ClusterResourcePlacement` name.

**Example**

1. Run the following command to view the status of the `ClusterResourcePlacement` deployment. In this case, the `ClusterResourcePlacement` name is `test-crp`.

    ```bash
    kubectl describe clusterresourceplacement test-crp
    ```

2. Here's an example output. From the `placementStatuses` section of the `test-crp` status, notice that it has distributed resources to two member clusters and, therefore, has two `ClusterResourceBindings` instances:

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

3. To get the `ClusterResourceBindings` value, run the following command:

    ```bash
    kubectl get clusterresourcebinding -l kubernetes-fleet.io/parent-CRP=test-crp 
    ```
    
    ```output
    NAME                               WORKCREATED   RESOURCESAPPLIED   AGE
    test-crp-kind-cluster-1-be990c3e   True          True               33s
    test-crp-kind-cluster-2-ec4d953c   True          True               33s
    ```

    The output lists all `ClusterResourceBindings` instances that are associated with `test-crp`. The `ClusterResourceBinding` resource name uses the following format:

    `{CRPName}-{clusterName}-{suffix}`

### How can I find the latest ClusterResourceSnapshot resource?

To find the latest ClusterResourceSnapshot resource, run the following command:

```bash
kubectl get clusterresourcesnapshot -l kubernetes-fleet.io/is-latest-snapshot=true,kubernetes-fleet.io/parent-CRP={CRPName}
```
<a id="find-work"></a>

> [!NOTE]  
> In this command, replace `{CRPName}` with your `ClusterResourcePlacement` name.

### How can I find the correct work resource that's associated with ClusterResourcePlacement?

To find the correct work resource, follow these steps:

1. Identify the member cluster namespace and the `ClusterResourcePlacement` name. The format for the namespace is `fleet-member-{clusterName}`.
1. To get the work resource, run the following command:
    
    ```bash
    kubectl get work -n fleet-member-{clusterName} -l kubernetes-fleet.io/parent-CRP={CRPName}
    ```

   > [!NOTE]  
   > In this command, replace `{clusterName}` and `{CRPName}` with the names that you identified in the first step.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
