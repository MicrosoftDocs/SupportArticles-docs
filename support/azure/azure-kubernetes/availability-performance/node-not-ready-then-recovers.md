---
title: Troubleshoot Node Not Ready failures followed by recoveries in AKS
description: Learn how to troubleshoot AKS Node Not Ready events that recover, identify root causes, and apply preventive actions to avoid repeat outages. Start now.
ms.date: 10/27/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, momajed, v-leedennis, novictor, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to prevent the Node Not Ready status for nodes that later recover so that I can avoid future errors within an AKS cluster.
ms.custom: sap:Node/node pool availability and performance
ai-usage: ai-assisted
---
# Troubleshoot Node Not Ready failures followed by recoveries in Azure Kubernetes Service 

## Summary

This article helps you troubleshoot **Node Not Ready** failures in Azure Kubernetes Service (AKS) clusters that recover on their own, so you can find root causes and prevent repeat outages. When a node enters a **NotReady** state, it disrupts the application's functionality and causes it to stop responding. Typically, the node recovers automatically after a short period. However, to prevent recurring problems and maintain a stable environment, you need to understand the underlying causes so you can implement effective resolutions.  

## Cause

The following scenarios can cause a **NotReady** state:

- The unavailability of the API server. This condition causes the readiness probe to fail. This failure prevents the pod from being attached to the service so that traffic is no longer forwarded to the pod instance.
- Virtual machine (VM) host faults. To determine whether VM host faults occurred, check the following information sources:
  - [AKS diagnostics](/azure/aks/concepts-diagnostics)
  - [Azure status](https://status.azure.com/)
  - Azure notifications (for any recent outages or maintenance periods)

## Resolution

To resolve this issue, follow these steps:

1. Run `kubectl describe node <node-name>` to review detailed information about the node's status. Look for any error messages or warnings that might indicate the root cause of the problem.
1. Check the API server availability by running the `kubectl get apiservices` command. Make sure that the readiness probe is correctly configured in the deployment YAML file.
1. Verify the node's network configuration to make sure that there are no connectivity problems.
1. Check the node's resource usage, like CPU, memory, and disk, to identify potential constraints. For more information, see [Monitor your Kubernetes cluster performance with Container insights](/azure/azure-monitor/containers/container-insights-analyze#view-performance-directly-from-a-cluster).

For further steps, see [Basic troubleshooting of Node Not Ready failures](node-not-ready-basic-troubleshooting.md).

## Prevention

To prevent this issue, take one or more of the following actions:

- Ensure that you pay for your service tier.
- Reduce the number of `watch` and `get` requests to the API server.
