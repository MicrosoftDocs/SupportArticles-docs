---
title: Recommended and useful mountOptions settings on Azure Files
description: Learn recommended mountOptions settings for Azure Files storage classes in AKS to improve performance and reliability, and use them to optimize your deployments.
ms.date: 07/24/2026
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to learn about mount option settings so that I can set up my Azure Files storage class object optimally on my Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Storage
---
# Use mountOptions settings in Azure Files

## Summary

This article explains the recommended mountOptions settings for Azure Files storage classes. Use these settings to provision Kubernetes storage with better performance and reliability.

## Recommended settings

Use the following `mountOptions` settings for Server Message Block (SMB) and Network File System (NFS) shares:

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

These permissions can grant broader permissions than applications require. Consider using a least-privilege approach first, like the following examples: 

- `dir_mode=0755`, `file_mode=0755`, `uid=1000`, and `gid=1000`. 
- `dir_mode=0777`, `file_mode=0777`, `uid=0`, `gid=0` might be more appropriate when applications require root or broader access.

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

For more information on `rsize` and `wsize` options for NFS, see [Optimize read and write size options](/azure/aks/create-volume-azure-files#optimize-read-and-write-size-options).

The `actimeo` and `nconnect` options are analyzed in depth in the following Microsoft documentation:

- [Recommended mount options](/azure/storage/files/nfs-large-directories#recommended-mount-options)
- [NFS nconnect](/azure/storage/files/nfs-performance#nfs-nconnect)

> [!NOTE]
> The location for configuring mount options (`mountOptions`) depends on whether you provision dynamic or static persistent volumes. If you [dynamically provision a volume](/azure/aks/azure-csi-files-storage-provision#dynamically-provision-a-volume) by using a storage class, specify the mount options on the storage class object (`kind: StorageClass`). If you [statically provision a volume](/azure/aks/azure-csi-files-storage-provision#statically-provision-a-volume), specify the mount options on the `PersistentVolume` object (`kind: PersistentVolume`). If you [mount the file share as an inline volume](/azure/aks/azure-csi-files-storage-provision#mount-file-share-as-an-inline-volume), specify the mount options on the `Pod` object (`kind: Pod`).

## References

For Azure Files best practices, see [Provision Azure Files storage](/azure/aks/azure-csi-files-storage-provision#best-practices).