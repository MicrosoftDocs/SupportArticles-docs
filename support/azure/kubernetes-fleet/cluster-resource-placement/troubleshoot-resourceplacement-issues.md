---
title: Troubleshoot Azure Kubernetes Fleet Manager ResourcePlacement
description: Troubleshoot errors that occur when using the ResourcePlacement API in Azure Kubernetes Fleet Manager.
author: weiweng
ms.author: weiweng
ms.service: azure-kubernetes-fleet-manager
ms.date: 12/08/2025
ms.custom: sap:Other issue or questions related to Fleet manager
---

# Troubleshooting ResourcePlacement API in Azure Kubernetes Fleet Manager (preview)

This troubleshooting guide helps you resolve `ResourcePlacement` API object-related issues when you use Azure Kubernetes Fleet Manager. Troubleshooting these errors on the hub cluster requires knowledge of the following objects:

- `ResourceSnapshot`
- `SchedulingPolicySnapshot`
- `ResourceBinding`
- `Work`

For more information about each object, see the [KubeFleet API reference](https://kubefleet-dev.github.io/website/docs/api-reference/).

## Important considerations for ResourcePlacement

### Namespace prerequisites

> [!IMPORTANT]
> ResourcePlacement can only place namespace-scoped resources to clusters that already have the target namespace.

Before creating a ResourcePlacement:

- Ensure the target namespace exists on the member clusters, either:
  - Created by a `ClusterResourcePlacement` using namespace-only mode
  - Preexisting on the member clusters
- If the namespace doesn't exist on a member cluster, the `ResourcePlacement` fails to apply resources to that cluster.

### Coordination with ClusterResourcePlacement

When using both ResourcePlacement and ClusterResourcePlacement together:

- **ClusterResourcePlacement in namespace-only mode**: Use ClusterResourcePlacement to create and manage the namespace itself across clusters.
- **ResourcePlacement for resources**: Use ResourcePlacement to manage specific resources within that namespace.
- **Avoid conflicts**: Ensure that ClusterResourcePlacement and ResourcePlacement don't select the same resources to prevent conflicts.

### Resource scope limitations

ResourcePlacement can only select and manage namespace-scoped resources within the same namespace where the ResourcePlacement object resides:

- ✅ **Supported**: ConfigMaps, Secrets, Services, Deployments, StatefulSets, Jobs, etc. within the ResourcePlacement's namespace
- ❌ **Not Supported**: Cluster-scoped resources (use ClusterResourcePlacement instead)
- ❌ **Not Supported**: Resources in other namespaces

## Complete progression of the ResourcePlacement deployment

Understanding the progression and status of the `ResourcePlacement` custom resource is crucial for diagnosing and identifying failures. You can view the status of the `ResourcePlacement` custom resource by using the following command:

```bash
kubectl describe resourceplacement <name> -n <namespace>
```

For more information, see [Use ResourcePlacement to place namespace-scoped resources](/azure/kubernetes-fleet/quickstart-namespace-scoped-resource-propagation#use-resourceplacement-to-place-namespace-scoped-resources).

The complete progression of `ResourcePlacement` is as follows:

1. **ResourcePlacementScheduled**: Indicates that a resource is scheduled for placement.

    If false, see [How to troubleshoot when the ClusterResourcePlacementScheduled condition status is false](crp-clusterresourceplacementscheduled-false.md).

    > [!NOTE]
    > ResourcePlacement and ClusterResourcePlacement share the same underlying architecture with a one-to-one mapping of condition types. The troubleshooting approaches documented in the ClusterResourcePlacement troubleshooting guides are applicable to ResourcePlacement as well. The main difference is that ResourcePlacement is namespace-scoped and works with namespace-scoped resources, while ClusterResourcePlacement is cluster-scoped.

2. **ResourcePlacementRolloutStarted**: Indicates that the rollout process started.

    If false, see [How to troubleshoot when the ClusterResourcePlacementRolloutStarted condition status is false](crp-clusterresourceplacementrolloutstarted-false.md).

3. **ResourcePlacementOverridden**: Indicates that the resource is overridden.

    If false, see [How to troubleshoot when the ClusterResourcePlacementOverridden condition status is false](crp-clusterresourceplacementoverridden-false.md).

4. **ResourcePlacementWorkSynchronized**: Indicates that work objects are synchronized.

    If false, see [How to troubleshoot when the ClusterResourcePlacementWorkSynchronized condition status is false](crp-clusterresourceplacementworksynchronized-false.md).

5. **ResourcePlacementApplied**: Indicates the resource is applied. This condition is only populated if the applied strategy type is `ClientSideApply` (default) or `ServerSideApply`.

    If false, see [How to troubleshoot when the ClusterResourcePlacementApplied condition status is false](crp-clusterresourceplacementapplied-false.md).

6. **ResourcePlacementAvailable**: Indicates that the resource is available. This condition is only populated if the applied strategy type is `ClientSideApply` (default) or `ServerSideApply`.

    If false, see [How to troubleshoot when the ClusterResourcePlacementAvailable condition status is false](crp-clusterresourceplacementavailable-false.md).

7. **ResourcePlacementDiffReported**: Indicates whether diff reporting completes on all resources. This condition is only populated if the applied strategy type is `ReportDiff`.

    For troubleshooting diff reporting issues, see the ClusterResourcePlacement troubleshooting guides and substitute the appropriate ResourcePlacement condition names.

> [!NOTE]
> The condition types follow a naming convention where ResourcePlacement conditions use the `ResourcePlacement` prefix while ClusterResourcePlacement conditions use the `ClusterResourcePlacement` prefix. For example:
>
> - `ResourcePlacementScheduled` ↔ `ClusterResourcePlacementScheduled`
> - `ResourcePlacementApplied` ↔ `ClusterResourcePlacementApplied`
> - `ResourcePlacementAvailable` ↔ `ClusterResourcePlacementAvailable`
>
> When following ClusterResourcePlacement troubleshooting guidance, substitute the appropriate ResourcePlacement condition names and commands (for example, use `kubectl get resourceplacement -n <namespace>` instead of `kubectl get clusterresourceplacement`).

## FAQ

### How can I debug if some clusters aren't selected as expected?

Check the status of `SchedulingPolicySnapshot` to determine which clusters the scheduler selected and the reason for their selection.

To find the latest `SchedulingPolicySnapshot` for a `ResourcePlacement` resource, run the following command:

```bash
kubectl get schedulingpolicysnapshot -n <namespace> -l kubernetes-fleet.io/is-latest-snapshot=true,kubernetes-fleet.io/parent-CRP={RPName}
```

> [!NOTE]
> In this command, replace `{RPName}` with your `ResourcePlacement` name and `<namespace>` with the namespace where the ResourcePlacement exists.

Then, compare the `SchedulingPolicySnapshot` with the `ResourcePlacement` policy to make sure that they match.

### How can I debug if a selected cluster doesn't have the expected resources or if ResourcePlacement doesn't pick up the latest changes?

1. Check whether the `ResourcePlacementRolloutStarted` condition in the `ResourcePlacement` status is set to **true** or **false**.
    - If **false**, the resource placement doesn't start rolling out yet.
    - If **true**, go to step 2.
2. Check whether the `ResourcePlacementApplied` condition is set to **unknown**, **false**, or **true**.
    - If **unknown**, wait for the process to finish because Fleet Manager still applies the resources to the member cluster. If the status remains **unknown** for a while, open an [issue](https://github.com/Azure/fleet/issues) because this status is unusual behavior.
    - If **false**, the resources failed to apply on one or more clusters. Check the `placementStatuses` section in the status for cluster-specific details.
    - If **true**, verify that the resource exists on the hub cluster in the same namespace as the ResourcePlacement.
3. To pinpoint issues on specific clusters, examine the `placementStatuses` section in `ResourcePlacement` status. For each cluster, you can find:
    - The cluster name
    - Conditions specific to that cluster (for example, `Applied`, `Available`)
    - `failedPlacements` section, which lists the resources that failed to apply along with the reasons

### How can I find the latest ResourceBinding resource?

The following command lists all `ResourceBindings` instances associated with `ResourcePlacement`:

```bash
kubectl get resourcebinding -n <namespace> -l kubernetes-fleet.io/parent-CRP={RPName}
```

> [!NOTE]
> In this command, replace `{RPName}` with your `ResourcePlacement` name and `<namespace>` with the namespace where the ResourcePlacement exists.

**Example**

1. Run the following command to view the status of the `ResourcePlacement` deployment. In this case, the `ResourcePlacement` name is `test-rp` in namespace `test-ns`.

    ```bash
    kubectl describe resourceplacement test-rp -n test-ns
    ```

2. Here's an example output:

    ```output
    Status:
      Conditions:
        Last Transition Time:   2025-11-13T22:25:45Z
        Message:                found all cluster needed as specified by the scheduling policy, found 2 cluster(s)
        Observed Generation:    2
        Reason:                 SchedulingPolicyFulfilled
        Status:                 True
        Type:                   ResourcePlacementScheduled
        Last Transition Time:   2025-11-13T22:25:45Z
        Message:                All 2 cluster(s) start rolling out the latest resource
        Observed Generation:    2
        Reason:                 RolloutStarted
        Status:                 True
        Type:                   ResourcePlacementRolloutStarted
        ...
      Placement Statuses:
        Cluster Name:  kind-cluster-1
        Conditions:
          Last Transition Time:   2025-11-13T22:25:45Z
          Message:                Successfully scheduled resources for placement in "kind-cluster-1"
          Status:                 True
          Type:                   Scheduled
          ...
        Cluster Name:             kind-cluster-2
        Conditions:
          ...
      Selected Resources:
        Kind:       ConfigMap
        Name:       app-config
        Namespace:  test-ns
        Version:    v1
    ```

    From the `placementStatuses` section of the `test-rp` status, notice that it distributed resources to two member clusters and, therefore, has two `ResourceBindings` instances.

3. To get the `ResourceBindings` value, run the following command:

    ```bash
    kubectl get resourcebinding -n test-ns -l kubernetes-fleet.io/parent-CRP=test-rp 
    ```
    
    ```output
    NAME                              WORKSYNCHRONIZED   RESOURCESAPPLIED   AGE
    test-rp-kind-cluster-1-be990c3e   True               True               33s
    test-rp-kind-cluster-2-ec4d953c   True               True               33s
    ```

    The output lists all `ResourceBindings` instances associated with `test-rp`. The `ResourceBinding` resource name uses the following format:

    `{RPName}-{clusterName}-{suffix}`

    Find the `ResourceBinding` for the target cluster you're looking for based on the `clusterName`.

### How can I find the latest ResourceSnapshot resource?

To find the latest ResourceSnapshot resource, run the following command:

```bash
kubectl get resourcesnapshot -n <namespace> -l kubernetes-fleet.io/is-latest-snapshot=true,kubernetes-fleet.io/parent-CRP={RPName}
```

> [!NOTE]
> In this command, replace `{RPName}` with your `ResourcePlacement` name and `<namespace>` with the namespace where the ResourcePlacement exists.

### How can I find the correct work resource associated with ResourcePlacement?

To find the correct work resource, follow these steps:

1. Identify the member cluster namespace and the `ResourcePlacement` name. The format for the namespace is `fleet-member-{clusterName}`.
2. To get the work resource, run the following command:
    
    ```bash
    kubectl get work -n fleet-member-{clusterName} -l kubernetes-fleet.io/parent-CRP={RPName}
    ```

   > [!NOTE]
   > In this command, replace `{clusterName}` and `{RPName}` with the names that you identified in the first step.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
