---
title: VM Inspector error messages
description: Review a reference table that describes the error codes for the VM Inspector for Azure virtual machines.
ms.date: 4/18/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: mimckitt
ms.service: virtual-machines
localization_priority: medium
keywords:
#Customer intent: As a customer, support agent, or third-party personnel with privileged access, I want to learn about VM Inspector error messages so that I can diagnose problems remotely on an Azure virtual machine.
---
# VM Inspector error messages

VM Inspector is a self-help diagnostic tool for remote users with privileged access. The tool is used on an Azure VM that runs Windows or Linux. When the Microsoft Azure VM Inspector tool discovers errors on an Azure virtual machine (VM), it returns specific error codes. The following table provides a comprehensive list of these error codes. 

## Error messages

The following table describes the error codes that the VM Inspector can return after it makes diagnostic checks on an Azure VM.

| HTTP status code | Error code                                    | Description
|------------------|-----------------------------------------------|-------------------------------------------------------------------------------
|              400 | `IncorrectPatternUploadSASUri`                | The `uploadSasUri` input parameter doesn't have a *.zip* file name extension. Use a shared access signature uniform resource identifier (URI) reference to a **.zip* blob.                         |
|              400 | `IncorrectPermissionUploadSasUri`             | The `uploadSasUri` input parameter doesn't have the required permissions. Generate a shared access signature URI with read and write permissions (`sp='rw'`).                                      |
|              400 | `IncorrectSasUriFormat`                       | The `uploadSasUri` input parameter isn't in the expected format. Send a shared access signature URI to a **Blob** resource.                                                                        |
|              400 | `IncorrectSignedResourceValueForUploadSasUri` | The `uploadSasUri` input parameter isn't generated for the **Blob** resource. Check the value of the storage resource parameter (`sr`). Send a shared access signature URI to a **Blob** resource. |
|              400 | `InvalidBlobUploadSASUri`                     | Input parameter 'uploadSasUri' does not have a file extension '.zip' in it. Please use a SAS URI reference to a '*.zip' blob.
|              400 | `InvalidBlobUploadSASUri`                     | Input parameter 'uploadSasUri' does not have the required permissions. Please generate a SAS URI with read and write permissions (sp='rw').
|              400 | `InvalidBlobUploadSASUri`                     | Input parameter 'uploadSasUri' is expired. Value of 'se' claim = {0}.
|              400 | `InvalidBlobUploadSASUri`                     | Input parameter 'uploadSasUri' is not in the expected format. Please send a SAS Uri to a 'Blob' resource.
|              400 | `InvalidBlobUploadSASUri`                     | Input parameter 'uploadSasUri' is not generated for resource: Blob. The Uri has claim 'sr'= {0}. Please send a SAS Uri to a 'Blob' resource.
|              400 | `InvalidBlobUploadSASUri`                     | Input parameter 'uploadSasUri' is not valid. The server returned the following error when retrieving data from the blob: {0}
|              400 | `InvalidParameter`                            | The input parameter is invalid. Check the parameters and try again.
|              400 | `InvalidParameter`                            | The input parameter '{parameterName}' is invalid.                                                                                                                        |
|              400 | `InvalidUploadSasUri`                         | The `uploadSasUri` input parameter isn't valid. The server returned an error while it retrieved data from the blob.                                                                                |
|              400 | `UploadSasUriExpired`                         | The `uploadSasUri` input parameter is expired. Check the value of the expiration time parameter (`se`).                                                                                            |
|              403 | `DiskInspectForbiddenError`                   | The disk doesn't have the correct access granted to execute disk inspection. Grant the correct access and try again. 
|              404 | `DiagnosticOperationNotFound`                 | $"Diagnostic operation with operationId: {operationId} is not found in location: {location} for subscription: {subscriptionId}. Please check subscription and location values and try again."
|              404 | `DiagnosticsMetadataNotFound`                  | Unable to get Diagnostics metadata.
|              404 | `DiskInspectionMetadataNotFound`              | Unable to get Disk Inspection metadata.
|              404 | `StorageAccountNotFoundInARM`                 | Unable to check access on resource of type: '{0}', resourceId: '{1}' due to resource not being found. Please check if the resource exists and try again.
|              404 | `StorageConfigurationNotFound`                | Unable to find a storage configuration for given subscriptionId: '{0}', location: '{1}'. Please check the value and try again or invoke "registerStorageConfiguration" to add a new storage configuration.
|              404 | `VirtualMachineNotFoundInARM`                | Unable to check access on resource of type: '{0}', resourceId: '{1}' due to resource not being found. Please check if the resource exists and try again.                                                                              |
|              405 | `EncryptedDiskNotSupported`                   | Disk inspection isn't supported for the specified VM and encrypted operating system disk.
|              405 | `ForbiddenError`                               | Caller with objectId: '{0} 'does not have access to perform action: '{1}' on resourceType: '{2}' for resourceId: '{3}'. Please check permissions and try again.                                                                                                          |
|              405 | `InvalidDiskStatus`                           | Disk inspection isn't supported for the specified operating system disk and provisioning state.                                                                                                    |
|              405 | `ResourceNotSupported`                        | A specified resource isn't supported.
|              405 | `ResourceNotSupported`                        | Disk inspection is not supported for VM '{0}' with encrypted OS disk '{1}'.
|              405 | `ResourceNotSupported`                        | Disk inspection is not supported for VM '{0}' with ephemeral OS disk '{1}'.
|              405 | `ResourceNotSupported`                        | Disk inspection is not supported for the OS disk '{0}' with provisioning state '{1}'.
|              405 | `ResourceNotSupported`                        | Disk inspection is not supported for VM '{0}' with unmanaged OS disk.
|              405 | `UnmanagedDiskNotSupported`                   | Disk inspection isn't supported for the specified VM and unmanaged operating system disk.
|              500 | `DiskInspectInternalServerError`              | An unexpected internal server error occurred during disk inspection. Try again later.
|              500 | `InternalServerError`                         | An unexpected internal server error occurred while running disk inspection.
|              500 | `InternalServerError`                         | Failed to register a new storage configuration. Subscription: '{0}', StorageAccount: '{1}', Location: '{1}'. Please check values and try again later.
|              500 | `InternalServerError`                         | Failed to update an existing configuration for subscriptionId: '{0}', location: '{1}'. Please try again.
|              500 | `InternalServerError`                         | Failed to validate if a storage configuration exists. Subscription: '{0}', Location: '{1}'. Please check the subscriptionId value and try again.
|              500 | `InternalServerError`                         | Unable to check if caller has access to perform action: '{0}' on resourceType: '{1}' for resourceId: '{2}' as incoming request does not have caller's objectId. Please try again.
|              500 | `InternalServerError`                         | Unable to check if caller with objectId: '{0}' has access to perform action: '{1}' on resourceType: '{2}' for resourceId: '{3}' as no decision given from downstream component. Please try again.
|              500 | `InternalServerError`                         | Unable to check if caller with objectId: '{0}' has access to perform action: '{1}' on resourceType: '{2}' for resourceId: '{3}' either due to missing action or resource information. Please try again.
|              500 | `InternalServerError`                         | VM '{0}' metadata are invalid. Please ensure that VM was provisioned successfully and not deleted.

## Resources

- [VM Inspector for Azure virtual machines](vm-inspector-azure-virtual-machines.md)
- [Grant limited access to Azure Storage resources using SAS](/azure/storage/common/storage-sas-overview)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
