---
title: In-place upgrade for supported VMs running Windows in Azure (Windows Client)
description: Learn how to perform an in-place upgrade for Windows VMs in Azure, which versions and upgrade methods are supported, and guidance for Azure Virtual Desktop session hosts.
ms.date: 07/10/2026
ms.reviewer: joscon, scotro, ericor, azurevmcptcic, maulikshah, yogitagohel, v-weizhu
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: 
   - sap:Windows Update, Guest Patching and OS Upgrades
   - sap:Windows Update and OS Upgrades
---
# In-place upgrade for supported VMs running Windows in Azure (Windows client)

**Applies to:** :heavy_check_mark: Windows VMs

_Original product version:_ &nbsp; Windows 10, version 1803, all editions, Windows 10, version 1709, all editions, Virtual Machine running Windows, Windows 10, Windows 8.1, Windows 7 Enterprise  
_Original KB number:_ &nbsp; 4014997

## Summary

This article describes how to do an in-place system upgrade of supported Windows 10-based and Windows-11-based Azure Virtual Machines (VMs). It also describes workarounds for Azure VMs that aren't supported for in-place system upgrades. 

> [!NOTE]  
> **Looking for Windows Server?**  
> For Azure VMs running Windows Server, see [In-place upgrade for supported Windows Server VMs](/azure/virtual-machines/windows-in-place-upgrade).

> [!CAUTION]
> Following the process in this article causes a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes#responsibilities-of-a-control-plane) of the VM. Azure capabilities like [Auto guest patching](/azure/virtual-machines/automatic-vm-guest-patching#how-does-automatic-vm-guest-patching-work), [Auto OS image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json#supported-updates), and [Azure Update Manager](/azure/update-manager/overview) aren't available. To use these features, create a new VM by using your preferred operating system instead of performing an in-place upgrade.


