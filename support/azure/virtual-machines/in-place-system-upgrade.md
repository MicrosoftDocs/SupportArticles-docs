---
title: In-place upgrade for supported VMs running Windows in Azure
description: Understand how to work around the unsupported in-place system upgrade on an Azure VM that runs Windows.
ms.date: 03/14/2024
ms.reviewer: joscon, scotro, azurevmcptcic, maulikshah, v-weizhu
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
ms.collection: windows
---
# In-place upgrade for supported VMs running Windows in Azure

> [!Important]
> Following the process below will cause a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the VM. Azure capabilities such as [Auto guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [Auto OS image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To utilize these features, it's recommended to create a new VM using your preferred OS instead of performing an in-place upgrade.

This article describes how to do an in-place system upgrade of supported Windows 10-based Azure virtual machines (Azure VMs). This article also describes workarounds for Azure VMs that aren't supported for in-place system upgrades. For Azure VMs running Windows Server, see [In-place upgrade for supported Windows Server VMs](/azure/virtual-machines/windows-in-place-upgrade).

> [!NOTE]  
> **Looking for Windows Server?**  
> For the in-place system upgrade procedure for virtual machines that are running Windows Server, see [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade).

_Original product version:_ &nbsp; Windows 10, version 1803, all editions, Windows 10, version 1709, all editions, Virtual Machine running Windows, Windows 10, Windows 8.1, Windows 7 Enterprise  
_Original KB number:_ &nbsp; 4014997

## Symptoms

Consider the following scenario:

- You have a virtual machine (VM) that's running Windows in a Microsoft Azure environment.
- You run an in-place upgrade of the VM to a newer version of the operating system.

 In this scenario, the upgrade may fail or become blocked and require direct console access.

## Cause

In-place system upgrades are supported for specific versions of Azure Windows VMs. We're working to broaden support of in-place system upgrade (as a Feature Update) to other versions soon.

### Windows versions supported for in-place system upgrades

- Windows 10 single-session, all editions, all versions
- Windows 10 Enterprise multi-session, all versions

   > [!NOTE]
   > - It's not currently possible to upgrade an existing virtual machine that's running Windows 10 Professional or Enterprise to [Windows 10 Enterprise multi-session](/azure/virtual-desktop/windows-10-multisession-faq#can-i-upgrade-a-windows-10-vm-to-windows-10-enterprise-multi-session).
   > - When migrating from Windows 10 to Windows 11, follow best practices by deploying new virtual machines. This approach avoids potential compatibility issues and ensures an optimized configuration.

### Windows versions not yet supported for in-place system upgrades (consider using a workaround)

- Windows 8.1
- Windows 7 Enterprise
   
## In-place system upgrade process for a Windows 10 VM

This process requires 45-60 minutes to complete and for the VM to restart. To do the in-place system upgrade, follow these steps:

1. Verify that the Windows 10 VM doesn't use [Ephemeral OS Disk](/azure/virtual-machines/ephemeral-os-disks). This feature is currently not supported.
2. Verify that the Windows 10 VM has at least 2 GB of RAM, and 12 GB of free disk space on the system disk.
3. To prevent data loss, back up the Windows 10 VM by using [Azure Backup](/azure/backup/). Or use a third-party backup solution from [Azure Marketplace Backup & Recovery](https://azuremarketplace.microsoft.com/marketplace/apps?search=Backup%20%26%20Recovery&page=1).
4. Check whether the backup was successful. To do this, turn off the original Windows 10 VM. Verify that a new VM can be successfully restored from the backup and that all applications are running successfully.

   > [!NOTE]  
   > Either the original Windows 10 VM or the restored VM can be used as a source for in-place system upgrade. But both VMs can't be running at the same time unless the system name of the VM and the IP addresses on one of the VMs was changed to prevent conflicts.

5. Connect to the Windows 10 VM, and go to **Settings** > **Updates & Security** > **Windows Update**.
6. In Windows Update, select **Check for updates**.
7. When the Feature Update item appears, select **Download and install now**.
8. The update will download and install. User settings and data will be preserved, and the VM will restart automatically.

If you have general questions about this procedure, post to [Microsoft Q&A](/answers/topics/azure-virtual-machines.html) and add the `azure-virtual-machines` tag to your question.

## Workaround

To work around this issue, create an Azure VM that's running a supported version. Download and upgrade the VHD of the VM.

To prevent data loss, back up the Windows 10 VM by using [Azure Backup](/azure/backup/). Or use a third-party backup solution from [Azure Marketplace Backup & Recovery](https://azuremarketplace.microsoft.com/marketplace/apps?search=Backup%20%26%20Recovery&page=1).

### Download and upgrade the VHD  

#### Step 1: Do an in-place upgrade in a local Hyper-V VM

1. [Download the VHD of the VM](/azure/virtual-machines/windows/download-vhd).
1. Attach the VHD to a local Hyper-V VM.
1. Start the VM.
1. Run the in-place upgrade.

#### Step 2: Upload the VHD to Azure

Follow the steps in the following article to upload the VHD to Azure and to deploy the VM.

[Upload a generalized VHD and use it to create new VMs in Azure](/azure/virtual-machines/windows/upload-generalized-managed)

## References

[Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
