---
title: Windows activation - duplicate Client Machine ID
description: Provides a solution to a duplicate Client Machine ID issue that occurs when you use a self-hosted Key Management Services (KMS) server for Windows activation.
ms.date: 12/26/2023
ms.reviewer: cwhitley, v-naqviadil, v-weizhu
ms.service: virtual-machines
ms.subservice: vm-windows-activation
---
# Windows activation - duplicate Client Machine ID

We generally recommend using Azure Key Management Services (KMS) servers to activate Azure Windows Virtual Machines (VMs), even when the hybrid benefit is enabled. However, in specific cases, because network restrictions might prevent VMs from communicating with Azure KMS servers, you use a self-hosted KMS server for activation. This article discusses an issue of duplicate Client Machine ID that occurs when you use a self-hosted KMS server for Windows activation, and provides a solution.

> [!NOTE]
> This article applies only when you use a self-hosted KMS server for activation. It doesn't apply when you use Azure KMS for activation.

## Symptoms

When you use a self-hosted KMS server for activation, and try to activate more than one Windows Server VM, the activation fails after the evaluation period and your self-hosted KMS server reports the following error in the **Duplicate Client Machine ID Report**:

> The **Duplicate Client Machine ID Report** helps identity machines in the environment which are running images that were not properly generalized by using the Sysprep tool before deployment.  
> Note:  
> \- Multiple Volume Activation Clients with the same CMID will be counted as a single client by KMS. If this causes the KMS Client Count to fall below the minimum threshold, KMS activation will fail in your environment.

## Cause

- The Client Machine ID (CMID) is cleared during the Sysprep process of the original source image. However, if the Sysprep is triggered with the parameter `SkipRearm` set to `1` instead of the default value `0`, the CMID won't be cleared. In this case, all VMs created from this image will have the same CMID.

- When you create VMs from Azure MarketPlace, Azure Marketplace images for Windows Server have been sysprepped with the parameter `SkipRearm` set to `1`. Therefore, the VMs created from the same Windows Server image will have the same CMID.

## Confirm duplicate CMID

Check if the VMs have the same CMID based on the source image and version:

1. Run the following command on the problem VMs:

    ```cmd
    cscript C:\Windows\System32\slmgr.vbs /dlv
    ```

    Here's the command output sample:
    
    ```output
    Most recent activation information:
    Key Management Service client information
        Client Machine ID (CMID): <client-machine-ID>
        Registered KMS machine name: <KMS-machine-name>
    ```

2. Compare the command outputs on problem VMs and confirm if the VMs have the same CMID.

## Solution

- For the problem VMs created from a custom image, generalize/sysprep the original VM with the parameter `SkipRearm` set to `0` to make sure the CMID is cleared from the image.

- For the problem VMs that are already deployed, follow these steps:

    1. Run the `slmgr /rearm` command from an elevated command prompt.
    2. Restart the VM.
    3. Once the VM is online after the restart, run the following command to confirm that the CMID has been changed:
    
        ```output
        cscript C:\Windows\System32\slmgr.vbs /dlv
        ```
    
    4. Trigger the activation again.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]