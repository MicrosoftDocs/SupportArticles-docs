---
title: Custom Linux image provisioning errors
description: Provides solutions to provisioning errors when you upload or capture a generalized VM image as a specialized VM image or vice versa.
ms.custom: sap:Cannot create a VM, linux-related-content
ms.service: virtual-machines
ms.date: 06/03/2024
ms.reviewer: srijangupta, scotro, jarrettr
---
# Provisioning errors when deploying custom Linux images

[!INCLUDE [virtual-machines-troubleshoot-deployment-new-vm-issue1](../../../includes/azure/virtual-machines-troubleshoot-deployment-new-vm-issue1-include.md)]

[!INCLUDE [virtual-machines-linux-troubleshoot-deployment-new-vm-table](../../../includes/azure/virtual-machines-linux-troubleshoot-deployment-new-vm-table.md)]

**Y:** If the OS is Linux generalized, and it is uploaded and/or captured with the generalized setting, then there won't be any errors. Similarly, if the OS is Linux specialized, and it is uploaded and/or captured with the specialized setting, then there won't be any errors.

## Upload errors

**N<sup>1</sup>:** If the OS is Linux generalized, and it is uploaded as specialized, you will get a provisioning timeout error because the VM is stuck at the provisioning stage.

**N<sup>2</sup>:** If the OS is Linux specialized, and it is uploaded as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username and password.

### Resolution - Upload error

To resolve both these errors, upload the original VHD, available on premises, with the same setting as that for the OS (generalized/specialized). To upload as generalized, remember to run -deprovision first.

## Capture errors

**N<sup>3</sup>:** If the OS is Linux generalized, and it is captured as specialized, you will get a provisioning timeout error because the original VM is not usable as it is marked as generalized.

**N<sup>4</sup>:** If the OS is Linux specialized, and it is captured as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username and password. Also, the original VM is not usable because it is marked as specialized.

### Resolution - Capture error

To resolve both these errors, delete the current image from the portal, and [recapture it from the current VHDs](/azure/virtual-machines/linux/capture-image) with the same setting as that for the OS (generalized/specialized).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
