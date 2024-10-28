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

- Use any of the `kubectl` `logs`, `exec`, `attach`, `top`, `port-forward` command.
- Use third-party Kubernetes client tools to achieve the same functionality as mentioned above.

### Why the error occurs

The Kubernetes API server need to forward API requests to an upstream component for several use cases. This error occurs when the API server can't establish a TCP connection to the upstream component. Example of such upstream components include kubernetes services inside the cluster and kubelet.

If the issue persists, a network blockage is likely the cause. To identify the responsible network configuration, first determine the scope of the problem:

### Narrowing down: Are all `kubectl` sub-commands failing?

Try running at least `kubectl exec`, `kubectl logs <podname>` and `kubectl top pods` commands.

If only `kubectl logs <podname>` or `kubectl exec` fails, check whether the issue occurs with pods on different nodes.

If only `kubectl top pods` fails, check whether the issue occurs with all nodes, or just occurs with pods on one node. 

## Cause 1: kubelet port (node:10250) is blocked

For pod-specific access issues, such as those encountered with `kubectl logs` and `kubectl exec`, they occur when the API server cannot reach the node on port 10250 to access the Kubelet API. It can be caused by the connection is blocked a Network Security Group (NSG) or firewall.

To resolve the issue, check if the NSG on the node subnet includes an inbound rule that might block TCP port 10250.

## Cause 2: Specific service failing

Kubernetes accesses `svc/metrics-server` under the `kube-system` namespace for executing kubectl top commands. There are other scenarios, such as [admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/), where the API server can also reach other services. It is important to note that depending on the service failure pattern, the error message may vary.

## Cause 3: Konnectivity or tunnel failing

When [API Server VNet Integration](/azure/aks/api-server-vnet-integration) is not enabled, AKS deploys a tunnel solution that proxies API server requests to in-cluster networking locations. Most AKS clusters use the Konnectivity solution, which does not require opening special ports on the API server. For information, see [AKS required network rules](/azure/aks/outbound-rules-control-egress#azure-global-required-network-rules).

To resolve the issue, check if the `konnectivity-agent` in the `kube-system` namespace is running and if its containers are in a ready state. Try to delete the pods to see if the connection recovers once the new pods are ready.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
