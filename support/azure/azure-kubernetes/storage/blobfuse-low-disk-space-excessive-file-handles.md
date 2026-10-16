---
title: Troubleshoot low disk space on AKS nodes caused by BlobFuse file handles
description: Learn how to troubleshoot low disk space on AKS nodes when workloads keep many files open on Azure Blob CSI (BlobFuse) volumes, and how to mitigate the issue.
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-kubernetes-service
ms.date: 10/15/2026
ms.reviewer: cssakscic
ms.custom: sap:Storage
ai-usage: ai-assisted
---
# Low disk space on Azure Kubernetes Service nodes caused by BlobFuse volumes

## Summary

This article helps you troubleshoot low disk space on Azure Kubernetes Service (AKS) nodes when a workload keeps a large number of files open on a volume that uses the Azure Blob storage Container Storage Interface (CSI) driver with BlobFuse.

## Symptoms

You experience one or more of the following symptoms:

- Disk usage alerts fire for a node disk, and usage keeps growing even though the workload doesn't write much data to local disk.
- Applications that use the BlobFuse volume fail with `Input/output error`. The following is an example.

  ```output
  dd: closing output file '/mnt/blob/openfiles/file_381.dat': Input/output error
  ```

- The node stays in the `Ready` state, and the `DiskPressure` condition stays `False`, even though a disk on the node is full.
- The problem occurs when a log collection, backup, antivirus, or indexing tool reads many files from the BlobFuse volume at the same time.

## Cause

BlobFuse uses a local cache to serve files from Blob Storage. In the default file cache mode, BlobFuse downloads the entire content of each open file into a temporary path (`tmp-path`) on the node. By default, the Azure Blob storage CSI driver uses a path under `/mnt` on the node, such as `/mnt/<storage-account>_<container>`.

BlobFuse can only evict cached content for files that are closed. When a tool keeps many files open at the same time, such as a log collector that tails many large files, BlobFuse caches all of those files in full. The total size of the open files can exceed the free space on the disk, and BlobFuse fails the operations with `Input/output error`. Each open file also uses a file handle in the `blobfuse2` process.

On many virtual machine (VM) sizes, `/mnt` is the VM temporary disk, which is separate from the OS disk. The kubelet `DiskPressure` condition and the node `ephemeral-storage` capacity track the OS disk only. As a result, a full BlobFuse cache disk doesn't trigger `DiskPressure` or pod eviction.

## Investigate the issue

Follow these steps to investigate the issue:

1. Check the disk usage on the node. Use a [node debugging pod](/azure/aks/node-access) and compare the OS disk with the disk that's mounted on `/mnt`. Run the following command.

    ```bash
    kubectl debug node/<node-name> -it --image=mcr.microsoft.com/cbl-mariner/base/core:2.0 -- df -h /host /host/mnt
    ```

    The following output shows the cache disk full while the OS disk is unaffected:

    ```output
    Filesystem      Size  Used Avail Use% Mounted on
    /dev/sdb1        74G   73G     0 100% /mnt
    ```

1. Find the BlobFuse cache directory that uses the space. Run the following command.

    ```bash
    du -sh /host/mnt/* 2>/dev/null | sort -h | tail
    ```

1. Count the file handles that the `blobfuse2` process holds. Run the following command.

    ```bash
    ls /proc/$(pgrep -o blobfuse2)/fd | wc -l
    ```

    A count that grows with the number of files that your tool keeps open is the typical sign of this problem.

1. Identify the process that holds many files open on the mount. Run the following command.

    ```bash
    lsof +D <mount-path> | awk '{print $1, $2}' | sort | uniq -c | sort -rn | head
    ```

## Mitigation

Use block cache (streaming) mode. In this mode, BlobFuse caches only the blocks that you read or write, instead of whole files. In a test that kept more than 250 large files open at the same time, block cache kept local disk usage at about 200 MB, compared to a completely full 74-GB disk in file cache mode.

Set the mount options in the `StorageClass` or `PersistentVolume`. Run the following command.

```yaml
mountOptions:
  - -o allow_other
  - --block-cache
  - --block-cache-disk-size=2048
```

For more information, see [BlobFuse2 configuration](/azure/storage/blobs/blobfuse2-configuration) and [Use Azure Blob storage CSI driver](/azure/aks/azure-blob-csi).

> [!NOTE]
> The following file cache settings don't prevent this problem when files stay open, because BlobFuse can't evict files that are open:
>
> - `--file-cache-timeout-in-seconds` evicts closed files, but doesn't affect open files.
> - `--cache-size-mb` together with `--hard-limit=true` doesn't stop the cache from growing beyond the limit while files are open.

Also consider the following actions to reduce the problem at its source:

- Reduce the number of files that the tool opens at the same time, or exclude the BlobFuse volume from file scanning.
- Ensure that the tool closes files after it reads them.
- Use a node pool with a larger temporary disk, or set the `tmp-path` option to a larger disk.

## References

- [Use Azure Blob storage CSI driver on AKS](/azure/aks/azure-blob-csi)
- [What is BlobFuse?](/azure/storage/blobs/blobfuse2-what-is)
- [BlobFuse2 configuration reference](/azure/storage/blobs/blobfuse2-configuration)

