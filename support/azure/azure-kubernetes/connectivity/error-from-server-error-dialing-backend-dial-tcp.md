---
title: Error from server - error dialing backend - dial tcp message in AKS
description: Fix Error from server - error dialing backend - dial tcp message in AKS to restore kubectl logs, exec, and top access. Use this guide to quickly find and resolve the network block.
ms.date: 11/02/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, nickoman, v-leedennis, pihe, mariusbutuc, kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "Error from server: error dialing backend: dial tcp" error so that I can connect to the API server or use the `kubectl logs` command to get logs.
ms.custom: sap:Connectivity
ai-usage: ai-assisted
---
# "Error from server: error dialing backend: dial tcp" message in Azure Kubernetes Service

## Summary

This article helps you troubleshoot the "Error from server: error dialing backend: dial tcp" error in Azure Kubernetes Service (AKS) so you can restore `kubectl logs`, `exec`, and `top` access. The error indicates that the API server can't connect to an upstream component, like a Kubernetes service or kubelet, that certain operations require.

## Symptoms

You receive an "Error from server: error dialing backend: dial tcp" error message when you take one of the following actions:

- Use any of the `kubectl` `logs`, `exec`, `attach`, `top`, or `port-forward` commands.
- Use third-party Kubernetes client tools to achieve the same functionality as the commands in the previous list item.

### Why the dial tcp error occurs

The Kubernetes API server has to forward API requests to an upstream component for several use cases. This error occurs if the API server can't establish a Transmission Control Protocol (TCP) connection to the upstream component. Examples of such upstream components include Kubernetes services that are inside the cluster and kubelet.

If the issue persists, a network blockage is likely the cause. To identify the responsible network configuration, determine the scope of the problem.

### Determine whether all `kubectl` subcommands fail

Try to run at least the `kubectl exec`, `kubectl logs <podname>`, and `kubectl top pods` commands. Use the following guidance to interpret the results.

- If only `kubectl logs <podname>` or `kubectl exec` fails, check whether the issue occurs by having pods on different nodes.
- If only `kubectl top pods` fails, check whether the issue occurs for pods on all nodes or only for pods on one node. 

## Cause 1: Kubelet port 10250 is blocked

Pod-specific access issues, such as those that occur when you run `kubectl logs` and `kubectl exec`, happen if the API server can't reach the node on port 10250 to access the Kubelet API. A network security group (NSG) or firewall might block the connection.

To resolve the issue, check whether the NSG on the node subnet includes an inbound rule that blocks TCP port 10250.

## Cause 2: Specific service failure

Kubernetes accesses `svc/metrics-server` under the `kube-system` namespace to run `kubectl top` commands. In other scenarios, such as [admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/), the API server can reach other services. The error message can vary depending on the service failure pattern.

To troubleshoot the issue, check the error message to identify which service is affected. Review the status of the related pods, services, and endpoints.

## Cause 3: Konnectivity or tunnel failure

When you don't enable [API Server VNet Integration](/azure/aks/api-server-vnet-integration), AKS deploys a tunnel solution that proxies API server requests to in-cluster networking locations. Most AKS clusters use the Konnectivity solution. Konnectivity doesn't require you to open special ports on the API server. For more information, see [AKS required network rules](/azure/aks/outbound-rules-control-egress#azure-global-required-network-rules).

To resolve the issue, check whether the `konnectivity-agent` in the `kube-system` namespace is running and its containers are in a ready state. Try deleting the pods to see whether the connection recovers after the new pods are ready.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]