---
title: TCP timeouts such as 10250 I/O timeouts
description: Troubleshoot TCP timeouts, such as the dial tcp <Node_IP> 10250 i/o timeout error, that occur when you use an Azure Kubernetes Service (AKS) cluster.
ms.date: 06/01/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why I'm receiving TCP timeouts (such as 'dial tcp <Node_IP>:10250: i/o timeout') so that I can use my Azure Kubernetes Service (AKS) cluster successfully.
---
# TCP timeouts such as "dial tcp <Node_IP>:10250: i/o timeout"

TCP timeouts may be related to blockages of internal traffic between nodes. Verify that this traffic isn't being blocked, such as by [network security groups](/azure/aks/concepts-security#azure-network-security-groups) (NSGs) on the subnet for your cluster's nodes.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
