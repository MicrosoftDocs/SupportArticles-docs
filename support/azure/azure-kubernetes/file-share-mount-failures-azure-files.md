---
title: File share mounting failures for Azure Files
description: Troubleshoot why your file share for Azure Files fails to mount as storage on your Azure Kubernetes Service (AKS) clusters.
ms.date: 06/10/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-azure-storage-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why my file share fails to mount so that I can successfully use Azure Files for storage on my Azure Kubernetes Service (AKS) clusters.
---
# File share mounting failures for Azure Files

This article discusses how to troubleshoot file share mounting failures for Azure Files, so that you can set up storage successfully on your Microsoft Azure Kubernetes Service (AKS) clusters.

## Cause

Your storage account key has changed.

## Solution

Manually update the `azurestorageaccountkey` field in an Azure file secret with your base64-encoded storage account key. To make this update, follow these steps:

1. Encode your storage account key in base64 by running the `echo <storage-account-key> | base64` command, such as in the following example:

    ```console
    echo X+ALAAUgMhWHL7QmQ87E1kSfIqLKfgC03Guy7/xk9MyIg2w4Jzqeu60CVw2r/dm6v6E0DWHTnJUEJGVQAoPaBc== | base64
    ```

1. [Update your Azure secret file](https://kubernetes.io/docs/concepts/configuration/secret/#editing-a-secret) by running the `kubectl edit secret` command, which opens the secret file in your default text editor:

    ```console
    kubectl edit secret azure-storage-account-<storage-account-name>-secret
    ```

1. Change the `azurestorageaccountkey` field to use the new base64-encoded storage account key, and save the file.

After a few minutes, the agent node will retry the Azure File mount with the updated storage key.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
