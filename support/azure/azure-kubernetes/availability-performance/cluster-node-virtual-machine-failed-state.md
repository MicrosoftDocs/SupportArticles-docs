---
title: Troubleshoot AKS upgrade, scaling, and failed-state errors
description: Troubleshoot AKS upgrade, scaling, and failed-state errors. Follow these steps to resolve failed cluster or node pool provisioning and restore service.
ms.date: 09/15/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, schaffererin, v-weizhu, v-six, shuyingqin
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to identify and resolve upgrade, scaling, or failed-state errors so that I can restore my AKS cluster.
ms.custom: sap:Node/node pool availability and performance, innovation-engine
ai-usage: ai-assisted
---

# Troubleshoot AKS upgrade, scaling, and failed-state errors

## Summary

Use this article to troubleshoot failed Azure Kubernetes Service (AKS) upgrades or scaling operations, or a cluster or node pool with a `Failed` provisioning state. Start by finding the error for the affected resource, then follow the matching resolution. In AKS APIs and this article, a node pool is also called an *agent pool*.

## Prerequisites

- For the CLI steps, Azure CLI version 2.85.0 or later, signed in to the subscription that contains the AKS cluster. See [Install the Azure CLI](/cli/azure/install-azure-cli).
- The `aks-preview` Azure CLI extension, which is required for `az aks operation show-latest` and `az aks kollect`. Install or update the extension by running `az extension add --name aks-preview --upgrade --yes`.
- Permission to read the AKS cluster, agent pools, and operations.
- For the `kubectl` checks, `kubectl` installed, network access to the cluster's Kubernetes API, and permission to read the nodes, pods, events, ConfigMaps, and node auto-provisioning (NAP) resources used in those checks.
- To query the Azure activity log, the `Microsoft.Insights/eventtypes/values/read` permission at the applicable scope. The built-in **Monitoring Reader** and **Reader** roles include this permission. For more information, see [Roles, permissions, and security in Azure Monitor](/azure/azure-monitor/fundamentals/roles-permissions-security)
- To query cluster autoscaler control plane logs, an Azure Monitor diagnostic setting that sends the `cluster-autoscaler` log category to a Log Analytics workspace. For more information, see [Configure resource log collection for the AKS control plane](/azure/aks/monitor-aks#aks-control-plane-resource-logs) and [Diagnostic settings in Azure Monitor](/azure/azure-monitor/platform/diagnostic-settings#methods-for-creating-a-diagnostic-setting).

## Identify the failed resource or operation

First, identify whether the failure affects the cluster, an AKS agent pool, or nodes managed by NAP. Then, check the operation details for the error.

### [Azure CLI](#tab/azure-cli)

1. **Check the cluster state and operation owner.**

    ```azurecli
    az aks show \
        --resource-group <resource-group-name> \
        --name <cluster-name> \
        --query "{ProvisioningState:provisioningState, PowerState:powerState.code, NodeProvisioningMode:nodeProvisioningProfile.mode, AutoUpgradeChannel:autoUpgradeProfile.upgradeChannel, NodeOSUpgradeChannel:autoUpgradeProfile.nodeOSUpgradeChannel}" \
        --output table
    ```

    For upgrades, compare the time of the failure with the [cluster](/azure/aks/auto-upgrade-cluster) and [node OS](/azure/aks/auto-upgrade-node-os-image) auto-upgrade settings and [maintenance schedules](/azure/aks/planned-maintenance). An enabled channel alone doesn't tell you what started a particular upgrade.

    If `NodeProvisioningMode` is `Auto` and NAP-managed capacity is affected, skip step 2 and use [NAP troubleshooting](#scenario-3-nap-managed-capacity-or-node-failure). Step 2 still applies to a traditional AKS system agent pool on that cluster.

2. **If an AKS agent pool is affected, check its state and scaling configuration.**

    ```azurecli
    az aks nodepool show \
        --resource-group <resource-group-name> \
        --cluster-name <cluster-name> \
        --name <node-pool-name> \
        --query "{ProvisioningState:provisioningState, PowerState:powerState.code, PoolType:typePropertiesType, Count:count, AutoscalerEnabled:enableAutoScaling, MinCount:minCount, MaxCount:maxCount}" \
        --output table
    ```

    For `PoolType = VirtualMachines`, also check its scale profiles and node status.

    ```azurecli
    az aks nodepool show \
        --resource-group <resource-group-name> \
        --cluster-name <cluster-name> \
        --name <node-pool-name> \
        --query "{ScaleProfiles:virtualMachinesProfile.scale, CurrentNodes:virtualMachineNodesStatus}" \
        --output json
    ```

    If you're investigating unexpected scaling on a pool with `AutoscalerEnabled` set to `true` or with an autoscale profile, use [Scenario 2: Cluster autoscaler doesn't scale](#scenario-2-cluster-autoscaler-doesnt-scale). For a failed upgrade or another AKS operation, continue below even if autoscaling is enabled.

3. **Retrieve the latest AKS operation and error.**

    ```azurecli
    az aks operation show-latest \
        --resource-group <resource-group-name> \
        --name <cluster-name> \
        --query "{OperationId:name, Status:status, StartTime:startTime, EndTime:endTime, Error:error}" \
        --output json
    ```

    For an AKS agent pool operation, add `--nodepool-name <node-pool-name>`. Don't use this parameter for a NAP Kubernetes `NodePool`. Check that the operation's timestamps match the failed attempt; a later operation might have replaced it as the latest result.
    
    For more information, see [az aks operation](/cli/azure/aks/operation).

4. **If the operation doesn't explain the failure, check the activity log.**

    Rejected requests might not appear as the latest operation. `<target-resource-id>` is the full Azure Resource Manager (ARM) ID of the resource whose activity log you want to query, not the AKS operation ID.

    For a cluster operation, get the cluster resource ID.

    ```azurecli
    az aks show \
        --resource-group <resource-group-name> \
        --name <cluster-name> \
        --query id --output tsv
    ```

    For an agent-pool operation, get that pool's resource ID.

    ```azurecli
    az aks nodepool show \
        --resource-group <resource-group-name> \
        --cluster-name <cluster-name> \
        --name <node-pool-name> \
        --query id --output tsv
    ```

    Replace `<target-resource-id>` in the following commands with the ID for the affected resource. For the backing-compute checks later in this article, use the VM or VMSS instance resource ID instead. Adjust `--offset` to include the failed attempt.

    ```azurecli
    az monitor activity-log list \
        --resource-id <target-resource-id> \
        --offset 24h \
        --status Failed \
        --query "[].{Time:eventTimestamp, Operation:operationName.localizedValue, Caller:caller, Error:properties.statusMessage, EventId:eventDataId, ActivityLogOperationId:operationId, CorrelationId:correlationId}" \
        --output json
    ```

    Record the caller, error `code`, `subcode`, and `message`, the AKS operation ID, and the activity log event, operation, and correlation IDs.

### [Azure portal](#tab/azure-portal)

1. On the AKS cluster page, select **Diagnose and solve problems**, and then select **Provisioning State Check**. Review the cluster and agent pool provisioning states.

    :::image type="content" source="media/cluster-node-virtual-machine-failed-state/provision-state-check.png" alt-text="Screenshot of the Provisioning State Check option for an AKS cluster." lightbox="media/cluster-node-virtual-machine-failed-state/provision-state-check.png":::

    Also open the diagnostic that matches the failed create, upgrade, delete, or scale operation.

    :::image type="content" source="media/cluster-node-virtual-machine-failed-state/diagnose-solve-problems-solutions.png" alt-text="Screenshot of solutions in Diagnose and Solve Problems for an AKS cluster." lightbox="media/cluster-node-virtual-machine-failed-state/diagnose-solve-problems-solutions.png":::

2. If the issue affects an AKS agent pool, open **Node pools** and check its state and autoscale configuration. For NAP-managed capacity, use [Scenario 3: NAP-managed capacity or node failure](#scenario-3-nap-managed-capacity-or-node-failure).

3. For an upgrade issue, review the configured cluster and node OS auto-upgrade channels and planned maintenance schedules.

4. On the AKS cluster page, select **Activity log**. Set **Status** to **Failed**, and adjust the timespan to include the attempted operation.

    :::image type="content" source="media/cluster-node-virtual-machine-failed-state/filter-events.png" alt-text="Screenshot of filters for failed events in the activity log." lightbox="media/cluster-node-virtual-machine-failed-state/filter-events.png":::

5. Open the failed upgrade, scale, or update event. Review the event summary and JSON data, and record the caller, error `code`, `subcode`, and `message`, and the event, operation, and correlation IDs.

    :::image type="content" source="media/cluster-node-virtual-machine-failed-state/json-data.png" alt-text="Screenshot of activity log JSON data that contains status message details for a failed operation." lightbox="media/cluster-node-virtual-machine-failed-state/json-data.png":::

---

If you don't know what started the upgrade, check whether the cluster belongs to Azure Kubernetes Fleet Manager. In the Azure portal, search for **Kubernetes Fleet Manager**, open the relevant Fleet resource, and check **Member clusters** and **Update runs**. The AKS operation caller alone doesn't reliably identify a Fleet-initiated upgrade. If Fleet started it, use the update run to find the failed member, then troubleshoot that member's AKS error here. Don't start a separate upgrade on the member while the Fleet run is active. See [Update Kubernetes and node images across multiple clusters](/azure/kubernetes-fleet/update-orchestration).

### Collect supporting node diagnostics

For node registration, readiness, or bootstrap problems, check the node as well as the Azure operation.

For an affected node that registers with Kubernetes, run the following command.

```bash
kubectl get node <node-name> --output wide
kubectl describe node <node-name>
```

Look for reasons, messages, and timestamps in **Conditions** and **Events**. For more details, check the node logs:

- For kubelet or registration problems, see [Get kubelet logs from AKS nodes](/azure/aks/kubelet-logs).
- For Linux provisioning or CSE failures, review `/var/log/azure/cluster-provision.log` for errors from the provisioning script. Also check the Azure Linux Agent log at `/var/log/waagent.log` and extension logs under `/var/log/azure/`. See [Troubleshoot Node Not Ready failures caused by CSE errors](node-not-ready-custom-script-extension-errors.md) and [Troubleshoot Linux VM extensions](/azure/virtual-machines/extensions/features-linux#troubleshoot-vm-extensions) for general diagnostic guidance.

If the node doesn't register, `kubectl describe node` can't retrieve it. Use the Azure provisioning and VM extension errors instead. For a NAP node, also inspect its `NodeClaim` as described in [NAP troubleshooting](#scenario-3-nap-managed-capacity-or-node-failure). For broader log collection, see [Additional logging and diagnostic tools](#use-additional-logging-and-diagnostic-tools).

### Inspect backing compute if no specific error is found

If the AKS operation, activity log, and node diagnostics still don't explain the failure, inspect the backing VM or virtual machine scale set instance in the cluster's [node resource group](/azure/aks/core-aks-concepts#node-resource-group). Check its provisioning state, VM extension status, and activity log.

For a `VirtualMachines` agent pool, use [az aks machine list and show](/cli/azure/aks/machine) to identify the machine and its backing VM. For a virtual machine scale sets agent pool, inspect the affected scale set instance. For NAP-managed capacity, use the backing VM resource ID from the `NodeClaim` provider ID.

For a VMSS extension failure, see [VM extension provisioning errors in Virtual Machine Scale Sets](../../virtual-machine-scale-sets/extensions/vm-extension-provisioning-errors.md) to identify the affected instance and extension.

If the error matches an AKS issue in [Failed operation or resource](#failed-operation-or-resource), follow that guidance. The table isn't a complete guide to VM or virtual machine scale sets failures. If the evidence points to a VM or virtual machine scale sets platform, guest-agent, host, or disk problem, or the cause is still unclear, contact Microsoft Support and request investigation with the Azure Compute (VM/VMSS) team alongside AKS support. Include the cluster and compute resource IDs, affected instance, failure time in UTC, extension status and logs, and activity log correlation IDs.

Make direct changes to AKS-managed VMs, scale sets, or extensions only when Microsoft Support directs you to do so. The generic VM and virtual machine scale sets articles also include repair steps that you shouldn't apply independently to AKS nodes. See [AKS support policies](/azure/aks/support-policies#user-customization-of-agent-nodes).

## Use additional logging and diagnostic tools

Start with the operation and activity log error. If you need to investigate node or workload behavior, these tools can provide more context:

- **Azure Monitor** provides Kubernetes monitoring data, including container logs, Kubernetes events, and node and pod performance data. Use it to compare the time of the failure with cluster or workload changes. See [Kubernetes monitoring in Azure Monitor](/azure/azure-monitor/containers/kubernetes-monitoring-overview).
- **AKS Periscope** collects node and pod logs, connectivity results, Kubernetes object descriptions, and other diagnostic information. The `az aks kollect` command deploys Periscope and uploads the results to Azure Blob Storage. For usage, prerequisites, and data-collection considerations, see [Deploy Periscope to an AKS cluster](/azure/aks/deploy-periscope-aks).

## Resolve the issue

<a id="active-or-conflicting-operation"></a>

### Scenario 1: Active or conflicting operation

If the latest operation doesn't have a terminal status (`Succeeded`, `Failed`, or `Canceled`), don't start another upgrade, scale, or reconciliation operation on the managed cluster or affected node pool until the active operation finishes.

Use the troubleshooting article that matches the error:

- For `OperationNotAllowed` that identifies another AKS operation as the blocker, see [Cluster pending operation errors](../create-upgrade-delete/operationnotallowed.md). If the response has HTTP status 429 or `TooManyRequests` details, use the throttling row in [Failed operation or resource](#failed-operation-or-resource).
- For `AKSOperationPreempted` or `AKSOperationPreemptedByDelete`, see [Troubleshoot AKSOperationPreempted errors](../error-codes/aksoperationpreempted-error.md).

If the operation runs longer than expected, review [Abort an AKS long-running operation](/azure/aks/manage-abort-operations) before canceling it. Canceling an operation doesn't roll back changes that AKS already applied.

<a id="cluster-autoscaler-doesnt-scale"></a>

### Scenario 2: Cluster autoscaler doesn't scale

An unexpected node count on an autoscaled pool doesn't necessarily mean a scale operation failed. Check whether cluster autoscaler decided to add or remove a node. If it requested a change that failed in Azure, use the error in [Failed operation or resource](#failed-operation-or-resource).

Check the cluster autoscaler events and status:

```bash
kubectl get events --all-namespaces --field-selector source=cluster-autoscaler,reason=NotTriggerScaleUp
kubectl get events --all-namespaces --field-selector source=cluster-autoscaler,type=Warning
kubectl get configmap --namespace kube-system cluster-autoscaler-status --output yaml
```

In the Azure portal, you can also open **Node pools** and review **Autoscale events**, **Autoscale warnings**, and **Scale-up not triggered**. For control plane log queries, see [Retrieve cluster autoscaler logs and status](/azure/aks/cluster-autoscaler#retrieve-cluster-autcaler-logs-and-status).

For a **scale-out** issue, list pending pods by running the following command.

```bash
kubectl get pods --all-namespaces --field-selector=status.phase=Pending
```

Check that the pool is below its maximum count and that a new node in that pool could run a pending pod. Use `kubectl describe pod <pod-name> --namespace <namespace>` to read the `FailedScheduling` events. Check resource requests, selectors and affinity, taints and tolerations, topology rules, and volume requirements. If the autoscaler requested a node, check the AKS error for quota, capacity, subnet IP, or node provisioning failures.

For a **scale-in** issue, check that the pool is above its minimum count, the scale-down delays have elapsed, and the node is underutilized. A `cluster-autoscaler.kubernetes.io/scale-down-disabled: "true"` node annotation or pods that can't be safely moved can prevent removal. See [What types of pods can prevent cluster autoscaler from removing a node?](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-types-of-pods-can-prevent-ca-from-removing-a-node). If node removal starts but fails, use [Failed operation or resource](#failed-operation-or-resource).

Don't manually scale a node pool while cluster autoscaler is enabled. For `Cannot scale cluster autoscaler enabled node pool`, see [Cluster autoscaler can't scale and shows "cannot scale cluster autoscaler enabled node pool" error](../create-upgrade-delete/cannot-scale-cluster-autoscaler-enabled-node-pool.md). For `Failed to fix node group sizes`, see [Cluster autoscaler fails to scale with "failed to fix node group sizes" error](../create-upgrade-delete/cluster-autoscaler-fails-to-scale.md).

<a id="nap-managed-capacity-or-node-failure"></a>

### Scenario 3: NAP-managed capacity or node failure

Use this section when `NodeProvisioningMode` is `Auto` and the affected nodes are managed by NAP. NAP uses Kubernetes `NodePool` and `NodeClaim` resources and creates an individual Azure VM for each node. These resources are separate from the cluster's traditional AKS system agent pool.

The `az aks nodepool` and `az aks machine` commands don't query NAP-managed capacity. Don't use `az aks nodepool scale` to add or remove NAP nodes, and don't modify a NAP VM directly in the node resource group.

Check the pending workloads, NAP-managed nodes, Kubernetes `NodePool` resources, and `NodeClaim` resources by running the following commands.

```bash
kubectl get pods --all-namespaces --field-selector=status.phase=Pending
kubectl get nodes --selector=karpenter.sh/nodepool --output wide
kubectl get nodepools.karpenter.sh
kubectl get nodeclaims.karpenter.sh
```

For a **scale-out** issue, review the pending pod's `FailedScheduling` events by running the following command. Then, inspect the applicable Kubernetes `NodePool`.

```bash
kubectl describe nodepool.karpenter.sh <node-pool-name>
```

If no `NodeClaim` appears, compare the `NodePool` conditions, requirements, taints, limits, and VM sizes with the pending pod's resource, scheduling, and volume requirements.

If NAP creates a `NodeClaim`, inspect it by running the following command.

```bash
kubectl describe nodeclaim.karpenter.sh <node-claim-name>
```

Check the `NodeClaim` conditions and events to see where provisioning stopped: launch, registration, initialization, or readiness. For an Azure provisioning error, use [Failed operation or resource](#failed-operation-or-resource). If a backing VM exists, copy the `/subscriptions/...` ARM resource ID from the `NodeClaim` provider ID and use it with the activity log command in [Identify the failed resource or operation](#identify-the-failed-resource-or-operation).

If an existing NAP node is `NotReady` or its VM is in a `Failed` provisioning state, match the node name to the `NODE` column from `kubectl get nodeclaims.karpenter.sh`. Then, inspect both resources by running the following commands.

```bash
kubectl describe node <node-name>
kubectl describe nodeclaim.karpenter.sh <node-claim-name>
```

For a **scale-in** issue, check the Kubernetes `NodePool` disruption budgets and consolidation settings, along with PDBs and pods that can't move. If removal starts but the node or `NodeClaim` remains, inspect its conditions and events for the blocker.

If NAP doesn't create a `NodeClaim` or initiate node removal, see [Troubleshoot node auto-provisioning in AKS](../extensions/troubleshoot-node-auto-provision.md). If NAP initiates the capacity change but the Azure operation fails, use [Failed operation or resource](#failed-operation-or-resource).

### Failed operation or resource

Find the error code or message from the failed operation in the following table. If AKS returns a wrapper such as `UpgradeVMSSAgentPoolFailed` or `ScaleVMSSAgentPoolFailed`, look for a more specific error in its subcode or details, when available.

| Error or symptom | Resolution |
| --- | --- |
| `TooManyRequests`, `Throttled`, `SubscriptionRequestsThrottled`, or `OperationNotAllowed` with HTTP status 429 or throttling details | Honor the `Retry-After` interval and reduce the request rate before retrying. See [Troubleshoot SubscriptionRequestsThrottled error code (429)](../create-upgrade-delete/error-code-subscriptionrequeststhrottled.md). To identify throttling by source, user agent, and operation in the portal, see [Analyze and identify errors by using AKS Diagnose and Solve Problems](../create-upgrade-delete/429-too-many-requests-errors.md#analyze-and-identify-errors-by-using-aks-diagnose-and-solve-problems). |
| `ReconcileMachineFailed`, a `VirtualMachines` agent pool or machine doesn't reach its desired state, or the request reports an invalid scale profile | Check the agent pool's manual or autoscale profiles. Use `az aks machine list` or `az aks machine show` to identify the affected machine, its backing VM resource ID, and any status or error that the Machine API returns. See [Virtual Machines node pools in AKS](/azure/aks/virtual-machines-node-pools) and [az aks machine](/cli/azure/aks/machine). |
| `InvalidParameter`, `ValidationError`, `AgentPoolUpgradeVersionNotAllowed`, a version incompatibility, or an unsupported configuration | Correct the value or combination identified in the error. For upgrades, check the [Kubernetes version upgrade rules](/azure/aks/upgrade-aks-control-plane#kubernetes-version-upgrade-rules) and [available node images](/azure/aks/upgrade-node-image). Don't retry the same invalid request. |
| `SubscriptionNotRegistered` or `MissingSubscriptionRegistration` | Register the resource provider identified in the error. For AKS, run `az provider register --namespace Microsoft.ContainerService`. See [Troubleshoot the MissingSubscriptionRegistration error code](../error-codes/missingsubscriptionregistration-error.md). |
| `ReadOnlyDisabledSubscription` | Resolve the subscription status, billing, or credit issue before retrying. See [Reactivate a disabled Azure subscription](/azure/cost-management-billing/manage/subscription-disabled). |
| `QuotaExceeded`, `ResourceGroupQuotaExceeded`, `PublicIPCountLimitReached`, or another quota error | Check which resource reached its limit. An upgrade can require temporary surge capacity. See [Troubleshoot the QuotaExceeded error code](../error-codes/quota-exceeded-error.md) and [Troubleshoot the PublicIPCountLimitReached error code](../error-codes/publicipcountlimitreached-error.md). |
| `PublicIpPrefixOutOfIpAddressesForVMScaleSet` | The configured public IP prefix doesn't have enough available addresses for the requested node count. Check the required count, including upgrade surge capacity, and use a prefix with sufficient addresses or reduce the requested node count before retrying. |
| `SubnetIsFull` or insufficient IP addresses | [Troubleshoot the SubnetIsFull error code](../error-codes/subnetisfull-error.md). Check the affected agent pool's subnet and account for upgrade surge capacity. |
| `AllocationFailed`, `ZonalAllocationFailed`, `SkuNotAvailable`, `OverconstrainedAllocationRequest`, or `OverconstrainedZonalAllocationRequest` | [Troubleshoot ZonalAllocationFailed or AllocationFailed errors](../error-codes/zonalallocation-allocationfailed-error.md). Regional capacity, SKU or zone availability, and subscription quota are different constraints. |
| `InvalidLoadBalancerProfileAllocatedOutboundPorts` | The node count, allocated outbound ports per node, and number of outbound IPs don't provide enough SNAT ports. Include upgrade surge nodes in the calculation. See [InvalidLoadBalancerProfileAllocatedOutboundPorts error code](../create-upgrade-delete/error-code-invalidloadbalancerprofileallocatedoutboundports.md). |
| `UpgradeFailed`, `PodDrainFailure`, `UnsatisfiablePDB`, a pod eviction that returns `Too Many Requests`, or another node drain or eviction failure | A restrictive PDB, a pod that doesn't terminate, an admission webhook, or the drain timeout can block an upgrade, manual scale-in, or controller-managed scale-in. Review the affected pod and drain details in the error. See [Troubleshoot UpgradeFailed errors due to eviction failures caused by PDBs](../create-upgrade-delete/error-code-poddrainfailure.md) and [Troubleshoot the UnsatisfiablePDB error code](../error-codes/unsatisfiablepdb-error.md). |
| `UpgradeBlockedOnDeprecatedAPIUsage` | [Mitigate stopped upgrade operations due to deprecated APIs](/azure/aks/stop-cluster-upgrade-api-breaking-changes#mitigate-stopped-upgrade-operations). Migrate from deprecated APIs instead of bypassing validation whenever possible. |
| `OperationBlockedByNodeDisruptionPolicy`, `OperationOutsideNodeDisruptionWindow`, or `InternalOperationError` with a message about evaluating Node Disruption Policy | Check `nodeDisruptionProfile.nodeDisruptionPolicy`. For `AllowDuringMaintenanceWindow`, check the `aksManagedNodeOSUpgradeSchedule` configuration and wait for the allowed window. For an internal policy-evaluation error, retry once. To proceed outside the window, with a `Block` policy, or after a persistent evaluation error, temporarily set the policy to `Allow` only if you intend to permit the disruption. Restore the original policy after the operation. For a persistent evaluation error, also contact AKS support with the operation and correlation IDs. See [Configure Node Disruption Policy in AKS](/azure/aks/use-node-disruption-policy). |
| `AgentCountNotMatch` or a VM count mismatch reported during the failed operation | Compare the expected and actual counts if the error includes them. For a VMSS pool, check whether Azure Monitor Autoscale or another system changed the scale set during an AKS operation. If Azure Monitor Autoscale is enabled, disable it and use AKS cluster autoscaler instead. For a `VirtualMachines` pool, compare the running VM count with the manual profile totals or autoscale minimums. Don't change backing VMs or scale sets directly. Once no related operation is active, retry once. If the mismatch persists, contact AKS support with the operation and correlation IDs. |
| `NodesNotReady`, `UpgradeNodesNotRegistered`, or a node-readiness issue during the failed operation | Identify the affected node and [collect supporting node diagnostics](#collect-supporting-node-diagnostics). See [Basic troubleshooting of Node Not Ready failures](node-not-ready-basic-troubleshooting.md) and the VM extension error guidance in this table. |
| `ControlPlaneAPIServerNotReady` | AKS couldn't connect to the Kubernetes API server. Check API server availability and the network, DNS, firewall, or private-cluster path between AKS and the API server. If `kubectl` requests also time out, have high latency, or repeatedly return HTTP 429 or 5xx responses, use the AKS diagnostics and see [Troubleshoot API server and etcd problems in AKS](../create-upgrade-delete/troubleshoot-apiserver-etcd.md). |
| `VMExtensionProvisioningError`, `OutboundConnFailVMExtensionError`, `K8SDownloadTimeoutVMExtensionError`, `CniDownloadTimeoutVMExtensionError`, `K8SAPIServerConnFailVMExtensionError`, `K8SAPIServerDNSLookupFailVMExtensionError`, or a message that contains `VMExtensionError_VHDFileNotFound` | Use the specific subcode or CSE message to identify the failed node provisioning step and follow the corresponding troubleshooting article: [Outbound connectivity failure](../error-codes/vmextensionerror-outboundconnfail.md), [Kubernetes binaries download timeout](../error-codes/vmextensionerror-k8sdownloadtimeout.md), [CNI binaries download timeout](../error-codes/vmextensionerror-cnidownloadtimeout.md), [K8SAPIServerConnFailVMExtensionError](../create-upgrade-delete/error-code-k8sapiserverconnfailvmextensionerror.md), [K8SAPIServerDNSLookupFailVMExtensionError](../create-upgrade-delete/error-code-k8sapiserverdnslookupfailvmextensionerror.md), [ERR_VHD_FILE_NOT_FOUND](../create-upgrade-delete/error-code-vhdfilenotfound.md), or [CSE errors that cause Node Not Ready](node-not-ready-custom-script-extension-errors.md). |
| `RequestDisallowedByPolicy`, `ResourceLocked`, `ScopeLocked`, or `InvalidResourceReference` | Correct the policy assignment, remove the blocking management lock, or restore the missing or modified dependency before retrying. See [RequestDisallowedByPolicy error with Azure Policy](../error-codes/requestdisallowedbypolicy-error.md), [Lock Azure resources to protect your infrastructure](/azure/azure-resource-manager/management/lock-resources), and [Troubleshoot the InvalidResourceReference error code](../create-upgrade-delete/error-code-invalidresourcereference.md). If the message reports a missing Log Analytics workspace, see ["Unable to get log analytics workspace info" error](../create-upgrade-delete/aks-upgrade-scale-fail-log-analytics-workspace-missing.md). |
| `CreateOrUpdateVirtualNetworkLinkFailed` or a private DNS reconciliation error | Correct the private DNS zone permissions, links, or conflicting resources identified in the error. See [CreateOrUpdateVirtualNetworkLinkFailed error](../create-upgrade-delete/createorupdatevirtualnetworklinkfailed-error.md). |
| `AuthorizationFailed`, `LinkedAuthorizationFailed`, or an identity or role-assignment error | Grant the principal or object ID identified in the error the required action on the specified scope. See [Resolve the LinkedAuthorizationFailed error](../error-codes/linkedauthorizationfailed-error.md). |
| `InternalOperationError`, `ServiceUnavailable`, or `TimedoutOrCancelled` without an actionable underlying error | Verify that no operation is still active and check the target's current state. If `kubectl` requests also time out, have high latency, or repeatedly return HTTP 429 or 5xx responses, use the AKS diagnostics and see [Troubleshoot API server and etcd problems in AKS](../create-upgrade-delete/troubleshoot-apiserver-etcd.md). Otherwise, retry once. If the error persists, collect the operation and correlation IDs and create a support request. |

## Retry, reconcile, and verify

Resolve the error you found in [Identify the failed resource or operation](#identify-the-failed-resource-or-operation) by using the matching guidance in [Failed operation or resource](#failed-operation-or-resource). Before retrying, check that no related operation is still running. Choose the method in the following section that matches how you started the operation.

### Retry a direct AKS upgrade or manual scale

Retry the original operation once, using the same resource and intended settings. Choose one of the following examples; don't run them together as a sequence. For a Fleet-initiated upgrade, use [Retry a Fleet update run](#retry-a-fleet-update-run) instead.

For a [full cluster Kubernetes upgrade](/azure/aks/upgrade-aks-control-plane), run the following command.

```azurecli
az aks upgrade \
    --resource-group <resource-group-name> \
    --name <cluster-name> \
    --kubernetes-version <target-kubernetes-version>
```

If you originally requested a control-plane-only upgrade, keep `--control-plane-only` so the retry doesn't also upgrade the node pools.

For a [single AKS agent-pool Kubernetes upgrade](/cli/azure/aks/nodepool#az-aks-nodepool-upgrade), run the following command.

```azurecli
az aks nodepool upgrade \
    --resource-group <resource-group-name> \
    --cluster-name <cluster-name> \
    --name <node-pool-name> \
    --kubernetes-version <target-kubernetes-version>
```

For a [node-image-only upgrade](/azure/aks/upgrade-node-image), run the following command using the cluster or agent-pool command with `--node-image-only` instead of `--kubernetes-version`. Keep the same scope: one pool or all pools.

For a [manual scale operation](/azure/aks/scale-node-pools) on a `VirtualMachineScaleSets` agent pool with cluster autoscaler disabled, run the following command to specify the intended total count, not the number of nodes to add or remove.

```azurecli
az aks nodepool scale \
    --resource-group <resource-group-name> \
    --cluster-name <cluster-name> \
    --name <node-pool-name> \
    --node-count <target-node-count>
```

For a `VirtualMachines` agent pool, if the failed operation changed the count of an existing manual scale profile, run the following command to use [az aks nodepool manual-scale update](/cli/azure/aks/nodepool/manual-scale#az-aks-nodepool-manual-scale-update).

```azurecli
az aks nodepool manual-scale update \
    --resource-group <resource-group-name> \
    --cluster-name <cluster-name> \
    --name <node-pool-name> \
    --current-vm-sizes "<existing-profile-vm-size>" \
    --node-count <target-profile-node-count>
```

Use the VM size from the existing manual profile in `virtualMachinesProfile.scale`. A manual profile has one VM size; the count applies to that profile, not the whole pool. This example updates an existing manual profile, not an autoscale profile or a profile creation or deletion. Recheck the scale profiles and machine states afterward.

### Verify controller-managed scaling

After you correct the cause, let cluster autoscaler or NAP reevaluate the workload. Use the following checks to see whether scaling resumes; don't trigger a manual scale to retry it.

- For cluster autoscaler, run the following command to rerun the event checks in [Scenario 2: Cluster autoscaler doesn't scale](#scenario-2-cluster-autoscaler-doesnt-scale) and check its status.

    ```bash
    kubectl get configmap --namespace kube-system cluster-autoscaler-status --output yaml
    ```

    Check that it adds capacity when pending pods need it, or removes an underutilized node when the pods can move. Account for the pool's minimum and maximum counts and scale-down delays.

- For NAP, inspect the `NodeClaim` state by running the following command.

    ```bash
    kubectl get nodeclaims.karpenter.sh
    ```

    For scale-out, check that the new `NodeClaim` becomes ready. For scale-in, check that the selected node is removed. If scaling stalls, return to [Scenario 3: NAP-managed capacity or node failure](#scenario-3-nap-managed-capacity-or-node-failure).

### Retry a Fleet update run

After fixing the member-cluster failure, run the following commands to check the Fleet update run. If the run is `Failed`, restart that same run once, then inspect its progress. These commands require the `fleet` Azure CLI extension.

```azurecli
az fleet updaterun start \
    --resource-group <fleet-resource-group-name> \
    --fleet-name <fleet-name> \
    --name <update-run-name>

az fleet updaterun show \
    --resource-group <fleet-resource-group-name> \
    --fleet-name <fleet-name> \
    --name <update-run-name> \
    --output json
```

Check the affected member's result, not just the update run's overall status. Keep the retry in Fleet rather than starting a separate upgrade on the member. See [Manage an update run](/azure/kubernetes-fleet/update-orchestration#manage-an-update-run) and [az fleet updaterun](/cli/azure/fleet/updaterun).

### Reconcile a failed cluster or node pool

If there's no original operation to retry but the cluster or agent pool is still `Failed`, reconcile that resource. First, confirm that you fixed the error and that no related operation is running.

For the cluster, run the following command.

```azurecli
az aks update \
    --resource-group <resource-group-name> \
    --name <cluster-name> \
    --yes
```

For an AKS agent pool, run the following command.

```azurecli
az aks nodepool update \
    --resource-group <resource-group-name> \
    --cluster-name <cluster-name> \
    --name <node-pool-name>
```

Run only the command for the failed resource. `az aks nodepool update` doesn't apply to a NAP Kubernetes `NodePool` or `NodeClaim`. Reconciliation won't fix an unresolved quota, policy, network, capacity, or configuration error.

Repeat the state checks in [Identify the failed resource or operation](#identify-the-failed-resource-or-operation). Confirm that the cluster or agent pool has a `Succeeded` provisioning state and that a direct AKS operation has a `Succeeded` status. Also check what you set out to change: the Kubernetes version, node count, scale profile, or node readiness.

If the operation fails again, use the new error details instead of repeatedly retrying.
