---
title: Troubleshoot common node auto-repair errors
description: Provides potential causes and solutions to common node auto-repair errors that occur when you repair a node with a NotReady status.
ms.date: 10/25/2024
ms.reviewer: juliayin, aritraghosh, shmalfat, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot common node auto-repair errors

When Azure Kubernetes Service (AKS) detects a node with a `NotReady` status for more than five minutes, it attempts to automatically repair the node. Node auto-repair is a best-effort service. It doesn't guarantee that the node can be restored to a healthy state. For more information, see [node auto-repair process](/azure/aks/node-auto-repair).

During the node auto-repair process, AKS initiates `reboot`, `reimage`, and `redeploy` actions on your unhealthy node. Errors can occur due to various reasons and error codes are discovered through [Kubernetes events](/azure/aks/events). You can use Kubernetes events to monitor the status of your node and the auto-repair actions.

This article provides potential causes and solutions to common node auto-repair errors, and outlines best practices for monitoring the node auto-repair process.

## Prerequisites

Check the following Kubernetes events to identify the type of a node auto-repair error:
 
| Reason | Event message | Description |
| --- | --- | --- |
| NodeRebootError | Node auto-repair reboot action failed due to an operation failure: [error code here] | Emitted when there's an error with the `reboot` action. |
| NodeReimageError | Node auto-repair reimage action failed due to an operation failure: [error code here] | Emitted when there's an error with the `reimage` action. |
| NodeRedeployError | Node auto-repair redeploy action failed due to an operation failure: [error code here] | Emitted when there's an error with the `redeploy` action. |

> [!NOTE]
> Because your node is already in an unhealthy state prior to the auto-repair process, in most cases, node auto-repair errors don't impact your cluster or applications. When you encounter node auto-repair errors, we recommend that you try to repair the node by following the instructions in [Basic troubleshooting of Node Not Ready failures](./node-not-ready-basic-troubleshooting.md). If you can't restore it to a `Succeeded` status and see persistent errors reported by node auto-repair, contact [Azure support](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) for assistance.

## Common error codes

| Error code | Cause and solution |
|---|---|
| VMExtensionProvisioningError | One or more virtual machine (VM) extensions failed to be provisioned on the VM. For more information about possible error types and troubleshooting steps, see [Troubleshoot the ERR_VHD_FILE_NOT_FOUND error code (124)](../create-upgrade-delete/error-code-vhdfilenotfound.md). To determine the exact VM extension provisioning error on your node, [view error details in the Azure portal](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md#view-resources-in-the-azure-portal). |
| InvalidParameter | This error occurs if the node auto-repair process tries to access a node that no longer exists.|
| scaleSetNameAndInstanceIDFromProviderID failed | This issue occurs when the node isn't provisioned correctly. |
| ManagedIdentityCredential authentication failed | This issue occurs when the node isn't initialized correctly.  |
| VMRedeploymentFailed | This error occurs when you try to redeploy the node. In this case, your node pool might enter a failed state. For more information about potential causes and troubleshooting steps, see [Troubleshoot Azure Kubernetes Service clusters or nodes in a failed state](./cluster-node-virtual-machine-failed-state.md#scenario-3-node-pool-is-in-a-failed-state). |
| TooManyVMRedeploymentRequests | This error occurs when your cluster exceeds the limit for VM redeployment requests. `Redeploy` is one of the node auto-repair actions. This error means that the `redeploy` action can't repair your node. To troubleshoot the Node Not Ready issue, see [Basic troubleshooting of Node Not Ready failures](./node-not-ready-basic-troubleshooting.md). |
| OutboundConnectivityNotEnabledOnVMSS | This error occurs when your node or overall Virtual Machine Scale Set doesn't have outbound access enabled. To resolve this issue, enable secure outbound access for your scale set by using a method that's best suited for your application. For more information, see ["OutboundConnectivityNotEnabledOnVM. No outbound connectivity configured for virtual machine."](../../virtual-machine-scale-sets/deploy/vmss-outbound-connectivity-not-enabled.md#solution) |

## Best practices for monitoring node auto-repair

- AKS stores Kubernetes events from the past hour by default. We recommend enabling [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable#enable-container-insights) so that you can store events for up to 90 days. You can also [query events and configure alerts](/azure/aks/events#automating-event-notifications) to quickly detect node auto-repair errors.

- Node auto-repair is a best-effort service. It doesn't guarantee that your node can be restored to a `Ready` status. We recommend that you actively monitor on and set alerts for Node Not Ready issues, and troubleshoot and resolve these issues yourself. For more information, see [basic troubleshooting of Node Not Ready issues](./node-not-ready-basic-troubleshooting.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
