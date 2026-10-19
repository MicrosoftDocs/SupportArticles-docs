---
title: Troubleshoot common node auto-repair errors
description: Learn common node auto-repair errors in AKS, find causes and fixes for NotReady nodes, and troubleshoot issues faster with actionable guidance.
ms.date: 10/19/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: juliayin, aritraghosh, shmalfat, v-weizhu, shuyingqin
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
ai-usage: ai-assisted
---
# Troubleshoot common node auto-repair errors in AKS

## Summary

When Azure Kubernetes Service (AKS) detects a node with a `NotReady` status for more than five minutes, it uses node auto-repair to try to restore the node. This article helps you troubleshoot common node auto-repair errors and understand why this best-effort service might not restore a node to a healthy state. For more information, see [node auto-repair process](/azure/aks/node-auto-repair).

During node auto-repair, AKS first reboots the unhealthy node. If the node remains unhealthy, AKS reimages it. For Linux nodes, AKS can also redeploy the node if reimage doesn't restore it. AKS can retry the repair sequence up to three times, and the overall process can take up to one hour. AKS emits Kubernetes events for the repair actions and any errors that occur.

This article provides potential causes and solutions to common node auto-repair errors. It also outlines best practices for monitoring the node auto-repair process.

## Identify the node auto-repair error

Node auto-repair events are recorded on the affected node object and are reported by the `aks-auto-repair` source. List warning events for node objects, and then inspect the affected node:

```bash
kubectl get events --all-namespaces \
  --field-selector involvedObject.kind=Node,type=Warning \
  --sort-by=.metadata.creationTimestamp

kubectl describe node <node-name>
```

Look for a `NodeRebootError`, `NodeReimageError`, or `NodeRedeployError` event. Record the complete event message, including the nested Azure error code, because the event reason alone doesn't identify the underlying failure.
 
| Reason | Event message | Description |
| --- | --- | --- |
| NodeRebootError | Node auto-repair reboot action failed due to an operation failure. See error details here: \<error code\> | Emitted when there's an error with the `reboot` action. |
| NodeReimageError | Node auto-repair reimage action failed due to an operation failure. See error details here: \<error code\> | Emitted when there's an error with the `reimage` action. |
| NodeRedeployError | Node auto-repair redeploy action failed due to an operation failure. See error details here: \<error code\> | Emitted when there's an error with the `redeploy` action. |

> [!NOTE]
> A node auto-repair error means that AKS couldn't complete a recovery action on a node that was already unhealthy. The failed repair doesn't cause the original node failure, but prolonged node unavailability can affect workloads if the cluster doesn't have enough healthy capacity or the workload doesn't have sufficient redundancy. Check pod availability and follow the [Node Not Ready troubleshooting guidance](./node-not-ready-basic-troubleshooting.md). If the node remains in `NotReady` status, the node pool isn't in a `Succeeded` provisioning state, or repair errors continue, contact [Azure support](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot).

## Common error codes

