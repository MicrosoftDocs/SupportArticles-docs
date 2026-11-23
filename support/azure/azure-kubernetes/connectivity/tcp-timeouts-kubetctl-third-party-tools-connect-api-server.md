---
title: TCP time-outs when kubectl or other third-party tools connect to API in AKS
description: Troubleshoot TCP time-outs when kubectl or third-party tools connect to the API server in Azure Kubernetes Service (AKS). Review the causes and apply solutions.
ms.topic: troubleshooting
ms.date: 11/04/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, rissing, v-leedennis, kaushika
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity,innovation-engine
ai-usage: ai-assisted
---

# TCP time-outs when kubectl or other third-party tools connect to the API server in Azure Kubernetes Service

## Summary

This article helps you troubleshoot Transmission Control Protocol (TCP) time-outs that occur when [kubectl](https://kubernetes.io/docs/reference/kubectl/) or other third-party tools connect to the API server in Azure Kubernetes Service (AKS). Use it to identify the cause of repeated connection time-outs and apply the matching solution. To ensure its service-level objectives (SLOs) and service-level agreements (SLAs), AKS uses high-availability (HA) control planes that scale vertically and horizontally, based on the number of cores.

## Symptoms

You experience repeated connection time-outs.

## Cause 1: Pods that handle node-to-control plane communication aren't running

If only a few of your API commands consistently time out, the following pods might not be running:

- `konnectivity-agent`
- `tunnelfront`
- `aks-link`

> [!NOTE]
> In newer AKS versions, `tunnelfront` and `aks-link` are replaced with `konnectivity-agent`, so you only see `konnectivity-agent`.

These pods handle communication between a node and the control plane.

### Solution: Reduce the utilization or stress of the node hosts

Ensure the nodes that host these pods aren't overly utilized or under stress. Consider moving the nodes to their own [system node pool](/azure/aks/use-system-pools).

To check which node hosts the `konnectivity-agent` pod and the usage of the node, run the following commands.

Set access to the AKS cluster. Replace the values of `ResourceGroupName` and `AKSClusterName` with your own.

```bash
az aks get-credentials --resource-group ${ResourceGroupName} --name ${AKSClusterName} --overwrite-existing
```

Check the running pods in the kube-system namespace and which node each one is assigned to.

```bash
kubectl get pod -n kube-system -o wide
```

The following are the expected results.

<!-- expected_similarity=0.3 -->

```output
NAME                                READY   STATUS    RESTARTS   AGE     IP             NODE                                NOMINATED NODE   READINESS GATES
konnectivity-agent-xxxxx            1/1     Running   0          22h     10.xxx.xx.xxx  aks-nodepool1-xxxxx-vmss000000      <none>           <none>
coredns-xxxxx                       1/1     Running   0          22h     10.xxx.xx.xxx  aks-nodepool1-xxxxx-vmss000001      <none>           <none>
# ...other pods...
```

Check the usage of the nodes and see the resource utilization for each node.

```bash
kubectl top node
```

The following are the expected results.

<!-- expected_similarity=0.3 -->

```output
NAME                                CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
aks-nodepool1-xxxxx-vmss000000      125m         12%    1510Mi          37% 
aks-nodepool1-xxxxx-vmss000001      106m         10%    1203Mi          42% 
# ...other nodes...
```

## Cause 2: Access is blocked on some required ports, FQDNs, and IP addresses

If you don't open the required ports, fully qualified domain names (FQDNs), and IP addresses, several command calls might fail. Secure, tunneled communication on AKS between the API server and the [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) (through the `konnectivity-agent` pod) requires some of those items to work successfully.

### Solution: Open the necessary ports, FQDNs, and IP addresses

For more information about what ports, FQDNs, and IP addresses you need to open, see [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress).

## Cause 3: The Application-Layer Protocol Negotiation TLS extension is blocked

To establish a connection between the control plane and nodes, the `konnectivity-agent` pod requires the [Transport Layer Security (TLS) extension for Application-Layer Protocol Negotiation (ALPN)](https://datatracker.ietf.org/doc/html/rfc7301). You might have previously blocked this extension.

### Solution: Enable the ALPN extension

Enable the ALPN extension on the `konnectivity-agent` pod to prevent TCP time-outs.

## Cause 4: The API server's IP authorized ranges don't cover your current IP address

If you use authorized IP address ranges on your API server, your API calls are blocked if your IP isn't included in the authorized ranges.

### Solution: Modify the authorized IP address ranges so that they cover your IP address

Change the authorized IP address ranges so that they cover your IP address. For more information, see [Update a cluster's API server authorized IP ranges](/azure/aks/api-server-authorized-ip-ranges#update-a-clusters-api-server-authorized-ip-ranges).

## Cause 5: A client or application leaks calls to the API server

Frequent GET calls can accumulate and overload the API server.

### Solution: Use watches instead of GET calls, but make sure the application doesn't leak those calls

Ensure that you use watches instead of frequent GET calls to the API server. You also have to ensure that your third-party applications don't leak any watch connections or GET calls. For example, in the [Istio microservice architecture](https://istio-releases.github.io/v0.1/docs/concepts/what-is-istio/overview.html), a [bug in the mixer application](https://github.com/istio/istio/issues/19481) creates a new API server watch connection whenever a secret is read internally. Because this behavior happens at a regular interval, the watch connections quickly accumulate. These connections eventually cause the API server to become overloaded no matter the scaling pattern.

## Cause 6: Too many releases in your Helm deployments

If you use too many releases in your deployments of [Helm](https://helm.sh/) (the Kubernetes package manager), the nodes start to consume too much memory. It also results in a large number of `ConfigMap` (configuration data) objects, which might cause unnecessary usage spikes on the API server.

### Solution: Limit the maximum number of revisions for each release

Because the maximum number of revisions for each release is infinite by default, you need to run a command to set this maximum number to a reasonable value. For Helm 2, the command is [helm init](https://v2.helm.sh/docs/helm/#helm-init). For Helm 3, the command is [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/). Set the `--history-max <value>` parameter when you run the command.

The following table summarizes the commands for setting the maximum number of revisions for each Helm version.

| Version | Command                                                                        |
|---------|--------------------------------------------------------------------------------|
| Helm 2  | `helm init --history-max <maximum-number-of-revisions-per-release> ...`        |
| Helm 3  | `helm upgrade ... --history-max <maximum-number-of-revisions-per-release> ...` |

## Cause 7: Internal traffic between nodes is blocked

There might be internal traffic blockages between nodes in your AKS cluster.

### Solution: Troubleshoot the "dial tcp <Node_IP>:10250: i/o timeout" error

For more information, see [Troubleshoot TCP timeouts, such as "dial tcp <Node_IP>:10250: i/o timeout"](tcp-timeouts-dial-tcp-nodeip-10250-io-timeout.md).

## Cause 8: Your cluster is private

Your cluster is a private cluster, but the client you're using to access the API server is in a public or different network that can't connect to the subnet used by AKS.

### Solution: Use a client that can access the AKS subnet

Since your cluster is private and its control plane is in the AKS subnet, you can't connect to the API server unless you're in a network that can connect to the AKS subnet. This limitation is expected.

In this case, try to access the API server from a client in a network that can communicate with the AKS subnet. Also, verify that network security groups (NSGs) or other appliances between networks aren't blocking packets.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

 