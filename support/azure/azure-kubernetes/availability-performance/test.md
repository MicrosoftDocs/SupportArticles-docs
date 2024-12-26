---
title: Troubleshoot common node auto-repair errors
description: Troubleshoot scenarios where node auto-repair returns an error code when trying to repair a node with a status of NotReady.
ms.date: 10/01/2024
ms.reviewer: 
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to make sure the automatic repair actions from AKS node auto-repair do not cause any impacts on my applications or cluster health.
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot common node auto-repair errors

When AKS detects a node which reports the NotReady status for more than 5 minutes, AKS will attempt to automatically repair your node. Node auto-repair is a best-effort service and does not guarantee that your node will be restored to a healthy state. Learn more about the [node auto-repair process](/azure/aks/node-auto-repair).

During the node auto-repair process, AKS will initiate reboot, reimage, and redeploy actions on your unhealthy node. These repair actions may encounter errors due to various underlying causes. The resulting error code is surfaced through a [Kubernetes event](/azure/aks/events), which you can use to monitor the status of your node and auto-repair actions. This article discusses common errors, together with their potential causes and next steps, as well as best practices for monitoring node auto-repair.

## Prerequisites
To determine what type of node auto-repair error has occured, look for one of the following Kubernetes events: 
| Reason | Event Message | Description |
| --- | --- | --- |
| NodeRebootError | Node auto-repair reboot action failed due to an operation failure: [error code here] | Emitted when there is an error with the reboot action. |
| NodeReimageError | Node auto-repair reimage action failed due to an operation failure: [error code here] | Emitted when there is an error with the reimage action. |
| NodeRedeployError | Node auto-repair redeploy action failed due to an operation failure: [error code here] | Emitted when there is an error with the redeploy action. |

> [!NOTE]
> In most cases, node auto-repair errors will not cause any impact to your cluster or applications since your node was already in an unhealthy state prior to the auto-repair process. When encountering node auto-repair errors, we recommend that you first attempt to repair the node yourself by following the instructions here: [Basic troubleshooting of Node Not Ready failures](./node-not-ready-basic-troubleshooting.md). If you are unable to restore your node back to a Succeeded status and are noticing persistent errors reported by node auto-repair, you may be encountering a rare issue and should reach out to Azure support.

## Common error codes
The table below contains the most common node auto-repair errors.

| Error code | Causes & Solution |
|---|---|
| VMExtensionProvisioningError | One or more VM extensions failed to be provisioned on the VM. Read more on possible error types and troubleshooting steps at [Troubleshoot the ERR_VHD_FILE_NOT_FOUND error code (124)](../create-upgrade-delete/error-code-vhdfilenotfound.md). To determine the exact VM extension provisioning error on your node, read more at [View error details in the Azure portal](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md#view-resources-in-the-azure-portal). |
| InvalidParameter | This is an internal error which occurs when the node auto-repair process requests a VM that no longer exists. If you notice any new symptoms or interruptions on your node, please reach out to Azure support. |
| scaleSetNameAndInstanceIDFromProviderID failed | This is an internal issue where the node may not have been provisioned correctly. If you notice any new symptoms or interruptions on your node, please reach out to Azure support. |
| ManagedIdentityCredential authentication failed | This is likely due to an internal issue where your nodes were not initialized properly. If you notice any new symptoms or interruptions on your node, please reach out to Azure support. |
| VMRedeploymentFailed | There was an error with redeploying your node. This may cause your nodepool to enter a failed state. Read more on potential causes and next steps at [Troubleshoot Azure Kubernetes Service clusters or nodes in a failed state](./cluster-node-virtual-machine-failed-state.md#scenario-3-node-pool-is-in-a-failed-state). |
| TooManyVMRedeploymentRequests | This error occurs when your cluster exceeds the internal limit for VM redeployment requests. Redeploy is one of the node auto-repair actions, which means that we are unable to repair your node using redeploy actions. We recommend that you  troubleshoot your node's NotReady status to understand the root cause and resolve the node health issue. Read more at [Basic troubleshooting of Node Not Ready failures](./node-not-ready-basic-troubleshooting.md). |
| OutboundConnectivityNotEnabledOnVMSS | This error occurs when your node or overall Virtual Machine Scale Set (VMSS) does not have outbound access enabled. Enable secure outbound access for your VMSS by using a method that's best suited for your application. Read more about the methods at [OutboundConnectivityNotEnabledOnVM. No outbound connectivity configured for virtual machine](../../virtual-machine-scale-sets/deploy/vmss-outbound-connectivity-not-enabled.md#solution). |

## Best practices for monitoring
- By default, AKS stores Kubernetes events from the past hour. We recommend that you to enable [Container Insights](/azure/azure-monitor/containers/kubernetes-monitoring-enable#enable-container-insights) so that you can store events for up to 90 days. Enabling Container Insights will also allow you to [query events and configure alerts](/azure/aks/events#automating-event-notifications) to quickly detect node auto-repair errors.
- Node auto-repair is a best-effort service and does not guarantee that your node will be restored back to Ready status. We highly recommend that you actively monitor and alert on node NotReady issues, and conduct your own troubleshooting and resolution of these issues. See [basic troubleshooting of node NotReady issues](./node-not-ready-basic-troubleshooting.md) for more details.