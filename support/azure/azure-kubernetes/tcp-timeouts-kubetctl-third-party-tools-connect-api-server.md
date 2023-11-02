---
title: TCP time-outs when kubectl, other 3rd-party tools connect to API
description: Troubleshoot TCP time-outs that occur when kubectl or other third-party tools connect to the API server in Azure Kubernetes Service (AKS).
ms.date: 06/09/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot TCP connection time-outs that occur when kubectl or other third-party tools connect to the API server so that my Azure Kubernetes Service (AKS) cluster operates successfully.
---
# TCP time-outs when kubectl or other third-party tools connect to the API server

This article discusses how to troubleshoot TCP time-outs that occur when [kubectl](https://kubernetes.io/docs/reference/kubectl/) or other third-party tools are used to connect to the API server in Microsoft Azure Kubernetes Service (AKS). To ensure its service-level objectives (SLOs) and service-level agreements (SLAs), AKS uses high-availability (HA) control planes that scale vertically and horizontally, based on the number of cores.

## Symptoms

You experience repeated connection time-outs.

## Cause 1: Pods that are responsible for node-to-control plane communication aren't running

If only a few of your API commands are timing out consistently, the following pods might not be in a running state:

- `konnectivity-agent`
- `tunnelfront`
- `aks-link`

These pods are responsible for communication between a node and the control plane.

### Solution: Reduce the utilization or stress of the node hosts

Make sure the nodes that host this pod aren't overly utilized or under stress. Consider moving the nodes to their own [system node pool](/azure/aks/use-system-pools).

## Cause 2: Access is blocked on some required ports, FQDNs, and IP addresses

If the required ports, fully qualified domain names (FQDNs), and IP addresses aren't all opened, several command calls might fail. Secure, tunneled communication on AKS between the API server and the [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) (through the `konnectivity-agent` pod) requires some of those items to work successfully.

### Solution: Open the necessary ports, FQDNs, and IP addresses

For more information about what ports, FQDNs, and IP addresses need to be opened, see [Control egress traffic for cluster nodes in Azure Kubernetes Service (AKS)](/azure/aks/limit-egress-traffic).

## Cause 3: The Application-Layer Protocol Negotiation TLS extension is blocked

To establish a connection between the control plane and nodes, the `konnectivity-agent` pod requires the [Transport Layer Security (TLS) extension for Application-Layer Protocol Negotiation (ALPN)](https://datatracker.ietf.org/doc/html/rfc7301). You might have previously blocked this extension.

### Solution: Enable the ALPN extension

Enable the ALPN extension on the `konnectivity-agent` pod to prevent TCP time-outs.

## Cause 4: The API server's IP authorized ranges doesn't cover your current IP address

If you use authorized IP address ranges on your API server, your API calls will be blocked if your IP isn't included in the authorized ranges.

### Solution: Modify the authorized IP address ranges so that it covers your IP address

Change the authorized IP address ranges so that your IP address is covered. For more information, see [Update a cluster's API server authorized IP ranges](/azure/aks/api-server-authorized-ip-ranges#update-a-clusters-api-server-authorized-ip-ranges).

## Cause 5: A client or application leaks calls to the API server

Frequent GET calls can accumulate and overload the API server.

### Solution: Use watches instead of GET calls, but make sure the application doesn't leak those calls

Make sure that you use watches instead of frequent GET calls to the API server. You also have to make sure that your third-party applications don't leak any watch connections or GET calls. For example, in the [Istio microservice architecture](https://istio-releases.github.io/v0.1/docs/concepts/what-is-istio/overview.html), a [bug in the mixer application](https://github.com/istio/istio/issues/19481) creates a new API server watch connection whenever a secret is read internally. Because this behavior happens at a regular interval, the watch connections quickly accumulate. These connections eventually cause the API server to become overloaded no matter the scaling pattern.

## Cause 6: Too many releases in your Helm deployments

If you use too many releases in your deployments of [Helm](https://helm.sh/) (the Kubernetes package manager), the nodes start to consume too much memory. It also results in a large amount of `ConfigMap` (configuration data) objects, which might cause unnecessary usage spikes on the API server.

### Solution: Limit the maximum number of revisions for each release

Because the maximum number of revisions for each release is infinite by default, you need to run a command to set this maximum number to a reasonable value. For Helm 2, the command is [helm init](https://v2.helm.sh/docs/helm/#helm-init). For Helm 3, the command is [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/). Set the `--history-max <value>` parameter when you run the command.

| Version | Command                                                                        |
|---------|--------------------------------------------------------------------------------|
| Helm 2  | `helm init --history-max <maximum-number-of-revisions-per-release> ...`        |
| Helm 3  | `helm upgrade ... --history-max <maximum-number-of-revisions-per-release> ...` |

## Cause 7: Internal traffic between nodes is being blocked

There might be internal traffic blockages between nodes in your AKS cluster.

### Solution: Troubleshoot the "dial tcp <Node_IP>:10250: i/o timeout" error

See [Troubleshoot TCP timeouts, such as "dial tcp <Node_IP>:10250: i/o timeout"](tcp-timeouts-dial-tcp-nodeip-10250-io-timeout.md).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
