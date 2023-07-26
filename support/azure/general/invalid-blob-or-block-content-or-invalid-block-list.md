---
title: Uploading blob or block content fails in Azure Blob Storage
description: Resolve upload failures of blob or block content (BlockCountExceedsLimit, InvalidBlobOrBlock, InvalidBlock, or InvalidBlockList) in Azure Blob Storage.
ms.date: 11/11/2022
editor: v-jsitser
ms.reviewer: broder, anradha, v-leedennis
ms.service: azure-storage
#Customer intent: As an Azure Blob Storage user, I want to resolve BlockCountExceedsLimit, InvalidBlobOrBlock, InvalidBlock, or InvalidBlockList errors so that I can successfully upload large blobs or blocks of data in my applications.
---
# Uploading blob or block content fails in Azure Blob Storage

This article discusses how to resolve failures that might occur when you use Microsoft Azure Blob Storage together with your cloud applications to upload blob or block content.

## Prerequisites

- A storage account from one of the following storage services:
  - [Azure Blob Storage](/azure/storage/blobs/storage-blobs-overview)
  - [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction)
  - [General-purpose v2 storage](/azure/storage/common/storage-account-upgrade)
- [Azure Storage SDK](/dotnet/api/overview/azure/storage)
- [Azure Storage Explorer](/azure/vs-azure-tools-storage-manage-with-storage-explorer)
- [PowerShell](/powershell/scripting/install/installing-powershell)

## Symptoms

You receive one of the following error messages.

| Error code                           | Error message                                                                    |
|--------------------------------------|----------------------------------------------------------------------------------|
| `BlockCountExceedsLimit`             | "The uncommitted block count cannot exceed the maximum limit of 100,000 blocks." |
| `InvalidBlobOrBlock`                 | "The specified blob or block content is invalid."                                |
| `InvalidBlock` or `InvalidBlockList` | "The specified block list is invalid."                                           |

## Cause 1: The block length that was specified in the Put Block call isn't valid

The block length that was specified in the [Put Block](/rest/api/storageservices/put-block) URI request isn't valid for one or more of the following reasons:

- The application or client specified a block size that isn't supported.

