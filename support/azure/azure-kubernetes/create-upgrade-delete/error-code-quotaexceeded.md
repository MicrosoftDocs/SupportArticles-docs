---
title: Troubleshoot QuotaExceeded error
description: Introduces how to troubleshoot the QuotaExceeded error when you try to upgrade an Azure Kubernetes Service cluster.
ms.date: 09/16/2024
editor: v-jsitser
ms.reviewer: chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of a QuotaExceeded error code so that I can upgrade the cluster successfully.
---

# Troubleshoot the "Quotaexceeded" error

This article discusses how to identify and resolve the "QuotaExceeded" error that occurs when you try to upgrade an Azure Kubernetes Service (AKS) cluster.

Here's an example of the error message:

> Operation results in exceeding quota limits of Core. Maximum allowed: X, Current in use: X, Additional requested: X

## Prerequisites

This article requires Azure CLI version 2.0.65 or a later version. To find the version number, run `az --version`. If you have to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

An AKS cluster upgrade fails, and you receive a "QuotaExceeded" error message.

## Cause

The issue occurs if the quota is reached. Your subscription doesn't have available resources that are required for upgrading.

## Solution

To raise the limit or quota for your subscription, go to the [Azure portal]( https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) and file a **Service and subscription limits (quotas)** support ticket. In this case, you have to submit a support ticket to increase the quota for compute cores.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
