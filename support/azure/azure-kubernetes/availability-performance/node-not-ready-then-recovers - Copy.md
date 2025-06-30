---
title: Node not ready but then recovers
description: Troubleshoot scenarios in which the status of an AKS cluster node is Node Not Ready, but then the node recovers.
ms.date: 2/25/2024
ms.reviewer: rissing, chiragpa, momajed, v-leedennis, novictor
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to prevent the Node Not Ready status for nodes that later recover so that I can avoid future errors within an AKS cluster.
ms.custom: sap:Node/node pool availability and performance
---
# Troubleshoot Node Not Ready failures that are followed by recoveries

This article provides a guide to troubleshoot and resolve Node Not Ready" issues in Azure Kubernetes Service (AKS) clusters. When a node enters a "NotReady" state, it can disrupt the application's functionality and cause it to stop responding. Typically, the node recovers automatically after a short period. However, to prevent recurring issues and maintain a stable environment, it's important to understand the underlying causes to be able to implement effective resolutions.  

## Cause

There are several scenarios that could cause a "NotReady" state to occur:

- The unavailability of the API server. This causes the readiness probe to fail. This prevents the pod from being attached to the service so that traffic is no longer forwarded to the pod instance.

- Virtual machine (VM) host faults. To determine whether VM host faults occurred, check the following information sources:
  - [AKS diagnostics](/azure/aks/concepts-diagnostics)
  - [Azure status](https://status.azure.com/)
  - Azure notifications (for any recent outages or maintenance periods)

## Resolution

To resolve this issue, follow these steps:

1. Run `kubectl describe node <node-name>` to review detail information about the node's status. Look for any error messages or warnings that might indicate the root cause of the issue.
2. Check the API server availability by running the `kubectl get apiservices` command. Make sure that the readiness probe is correctly configured in the deployment YAML file.
3. Verify the node's network configuration to make sure that there are no connectivity issues.
4. Check the node's resource usage, such as CPU, memory, and disk, to identify potential constraints. For more information, see [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze#view-performance-directly-from-a-cluster).

For further steps, see [Basic troubleshooting of Node Not Ready failures](node-not-ready-basic-troubleshooting.md).

## Prevention

To prevent this issue from occurring in the future, take one or more of the following actions:

- Make sure that your service tier is fully paid for.
- Reduce the number of `watch` and `get` requests to the API server.
