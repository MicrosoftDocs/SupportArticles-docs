---
title: Troubleshoot common node auto-repair errors
description: Troubleshoot a scenario in which node auto-repair returns an error code when you try to repair a node that has a NotReady status.
ms.date: 10/17/2024
ms.reviewer: juliayin;tamram
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to make sure the automatic repair actions from AKS node auto-repair don't adversely affect my applications or cluster health.
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot common node auto-repair errors

If Azure Kubernetes Service (AKS) detects a node that reports a NotReady status for more than 5 minutes, AKS tries to automatically repair the node. Node auto-repair is a best-effort service. It doesn't guarantee that your node will be restored to a healthy state. Learn more about the [node auto-repair process](/azure/aks/node-auto-repair).

During the node auto-repair process, AKS initiates restart, reimage, and redeploy actions on your unhealthy node. These repair actions might experience errors because of various underlying causes. The resulting error code is discovered through a [Kubernetes event](/azure/aks/events). You can use this event to monitor the status of your node and auto-repair actions. This article discusses common errors, together with their potential causes and next steps, as well as best practices for monitoring node auto-repair.

## Prerequisites
To determine which type of node auto-repair error occurred, look for one of the following Kubernetes events.  

| Reason | Event message | Description|
| --- | --- | --- |
| NodeRebootError | Node auto-repair reboot action failed due to an operation failure: [error code] | This event is logged if an error affects the restart action. |
| NodeReimageError | Node auto-repair reimage action failed due to an operation failure: [error code] | This event is logged if an error affects the reimage action. |
| NodeRedeployError | Node auto-repair redeploy action failed due to an operation failure: [error code] | This event is logged if an error affects the redeploy action. |

> [!NOTE]
> In most cases, node auto-repair errors will not affect your cluster or applications because your node was already in an unhealthy state prior to the auto-repair process. If you encounter node auto-repair errors, we recommend that you first try to repair the node yourself by following the instructions at [Basic troubleshooting of Node Not Ready failures](./node-not-ready-basic-troubleshooting.md). If you can't restore your node to a Succeeded status, and you're noticing persistent errors that are reported by node auto-repair, contact [Azure support](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) for assistance.

## Common error codes
The following table contains the most common node auto-repair errors.

| Error code | Causes and solutions |
|---|---|
| VMExtensionProvisioningError | One or more VM extensions weren't provisioned on the node. Learn more about possible causes and troubleshooting steps at [Troubleshoot the ERR_VHD_FILE_NOT_FOUND error code (124)](../create-upgrade-delete/error-code-vhdfilenotfound.md). To determine the exact VM extension provisioning error on your node, read more at [View error details in the Azure portal](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md#view-resources-in-the-azure-portal). |
| InvalidParameter | This error occurs if the node auto-repair process tries to access a node that no longer exists. |
| scaleSetNameAndInstanceIDFromProviderID failed | This issue occurs if the node isn't provisioned correctly. |
| ManagedIdentityCredential authentication failed | This error occurs if the node isn't initialized correctly. |
| VMRedeploymentFailed | An error occurred when you tried to redeploy the node. This may cause your node pool to enter a failed state. Learn more about potential causes and next steps at [Troubleshoot Azure Kubernetes Service clusters or nodes in a failed state](./cluster-node-virtual-machine-failed-state.md#scenario-3-node-pool-is-in-a-failed-state). |
| TooManyVMRedeploymentRequests | This error occurs if your cluster exceeds the limit for VM redeployment requests. Redeploy is one of the auto-repair actions. This means that auto-repair can't repair your node by using redeployment actions. To troubleshoot the node's NotReady issue manually, see [Basic troubleshooting of Node Not Ready failures](./node-not-ready-basic-troubleshooting.md). |
| OutboundConnectivityNotEnabledOnVMSS | This error occurs if your node or overall Virtual Machine Scale Set (VMSS) does not have outbound access enabled. Enable secure outbound access for your VMSS by using a method that's best suited for your application. Read more about the methods at [OutboundConnectivityNotEnabledOnVM. No outbound connectivity configured for virtual machine](../../virtual-machine-scale-sets/deploy/vmss-outbound-connectivity-not-enabled.md#solution). |

## Best practices for monitoring
- By default, AKS stores Kubernetes events from the past hour. We recommend that you enable [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable#enable-container-insights) so that you can store events for up to 90 days. The Container Insights also enable you to [query events and configure alerts](/azure/aks/events#automating-event-notifications) to quickly detect node auto-repair errors.
- Node auto-repair is a best-effort service. It carries no guarantee that your node will be restored to Ready status. We highly recommend that you actively monitor on and set alerts for node NotReady issues, and conduct your own troubleshooting and resolution of these issues. For more details, see [basic troubleshooting of node NotReady issues](./node-not-ready-basic-troubleshooting.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
