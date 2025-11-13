---
title: In-place upgrade for supported VMs running Windows in Azure (Windows Client)
description: Understand how to work around the unsupported in-place system upgrade on an Azure VM that runs Windows.
ms.date: 05/09/2025
ms.reviewer: joscon, scotro, azurevmcptcic, maulikshah, yogitagohel, v-weizhu
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:Windows Update, Guest Patching and OS Upgrades
---
# In-place upgrade for supported VMs running Windows in Azure (Windows Client)

**Applies to:** :heavy_check_mark: Windows VMs

_Original product version:_ &nbsp; Windows 10, version 1803, all editions, Windows 10, version 1709, all editions, Virtual Machine running Windows, Windows 10, Windows 8.1, Windows 7 Enterprise  
_Original KB number:_ &nbsp; 4014997

This article describes how to do an in-place system upgrade of supported Windows 10-based and Windows-11-based Azure Virtual Machines (VM). This article also describes workarounds for Azure VMs that aren't supported for in-place system upgrades. 

> [!NOTE]  
> **Looking for Windows Server?**  
> For Azure VMs running Windows Server, see [In-place upgrade for supported Windows Server VMs](/azure/virtual-machines/windows-in-place-upgrade).

> [!CAUTION]
> Following the process in this article causes a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the virtual machine (VM). Azure capabilities such as [Auto guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [Auto OS image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To utilize these features, create a new VM using your preferred operating system instead of performing an in-place upgrade.


[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]


## Symptoms

Consider the following scenario:

- You have a VM that's running Windows in a Microsoft Azure environment.
- You run an in-place upgrade of the VM to a newer version of the operating system.

 In this scenario, the upgrade may fail or become blocked and require direct console access.

## Cause

In-place system upgrades are supported for specific versions of Azure Windows VMs. We're working to broaden support of in-place system upgrade (as a Feature Update) to other versions soon.

### Windows versions supported for in-place system upgrades

- Windows 10 single-session, all editions, all versions

   > [!NOTE]
   > - You can't do an in-place upgrade from a single-session SKU of Windows to a multi-session SKU. For more information, see [Can I upgrade a Windows VM to Windows Enterprise multi-session?
](/azure/virtual-desktop/windows-multisession-faq#can-i-upgrade-a-windows-vm-to-windows-enterprise-multi-session).
   > - When migrating from Windows 10 to Windows 11, follow best practices by deploying new VMs. This approach avoids potential compatibility issues and ensures an optimized configuration. The VM must meet the [hardware requirements for Windows 11](/windows/whats-new/windows-11-requirements#virtual-machine-support).

### Single-Session Vs. Multi-Session Scenarios Suport

| **Scenario** | **Single-Session** | **Multi-Session** |
|:-----|:-----|:-----|
| Windows 10 *(Ex: 21H2 → 22H2)* | Supported     | Supported | It is recommended to create a new AVD environment | 
| Windows 10 → Windows 11      | Not Supported | Not Supported | It is recommended to create a new AVD environment |
| Windows 11 *(Ex: 24H2 → 25H2)* | Supported | Supported | It is recommended to create a new AVD environment |

#### Can Windows Enterprise multi-session receive feature updates through Windows Server Update Services (WSUS)?
You can update [Windows Enterprise multi-session with the appropriate feature updates published to WSUS](/azure/virtual-desktop/faq#can-i-do-an-in-place-upgrade-of-a-session-host-s-operating-system), the same as a single-session version of Windows. The underlying VM must meet the hardware requirements for the operating system you're using, such as the [hardware requirements for Windows 11](/windows/whats-new/windows-11-requirements#virtual-machine-support). 

#### Can session hosts in a hostpool be upgraded (Azure Virtual Desktop)?
In-place upgrade of Windows, for example from Windows 10 to Windows 11, isn't supported for session hosts in a pooled host pool. For more information, see [Can I do an in-place upgrade of a session host's operating system](/azure/virtual-desktop/faq#can-i-do-an-in-place-upgrade-of-a-session-host-s-operating-system).


### Windows versions out of support for in-place system upgrades

- Windows 8.1 (End Of Service)
- Windows 7 Enterprise (End Of Service)

## In-place system upgrade process for a Windows 10 VM

This process requires 45-60 minutes to complete and for the VM to restart. To do the in-place system upgrade, follow these steps:

1. Run [Azure Virtual Machine (VM) Windows OS Upgrade Assessment Tool](windows-vm-osupgradeassessment-tool.md) to validate the OS upgrade path and any known issues.
2. Verify that the Windows 10 VM doesn't use [Ephemeral OS Disk](/azure/virtual-machines/ephemeral-os-disks). This feature is currently not supported.
3. Verify that the Windows 10 VM has at least 2 GB of RAM, and 12 GB of free disk space on the system disk.
4. To prevent data loss, back up the Windows 10 VM by using [Azure Backup](/azure/backup/). Or use a third-party backup solution from [Azure Marketplace Backup & Recovery](https://azuremarketplace.microsoft.com/marketplace/apps?search=Backup%20%26%20Recovery&page=1).
5. To check whether the backup was successful, turn off the original Windows 10 VM and verify that a new VM can be successfully restored from the backup and that all applications are running successfully.

   > [!NOTE]  
   > Either the original Windows 10 VM or the restored VM can be used as a source for in-place system upgrade. Both VMs cannot run simultaneously unless one VM's system name and IP address are changed to avoid conflicts.
  
6. Connect to the Windows 10 VM, and go to **Settings** > **Updates & Security** > **Windows Update**.
7. In Windows Update, select **Check for updates**.
8. When the Feature Update item appears, select **Download and install now**.
9. The update will download and install. User settings and data will be preserved, and the VM will restart automatically.

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

> [!NOTE]  
> When performing an in-place upgrade on Azure Windows VMs, the VM properties on the Azure portal aren't updated; the changes are only reflected within the OS. This means that the source image information in the VM properties, including the publisher, offer, and plan, remains unchanged. The image used to deploy the VM remains the same, and only the OS is upgraded.


## References

[Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
