---
title: Recommended and useful mountOptions settings on Azure Files
description: Learn about the useful and recommended mountOptions settings when you configure the storage class object on Azure Files.
ms.date: 04/27/2025
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to learn about mount option settings so that I can set up my Azure Files storage class object optimally on my Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Storage
---
# Use mountOptions settings in Azure Files

This article discusses recommended mount options when you configure the storage class object on Azure Files. These mounting options help you to provision storage on your Kubernetes cluster.

## Recommended settings

The following `mountOptions` settings are recommended for Server Message Block (SMB) and Network File System (NFS) shares:

- **SMB shares**

    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: azurefile-csi
    provisioner: file.csi.azure.com
    allowVolumeExpansion: true
    parameters:
      skuName: Premium_LRS  # available values: Premium_LRS, Premium_ZRS, Standard_LRS, Standard_GRS, Standard_ZRS, Standard_RAGRS, Standard_RAGZRS
    reclaimPolicy: Delete
    volumeBindingMode: Immediate
    mountOptions:
      - dir_mode=0777  # modify this permission if you want to enhance the security
      - file_mode=0777 # modify this permission if you want to enhance the security
      - mfsymlinks    # support symbolic links
      - cache=strict  # https://linux.die.net/man/8/mount.cifs
      - nosharesock  # reduces probability of reconnect race
      - actimeo=30  # reduces latency for metadata-heavy workload
      - nobrl  # disable sending byte range lock requests to the server and for applications which have challenges with posix locks
    ```

- **NFS shares**

    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: azurefile-csi-nfs
    provisioner: file.csi.azure.com
    parameters:
      protocol: nfs
      skuName: Premium_LRS     # available values: Premium_LRS, Premium_ZRS
    reclaimPolicy: Delete
    volumeBindingMode: Immediate
    allowVolumeExpansion: true
    mountOptions:
      - nconnect=4  # improves performance by enabling multiple connections to share
      - noresvport  # improves availability
      - actimeo=30  # reduces latency for metadata-heavy workloads
    ```

> [!NOTE]
> The location for configuring mount options (`mountOptions`) depends on whether you're provisioning dynamic or static persistent volumes. If you're [dynamically provisioning a volume](/azure/aks/azure-csi-files-storage-provision#dynamically-provision-a-volume) with a storage class, specify the mount options on the storage class object (`kind: StorageClass`). If you're [statically provisioning a volume](/azure/aks/azure-csi-files-storage-provision#statically-provision-a-volume), specify the mount options on the `PersistentVolume` object (`kind: PersistentVolume`). If you're [mounting the file share as an inline volume](/azure/aks/azure-csi-files-storage-provision#mount-file-share-as-an-inline-volume), specify the mount options on the `Pod` object (`kind: Pod`).

## More information

For Azure Files best practices, see [Provision Azure Files storage](/azure/aks/azure-csi-files-storage-provision#best-practices).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
