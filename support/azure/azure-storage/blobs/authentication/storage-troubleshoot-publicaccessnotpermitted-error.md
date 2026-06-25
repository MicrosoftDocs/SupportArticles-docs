---
title: Troubleshoot PublicAccessNotPermitted error
description: How to troubleshoot PublicAccessNotPermitted error.
ms.date: 06/23/2026
ms.service: azure-blob-storage
author: jeffpatt24
ms.author: jeffpatt
ms.custom: sap:Authentication and Authorization
---

# Troubleshoot PublicAccessNotPermitted error

When accessing Azure Blob storage, you may encounter a `PublicAccessNotPermitted` error. This article describes how to resolve this error.

## Symptom

When attempting to access an Azure Blob container or blob, you may receive the following error:

```text
Public access is not permitted on this storage account.
ErrorCode: PublicAccessNotPermitted
```

## Cause

This error occurs when an unauthenticated (anonymous) request is made to a blob or container that does not allow public access.

## Resolution

#### Option 1: Use authenticated access (recommended)

Instead of enabling anonymous access, use a supported authentication method to securely access Azure Blob storage:

- **Microsoft Entra ID (recommended)**  
  [Authorize Blob Access with Microsoft Entra ID](/azure/storage/blobs/authorize-access-azure-active-directory)

- **Shared access signature (SAS)**  
  [Grant limited access to data with shared access signatures (SAS)](/azure/storage/common/storage-sas-overview)

- **Storage account key**  
  [Authorize with Shared Key](/rest/api/storageservices/authorize-with-shared-key)

For more information: [Authorize access to data in Azure Storage](/azure/storage/common/authorize-data-access)

#### Option 2: Enable anonymous access (only if required)

> [!WARNING]
> When a container is configured for anonymous access, any client can read data in that container. This can introduce significant security risks. Only enable anonymous access when explicitly required.

If your scenario requires anonymous access, see: [Configure anonymous read access for containers and blobs](/azure/storage/blobs/anonymous-read-access-configure)
