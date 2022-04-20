---
title: VM Inspector error messages
description: Review a reference table that describes the error codes for the VM Inspector for Azure virtual machines.
ms.date: 11/17/2021
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: mimckitt
ms.service: virtual-machines
localization_priority: medium
keywords:
#Customer intent: As a customer, support agent, or third-party personnel with privileged access, I want to learn about VM Inspector error messages so that I can diagnose problems remotely on an Azure virtual machine.
---
# VM Inspector error messages

This article provides a comprehensive list of error codes that the Microsoft Azure VM Inspector tool returns when it discovers errors on an Azure virtual machine (VM). VM Inspector is a self-help diagnostic tool for remote users with privileged access. The tool is used on an Azure VM that runs Windows or Linux.

## Error messages

The following table describes the error codes that the VM Inspector can return after it makes diagnostic checks on an Azure VM.

| HTTP status code | Error code                                    | Description                                                                                                                                                                                        |
| ---------------- | --------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|              400 | `IncorrectPatternUploadSASUri`                | The `uploadSasUri` input parameter doesn't have a *.zip* file name extension. Use a shared access signature uniform resource identifier (URI) reference to a **.zip* blob.                         |
|              400 | `IncorrectPermissionUploadSasUri`             | The `uploadSasUri` input parameter doesn't have the required permissions. Generate a shared access signature URI with read and write permissions (`sp='rw'`).                                      |
|              400 | `IncorrectSasUriFormat`                       | The `uploadSasUri` input parameter isn't in the expected format. Send a shared access signature URI to a **Blob** resource.                                                                        |
|              400 | `IncorrectSignedResourceValueForUploadSasUri` | The `uploadSasUri` input parameter isn't generated for the **Blob** resource. Check the value of the storage resource parameter (`sr`). Send a shared access signature URI to a **Blob** resource. |
|              400 | `InvalidParameter`                            | The input parameter is invalid. Check the parameters and try again.                                                                                                                                |
|              400 | `InvalidUploadSasUri`                         | The `uploadSasUri` input parameter isn't valid. The server returned an error while it retrieved data from the blob.                                                                                |
|              400 | `UploadSasUriExpired`                         | The `uploadSasUri` input parameter is expired. Check the value of the expiration time parameter (`se`).                                                                                            |
|              403 | `DiskInspectForbiddenError`                   | The disk doesn't have the correct access granted to execute disk inspection. Grant the correct access and try again.                                                                               |
|              405 | `EncryptedDiskNotSupported`                   | Disk inspection isn't supported for the specified VM and encrypted operating system disk.                                                                                                          |
|              405 | `InvalidDiskStatus`                           | Disk inspection isn't supported for the specified operating system disk and provisioning state.                                                                                                    |
|              405 | `ResourceNotSupported`                        | A specified resource isn't supported.                                                                                                                                                              |
|              405 | `UnmanagedDiskNotSupported`                   | Disk inspection isn't supported for the specified VM and unmanaged operating system disk.                                                                                                          |
|              500 | `DiskInspectInternalServerError`              | An unexpected internal server error occurred during disk inspection. Try again later.                                                                                                              |

## Resources

- [VM Inspector for Azure virtual machines](vm-inspector-azure-virtual-machines.md)
- [Grant limited access to Azure Storage resources using SAS](/azure/storage/common/storage-sas-overview)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
