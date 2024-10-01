---
title: Troubleshoot common node auto-repair errors
description: Troubleshoot scenarios where node auto-repair returns an error code when trying to repair your NotReady node.
ms.date: 10/01/2024
ms.reviewer: 
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to make sure the automatic repair actions from AKS node auto-repair do not cause any impacts on my applications or cluster health.
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot common node auto-repair errors

When AKS detects a node which reports the NotReady status for more than 5 minutes, we will attempt to automatically repair your node. Learn more about the node auto-repair process [here](https://learn.microsoft.com/en-us/azure/aks/node-auto-repair).

During this process, AKS will initiate reboot, reimage, and redeploy actions on your unhealthy node. These repair actions may be unsuccessful due to an underlying cause, resulting in an error code. This article will discuss common errors with their potential causes and next steps, as well as best practices for monitoring node auto-repair.

## Prerequisites
To determine what type of node auto-repair error has occured, you will need to look for the following Kubernetes event: 
"Node auto-repair [reboot/reimage/redeploy] action failed due to an operation failure: [error code]."

## Common error codes
The table below contains the most common node auto-repair errors.

| Error code | Potential causes | Next steps |
|---|---|---|
| ClientSecretCredential authentication failed |  |  |
| ARM ErrorCode: VMExtensionProvisioningError |  |  |
| ARM ErrorCode: InvalidParameter |  |  |
| scaleSetNameAndInstanceIDFromProviderID failed |  |  |
| ManagedIdentityCredential authentication failed |  |  |
| ARM ErrorCode: VMRedeploymentFailed |  |  |
| ARM ErrorCode: TooManyVMRedeploymentRequests |  |  |
| ARM ErrorCode: OutboundConnectivityNotEnabledOnVMSS |  |  |
| ARM ErrorCode: NotFound |  |  |


## Best practices for monitoring

- By default, AKS stores Kubernetes events from the past 1 hour. We recommend for you to enable Container Insights to store events for up to 90 days. Enabling Container Insights will also allow you to query events and configure alerts to quickly detect node auto-repair errors.
- Configure alerts to quickly detect when node auto-repair errors occur. To configure an alert on a specific event, see instructions [here](LINK).
- Node auto-repair is a best-effort service and does not guarantee that your node will be restored back to Ready status. We highly recommend that you actively monitor and alert on node NotReady issues, and conduct your own troubleshooting and resolution of these issues. See [basic troubleshooting of node NotReady issues](LINK) for more details.
