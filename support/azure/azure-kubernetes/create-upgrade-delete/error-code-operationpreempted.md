---
title: AKSOperationPreempted error when performing a new operation
description: Helps resolve the AKSOperationPreempted or AKSOperationPreemptedByDelete error when you perform a new operation on an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/18/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, dorinalecu, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OperationPreempted error code so that I can successfully perform a new operation an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# AKSOperationPreempted or AKSOperationPreemptedByDelete error when performing a new operation

This article discusses how to identify and resolve the `AKSOperationPreempted` or `AKSOperationPreemptedByDelete` error that might occur when you try to perform a new operation but it has been preempted by another operation on a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to perform a new operation on an AKS cluster, you receive one of the following error messages:

- > Code: "AKSOperationPreempted"
  > 
  > Message: "This operation has been preempted by another operation with ID \<operation ID\>"


- > Code: "AKSOperationPreemptedByDelete"
  > 
  > Message: "This operation has been preempted by Deleting operation."

## Cause

This error usually occurs when an in-progress operation is interrupted by a subsequent operation that was issued before the in-progress operation is finished. The error will indicate the subsequent operation, which can be a delete or any other operation.

## Solution

Retry the operation after the in-progress operation finishes or abort the long-running operation. For more information abouot the abort operation, see [Terminate a long running operation on an Azure Kubernetes Service (AKS) cluster](/azure/aks/manage-abort-operations).

## More information

[General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
