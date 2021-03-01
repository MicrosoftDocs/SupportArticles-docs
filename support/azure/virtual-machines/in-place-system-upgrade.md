---
title: Performing an in-place system upgrade is not supported on Windows-based Azure VMs
description: Describes how to work around the unsupported in-place system upgrade on a Windows Azure VM.
ms.date: 07/21/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# Performing an in-place system upgrade is not supported on Windows-based Azure VMs

This article describes how to work around the unsupported in-place system upgrade on a Windows Azure VM.

_Original product version:_ &nbsp; Windows Server version 1709, Windows Server version 1803, Windows 10, version 1709, all editions, Virtual Machine running Windows, Windows Server 2016, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Datacenter, Windows 10, Windows 8.1, Windows 7 Enterprise, Windows 10, version 1803, all editions, Windows Server version 1803  
_Original KB number:_ &nbsp; 4014997

## Symptoms

Consider the following scenario:

- You have a virtual machine (VM) that is running Microsoft Windows in a Microsoft Azure environment.
- You run an in-place upgrade of the VM to a newer version of the operating system. 
 In this scenario, the upgrade may fail or become blocked and require direct console access to unblock it.

> [!NOTE]
> This article applies to clients running Windows 7, Windows Server 2008 R2, and later versions of both operating systems.

## Cause

Microsoft does not support an upgrade of the operating system of an Azure VM. 

## Workaround

To work around this issue, create an Azure VM that's running a supported version of an operating system, and then migrate the workload (Method 1, preferred), or download and upgrade the VHD of the VM (Method 2).

### Method 1: Deploy a newer system and migrate the workload

Microsoft does not support an upgrade of the operating system of an Azure VM. Instead, you can create an Azure VM that is running the supported version of the required operating system, and then migrate the workload. Instructions for how to migrate Windows Server roles and features are available in the following TechNet topic:

[Install, use, and remove Windows Server migration tools](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134202(v=ws.11)?redirectedfrom=MSDN)

### Method 2: Download and upgrade the VHD  

#### Step 1: Download the VHD of the VM

1. In Azure portal, open the Storage account.
2. Select the Storage account that contains the VHD file.
3. Select the container for the VHD file.
4. Select the VHD file, and then select the **Download** button.

    :::image type="content" source="media/in-place-system-upgrade/4017843_en_1.png" alt-text="Screenshot of downloading the Azure VM VHD file.":::

#### Step 2: Do an in-place upgrade

1. Attach the VHD to a local Hyper-V VM.
2. Start the VM.
3. Run the in-place upgrade.

#### Step 3: Upload the VHD to Azure

Follow the steps in the following article to upload the VHD to Azure and to deploy the VM.

[Upload a Windows VHD from an on-premises VM to Azure](https://docs.microsoft.com/azure/virtual-machines/windows/upload-image)

## References

For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672).