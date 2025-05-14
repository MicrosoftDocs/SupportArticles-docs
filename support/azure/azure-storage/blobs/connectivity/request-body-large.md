---
title: Request body is too large error when you write more than 4 MB of data to Azure Storage
description: Describes an issue that triggers a "Request body is too large" error in Microsoft Azure. Occurs when you try to write more than 4 megabytes (MB) of data to Azure Storage.
ms.date: 04/09/2024
author: genlin
ms.author: genli
ms.service: azure-file-storage
ms.reviewer: 
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

There's a 4-MB limit for each call to the Azure Storage service. If your file is larger than 4 MB, you must break it in chunks. For more information, see [Azure Storage scalability and performance targets](/azure/storage/storage-scalability-targets).

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
