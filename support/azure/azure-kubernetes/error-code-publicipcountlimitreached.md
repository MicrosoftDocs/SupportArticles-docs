---
title: Troubleshoot PublicIPCountLimitReached error code
description: Learn how to troubleshoot the PublicIPCountLimitReached error when you try to upgrade an Azure Kubernetes Service cluster.
ms.date: 07/28/2022
editor: v-jsitser
ms.reviewer: chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-upgrade-operations
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of a PublicIPCountLimitReached error so that I can upgrade the cluster successfully.
---

# Troubleshoot the "PublicIPCountLimitReached" error code

This article discusses how to identify and resolve the "PublicIPCountLimitReached" error that occurs when you try to upgrade an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

This article requires Azure CLI version 2.0.65 or a later version. To find the version number, run `az --version`. If you have to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

An AKS cluster upgrade fails, and you receive a "PublicIPCountLimitReached" error message.

## Cause

The error occurs if you reached the maximum number of public IP addresses that are allowed for your subscription.

## Solution

To raise the limit or quota for your subscription, go to the [Azure portal]( https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest), file a **Service and subscription limits (quotas)** support ticket, and set the quota type to **Networking**.

After the quota change takes effect, try to upgrade the cluster to the same version that you previously tried to upgrade to. This process will trigger a reconciliation.

```cli
az aks upgrade --resource-group <ResourceGroupName> --name <AKSClusterName> --kubernetes-version <KUBERNETES_VERSION>
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
