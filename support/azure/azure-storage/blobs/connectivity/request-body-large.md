---
title: Request body is too large error when you write more than 4 MB of data to Azure Storage
description: Describes an issue that triggers a "Request body is too large" error in Microsoft Azure. Occurs when you try to write more than 4 megabytes (MB) of data to Azure Storage.
ms.date: 05/16/2025
author: genlin
ms.author: genli
ms.service: azure-file-storage
ms.custom: sap:Connectivity
---
# Error when you write more than 4 MB of data to Azure Storage: Request body is too large

_Original product version:_ &nbsp; Storage Account Management  
_Original KB number:_ &nbsp; 4016806

## Symptoms

Assume that you try to write more than 4 megabytes (MB) of data to a file on Azure Storage, or you try to upload a file that's larger than 4 MB by using the SAS url (REST API) or HTTPS PUT method. In this scenario, the following error is returned:

> Code : RequestBodyTooLarge  
Message: The request body is too large and exceeds the maximum permissible limit.  
RequestId:\<ID>  
MaxLimit : 4194304

## Cause

This error can occur if the block size limit for the service version you run is exceeded. For example, versions prior to `2016-05-31` have a 4-MB block size limit per call to the Azure Storage service. Newer service versions support larger block sizes.
For more information, see the following articles:

- [Scale targets for Blob storage](/azure/storage/blobs/scalability-targets#scale-targets-for-blob-storage).
- [Versioning for Azure Storage](/rest/api/storageservices/versioning-for-the-azure-storage-services)

## Workaround

If your file is too large, you must split it into chunks. For more information, see [Scalability and performance targets for standard storage accounts](/azure/storage/common/scalability-targets-standard-account).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
