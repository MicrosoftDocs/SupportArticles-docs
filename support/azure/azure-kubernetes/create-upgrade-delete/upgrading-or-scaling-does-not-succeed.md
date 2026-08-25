---
title: Troubleshoot cluster upgrading and scaling errors
description: Learn how to troubleshoot Azure Kubernetes Service (AKS) cluster upgrade and scaling errors, identify failed operations, and complete cluster changes.
ms.date: 08/24/2026
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, v-leedennis, shuyingqin, pihe
ms.service: azure-kubernetes-service
ai-usage: ai-assisted
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot errors so that I can successfully upgrade or scale an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool), innovation-engine
---

# Troubleshoot cluster upgrading and scaling errors

## Summary

This article discusses how to troubleshoot errors that occur when you try to upgrade or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- Azure CLI version 2.85.0 or later installed and signed in to the subscription that contains the AKS cluster. For installation instructions, see [Install the Azure CLI](/cli/azure/install-azure-cli).
- Permission to read the AKS cluster, node pools, operations, and Azure activity log.
- `kubectl` access to the cluster if cluster autoscaler or node auto-provisioning (NAP) controls the scaling.
- To query cluster autoscaler control plane logs, an Azure Monitor diagnostic setting that sends the `cluster-autoscaler` log category to a Log Analytics workspace. For more information, see [Configure resource log collection for the AKS control plane](/azure/aks/monitor-aks#aks-control-plane-resource-logs) and [Diagnostic settings in Azure Monitor](/azure/azure-monitor/platform/diagnostic-settings#methods-for-creating-a-diagnostic-setting).

## Identify the failed or active operation

First, identify whether the upgrade or scale operation targets the managed cluster or a node pool. Then, retrieve the operation status and error details.

### [Azure CLI](#tab/azure-cli)

1. Check the managed cluster state and node provisioning mode:

    ```azurecli
    az aks show \
        --resource-group <resource-group-name> \
        --name <cluster-name> \
        --query "{ProvisioningState:provisioningState, PowerState:powerState.code, NodeProvisioningMode:nodeProvisioningProfile.mode}" \
        --output table
    ```

1. If the operation targets a node pool, check the node pool state:

    ```azurecli
    az aks nodepool show \
        --resource-group <resource-group-name> \
        --cluster-name <cluster-name> \
        --name <node-pool-name> \
        --query "{ProvisioningState:provisioningState, PowerState:powerState.code, PoolType:typePropertiesType, Count:count, AutoscalerEnabled:enableAutoScaling, MinCount:minCount, MaxCount:maxCount}" \
        --output table
    ```

    For a `VirtualMachines` pool, inspect its scale profiles and individual VMs by using the Machine API:

    ```azurecli
    az aks nodepool show \
        --resource-group <resource-group-name> \
        --cluster-name <cluster-name> \
        --name <node-pool-name> \
        --query "{ScaleProfiles:virtualMachinesProfile.scale, CurrentNodes:virtualMachineNodesStatus}" \
        --output json

    az aks machine list \
        --resource-group <resource-group-name> \
        --cluster-name <cluster-name> \
        --nodepool-name <node-pool-name> \
        --output table
    ```

    If the issue is controller-managed scaling, use [Cluster autoscaler](#cluster-autoscaler) when `AutoscalerEnabled` is `true` or the Virtual Machines pool has an autoscale profile. Use [Node auto-provisioning](#node-auto-provisioning) when `NodeProvisioningMode` is `Auto`. Otherwise, continue to the next step.

1. Inspect the latest AKS operation to determine its status and error details. The `az aks operation show-latest` command requires the `aks-preview` extension. Install or update the extension before you run the command:

    ```azurecli
    az extension add --name aks-preview --upgrade --yes

    az aks operation show-latest \
        --resource-group <resource-group-name> \
        --name <cluster-name> \
        --query "{OperationId:name, Status:status, StartTime:startTime, EndTime:endTime, Error:error}" \
        --output json
    ```

    For a node pool operation, add `--nodepool-name <node-pool-name>`.

1. If the latest operation doesn't explain the failure, query failed events in the activity log. A request that AKS rejects before it starts might not replace the latest operation. Adjust the `--offset` value to include the attempted operation.

    For a managed cluster operation, set the target resource ID:

    ```azurecli
    TARGET_RESOURCE_ID=$(az aks show \
        --resource-group <resource-group-name> \
        --name <cluster-name> \
        --query id \
        --output tsv)
    ```

    For a node pool operation, set the node pool as the target:

    ```azurecli
    TARGET_RESOURCE_ID=$(az aks nodepool show \
        --resource-group <resource-group-name> \
        --cluster-name <cluster-name> \
        --name <node-pool-name> \
        --query id \
        --output tsv)
    ```

    Then, query the activity log:

    ```azurecli
    az monitor activity-log list \
        --resource-id "$TARGET_RESOURCE_ID" \
        --offset 24h \
        --status Failed \
        --query "[].{Time:eventTimestamp, Operation:operationName.localizedValue, Error:properties.statusMessage, EventId:eventDataId, ActivityLogOperationId:operationId, CorrelationId:correlationId}" \
        --output json
    ```

    Record the error `code`, `subcode`, and `message`, the AKS operation ID, and the activity log event, operation, and correlation IDs.

### [Azure portal](#tab/azure-portal)

1. Check the cluster and agent pool provisioning states by using [Provisioning State Check](../availability-performance/cluster-node-virtual-machine-failed-state.md#provisioning-state-check).
1. Follow [View the activity log for a failed cluster using the Azure portal](../availability-performance/cluster-node-virtual-machine-failed-state.md#view-the-activity-log-for-a-failed-cluster-using-the-azure-portal). Open the failed upgrade or scale event and record the error `code`, `subcode`, and `message`, and the event, operation, and correlation IDs.
1. Use [AKS Diagnose and Solve Problems](/azure/aks/aks-diagnostics#open-aks-diagnose-and-solve-problems) to open the relevant create, upgrade, delete, or scale diagnostic.

---

If Azure Kubernetes Fleet Manager initiated the upgrade, first use the Fleet update run to identify the failed member cluster. Then, use this article to troubleshoot that member's AKS operation. Don't start a separate upgrade directly on the member while its Fleet update run is active. For more information, see [Update Kubernetes and node images across multiple clusters](/azure/kubernetes-fleet/update-orchestration).

## Resolve the operation

### Active or conflicting operation

If the latest operation doesn't have a terminal status (`Succeeded`, `Failed`, or `Canceled`), don't start another upgrade or scale operation until it finishes. AKS blocks a managed-cluster operation while the cluster or any node pool has an active operation. It blocks a node-pool operation while the cluster or that node pool has an active operation.

Use the troubleshooting article that matches the error code:

- For `OperationNotAllowed` that identifies another AKS operation as the blocker, see [Cluster pending operation errors](operationnotallowed.md). If the response has HTTP status 429 or `TooManyRequests` details, use the throttling row in [Failed or rejected operation](#failed-or-rejected-operation).
- For `AKSOperationPreempted` or `AKSOperationPreemptedByDelete`, see [Troubleshoot AKSOperationPreempted errors](../error-codes/aksoperationpreempted-error.md).

If the operation runs longer than expected, review [Abort an AKS long-running operation](/azure/aks/manage-abort-operations) before canceling it. Canceling an operation doesn't roll back changes that AKS already applied.

### Cluster autoscaler or NAP doesn't scale

When cluster autoscaler or NAP manages capacity, an unexpected node count doesn't always mean that an AKS scale operation failed. First, determine whether the controller decided to add or remove a node. If it submitted a change that failed in Azure, use the reported error in [Failed or rejected operation](#failed-or-rejected-operation).

#### Cluster autoscaler

Check the cluster autoscaler events and status:

```bash
kubectl get events --all-namespaces --field-selector source=cluster-autoscaler,reason=NotTriggerScaleUp
kubectl get events --all-namespaces --field-selector source=cluster-autoscaler,type=Warning
kubectl get configmap --namespace kube-system cluster-autoscaler-status --output yaml
```

In the Azure portal, you can also open **Node pools** and review **Autoscale events**, **Autoscale warnings**, and **Scale-up not triggered**. For control plane log queries, see [Retrieve cluster autoscaler logs and status](/azure/aks/cluster-autoscaler#retrieve-cluster-autoscaler-logs-and-status).

For a **scale-out** issue, confirm that the pool is below its maximum count and that a pending pod can run on a new node from an eligible pool. Use `kubectl describe pod <pod-name> --namespace <namespace>` to check `FailedScheduling` events, resource requests, node selectors, affinity, taints and tolerations, topology requirements, and volume constraints. If the autoscaler requested a node, use the AKS error to check for quota, capacity, subnet IP, or node provisioning failures.

For a **scale-in** issue, confirm that the pool is above its minimum count, the scale-down delays have elapsed, and the node is underutilized. Cluster autoscaler-specific blockers include the `cluster-autoscaler.kubernetes.io/scale-down-disabled: "true"` node annotation and pods that the autoscaler doesn't consider safe or possible to move. See [What types of pods can prevent cluster autoscaler from removing a node?](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-types-of-pods-can-prevent-ca-from-removing-a-node). If the autoscaler starts a node removal but the operation fails, use [Failed or rejected operation](#failed-or-rejected-operation).

Don't manually scale a node pool while cluster autoscaler is enabled. For `Cannot scale cluster autoscaler enabled node pool`, see [Cluster autoscaler can't scale and shows "cannot scale cluster autoscaler enabled node pool" error](cannot-scale-cluster-autoscaler-enabled-node-pool.md). For `Failed to fix node group sizes`, see [Cluster autoscaler fails to scale with "failed to fix node group sizes" error](cluster-autoscaler-fails-to-scale.md).

#### Node auto-provisioning

Check the pending workload and NAP resources:

```bash
kubectl describe pod <pod-name> --namespace <namespace>
kubectl get nodepools.karpenter.sh
kubectl get nodeclaims.karpenter.sh
```

When a `NodeClaim` exists, inspect it for either a scale-out or scale-in issue:

```bash
kubectl describe nodeclaim.karpenter.sh <node-claim-name>
```

For a **scale-out** issue, if NAP doesn't create a `NodeClaim`, review the pending pod events and the Kubernetes `NodePool` status, requirements, taints, resource limits, and VM SKU constraints. If it creates a `NodeClaim`, use its conditions and events to determine whether the VM was launched, registered, initialized, and ready, and identify any underlying Azure provisioning error.

For a **scale-in** issue, use the `NODE` column from `kubectl get nodeclaims.karpenter.sh` to identify the `NodeClaim` for the node that remains. Describe the `NodeClaim` and review its conditions and events for a disruption or termination blocker. If NAP doesn't initiate removal, review the Kubernetes `NodePool` disruption policy, disruption budgets, and consolidation settings together with PDBs and workloads that can't move.

If NAP doesn't initiate the expected capacity change, see [Troubleshoot node auto-provisioning in AKS](../extensions/troubleshoot-node-auto-provision.md). If NAP initiates the change but the Azure operation fails, use [Failed or rejected operation](#failed-or-rejected-operation).

### Failed or rejected operation

If the operation, provisioning state, or activity log event reports a failure, use the error code and message to select the appropriate resolution. Some operations return a wrapper error, such as `UpgradeVMSSAgentPoolFailed` or `ScaleVMSSAgentPoolFailed`. When a subcode or details are available, use the more specific error.

| Error or symptom | Resolution |
| --- | --- |
| `TooManyRequests`, `Throttled`, `SubscriptionRequestsThrottled`, or `OperationNotAllowed` with HTTP status 429 or throttling details | Honor the `Retry-After` interval and reduce the request rate before retrying. See [Troubleshoot SubscriptionRequestsThrottled error code (429)](error-code-subscriptionrequeststhrottled.md). To identify throttling by source, user agent, and operation in the portal, see [Analyze and identify errors by using AKS Diagnose and Solve Problems](429-too-many-requests-errors.md#analyze-and-identify-errors-by-using-aks-diagnose-and-solve-problems). |
| `ReconcileMachineFailed`, a `VirtualMachines` node pool or one of its individual VMs doesn't reach its desired state, or the request reports an invalid scale profile | Check the node pool's manual or autoscale profiles and use `az aks machine list` or `az aks machine show` to identify the affected VM. See [Virtual Machines node pools in AKS](/azure/aks/virtual-machines-node-pools) and [az aks machine](/cli/azure/aks/machine). |
| `InvalidParameter`, `ValidationError`, `AgentPoolUpgradeVersionNotAllowed`, a version incompatibility, or an unsupported configuration | Correct the value or combination identified in the error. For upgrades, check the [Kubernetes version upgrade rules](/azure/aks/upgrade-aks-control-plane#kubernetes-version-upgrade-rules) and [available node images](/azure/aks/upgrade-node-image). Don't retry the same invalid request. |
| `QuotaExceeded`, `ResourceGroupQuotaExceeded`, `PublicIPCountLimitReached`, or another quota error | Check which resource reached its limit. An upgrade can require temporary surge capacity. See [Troubleshoot the QuotaExceeded error code](../error-codes/quota-exceeded-error.md) and [Troubleshoot the PublicIPCountLimitReached error code](../error-codes/publicipcountlimitreached-error.md). |
| `SubnetIsFull` or insufficient IP addresses | [Troubleshoot the SubnetIsFull error code](../error-codes/subnetisfull-error.md). Check the affected node pool's subnet and account for upgrade surge capacity. |
| `AllocationFailed`, `ZonalAllocationFailed`, `SkuNotAvailable`, `OverconstrainedAllocationRequest`, or `OverconstrainedZonalAllocationRequest` | [Troubleshoot ZonalAllocationFailed or AllocationFailed errors](../error-codes/zonalallocation-allocationfailed-error.md). Regional capacity, SKU or zone availability, and subscription quota are different constraints. |
| `InvalidLoadBalancerProfileAllocatedOutboundPorts` | The node count, allocated outbound ports per node, and number of outbound IPs don't provide enough SNAT ports. Include upgrade surge nodes in the calculation. See [InvalidLoadBalancerProfileAllocatedOutboundPorts error code](error-code-invalidloadbalancerprofileallocatedoutboundports.md). |
| `UpgradeFailed`, `PodDrainFailure`, `UnsatisfiablePDB`, a pod eviction that returns `Too Many Requests`, or another node drain or eviction failure | A restrictive PDB, a pod that doesn't terminate, an admission webhook, or the drain timeout can block an upgrade, manual scale-in, or controller-managed scale-in. Review the affected pod and drain details in the error. See [Troubleshoot UpgradeFailed errors due to eviction failures caused by PDBs](error-code-poddrainfailure.md) and [Troubleshoot the UnsatisfiablePDB error code](../error-codes/unsatisfiablepdb-error.md). |
| `UpgradeBlockedOnDeprecatedAPIUsage` | [Mitigate stopped upgrade operations due to deprecated APIs](/azure/aks/stop-cluster-upgrade-api-breaking-changes#mitigate-stopped-upgrade-operations). Migrate from deprecated APIs instead of bypassing validation whenever possible. |
| `AgentCountNotMatch` | Compare the expected and actual VM counts reported in the error, and check which controller owns scaling. During upgrade surge, Azure Monitor Autoscale or another system that changes VM scale set capacity outside AKS can interfere with the operation. Disable competing VM scale set autoscale automation, and use AKS cluster autoscaler or another AKS-compatible autoscaling component. If no competing scaler exists or the error persists, collect the operation details and contact Azure support. |
| `NodesNotReady` or `UpgradeNodesNotRegistered` | Identify the affected node or newly created upgrade node. Then, check its provisioning, registration, and readiness errors. See [Basic troubleshooting of Node Not Ready failures](/troubleshoot/azure/azure-kubernetes/availability-performance/node-not-ready-basic-troubleshooting) and the VM extension errors in the next row. |
| `VMExtensionProvisioningError`, `OutboundConnFailVMExtensionError`, `K8SAPIServerConnFailVMExtensionError`, `K8SAPIServerDNSLookupFailVMExtensionError`, or a message that contains `VMExtensionError_VHDFileNotFound` | Use the specific VM extension error or message to troubleshoot node bootstrap, outbound connectivity, API server connectivity, DNS, or image download. See [OutboundConnFailVMExtensionError](error-code-outboundconnfailvmextensionerror.md), [K8SAPIServerConnFailVMExtensionError](error-code-k8sapiserverconnfailvmextensionerror.md), [K8SAPIServerDNSLookupFailVMExtensionError](error-code-k8sapiserverdnslookupfailvmextensionerror.md), or [ERR_VHD_FILE_NOT_FOUND](error-code-vhdfilenotfound.md). |
| `RequestDisallowedByPolicy`, `ResourceLocked`, `ScopeLocked`, or `InvalidResourceReference` | Correct the policy assignment, remove the blocking management lock, or restore the missing or modified dependency before retrying. See [RequestDisallowedByPolicy error with Azure Policy](../error-codes/requestdisallowedbypolicy-error.md), [Lock Azure resources to protect your infrastructure](/azure/azure-resource-manager/management/lock-resources), and [Troubleshoot the InvalidResourceReference error code](error-code-invalidresourcereference.md). |
| `AuthorizationFailed`, `LinkedAuthorizationFailed`, or an identity or role-assignment error | Grant the principal or object ID identified in the error the required action on the specified scope. See [Resolve the LinkedAuthorizationFailed error](../error-codes/linkedauthorizationfailed-error.md). |
| `InternalOperationError`, `ServiceUnavailable`, or `TimedoutOrCancelled` without an actionable underlying error | Verify that no operation is still active and check the target's current state. If `kubectl` requests also time out, have high latency, or repeatedly return HTTP 429 or 5xx responses, use the AKS diagnostics and see [Troubleshoot API server and etcd problems in AKS](troubleshoot-apiserver-etcd.md). Otherwise, retry once. If the error persists, collect the operation and correlation IDs and create a support request. |

## Retry and verify

After you address the specific error identified in the AKS operation or activity log, retry or verify the operation through the controller that owns it:

- For a direct AKS upgrade or manual scale, retry the same operation once.
- For cluster autoscaler, verify that it adds a node for eligible pending workload demand or removes an eligible underutilized node, within the configured range and delays.
- For NAP, verify that it creates a ready `NodeClaim` for scale-out or removes an eligible node for scale-in. Don't replace the NAP workflow with `az aks nodepool scale`.
- For a `VirtualMachines` node pool, verify the intended scale profiles and the individual VM states returned by the Machine API.
- For a Fleet-initiated upgrade, retry and monitor it through the Fleet update run.

Run the state checks from [Identify the failed or active operation](#identify-the-failed-or-active-operation). For a direct AKS operation, the target cluster or node pool should have a `Succeeded` provisioning state, and the latest operation should have a `Succeeded` status. Also verify the intended outcome, such as the target Kubernetes version, node count, scale profile, or controller-managed capacity change.

If it still fails but reports a different error or symptom, troubleshoot the new result.
