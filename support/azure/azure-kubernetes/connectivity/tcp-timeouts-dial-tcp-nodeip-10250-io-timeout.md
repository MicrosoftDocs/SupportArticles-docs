---
title: TCP timeouts such as 10250 I/O timeouts
description: Troubleshoot TCP timeouts, such as the dial tcp <Node_IP> 10250 i/o timeout error, that occur when you use an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/19/2024
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why I'm receiving TCP timeouts (such as 'dial tcp <Node_IP>:10250: i/o timeout') so that I can use my Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Connectivity
---
# TCP timeouts such as "dial tcp <Node_IP>:10250: i/o timeout"

TCP timeouts may be related to blockages of internal traffic between nodes. Verify that this traffic isn't being blocked, such as by [network security groups](/azure/aks/concepts-security#azure-network-security-groups) (NSGs) on the subnet for your cluster's nodes.

## Symptoms
Tunnel functionalities, such as logs and code execution, work only for pods hosted on nodes where tunnel service pods are deployed. Pods on other nodes without tunnel service pods cannot reach to the tunnel. You receive the following error when viewing the logs of these pod.

```bash
kubectl logs <pod>

Error from server: Get "https://aks-agentpool-000000000-vmss000002:10250/containerLogs/vsm-mba-prod/mba-api-app-794f756bc5-5zfpw/technosvc": dial tcp <IP-Address>:10250: i/o timeout
```
## Solution
To resolve this issue, allow port 10250 in the network security group as described in this [article](tunnel-connectivity-issues.md).


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
