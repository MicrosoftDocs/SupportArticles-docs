---
title: Custom image provisioning errors
description: Provides solutions to provisioning errors when you upload or capture a generalized VM image as a specialized VM image or vice versa.
ms.service: virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Provisioning errors when deploying custom images

Provisioning errors arise if you upload or capture a generalized VM image as a specialized VM image or vice versa. The former will cause a provisioning timeout error and the latter will cause a provisioning failure. To deploy your custom image without errors, you must ensure that the type of the image does not change during the capture process.

The following table lists the possible combinations of generalized and specialized images, the error type you will encounter and what you need to do to fix the errors.

[!INCLUDE [virtual-machines-windows-troubleshoot-deployment-new-vm-table](../../../includes/azure/virtual-machines-windows-troubleshoot-deployment-new-vm-table.md)]

**Y:** If the OS is Windows generalized, and it is uploaded and/or captured with the generalized setting, then there won't be any errors. Similarly, if the OS is Windows specialized, and it is uploaded and/or captured with the specialized setting, then there won't be any errors.

## Upload errors

**N<sup>1</sup>:** If the OS is Windows generalized, and it is uploaded as specialized, you will get a provisioning timeout error with the VM stuck at the OOBE screen.

**N<sup>2</sup>:** If the OS is Windows specialized, and it is uploaded as generalized, you will get a provisioning failure error with the VM stuck at the OOBE screen because the new VM is running with the original computer name, username and password.

### Resolution

To resolve both these errors, use [Add-AzVhd to upload the original VHD](/powershell/module/az.compute/add-azvhd), available on-premises, with the same setting as that for the OS (generalized/specialized). To upload as generalized, remember to run sysprep first.

## Capture errors

**N<sup>3</sup>:** If the OS is Windows generalized, and it is captured as specialized, you will get a provisioning timeout error because the original VM is not usable as it is marked as generalized.

**N<sup>4</sup>:** If the OS is Windows specialized, and it is captured as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username, and password. Also, the original VM is not usable because it is marked as specialized.

### Resolution

To resolve both these errors, delete the current image from the portal, and [recapture it from the current VHDs](/azure/virtual-machines/windows/create-vm-specialized) with the same setting as that for the OS (generalized/specialized).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
