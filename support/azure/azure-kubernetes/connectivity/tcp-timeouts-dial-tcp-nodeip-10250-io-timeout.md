---
title: Troubleshoot TCP 10250 I/O timeout errors when connecting to a node's Kubelet for log retrieval in AKS
description: Fix TCP 10250 i/o timeout errors when running kubectl logs in AKS. Follow these troubleshooting steps to restore log access quickly.
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.date: 11/03/2026
ms.reviewer: chiragpa, nickoman, v-leedennis, kaushika
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why I'm receiving TCP timeouts (such as 'dial tcp <Node_IP>:10250: i/o timeout') so that I can use my Azure Kubernetes Service (AKS) cluster successfully.
ms.custom: sap:Connectivity, innovation-engine
ai-usage: ai-assisted
---

# Troubleshoot 10250 I/O timeout errors when running kubectl log command in Azure Kubernetes Service

## Summary

A TCP 10250 i/o timeout error when you run `kubectl logs` often occurs when internal traffic between cluster nodes is blocked. This article helps you check whether [network security groups](/azure/aks/concepts-security#azure-network-security-groups) (NSGs) block required node subnet traffic so that you can restore log retrieval.

## Connect to the AKS cluster

First, connect to your Azure Kubernetes Service (AKS) cluster by running the following command.

```bash
export RESOURCE_GROUP=<your-resource-group>
export CLUSTER_NAME=<your-cluster-name>

az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME
```

## Symptoms

Tunnel functionalities, such as `kubectl logs` and code execution, work only for pods that are hosted on nodes where tunnel service pods are deployed. Pods on other nodes that don't have tunnel service pods can't reach the tunnel. When you view the logs of these pods, you receive the following error message.

```bash
kubectl logs $POD_NAME
```

The following error messages appear.

<!-- expected_similarity=0.3 -->

```output
Error from server: Get "https://aks-agentpool-xxxxxxxxx-vmssxxxxxxxxx:10250/containerLogs/vsm-mba-prod/mba-api-app-xxxxxxxxxx/technosvc": dial tcp <IP-Address>:10250: i/o timeout
```

## Solution

To resolve this issue, allow traffic on port 10250 as described in [Troubleshoot tunnel connectivity issues in Azure Kubernetes Service](tunnel-connectivity-issues.md).