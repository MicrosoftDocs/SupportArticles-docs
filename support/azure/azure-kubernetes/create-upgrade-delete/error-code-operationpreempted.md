---
title: AKSOperationPreempted error when performing a new operation
description: Helps resolve the AKSOperationPreempted or AKSOperationPreemptedByDelete error when you perform a new operation on an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/21/2024
editor: jopalhei
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
  This indicates that the operation has been preempted by another operation, the GUID for the new operation is given on the error message.

- > Code: "AKSOperationPreemptedByDelete"
  > 
  > Message: "This operation has been preempted by Deleting operation."
  This indicates that the operation has been preempted by a deleting operation.
  
## Cause

This error usually occurs when an in-progress operation is interrupted by a subsequent operation that was issued before the in-progress operation is finished. The error will indicate the subsequent operation, which can be a delete or any other operation.

## Solution

Option 1 - Wait for the previous operation to complete before reattempting. You can check the status of the operation using the ID given in the error message with the follwing command :

```azurecli-interactive
az aks operation show \
    --resource-group myResourceGroup \
    --name myCluster \
    --operation-id "<operation-id>"
```

Option 2 - Run an Abort command to stop the previous operation, for more information about how to abort an operation, see [Terminate a long running operation on an Azure Kubernetes Service (AKS) cluster](/azure/aks/manage-abort-operations). 

Once there are no operations running you can reattempt to run your operation again.

## More information

[General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
