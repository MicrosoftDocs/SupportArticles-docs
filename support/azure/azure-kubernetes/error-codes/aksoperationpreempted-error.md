---
title: Resolve AKSOperationPreempted or AKSOperationPreemptedByDelete error when performing a new operation in AKS
description: Resolve the AKSOperationPreempted or AKSOperationPreemptedByDelete error on an AKS cluster. Learn how to check or abort the blocking operation and retry.
ms.date: 11/23/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, erbookbi, jopalhei, dorinalecu, v-leedennis, v-weizhu, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OperationPreempted error code so that I can successfully perform a new operation an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Resolve an "AKSOperationPreempted" or "AKSOperationPreemptedByDelete" error when performing a new operation in Azure Kubernetes Service

## Summary

This article explains how to resolve the `AKSOperationPreempted` or `AKSOperationPreemptedByDelete` error in Azure Kubernetes Service (AKS). The error occurs when another operation preempts your new operation on a cluster. Learn how to check or abort the blocking operation so that you can retry successfully.

## Symptoms

When you try to perform a new operation on an AKS cluster, you receive one of the following error messages:

- > Code: "AKSOperationPreempted"
  > 
  > Message: "This operation has been preempted by another operation with ID \<operation ID\>" 
  
  This message indicates that another operation preempted the operation. The error message gives the GUID for the new operation.

- > Code: "AKSOperationPreemptedByDelete"
  > 
  > Message: "This operation has been preempted by Deleting operation."
  
  This message indicates that a delete operation preempted the operation.
  
## Cause

This error usually occurs when a subsequent operation interrupts an in-progress operation. The error indicates the subsequent operation, which can be a delete operation or any other operation.

## Solution

To resolve this issue, use one of the following methods. When no operations are running, try your operation again.

- Wait for the previous operation to complete. Check the status of the operation by using the ID in the error message with the following command.

  ```azurecli-interactive
  az aks operation show \
      --resource-group myResourceGroup \
      --name myCluster \
      --operation-id "<operation-id>"
  ```

- Run an `abort` command to stop the previous operation. For more information about how to abort an operation, see [Terminate a long running operation on an Azure Kubernetes Service (AKS) cluster](/azure/aks/manage-abort-operations). 

## References

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)