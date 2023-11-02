---
title: Troubleshoot the OperationPreempted error code
description: Learn how to troubleshoot the OperationPreempted error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/10/2022
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OperationPreempted error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the OperationPreempted error code

This article discusses how to identify and resolve the `OperationPreempted` error that might occur when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to deploy an AKS cluster, you receive the following error message:

> This operation has been preempted by Deleting operation.

## Cause

This error usually occurs when an in-progress create operation is interrupted by a subsequent delete operation that was issued before the create cluster operation is finished.

## Solution

Retry the operation after the delete operation finishes.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
