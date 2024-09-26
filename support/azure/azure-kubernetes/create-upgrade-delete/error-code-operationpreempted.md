---
title: Troubleshoot the OperationPreempted error code
description: Learn how to troubleshoot the OperationPreempted error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/10/2022
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OperationPreempted error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the OperationPreempted error code

This article discusses how to identify and resolve the `OperationPreempted` error that might occur when you try to perform a new operation but it has been preempted by a previous operation on a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to perform a new operation on an AKS cluster, you receive the following error message:

> Code: "AKSOperationPreempted"
> 
> Message: "This operation has been preempted by another operation with ID xxxx"

OR 

> Code: "AKSOperationPreemptedByDelete"
> 
> Message: "This operation has been preempted by Deleting operation."

## Cause

This error usually occurs when an in-progress operation is interrupted by a subsequent operation that was issued before the previous cluster operation is finished. The error itself would give an indication of the in-progress operation, which can be Delete or any other operations.

## Solution

Retry the operation after the in-progress operation finishes or abort the long-running operation.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
