---
title: Data restore scenarios for Azure Storage service
description: This article describes the data restore scenarios for Azure Storage service.
ms.date: 01/26/2021
author: genlin
ms.author: genli
ms.service: storage
ms.prod-support-area-path: 
ms.reviewer: 
---
# Data restore scenarios for Azure Storage service

This article describes the data restore scenarios for Azure Storage service.  

_Original product version:_ &nbsp; Blob Storage  
_Original KB number:_ &nbsp; 4012226

## Background knowledge

After the storage account or blob container is deleted, it is queued to be recycled and collected by the garbage collector. The system can then free up space for reuse. The deleted storage account or blob container may be restored if the garbage collector has not yet run and the storage space is not yet cleaned up. 

The time at which the garbage collector is run varies depending on many factors, such as workloads on the storage scale unit, the number of available storage spaces, and so on. On average, the garbage collection of storage accounts occurs 14 days after deletion，and typically the data is unrecoverable by Microsoft. It is recommended to enabled soft delete for blobs that allow you to recover blob data after it has been deleted. For more information, see [Soft delete for blobs](https://docs.microsoft.com/azure/storage/blobs/soft-delete-blob-overview).

## Data restore scenarios

The following resources can be restored if they have not been collected by the garbage collector:

- Storage account 
- Blob container in geo-redundant storage, zone-redundant storage, or read-access geo-redundant storage 

A new Shared Access Signature (SAS) token is required for restoring.
> [!NOTE]
> Restoring the Blob container in the Local redundant storage is not supported.

Azure supports only the storage account level or Blob container level restoring. Therefore, the following data restore scenarios are not supported:

- Restoring Queue 
- Restoring blob data (individual blob) in the storage account 
- Restoring partial data in the storage account, such as files inside of a blob 
- Restoring partial data in Table or Queue  

## More information

- [Manage Azure Blob Storage resources with Storage Explorer (Preview)](https://docs.microsoft.com/azure/vs-azure-tools-storage-explorer-blobs) 
- [Protecting your tables](https://azure.microsoft.com/blog/)  
