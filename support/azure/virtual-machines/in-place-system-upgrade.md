---
title: Performing an in-place system upgrade for Windows 10 based Azure VMs and workarounds for other versions of Windows Azure VMs
description: Describes how to work around the unsupported in-place system upgrade on a Windows Azure VM.
ms.date: 07/21/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# Performing an in-place system upgrade for Windows-based Azure VMs

This article describes how to perform an in-place system upgrade for Windows 10 Azure VMs and workarounds for in-place system upgrade of other Windows Azure VMs.

_Original product version:_ &nbsp; Windows Server version 1709, Windows Server version 1803, Windows 10, version 1709, all editions, Virtual Machine running Windows, Windows Server 2016, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Datacenter, Windows 10, Windows 8.1, Windows 7 Enterprise, Windows 10, version 1803, all editions, Windows Server version 1803  
_Original KB number:_ &nbsp; 4014997

## Symptoms

Consider the following scenario:

- You have a virtual machine (VM) that is running Microsoft Windows in a Microsoft Azure environment.
- •	When running an in-place upgrade of the VM to a newer version of the operating system, the upgrade fails or stops responding (hangs) and requires direct console access to stop upgrading and roll back.

> [!NOTE]
> In-place system upgrades are supported for specific versions of Windows Azure VMs. 

Windows Operating System versions that **support** in-place system upgrade:

- Windows 10
- Windows 10, version 1709, all editions
- Windows 10, version 1803, all editions
- Windows 10 Enterprise multi-session, all editions

Windows Operating System versions that don’t yet support in-place system upgrade: 

- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2 Standard
- Windows Server 2012 R2 Datacenter
- Windows Server 2012 Datacenter
- Windows Server 2012 Standard
- Windows Server 2008 R2 Standard
- Windows Server 2008 R2 Datacenter
- Windows 8.1
- Windows 7 Enterprise
- Windows Server version 1709
- Windows Server version 1803

## Cause

In-place system upgrades are supported for specific versions of Windows Azure VMs. We are working to make In-place system upgrades (Feature Update) supported by other versions soon.

## Supported In-place system upgrade process for Windows 10

This process takes from 45 to 60 minutes and requires to restart the VM:

1. Check that the Windows 10 VM isn’t using Azure Disk Encryption or Ephemeral OS Disk features – these features aren’t currently supported.
2. Check that the Windows 10 VM has at least 2 GB RAM and 20 GB of free disk space on the System Disk (C:\ Drive).
3. To prevent data loss, backup the Windows 10 VM using Azure Backup or a 3rd-Party backup solution from the Azure Marketplace Backup & Recovery.
4. Check that the backup was successful - turn off the original Windows 10 VM, and verify that a new VM can be successfully restored from the backup and that all applications are running normally.
5. Either the original Windows 10 VM or the restored VM can be used as a source for In-place system upgrade, but both VMs can’t be running at the same time unless the system name of the VM and IP Addresses on one of the VMs has been changed to prevent conflicts.
6. Connect to the Windows 10 VM and go to Settings > Updates & Security > Windows Update.
7. In Windows Update simple click Check for Updates.
8. When the Feature Update appears, click Download and install now.
9. The Feature Update will download, install, and user settings and data will be preserved. The VM will restart (reboot) automatically.
10. General questions can be directed to the azurevmupgrade@microsoft.com.

## Workaround approaches

To work around this issue, create an Azure VM that runs a supported version of an operating system, and then migrate the workload (Method 1, preferred), or download and upgrade the VHD of the VM (Method 2).

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

#### Step 2: Perform an in-place upgrade

1. Attach the VHD to a local Hyper-V VM.
2. Start the VM.
3. Run the in-place upgrade.

#### Step 3: Upload the VHD to Azure

Follow the steps in the following article to upload the VHD to Azure and to deploy the VM.

[Upload a Windows VHD from an on-premises VM to Azure](https://docs.microsoft.com/azure/virtual-machines/windows/upload-image)

### Method 3: Request to join Azure VM Upgrade Preview

If you want to upgrade an Operating System version that isn’t supported yet, request to join a Private or Public Preview program at azurevmrequest@microsoft.com. Availability is limited.

## References

For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672).
