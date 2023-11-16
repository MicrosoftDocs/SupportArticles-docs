---
title: Troubleshoot the ReservedResourceName error code
description: Learn how to troubleshoot the ReservedResourceName error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/10/2022
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the ReservedResourceName error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the ReservedResourceName error code

This article discusses how to identify and resolve the `ReservedResourceName` error that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to deploy an AKS cluster, you receive the following error message:

> Either resource name or resource group name is using an Azure reserved name. Check details: autorest/azure: Service returned an error.
>
> Status=400 Code="ReservedResourceName"
>
> Message="**The resource name 'omsagent-aks-dev-microsoft' or a part of the name is a trademarked or reserved word.**".

## Cause

The resource name that was used to create the cluster or resource group is marked as a trademarked or reserved word.

## Solution

Redeploy the cluster by using a different resource group or cluster name.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
