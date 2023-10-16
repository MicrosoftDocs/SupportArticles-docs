---
title: Node not ready but then recovers
description: Troubleshoot scenarios in the status of an Azure Kubernetes Service (AKS) cluster node is Node Not Ready, but then the node recovers.
ms.date: 04/15/2022
ms.reviewer: rissing, chiragpa, momajed, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-node-not-ready
#Customer intent: As an Azure Kubernetes user, I want to prevent the Node Not Ready status for nodes that later recover so that I can avoid future errors within an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot Node Not Ready failures that are followed by recoveries

This article helps troubleshoot scenarios in which a node within a Microsoft Azure Kubernetes Service (AKS) cluster shows the Node Not Ready status, but then automatically recovers to a healthy state.

## Symptoms

You notice that your application stops responding while the node is reporting that it has a Not Ready status. However, the node recovers automatically, and now, it's looking for a root cause analysis (RCA).

## Cause

Possible causes of this issue include the following scenarios:

- The API server isn't available, and you're using a readiness probe for the deployment.

  If a pod is running but isn't ready, that situation means that the readiness probe is failing. If the readiness probe fails, the pod isn't attached to the service, and traffic isn't forwarded to the pod instance.

- Virtual machine (VM) host faults occur. To determine whether VM host faults occurred, check the following information sources:
  - [AKS diagnostics](/azure/aks/concepts-diagnostics)
  - [Azure status](https://status.azure.com/)
  - Azure notifications (for any recent outages or maintenance periods)

## Prevention

To prevent this issue from occurring in the future, take one or more of the following actions:

- Make sure that your service tier is fully paid for.
- Reduce the number of `watch` and `get` requests to the API server.
- Replace the node pool with a healthy node pool.

## More information

- For general troubleshooting steps, see [Basic troubleshooting of Node Not Ready failures](node-not-ready-basic-troubleshooting.md).
