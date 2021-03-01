---
title: Performing an in-place system upgrade for Windows 10 based Azure VMs and workarounds for other versions of Azure Windows VMs
description: Describes how to perform an in-place system upgrade for Windows 10 based Azure VMs and workarounds for other versions of Azure Windows VMs
ms.date: 03/01/2021
ms.prod-support-area-path: 
ms.reviewer: 
---
# Performing an in-place system upgrade for Windows-based Azure VMs

This article describes how to perform an in-place system upgrade for Windows 10-based Azure VMs and workarounds for in-place system upgrade of other Azure Windows VMs.

_Original product version:_ &nbsp; Windows Server version 1709, Windows Server version 1803, Windows 10, version 1709, all editions, Virtual Machine running Windows, Windows Server 2016, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Datacenter, Windows 10, Windows 8.1, Windows 7 Enterprise, Windows 10, version 1803, all editions, Windows Server version 1803  
_Original KB number:_ &nbsp; 4014997

## Symptoms

When you perform an in-place upgrade of an Azure Windows VM to a newer version of the operating system, the upgrade fails or stops responding (hangs).

## Cause

In-place system upgrades are supported for specific versions of Azure Windows VMs. We are working to make in-place system upgrades (Feature Update) supported by other versions soon.

Windows operating system versions that **support** in-place system upgrade:

- Windows 10
- Windows 10, version 1709, all editions
- Windows 10, version 1803, all editions
- Windows 10 Enterprise multi-session, all editions

Windows operating system versions that **don’t currently support** in-place system upgrade: 

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

## Supported in-place system upgrade process for Windows 10

This process takes from 45 to 60 minutes and requires to reboot the VM:

1. Check that the Windows 10 VM isn’t using [Azure Disk Encryption](https://docs.microsoft.com[/azure/virtual-machines/windows/disk-encryption-overview) or [Ephemeral OS Disk](https://docs.microsoft.com/azure/virtual-machines/ephemeral-os-disks) features – these features aren’t currently supported.
2. Check that the Windows 10 VM has at least 2 GB RAM and 20 GB of free disk space on the System Disk (C:\ Drive).
3. To prevent data loss, backup the Windows 10 VM using [Azure Backup](https://docs.microsoft.com/azure/backup) or a 3rd-Party backup solution from the [Azure Marketplace  - Backup & Recovery](https://azuremarketplace.microsoft.com/en-us/marketplace/apps?search=Backup%20%26%20Recovery&page=1).
4. Check that the backup was successful - turn off the original Windows 10 VM, and verify that a new VM can be successfully restored from the backup and that all applications are running normally.
5. Either the original Windows 10 VM or the restored VM can be used as a source for in-place system upgrade, but both VMs can’t be running at the same time unless the system name of the VM and IP addresses on one of the VMs has been changed to prevent conflicts.
6. Connect to the Windows 10 VM, and then go to **Settings** > **Updates & Security** > **Windows Update**.
7. In Windows Update, select **Check for Updates**.
8. When the Feature Update appears, select **Download and install now**.
9. The Feature Update will download, install, and user settings and data will be preserved. The VM will reboot automatically.
10. General questions can be emailed to Azure VM team at azurevmupgrade@microsoft.com.

## Workaround approaches

To work around this issue, create an Azure VM that runs a supported version of an operating system, and then migrate the workload (Method 1, preferred), or download and upgrade the VHD of the VM (Method 2).

### Method 1: Deploy a newer system and migrate the workload

Create an Azure VM that is running the supported version of the required operating system, and then migrate the workload. Here’s how to migrate Windows Server roles and features: 

[Install, use, and remove Windows Server migration tools](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134202(v=ws.11)?redirectedfrom=MSDN)

### Method 2: Download and upgrade the VHD  

#### Step 1: Download and perform in-place upgrade in a local VM

1. [Download the VHD of the VM](https://docs.microsoft.com/azure/virtual-machines/windows/download-vhd).
1. Attach the VHD to a local Hyper-V VM.
1. Start the VM.
1. Run the in-place upgrade.

#### Step 2: Upload the VHD to Azure

Follow the steps in the following article to upload the VHD to Azure and to deploy the VM.

[Upload a Windows VHD from an on-premises VM to Azure](https://docs.microsoft.com/azure/virtual-machines/windows/upload-image)

### Method 3: Request to join Azure VM Upgrade Preview

If you want to upgrade a Windows operating system version that isn’t supported yet, request to join a Private or Public Preview program at azurevmrequest@microsoft.com. We will accommodate your request based on capacity and availability.

## References

For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672).
