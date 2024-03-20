---
title: Can't enable Azure Disk Encryption
description: Works around a problem in which you receive an Extension version '2.2' is not supported error when you enable Azure Disk Encryption.
ms.date: 07/21/2020
ms.reviewer: Ejarvi, devtiw, scotro
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
---
# Error when you try to enable Azure Disk Encryption: Extension version '2.2' is not supported

This article provides two workarounds to an issue in which you can't enable Azure Disk Encryption with error "Azure Disk Encryption extension version '2.2' is not supported".

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4339481

## Symptoms

When you try to enable Azure Disk Encryption on an Azure virtual machine (VM) on Windows, you receive the following error message:

> Azure Disk Encryption extension version '2.2' is not supported

## Workaround

To work around this problem, use one of the following methods.

### Method 1

Revert to using the Microsoft Entra parameters in the syntax for [Set-AzureRmVmDiskEncryptionExtension](/powershell/module/azurerm.compute/set-azurermvmdiskencryptionextension?view=azurermps-6.2.0&preserve-view=true).

The parameters are the following:

```
[-AadClientID] <String> 
[-AadClientSecret] <String>
```

### Method 2

Opt in to the "UnifiedDiskEncryptionForVMs" feature for your subscription by running the following script before you try again to enable encryption:

```powershell
Register-AzureRmProviderFeature -ProviderNamespace "Microsoft.Compute" -FeatureName "UnifiedDiskEncryptionForVMs" # Wait 10 minutes until state transitions to 'Registered' Register-AzureRmResourceProvider -ProviderNamespace Microsoft.Compute
```

## More Information

### Steps to reproduce the problem

Run the following script:

```
Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $resourceGroupName -VMName $vmName -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $keyVaultResourceId -KeyEncryptionKeyUrl $keyEncryptionKeyUrl -KeyEncryptionKeyVaultId $keyVaultResourceId -VolumeType 'All';
DEBUG: 10:47:22 AM - SetAzureDiskEncryptionExtensionCommand end processing.
Set-AzureRmVMDiskEncryptionExtension : Azure Disk Encryption extension version '2.2' is not supported.
ErrorCode: NotSupported
ErrorMessage: Azure Disk Encryption extension version '2.2' is not supported.
StatusCode: 409
ReasonPhrase: Conflict
OperationID : 2cb4ac35-e2a5-4cd4-84d9-3174663e0a46
At line:1 char:1
+ Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName $resourceGrou ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : CloseError: (:) [Set-AzureRmVMDiskEncryptionExtension], ComputeCloudException
```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
