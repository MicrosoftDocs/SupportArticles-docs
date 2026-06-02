---
title: File share mounting failures for Azure Files
description: Troubleshoot Azure Files file share mounting failures on Azure Kubernetes Service (AKS) clusters and restore storage access by following these steps.
ms.date: 10/23/2024
ms.reviewer: chiragpa, nickoman, jaewonpark, v-leedennis
ms.service: azure-kubernetes-service
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot a file share that doesn't mount so that I can successfully use Azure Files for storage on my Azure Kubernetes Service (AKS) clusters.
ms.custom: sap:Storage
---
# File share mounting failures for Azure Files

## Summary

This article discusses how to troubleshoot file share mounting failures for Azure Files so that you can set up storage successfully on your Microsoft Azure Kubernetes Service (AKS) clusters.

## Common cause

Your storage account key has changed. This problem can cause a range of errors. The following pod error is typical:
```
Error: failed to generate container "56907e9807c6f4203c3aace8c5a6e3a75832cf07d3080a3869d355114657b54f" spec: failed to generate spec: failed to stat "/var/lib/kubelet/pods/xxxxxxxx-9fe6-46d7-b12e-339951b8d2f5/volumes/kubernetes.io~csi/pvc-xxxxxxxx-3b70-498c-b357-3488e1c1f429/mount": stat /var/lib/kubelet/pods/xxxxxxxx-9fe6-46d7-b12e-339951b8d2f5/volumes/kubernetes.io~csi/pvc-xxxxxxxx-3b70-498c-b357-3488e1c1f429/mount: host is down
```

## Solution

Manually update the `azurestorageaccountkey` field in an Azure file secret to add your base64-encoded storage account key. To make this update, follow these steps:

1. Encode your storage account key in base64 by running the following command:

    ```console
    echo <storage-account-key> | base64
    ```

1. [Update your Azure secret file](https://kubernetes.io/docs/concepts/configuration/secret/#editing-a-secret) by running the `kubectl edit secret` command to open the secret file in your default text editor:

    ```console
    kubectl edit secret azure-storage-account-<storage-account-name>-secret
    ```

1. Change the `azurestorageaccountkey` field to use the new base64-encoded storage account key, and then save the file.

1. Ensure proper unmount and recovery by using one of the following options. Redeploying pods alone often fails to fix the issue if an existing mount with a stale account key is reused.

    **Option A: Cordon the node (single pod/node scenario)**

    1. Cordon the current node where the pod is running:

        ```console
        kubectl cordon <node-name>
        ```

    1. Force the pod to restart on a different node:

        ```console
        kubectl delete pod <pod-name>
        ```

    1. The new pod mounts the file share by using the updated credential.

    **Option B: Scale replicas (Deployment/StatefulSet - recommended)**

    1. Scale replicas down to 0:

        ```console
        kubectl scale deployment <deployment-name> --replicas=0
        ```

    1. Wait 3-5 minutes for the account key cache to expire.

    1. Scale replicas back to the original count:

        ```console
        kubectl scale deployment <deployment-name> --replicas=<original-count>
        ```

    1. The new pods mount the file share by using the updated credentials.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

 