| Error code | Cause and solution |
|---|---|
| VMExtensionProvisioningError | One or more virtual machine (VM) extensions failed to provision on the node. [View the VM scale set instance or deployment error details](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md#view-resources-in-the-azure-portal), and identify the nested VM extension error code and message. Follow the troubleshooting guidance for that specific nested error. Use the [ERR_VHD_FILE_NOT_FOUND article](../create-upgrade-delete/error-code-vhdfilenotfound.md) only when error 124 is reported. If the nested error is related to outbound connectivity, validate the [AKS required outbound endpoints](/azure/aks/outbound-rules-control-egress) and the cluster egress configuration. |
| InvalidParameter | The auto-repair operation referenced a node that no longer exists. Check the event timestamp, and run `kubectl get node <node-name>` to confirm whether the node is still present. If the node was intentionally removed or replaced and the event is no longer recurring, no further action is required. If the event continues for a current node, collect the complete event message and contact Azure support. |
| scaleSetNameAndInstanceIDFromProviderID failed | AKS couldn't map the node's provider ID to a VM scale set instance. Run `kubectl get node <node-name> -o jsonpath='{.spec.providerID}{"\n"}'` to check the provider ID. Run `az aks nodepool show --resource-group <cluster-resource-group> --cluster-name <cluster-name> --name <node-pool-name> --query provisioningState --output tsv` to check the node pool provisioning state. If the provider ID is missing or malformed, or the node pool isn't in a `Succeeded` provisioning state, follow the [AKS node pool failed-state guidance](./cluster-node-virtual-machine-failed-state.md#failed-operation-or-resource). If the error continues, contact Azure support because the node-to-VM mapping used by auto-repair is service-managed. |
| ManagedIdentityCredential authentication failed | The auto-repair operation couldn't obtain a managed identity credential. Check the cluster and node pool provisioning states by using `az aks show --resource-group <cluster-resource-group> --name <cluster-name> --query provisioningState --output tsv` and `az aks nodepool show --resource-group <cluster-resource-group> --cluster-name <cluster-name> --name <node-pool-name> --query provisioningState --output tsv`. Review the Azure Activity Log for a related identity, authorization, or control-plane error. Don't change identities or role assignments directly on resources in the AKS node resource group. If the error continues, contact Azure support and include the node name, event timestamp, cluster resource ID, and complete error message. |
| VMRedeploymentFailed | Azure Compute couldn't complete the redeploy action. Record the complete nested error from the node event, and check the Azure Activity Log for the corresponding operation. Check whether the node pool is in a `Succeeded` provisioning state. Follow the [AKS failed-state guidance](./cluster-node-virtual-machine-failed-state.md#failed-operation-or-resource) for a failed node pool. If the node pool is healthy but redeploy continues to fail, contact Azure support with the event and Activity Log details. |
| TooManyVMRedeploymentRequests | Azure Compute temporarily rejected the redeploy action because too many redeployment requests were received for the VM or related VMs. Allow node auto-repair to retry, and continue monitoring the node events. If the node remains in `NotReady` status after the auto-repair process, or the throttling error continues, follow the [Node Not Ready troubleshooting guidance](./node-not-ready-basic-troubleshooting.md) and contact Azure support. |
| OutboundConnectivityNotEnabledOnVMSS | Azure Compute reported that the node or VM scale set doesn't have outbound connectivity configured. Don't modify the AKS-managed VM scale set directly. Run `az aks show --resource-group <cluster-resource-group> --name <cluster-name> --query networkProfile.outboundType --output tsv` to check the cluster outbound type. For `loadBalancer`, `managedNATGateway`, `userAssignedNATGateway`, or `userDefinedRouting`, validate the egress resource, routes, firewall or network virtual appliance, network security groups, proxy configuration, DNS, and [required AKS outbound endpoints](/azure/aks/outbound-rules-control-egress). For a network-isolated cluster that uses `none` or `block`, verify that the configuration is intentional and follows the [network-isolated cluster requirements](/azure/aks/concepts-network-isolated). If the cluster has a [supported egress configuration](/azure/aks/egress-outboundtype) and the error continues, contact Azure support. |

## Best practices for monitoring node auto-repair

- Kubernetes events are available from the Kubernetes API for one hour after they're generated. To retain events for longer, enable [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable#enable-container-insights), and configure retention for the relevant [Log Analytics workspace and tables](/azure/azure-monitor/logs/data-retention-configure) based on your operational and cost requirements. Query the `KubeEvents` table, and [configure alert rules](/azure/aks/events#automating-event-notifications) for node auto-repair errors.

- Node auto-repair is a best-effort service. It doesn't guarantee that your node can be restored to a `Ready` status. Actively monitor and set alerts for Node Not Ready issues, and troubleshoot and resolve these issues yourself. For more information, see [basic troubleshooting of Node Not Ready issues](./node-not-ready-basic-troubleshooting.md).

 