[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

## Understanding in-place upgrades

The term "in-place upgrade" refers to updating the Windows operating system version on an existing VM while retaining user data, applications, and settings. In-place upgrades can be performed through the following methods:

- **ISO-based upgrade** — Mounting a Windows installation ISO and running `setup.exe /auto upgrade`
- **Windows Update via Settings app** — Using **Settings** > **Windows Update** to install a feature update
- **Windows Server Update Services (WSUS)** — Deploying feature updates through WSUS to managed VMs

> [!IMPORTANT]
> An in-place upgrade that changes the Windows version (for example, Windows 10 to Windows 11) is an **OS version upgrade**. An in-place upgrade that updates to a newer feature release of the same version (for example, Windows 11 24H2 to 25H2) is a **feature update**. These scenarios have different supportability depending on the VM type and Azure Virtual Desktop configuration. See [Azure Virtual Desktop in-place upgrade support matrix](#azure-virtual-desktop-in-place-upgrade-support-matrix) for details.

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

### Windows versions that don't support in-place system upgrades (consider using a workaround)

- Windows 10 and 11 multi-session (all versions) — commonly used as Azure Virtual Desktop session hosts
- Windows 10 and 11 single-session up to Windows 10 and 11 multisesion (cross-SKU)
- Windows 8.1
- Windows 7 Enterprise

> [!IMPORTANT]
> **Azure Virtual Desktop session hosts:** In-place upgrade supportability depends on the session host type, Windows SKU, and upgrade scenario. See the following support matrix and [Azure Virtual Desktop session host upgrade guidance](#azure-virtual-desktop-session-host-upgrade-guidance) for details.

### Azure Virtual Desktop in-place upgrade support matrix

The following table shows in-place upgrade supportability for Azure Virtual Desktop session hosts and standard Azure VMs. **All upgrade methods** (ISO, Settings app, WSUS) follow the same supportability.

**Summary:** Feature updates within the same Windows version are supported. OS version upgrades (Windows 10 to Windows 11) aren't supported on any session host type or standard Azure VM — deploy new VMs instead.

| Upgrade scenario | AVD single-session (personal) | AVD multi-session (pooled) | Azure VM (non-AVD) | Recommendation |
|---|---|---|---|---|
| **Windows 10 feature update** (for example, 21H2 to 22H2) | Supported | Supported | Supported | Deploy new environment (recommended) |
| **Windows 10 to Windows 11** (OS version upgrade) | Not supported | Not supported | Not supported | Deploy new VMs with the target OS |
| **Windows 11 feature update** (for example, 24H2 to 25H2) | Supported | Supported | Supported | Deploy new environment (recommended) |

> [!IMPORTANT]
> **⚠ The VM SKU and configuration must meet Windows 11 hardware requirements.** Even for upgrade scenarios marked **Supported** in the preceding matrix, the underlying VM must satisfy the [Windows 11 virtual machine requirements](/windows/whats-new/windows-11-requirements#virtual-machine-support) — including **Generation 2**, **Trusted Launch with vTPM** (virtual TPM 2.0) enabled, **Secure Boot**, and a supported virtual CPU. A common cause of failed or unsupported in-place upgrades is selecting a Generation 1 VM, or a Generation 2 VM that doesn't have Trusted Launch / vTPM enabled. Verify the VM meets these requirements **before** attempting any in-place upgrade. VMs that don't meet the requirements aren't eligible for Windows 11 feature updates or OS version upgrades, regardless of the support matrix.

> [!NOTE]
> - For WSUS-distributed feature updates, ensure the correct feature updates are published to WSUS and the target VMs meet the OS hardware requirements described in the preceding callout.
> - **Windows 10 to Windows 11:** Not supported for any session host type or standard Azure VM as an in-place upgrade. Deploy new VMs with the target Windows version instead.
> - **Windows 11 feature updates (for example, 24H2 to 25H2):** Supported for single-session (personal) hosts, multi-session (pooled) hosts, and standard Azure VMs, provided the VM meets Windows 11 hardware requirements.

> [!CAUTION]
> Even for supported upgrade scenarios, Microsoft recommends **deploying a new Azure Virtual Desktop environment** rather than upgrading existing session hosts in place. Continuing to use an existing AVD environment after an in-place upgrade carries risk of failed upgrades, broken session host registration, and loss of FSLogix profile connectivity. If issues occur after an in-place upgrade on an AVD session host, the resolution may require deleting and redeploying the AVD environment.

## In-place system upgrade process for a Windows 10 VM

This process takes 45-60 minutes to complete and restarts the VM. To perform the in-place system upgrade, follow these steps:

1. Run the [Azure Virtual Machine (VM) Windows OS Upgrade Assessment Tool](windows-vm-osupgradeassessment-tool.md) to validate the OS upgrade path and check for any known issues.
1. Verify that the Windows 10 VM doesn't use [Ephemeral OS Disk](/azure/virtual-machines/ephemeral-os-disks). This feature isn't currently supported.
1. Verify that the Windows 10 VM has at least 2 GB of RAM, and 12 GB of free disk space on the system disk.
1. To prevent data loss, back up the Windows 10 VM by using [Azure Backup](/azure/backup/). You can also use a third-party backup solution from [Azure Marketplace Backup & Recovery](https://azuremarketplace.microsoft.com/marketplace/apps?search=Backup%20%26%20Recovery&page=1).
1. To check whether the backup was successful, turn off the original Windows 10 VM and verify that you can restore a new VM from the backup and that all applications are running successfully.

   > [!NOTE]  
   > You can use either the original Windows 10 VM or the restored VM as a source for an in-place system upgrade. The VMs can't run simultaneously unless you change one VM's system name and IP address to avoid conflicts.
  
1. Connect to the Windows 10 VM, and then go to **Settings** > **Updates & Security** > **Windows Update**.
1. In Windows Update, select **Check for updates**.
1. When the Feature Update item appears, select **Download and install now**.

The update downloads and installs. User settings and data are preserved, and the VM restarts automatically.

If you have general questions about this procedure, post them to [Microsoft Q&A](/answers/topics/azure-virtual-machines.html). Add the `azure-virtual-machines` tag to your questions.

## Workaround

To work around this issue, create an Azure VM that's running a supported version. Download and upgrade the VHD of the VM.

To prevent data loss, back up the Windows 10 VM by using [Azure Backup](/azure/backup/). Or, use a third-party backup solution from [Azure Marketplace Backup & Recovery](https://azuremarketplace.microsoft.com/marketplace/apps?search=Backup%20%26%20Recovery&page=1).

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
> When you perform an in-place upgrade on Azure Windows VMs, the VM properties on the Azure portal aren't updated. The changes are reflected only within the OS. This means that the source image information in the VM properties (including the publisher, offer, and plan) remains unchanged. The image that's used to deploy the VM remains the same. Only the OS is upgraded.

## Azure Virtual Desktop session host upgrade guidance

Azure Virtual Desktop session hosts have specific supportability considerations for in-place upgrades. While some scenarios are technically supported (see [support matrix](#azure-virtual-desktop-in-place-upgrade-support-matrix)), Microsoft strongly recommends image-based replacement for all AVD environments.

> [!WARNING]
> Performing an in-place upgrade on an AVD session host — even in a supported scenario — carries inherent risk. If the upgrade fails or causes issues, Microsoft support may require you to **delete and redeploy the AVD environment** as the resolution path. Customers must fully understand this risk before proceeding.

### Why in-place upgrades are risky for AVD

Attempting an in-place upgrade on AVD session hosts can cause:

- Broken session host registration with the Azure Virtual Desktop host pool.
- User connection failures.
- Loss of FSLogix profile container connectivity.
- Session host unavailability requiring manual recovery or full redeployment.

### Recommended approach: Image-based replacement

Instead of upgrading the OS on an existing session host, replace session hosts with new VMs built from an updated image:

1. **Create a new golden image** — Build a new VM image with the target Windows version, install required applications, and configure FSLogix and other Azure Virtual Desktop components.
1. **Add new session hosts** — Deploy new session hosts from the updated image into the existing host pool.
1. **Drain existing session hosts** — Set existing (old-version) session hosts to drain mode so no new user sessions connect to them.
1. **Remove old session hosts** — After users move to the new session hosts, remove the old VMs from the host pool and deallocate them.

For more information, see:

- [Create a golden image in Azure](/azure/virtual-desktop/set-up-golden-image)
- [Host pool management approaches for Azure Virtual Desktop](/azure/virtual-desktop/host-pool-management-approaches)

### WSUS feature updates for AVD session hosts

Windows Enterprise multi-session session hosts can receive feature updates through WSUS (for example, Windows 11 24H2 to 25H2), provided that:

- The correct feature updates are published to WSUS.
- The VM meets the target OS hardware requirements (for example, [Windows 11 requirements](/windows/whats-new/windows-11-requirements#virtual-machine-support)).

Although WSUS-based feature updates are technically possible, the same risk applies — if the update fails, the session host may require redeployment. Microsoft recommends image-based replacement over WSUS feature updates for production AVD environments.

### Azure Virtual Desktop personal desktop exception

For Azure Virtual Desktop **personal desktop** session hosts that use Windows 10 or Windows 11 **single-session** (not multi-session), in-place upgrade follows the same process as standard Azure VMs. See [In-place system upgrade process for a Windows 10 VM](#in-place-system-upgrade-process-for-a-windows-10-vm) earlier in this article.

> [!NOTE]
> - Personal desktops that use single-session Windows are eligible for in-place feature updates (for example, Windows 10 21H2 to 22H2, or Windows 11 24H2 to 25H2). OS version upgrades (Windows 10 to Windows 11) are not supported. See the [support matrix](#azure-virtual-desktop-in-place-upgrade-support-matrix) for details.
> - Personal desktops that use multi-session Windows aren't eligible for in-place upgrade. Verify the Windows SKU before attempting an upgrade. Run `winver` or check `SystemInfo` on the session host to confirm whether it's single-session or multi-session.
> - For Azure Virtual Desktop personal host pools, see also: [Can I do an in-place upgrade of a session host's OS?](/azure/virtual-desktop/faq#can-i-do-an-in-place-upgrade-of-a-session-host-s-operating-system)

## References

[Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672).

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
