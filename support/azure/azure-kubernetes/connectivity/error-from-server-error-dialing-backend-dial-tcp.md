---
title: 'Error from server: error dialing backend: dial tcp'
description: 'Troubleshoot the Error from server: error dialing backend: dial tcp error that blocks you from using kubectl commands or other tools when connecting to the API server.'
ms.date: 10/21/2024
ms.reviewer: chiragpa, nickoman, v-leedennis, pihe
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "Error from server: error dialing backend: dial tcp" error so that I can connect to the API server, or use the `kubectl logs` command to get logs.
ms.custom: sap:Connectivity
---
# "Error from server: error dialing backend: dial tcp" message

## Symptoms

You receive an "Error from server: error dialing backend: dial tcp" error message when you take one of the following actions:

- Use any of the `kubectl` `logs`, `exec`, `attach`, `top`, `port-forward`
  command.
- Using thrird-party Kubernetes client tools to do the equivalent of above.

### What does it mean

The Kubernetes API server forwards API requests to an upstream component for several use cases. This error occurs when the API server can't establish a TCP connection to the upstream component. Upstream components include services like Kubernetes services within the cluster and Kubelet.

If the issue persists, a network blockage is likely the cause. To identify the responsible network configuration, first determine the scope of the problem:

### Narrowing down: Are all `kubectl` sub-commands failing?

Try running both `kubectl logs <podname>` and `kubectl top pods`.

If only `kubectl logs <podname>` or `kubectl exec` fails, check whether the issue occurs with pods on different nodes.

If only `kubectl top pods` fails, try to see if it fails for all nodes, or just for pods on one node. 

## Cause 1: kubelet port (node:10250) is blocked

For pod specific access failures, such as `kubectl logs` and `kubectl exec`, apiserver reaches node:10250 when it needs to access kubelet API. If the access is blocked by any component such as NSG, the connectivity fails.

Check if NSG on the node subnet includes a block inbound rule that might block port TCP port 10250.

## Cause 2: Specific service failing

Kubernetes accesses `svc/metrics-server` under `kube-system` namespace for `kubectl top` commands. There are other scenarios, such as
[admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/), that apiserver can reach other services as well. Noting that depending on the service failure pattern, the error message may be different.

## Cause 3: Konnectivity/tunnel failing

When not enabling [API Server VNet Integration](/azure/aks/api-server-vnet-integration), AKS deploys a tunnel solution proxying apiserver requests to in-cluster networking locations.

Most AKS clusters are using [Konnectivity](/azure/aks/faq#how-does-the-managed-control-plane-communicate-with-my-nodes-) solution which does not require opening special ports on apiserver. Review [AKS required network rules](/azure/aks/outbound-rules-control-egress#azure-global-required-network-rules) for detail.

Check if `konnectivity-agent` under `kube-system` namespace are in running, and containers in ready state. Try deleting the pods to see if connection recoversafter new pods become ready.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
