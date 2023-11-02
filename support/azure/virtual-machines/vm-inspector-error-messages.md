---
title: VM Inspector error messages and common solutions
description: Review a reference table that describes the error codes for the VM Inspector for Azure virtual machines.
ms.date: 06/06/2022
ms.reviewer: mimckitt, v-leedennis
ms.service: virtual-machines
ms.subservice: vm-troubleshooting-tools
localization_priority: medium
keywords:
#Customer intent: As a customer, support agent, or third-party personnel with privileged access, I want to learn about VM Inspector error messages so that I can diagnose problems remotely on an Azure virtual machine.
---
# VM Inspector error messages and solutions

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
|              404 | `DiagnosticOperationNotFound`                 | Diagnostic operation with operationId: {operationId} is not found in location: {location} for subscription: {subscriptionId}. Please check subscription and location values and try again.
|              404 | `DiagnosticsMetadataNotFound`                  | Unable to get Diagnostics metadata.
|              404 | `DiskInspectionMetadataNotFound`              | Unable to get Disk Inspection metadata.
|              404 | `StorageAccountNotFoundInARM`                 | Storage Account '{0}' is not found. Please choose another storage account and try again. 
|              404 | `StorageConfigurationNotFound`                | Unable to find a storage configuration for given subscriptionId: '{0}', location: '{1}'. Please check value of subscriptionId and try again or invoke "registerStorageConfiguration" to add a new storage configuration.
|              404 | `VirtualMachineNotFoundInARM`                | Virtual machine '{0}' is not found. Please choose another virtual machine and try again.                                                                               |
|              405 | `EncryptedDiskNotSupported`                   | Disk inspection isn't supported for the specified VM and encrypted operating system disk.
|              405 | `ForbiddenError`                               | Caller does not have access to perform action(s): '{0}' on storage account: '{1}'. Please check the full set of required permissions.                                                                                                         |
|              405 | `InvalidDiskStatus`                           | Disk inspection isn't supported for the specified operating system disk and provisioning state.                                                                                                    |
|              405 | `ResourceNotSupported`                        | A specified resource isn't supported.
|              405 | `ResourceNotSupported`                        | Disk inspection is not supported for VM '{0}' with encrypted OS disk '{1}'.
|              405 | `ResourceNotSupported`                        | Disk inspection is not supported for VM '{0}' with ephemeral OS disk '{1}'.
|              405 | `ResourceNotSupported`                        | Disk inspection is not supported for the OS disk '{0}' with provisioning state '{1}'.
|              405 | `ResourceNotSupported`                        | Disk inspection is not supported for VM '{0}' with unmanaged OS disk.
|              405 | `UnableToCheckAccess`                         | Unable to determine permissions for clientObjectId: '{0}' on resourceId: '{1}' for actions: '{2}'. |
|              405 | `UnmanagedDiskNotSupported`                   | Disk inspection isn't supported for the specified VM and unmanaged operating system disk.
|              429 | `TooManyRequestsError`                        | Unable to determine permissions for clientObjectId: '{0}' on resourceId: '{1}' for actions: '{2}'. This is caused due to downstream API throttling. Please retry the request after some time. |
|              500 | `DiskInspectInternalServerError`              | An unexpected internal server error occurred during disk inspection. Try again later.
|              500 | `InternalServerError`                         | An unexpected internal server error occurred while running disk inspection.
|              500 | `InternalServerError`                         | Failed to register storage account. Please try again. If problem still persists, create a support request.
|              500 | `InternalServerError`                         | Failed to update storage account. Please try again. If problem still persists, create a support request. 
|              500 | `InternalServerError`                         | Failed to validate if a storage configuration exists. Please try again. If problem still persists, create a support request.
|              500 | `InternalServerError`                         | An unexpected internal server error has occurred. If problem still persists, create a support request.
|              500 | `InternalServerError`                         | VM '{0}' metadata are invalid. Please ensure that VM was provisioned successfully and not deleted.

## Common errors and solutions

The following are common issues when using VM Inspector and known solutions. 

### You don't have a role assignment that can run diagnostics

This error can occur when you use VM Inspector for the first time through the [Azure portal](https://portal.azure.com). As part of onboarding, the VM Inspector tool gets user consent to grant the Disk Backup reader role to the Compute Recommendation Service app. To add this role assignment, you should have Owner-level permissions.

For more information about the list of permissions that are needed to run VM Inspector, see [Get access to VM Inspector](vm-inspector-azure-virtual-machines.md#get-access-to-vm-inspector).

### Error message 403 "The client 'name' with object id 'value' does not have authorization to perform action 'Microsoft.Compute/locations/diagnostics/validateStorageConfiguration/action' over scope '/subscriptions/{0}' or the scope is invalid. If access was recently granted, please refresh your credentials"

This error can occur if you don't have enough permissions to invoke an API at the subscription level. The closest built-in role that you can use is [Contributor](/azure/role-based-access-control/built-in-roles#contributor) at the subscription level.

### Error message 405 "Caller does not have access to perform action(s): '{0}' on storage account: '{1}'. Please check the full set of required permissions."

This error can occur if you don't have enough permissions to run VM Inspector on the virtual machine or storage account. For example, if you have a Service Administrator role or a Classic Administrator role on the resources (even if it's inherited from the subscription level), running VM Inspector will result in a Forbidden error.

For more information about the list of permissions that are needed to run VM Inspector, see [Get access to VM Inspector](vm-inspector-azure-virtual-machines.md#get-access-to-vm-inspector).

## Resources

- [VM Inspector for Azure virtual machines](vm-inspector-azure-virtual-machines.md)

- [Grant limited access to Azure Storage resources using SAS](/azure/storage/common/storage-sas-overview)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