- The size of the block is larger than the maximum allowed block size. To find the block size limits for different versions of the Blob Service REST API, see the [Remarks](/rest/api/storageservices/put-block#remarks) section of the "Put Block" reference article.

- When you tried to upload blocks of data by using more than one application, there were uncommitted blocks that had inconsistent block lengths. This situation occurs because different applications use different lengths to upload data, or because a previous upload failed.

- The blob has too many uncommitted blocks because a previous upload operation was canceled. The maximum number of uncommitted blocks that can be associated with a blob is 100,000.

Remove the uncommitted blocks by implementing one of these solutions.

### Solution 1: Wait for garbage collection to pick up the uncommitted data

Wait seven days for the uncommitted block list to be cleaned up by garbage collection.

### Solution 2: Use a dummy blob to make the data transfer

Use the Azure Storage SDK to transfer the data by using a dummy blob. To do this, follow these steps:

1. Create a dummy blob that has the same blob name and is in the same container. This blob can have a length of zero.

1. Transfer the blob by using an unblocked transfer.

### Solution 3: Commit the uncommitted block list by using the Azure Storage SDK

Use the Azure Storage SDK to commit the uncommitted block list and clean up the blob. To do this, follow these steps:

1. Retrieve the uncommitted block list by making a [Get Block List](/rest/api/storageservices/get-block-list) URI request in which the `blocklisttype` URI parameter is set to `uncommitted`.

1. Commit the block list by using the [Put Block List](/rest/api/storageservices/put-block-list) URI request.

1. Delete the blob.

The following PowerShell function is an example of how to retrieve an uncommitted block list and then delete it. The function requires the following parameters.

| Parameter name | Description |
|--|--|
| `-StorageAccountName` | The name of the storage account. |
| `-SharedAccessSignature` | A shared access signature (SAS) token that uses the URI parameters `<ss=b;srt=sco;sp=rwldc>`. These parameters are described in [Construct an account SAS URI](/rest/api/storageservices/create-account-sas#construct-an-account-sas-uri). |
| `-ContainerName` | The name of the storage container. |
| `-BlobName` | The name of the blob. |

```powershell
[CmdletBinding()] Param(
    [Parameter(Mandatory=$true, Position=1)] [string] $StorageAccountName,
    [Parameter(Mandatory=$True, Position=1)] [string] $SharedAccessSignature,
    [Parameter(Mandatory=$True, Position=1)] [string] $ContainerName,
    [Parameter(Mandatory=$True, Position=1)] [string] $BlobName
)

# Build the URI strings in the REST API for GET and DELETE.
$uriDelete = (
    "https://$StorageAccountName.blob.core.windows.net/",
    "$ContainerName",
    "/",
    "$BlobName",
    "$SharedAccessSignature"
) -Join ""
$uriGet = (
    "$uriDelete",
    "&comp=blocklist",
    "&blocklisttype=uncommitted"
) -Join ""
Write-Host "The Delete URI is $uriDelete."
Write-Host "The Get URI is $uriGet."

# Make a REST API call to get the uncommitted block list.
$listFileURI = Invoke-WebRequest -Uri $uriGet -Method Get
$FileSystemName = $listFileURI.Content
$String = $FileSystemName -replace 'ï»¿' , ''
$String |
    Select-Xml –XPath "/BlockList/UncommittedBlocks/Block" |
        Select-Object -Expand Node
$Count = $String.Count

# Delete the blob and the uncommitted block.
if ($Count.Count -gt 0) {
    $listFileURI1 =  Invoke-WebRequest -Uri $uriDelete -Method Delete
    $FileSystemName1 = $listFileURI1.StatusCode
    Write-Host "The deletion was successful. The API returned status code $FileSystemName1."
}

Write-Host "Check whether the uncommitted blocks are still present."
Try {
    $listFileURI2 = Invoke-WebRequest -Uri $uriGet -Method Get
} Catch {
    # $err = $_.Exception
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
}

Write-Host (
    "In this error message, we can verify that the",
    "uncommitted blocks and their respective blob have been deleted.",
    "The name and size of the uncommitted blocks that have been deleted are shown."
)
```

<!-- Commenting out the solution using blob storage events for now. Might be restored later.
### Solution 4: Commit the uncommitted block list by using Azure Blob Storage events

Commit the uncommitted block list and clean up the blob by using [Azure Blob Storage events](/azure/event-grid/event-schema-blob-storage). The event is triggered only after a Put Blob or Put Block List is completed. When the event is triggered, you'll know that the blob is fully committed before you have to take action on it. This feature lets you be notified when a new blob is written. Then, you can reference this blob directly without having to search in the storage container for blobs that you want to take action on.
-->
## Cause 2: PUT operations occur simultaneously for a blob

A timing or concurrency issue occurs. This causes multiple PUT (Put Block) operations to occur at about the same time for a single blob. The [Put Block List](/rest/api/storageservices/put-block-list) operation writes a blob by specifying the list of block IDs that make up the blob. To be written as part of a blob, a block must have been successfully written to the server in a previous [Put Block](/rest/api/storageservices/put-block) operation.

> [!NOTE]
>
> This error can occur during concurrent upload commits after you start the upload but before you commit. In this case, the upload fails. The application can retry the upload when the error occurs, or it can try another recovery action that's based on the required scenario.

### Solution: Use leases

Instead of using optimistic concurrency, try to implement pessimistic concurrency (leases) by using the Azure Storage SDK or a GUI-based tool, such as Azure Storage Explorer. For more information about optimistic and pessimistic concurrency, see [Managing concurrency in blob storage](/azure/storage/blobs/concurrency-manage).

If the error is caused by concurrency issues, you might also have to clean up the uncommitted blocks by following one of the solutions in [Cause 1](#cause-1-the-block-length-that-was-specified-in-the-put-block-call-isnt-valid).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
