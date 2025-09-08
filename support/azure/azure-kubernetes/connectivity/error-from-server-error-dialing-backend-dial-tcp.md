---
title: 'Error from server: error dialing backend: dial tcp'
description: 'Troubleshoot the error dialing backend: dial tcp error that blocks you from using kubectl commands or other tools when you connect to the API server.'
ms.date: 03/05/2025
ms.reviewer: chiragpa, nickoman, v-leedennis, pihe, mariusbutuc
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "Error from server: error dialing backend: dial tcp" error so that I can connect to the API server or use the `kubectl logs` command to get logs.
ms.custom: sap:Connectivity
---
# "Error from server: error dialing backend: dial tcp" message

## Symptoms

You receive an "Error from server: error dialing backend: dial tcp" error message when you take one of the following actions:

- Use any of the `kubectl` `logs`, `exec`, `attach`, `top`, or `port-forward` commands.
- Use third-party Kubernetes client tools to achieve the same functionality as the commands in the previous list item.

### Why the error occurs

The Kubernetes API server has to forward API requests to an upstream component for several use cases. This error occurs if the API server can't establish a TCP connection to the upstream component. Example of such upstream components include kubernetes services that are inside the cluster and kubelet.

If the issue persists, a network blockage is likely the cause. To identify the responsible network configuration, first determine the scope of the problem.

### Narrowing down: Are all `kubectl` sub-commands failing?

Try to run at least the `kubectl exec`, `kubectl logs <podname>`, and `kubectl top pods` commands.

If only `kubectl logs <podname>` or `kubectl exec` fails, check whether the issue occurs by having pods on different nodes.

If only `kubectl top pods` fails, check whether the issue occurs for pods on all nodes or only for pods on one node. 

## Cause 1: kubelet port (node:10250) is blocked

Pod-specific access issues, such as those that are experienced by running `kubectl logs` and `kubectl exec`, occur if the API server cannot reach the node on port 10250 to access the Kubelet API. These issues can be caused by a connection that's blocked by a Network Security Group (NSG) or firewall.

To resolve the issue, check whether the NSG on the node subnet includes an inbound rule that might block TCP port 10250.

## Cause 2: Specific service failing

Kubernetes accesses `svc/metrics-server` under the `kube-system` namespace for running kubectl top commands. There are other scenarios, such as [admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/), in which the API server can also reach other services. It is important to note that, depending on the service failure pattern, the error message may vary.

To troubleshoot the issue, check the error message to identify which service is affected and review the status of the related pods, services, and endpoints.

## Cause 3: Konnectivity or tunnel failing

When [API Server VNet Integration](/azure/aks/api-server-vnet-integration) is not enabled, AKS deploys a tunnel solution that proxies API server requests to in-cluster networking locations. Most AKS clusters use the Konnectivity solution. Konnectivity does not require that you open special ports on the API server. For more information, see [AKS required network rules](/azure/aks/outbound-rules-control-egress#azure-global-required-network-rules).

To resolve the issue, check whether the `konnectivity-agent` in the `kube-system` namespace is running and its containers are in a ready state. Try to delete the pods to see whether the connection recovers after the new pods are ready.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
