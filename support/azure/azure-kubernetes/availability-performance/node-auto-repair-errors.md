---
title: Troubleshoot common node auto-repair errors
description: Provides potential causes and solutions to common node auto-repair errors that occur when you repair a node with a NotReady status.
ms.date: 10/21/2024
ms.reviewer: juliayin, aritraghosh, shmalfat, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot common node auto-repair errors

This article provides potential causes and solutions to common node auto-repair errors, and outlines best practices for monitoring the node auto-repair process.

## Overview

When Azure Kubernetes Service (AKS) detects a node with a NotReady status for more than 5 minutes, it attempts to automatically repair the node. Node auto-repair is a best-effort service. It doesn't guarantee that the node can be restored to a healthy state. For more information, see [node auto-repair process](/azure/aks/node-auto-repair).

During the node auto-repair process, AKS initiates reboot, reimage, and redeploy actions on your unhealthy node. Errors can occur due to various reasons and error codes are discovered through [Kubernetes events](/azure/aks/events). You can use Kubernetes events to monitor the status of your node and the auto-repair actions.

## Kubernetes events

To identify the type of a node auto-repair error, check the following Kubernetes events:
 
| Reason | Event message | Description |
| --- | --- | --- |
| NodeRebootError | Node auto-repair reboot action failed due to an operation failure: [error code here] | Emitted when there's an error with the reboot action. |
| NodeReimageError | Node auto-repair reimage action failed due to an operation failure: [error code here] | Emitted when there's an error with the reimage action. |
| NodeRedeployError | Node auto-repair redeploy action failed due to an operation failure: [error code here] | Emitted when there's an error with the redeploy action. |

> [!NOTE]
> Because your node is already in an unhealthy state prior to the auto-repair process, in most cases, node auto-repair errors don't impact your cluster or applications. When you encounter node auto-repair errors, we recommend that you try to repair the node by following the instructions in [Basic troubleshooting of Node Not Ready failures](./node-not-ready-basic-troubleshooting.md). If you can't restore it to a Succeeded status and see persistent errors reported by node auto-repair, contact [Azure support](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) for assistance.

## Common error codes

| Error code | Causes & solution |
|---|---|
| VMExtensionProvisioningError | One or more virtual machine (VM) extensions failed to be provisioned on the VM. For more information about possible error types and troubleshooting steps, see [Troubleshoot the ERR_VHD_FILE_NOT_FOUND error code (124)](../create-upgrade-delete/error-code-vhdfilenotfound.md). To determine the exact VM extension provisioning error on the node, [view error details in the Azure portal](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md#view-resources-in-the-azure-portal). |
| InvalidParameter | It's an internal error that occurs when the node auto-repair process requests a VM that no longer exists. If you notice any new symptoms or interruptions on the node, contact Azure support. |
| scaleSetNameAndInstanceIDFromProviderID failed | It's an internal issue where the node might not be provisioned correctly. If you notice any new symptoms or interruptions on the node, contact Azure support. |
| ManagedIdentityCredential authentication failed | It's likely due to an internal issue where your nodes weren't initialized properly. If you notice any new symptoms or interruptions on your node, contact Azure support. |
| VMRedeploymentFailed | There was an error with redeploying your node, which might cause your node pool to enter a failed state. For more information about potential causes and troubleshooting steps, see [Troubleshoot Azure Kubernetes Service clusters or nodes in a failed state](./cluster-node-virtual-machine-failed-state.md#scenario-3-node-pool-is-in-a-failed-state). |
| TooManyVMRedeploymentRequests | This error occurs when your cluster exceeds the internal limit for VM redeployment requests. Redeploy is one of the node auto-repair actions. This error means that the redeploy action can't repair your node. We recommend that you troubleshoot your node's NotReady status to understand the root cause and resolve the node health issue. For more information, see [Basic troubleshooting of Node Not Ready failures](./node-not-ready-basic-troubleshooting.md). |
| OutboundConnectivityNotEnabledOnVMSS | This error occurs when your node or overall Virtual Machine Scale Set (VMSS) doesn't have outbound access enabled. To resolve this issue, enable secure outbound access for your VMSS by using a method that's best suited for your application. For more information, see ["OutboundConnectivityNotEnabledOnVM. No outbound connectivity configured for virtual machine."](../../virtual-machine-scale-sets/deploy/vmss-outbound-connectivity-not-enabled.md#solution) |

## Best practices for monitoring node auto-repair

- By default, AKS stores Kubernetes events from the past hour. We recommend enabling [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable#enable-container-insights) so that you can store events for up to 90 days, and [query events and configure alerts](/azure/aks/events#automating-event-notifications) to quickly detect node auto-repair errors.

- Node auto-repair is a best-effort service and doesn't guarantee that your node can be restored to Ready status. We recommend that you actively monitor and alert on node NotReady issues, and troubleshoot and resolve these issues yourself. For more information, see [basic troubleshooting of node NotReady issues](./node-not-ready-basic-troubleshooting.md).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]