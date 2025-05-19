---
title: Custom Linux image provisioning errors
description: Provides solutions to provisioning errors when you upload or capture a generalized virtual machine image as a specialized Linux VM image or vice versa.
ms.custom: sap:Cannot create a VM, linux-related-content
ms.service: azure-virtual-machines
ms.date: 05/19/2025
ms.reviewer: srijangupta, scotro, maries, jarrettr, v-weizhu
---
# Provisioning errors when deploying custom Linux images

**Applies to:** :heavy_check_mark: Linux VMs

## Overview

When you upload or capture a generalized virtual machine (VM) image as a specialized VM image, a [provisioning timeout error](#provisioning-timeout-error-during-an-upload-process) will occur.

When you upload or capture a specialized VM image as a generalized VM image, a [provisioning timeout error](#provisioning-timeout-error-during-an-upload-process) and provisioning failure will occur.

To deploy your custom image without errors, you must ensure that the type of the image doesn't change during the upload or capture process.

This article covers the possible combinations of generalized and specialized images, the error types you'll encounter, and how to fix the errors.

> [!NOTE]
> For descriptions and comparison of generalized and specialized images, see [Generalized and specialized](/azure/virtual-machines/linux/imaging#generalized-and-specialized).

## Upload combinations of generalized and specialized images

- If the operating system (OS) is a generalized Linux image uploaded using the generalized setting, the upload and deployment will succeed.  
- If the OS is a specialized Linux image and you upload it using the specialized setting, the upload and deployment will succeed.
- If the OS is a generalized Linux image uploaded as a specialized image, the new VM will fail to progress past the provisioning stage with a [provisioning timeout error](#provisioning-timeout-error-during-an-upload-process).
- If the OS is Linux-specialized and uploaded as a generalized image, the new VM will run with the original computer name, username, and password, which causes a provisioning failure error.

The following matrix shows the possible upload combinations of Linux generalized and specialized OS images:

|OS| Upload specialized image|Upload generalized image|
|---|---|---|
|Generalized image|VM will fail to progress past the provisioning stage with a [provisioning timeout error](#provisioning-timeout-error-during-an-upload-process).| The upload and deployment will succeed.|
|Specialized image|The upload and deployment will succeed. |VM will run with the original computer name, username, and password, which causes a provisioning failure error. |

### Resolution for upload errors

To resolve these errors, upload the original VHD from your on-premises environment using the same setting as the OS (generalized or specialized). If you upload it as generalized, make sure to run the `-deprovision` command first.

## Capture combinations of generalized and specialized images  

- If the OS is a generalized Linux image captured using the generalized setting, the upload and deployment will succeed.  
- If the OS is a specialized Linux image and you capture it using the specialized setting, the upload and deployment will succeed. 
- If the OS is Linux generalized but captured as specialized, you'll get a [provisioning timeout error](#provisioning-timeout-error-during-an-upload-process) because the original VM is unusable as it's marked as generalized.
- If the OS is Linux-specialized but captured as generalized, you'll get a provisioning failure error because the new VM will retain the original computer name, username, and password. Additionally, the original VM will become unusable as it's marked as specialized.

The following matrix shows the possible capture combinations of Linux generalized and specialized OS images:

|OS|Capture specialized image|Capture generalized image|
|---|---|---|
|Generalized image|[Provisioning timeout error](#provisioning-timeout-error-during-an-upload-process) because the original VM is unusable as it's marked as generalized.|The upload and deployment will succeed.|
|Specialized image|The upload and deployment will succeed.|Provisioning failure error because the new VM will retain the original computer name, username, and password. Additionally, the original VM will become unusable as it's marked as specialized.|

### Resolution for capture errors

To resolve these errors, delete the current image from the portal, and [recapture it from the current VHDs](/azure/virtual-machines/linux/capture-image) with the same setting as that for the OS (generalized or specialized). For more information, see [How to capture a Linux VM image for upload preparation](capture-linux-image-for-upload.md).

## Provisioning timeout error during an upload process

When a Linux generalized OS is uploaded as specialized, it might result in a provisioning timeout error, causing the VM to get stuck during provisioning. This issue typically occurs due to the fundamental differences in configuration between generalized and specialized images. For more information about the differences, see [Generalized and specialized](/azure/virtual-machines/linux/imaging#generalized-and-specialized).

Here are some possible scenarios and explanations of the provisioning timeout error:

|Scenario|Issue|Cause|Solution|
|---|---|---|---|
|Persistent network configuration conflicts|Generalized images are designed to remove unique identifiers and specific configurations, making them ready for new deployments. Uploading a generalized image as specialized might result in network conflicts due to persistent network configurations.|Residual network settings or DHCP client IDs remain in the image, which causes the system to hang when it tries to acquire a new IP address during provisioning.|Verify and remove any static network configurations or identifiers before uploading the image.|
|Secure Shell (SSH) key or password reset issues|Generalized images don't retain user-specific configurations like SSH keys or passwords. During provisioning, the VM might attempt to reset these configurations; however, their absence or misconfiguration can result in timeouts.|Without predefined SSH keys or passwords, the provisioning service can't complete the configuration.|Ensure that the VM configuration includes SSH or password authentication methods compatible with the OS state.|
|Missing Cloud-Init or Waagent configuration|Generalized images require provisioning agents such as `cloud-init` or `waagent` to set up the VM during the first boot. If these configurations are missing or incompatible, the provisioning will stall.|Specialized images come with preconfigured initial setup scripts, while generalized images depend on initialization tools for their configuration.|Validate that `cloud-init` or `waagent` is properly configured in the image before uploading.|

## More information

For more information about how to capture a Linux image to prepare for upload, see [How to capture a Linux image for upload preparation](capture-linux-image-for-upload.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
