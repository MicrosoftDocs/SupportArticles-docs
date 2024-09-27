---
title: TCP 10250 I/O timeout errors when connecting to a node's Kubelet for log retrieval
description: Learn how to troubleshoot TCP 10250 I/O timeout errors that occur when retrieving kubectl logs from a pod in an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/19/2024
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why I'm receiving TCP timeouts (such as 'dial tcp <Node_IP>:10250: i/o timeout') so that I can use my Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Connectivity
---
# 10250 I/O timeouts error when running kubectl log command

TCP timeouts can be caused by blockages of internal traffic that runs between nodes. To investigate TCP time-outs, verify that this traffic isn't being blocked, for example, by [network security groups](/azure/aks/concepts-security#azure-network-security-groups) (NSGs) on the subnet for your cluster nodes.

## Symptoms
Tunnel functionalities, such as `kubectl logs` and code execution, work only for pods that are hosted on nodes on which tunnel service pods are deployed. Pods on other nodes that have no tunnel service pods cannot reach to the tunnel. When viewing the logs of these pods, you receive the following error message:

```bash
kubectl logs <pod>

Error from server: Get "https://aks-agentpool-000000000-vmss000002:10250/containerLogs/vsm-mba-prod/mba-api-app-794f756bc5-5zfpw/technosvc": dial tcp <IP-Address>:10250: i/o timeout
```


## Solution

To resolve this issue, allows traffic on port 10250 as described in this [article](tunnel-connectivity-issues.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
