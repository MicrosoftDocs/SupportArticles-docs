---
title: Recommended and useful mountOptions settings on Azure Files
description: Learn about the useful and recommended mountOptions settings when you configure the storage class object on Azure Files.
ms.date: 05/25/2022
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-azure-storage-issues
#Customer intent: As an Azure Kubernetes user, I want to learn about mount option settings so that I can set up my Azure Files storage class object optimally on my Azure Kubernetes Service (AKS) cluster.
---
# Use mountOptions settings in Azure Files

This article discusses the useful and recommended mounting options when you configure the storage class object on Azure Files. These mounting options help you to provision storage on your Kubernetes cluster.

## Recommended settings

The following `mountOptions` field settings are recommended for the Kubernetes version and the file and directory mode (permissions):

| Setting                          | Recommended value |
|----------------------------------|-------------------|
| Kubernetes version               | 1.12.2 or later   |
| `file_mode` and `dir_mode` value | `0777`            |

The following configuration file is an example of how to set the file and directory permissions:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: azurefile
provisioner: kubernetes.io/azure-file
mountOptions:
  - dir_mode=0777
  - file_mode=0777
  - uid=1000
  - gid=1000
  - mfsymlinks
  - nobrl
  - cache=none
parameters:
  skuName: Standard_LRS
```

## Other useful settings

You might also find the following `mountOptions` settings useful:

| Setting | Description |
|--|--|
| `mfsymlinks` | This setting forces the Azure Files mount (Common Internet File System, or cifs) to support symbolic links. |
| `nobrl` | This setting prevents sending byte range lock requests to the server. It's necessary for certain applications that break with cifs-style mandatory byte range locks. Most cifs servers don't yet support requesting advisory byte range locks. If an application doesn't use this setting and breaks with cifs-style mandatory byte range locks, error messages such as `Error: SQLITE_BUSY: database is locked` might occur. |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
