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
Tunnel functionalities (such as logs and code execution) will work for only the pods that are scheduled on the nodes where tunnel pods are scheduled. The other pods won't work because their nodes won't be able to reach the tunnel, and the tunnel is scheduled on other nodes.

```bash
//commands like `kubectl logs` and `kubectl exec`.
kubectl logs po/mba-api-app-794f756bc5-5zfpw -n vsm-mba-prod
Error from server: Get "https://aks-agentpool-12774896-vmss000002:10250/containerLogs/vsm-mba-prod/mba-api-app-794f756bc5-5zfpw/technosvc": dial tcp 10.254.40.226:10250: i/o timeout
```
## Solution
You need to allow port 10250 as described in this [article](tunnel-connectivity-issues.md).



[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
