---
title: Steps for in-place system upgrades for supported Windows 10 Azure VMs and workarounds for unsupported versions
description: Describes how to work around the unsupported in-place system upgrade on a Windows Azure VM.
ms.date: 07/21/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# Steps for in-place system upgrades for supported Windows 10 Azure VMs and workarounds for unsupported versions

This article describes how to do an in-place system upgrade of supported Windows 10-based Azure virtual machines (Azure VMs). This article also describes workarounds for Azure VMs that are not supported for in-place system upgrades.

_Original product version:_ &nbsp; Windows Server version 1709, Windows Server version 1803, Windows 10, version 1709, all editions, Virtual Machine running Windows, Windows Server 2016, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Datacenter, Windows 10, Windows 8.1, Windows 7 Enterprise, Windows 10, version 1803, all editions, Windows Server version 1803  
_Original KB number:_ &nbsp; 4014997

## Symptoms

Consider the following scenario:

- You have a virtual machine (VM) that is running Windows in a Microsoft Azure environment.
- You run an in-place upgrade of the VM to a newer version of the operating system.

 In this scenario, the upgrade may fail or become blocked and require direct console access.

## Cause

In-place system upgrades are supported for specific versions of Azure Windows VMs. We’re working to broaden support of in-place system upgrade (as a Feature Update) to other versions soon.

### Windows versions supported for in-place system upgrades:

- Windows 10
- Windows 10, version 1709, all editions
- Windows 10, version 1803, all editions
- Windows 10 Enterprise multi-session, all editions

## Windows versions not yet supported for in-place system upgrades (consider using a workaround):

- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2 Datacenter
- Windows Server 2012 R2 Standard
- Windows Server 2012 Datacenter
- Windows Server 2012 Standard
- Windows Server 2008 R2 Datacenter
- Windows Server 2008 R2 Standard
- Windows 8.1
- Windows 7 Enterprise
- Windows Server, version 1709
- Windows Server, version 1803

### Supported in-place system upgrade process (Feature Update) for Windows 10 and Windows 10 Multi-session

This process requires 45-60 minutes to complete and for the VM to restart. To do the in-place system upgrade, follow these steps:

1. Verify that the Windows 10 VM doesn’t use [Azure Disk Encryption](https://docs.microsoft.com/azure/virtual-machines/windows/disk-encryption-overview) or [Ephemeral OS Disk](https://docs.microsoft.com/azure/virtual-machines/ephemeral-os-disks). These features are currently not supported.
2. Verify that the Windows 10 VM has at least 2 GB of RAM and 12 GB of free disk space on the system disk (drive C).
3. To prevent data loss, back up the Windows 10 VM by using [Azure Backup](https://docs.microsoft.com/azure/backup/) or a third-party backup solution from [Azure Marketplace Backup & Recovery](https://azuremarketplace.microsoft.com/marketplace/apps?search=Backup%20%26%20Recovery&page=1).
4. Check whether the backup was successful. To do this, turn off the original Windows 10 VM, and verify that a new VM can be successfully restored from the backup and that all applications are running successfully.

   > [!NOTE]
   > Either the original Windows 10 VM or the restored VM can be used as a source for in-place system upgrade. However, both VMs can’t be running at the same time unless the system name of the VM and the IP addresses on one of the VMs was changed to prevent conflicts.

5. Connect to the Windows 10 VM, and go to **Settings** > **Updates & Security** > **Windows Update**.
6. In Windows Update, select **Check for updates**.
7. When the Feature Update item appears, select **Download and install now**.
8. The update will download and install. User settings and data will be preserved, and the VM will restart automatically.

If you have general questions about this procedure, write to the [azurevmupgrade@microsoft.com](mailto:azurevmupgrade@microsoft.com) alias.

## Workaround

To work around an Azure VM that’s running a version of the operating system that’s not supported for in-place upgrades, create an Azure VM that's running a supported version, and then either migrate the workload (Method 1, preferred) or download and upgrade the VHD of the VM (Method 2).

### Method 1: Deploy a newer system and migrate the workload

 Create an Azure VM that runs a supported version of the operating system, and then migrate the workload. To do this, you will use Windows Server migration tools. For instructions to migrate Windows Server roles and features , see the following Microsoft Ignite topic:

[Install, use, and remove Windows Server migration tools](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134202(v=ws.11)?redirectedfrom=MSDN)

### Method 2: Download and upgrade the VHD  

#### Step 1: Do an in-place upgrade in a local Hyper-V VM

1. [Download the VHD of the VM](https://docs.microsoft.com/azure/virtual-machines/windows/download-vhd).
1. Attach the VHD to a local Hyper-V VM.
1. Start the VM.
1. Run the in-place upgrade.

#### Step 2: Upload the VHD to Azure

Follow the steps in the following article to upload the VHD to Azure and to deploy the VM.

[Upload a Windows VHD from an on-premises VM to Azure](https://docs.microsoft.com/azure/virtual-machines/windows/upload-image)

### Method 3: Request to join Azure IaaS VM Upgrade Preview

If you’re interested in upgrading an operating system version that’s not yet supported, you might be able to join a Private or Public Preview program, depending on capacity and availability. Please email your request to [azurevmrequest@microsoft.com](mailto:azurevmrequest@microsoft.com).

## References

[Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672).