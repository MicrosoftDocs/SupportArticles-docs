---
title: Windows 11 Virtual Machine Doesn't Start After Migration From VMware to Hyper-V
description: Describes how to configure a Windows 11 virtual machine after you migrate it from VMware to Hyper-V.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-appelgatet
ms.custom:
- sap:virtualization and hyper-v\virtual machine state
- pcy:WinComm Storage High avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Windows 11 VM doesn't start after migration from VMware to Hyper-V

This article provides steps to make sure that a migrated Windows 11 virtual machine (VM) can start after you migrate it from VMware to Hyper-V.

## Symptoms

After you migrate a VM from VMware to Hyper-V, the VM doesn't start. When this issue occurs, you don't see any specific error codes.

## Cause

Windows 11 requires a TPM for Secure Boot and security compliance. The following settings affect VM startup:

- Secure Boot configuration
- Trusted Platform Module (TPM) configuration

## Solution

For best results when you migrate a VM, we recommend that you follow the procedures that are provided in [Convert a VMware VM to Hyper-V in the VMM fabric](/system-center/vmm/vm-convert-vmware). That article provides detailed steps for how to prepare to migrate a VM and the migration process itself.

The following procedure provides steps that are specific to VMs that run Windows 11 or a later version.

> [!IMPORTANT]  
>
> - Make sure that you have administrative access to both the VMware and Hyper-V environments.
> - Make sure that System Center Virtual Machine Manager (SCVMM) is installed and configured to manage and migrate the VM. For more information, see the "Start by bringing your vCenter server and the source ESXi hosts under SCVMM management" section of [Convert a VMware VM to Hyper-V in the VMM fabric](/system-center/vmm/vm-convert-vmware#start-by-bringing-your-vcenter-server-and-the-source-esxi-hosts-under-scvmm-management).
> - Verify that the edition of Windows 11 that you're using is compatible with Hyper-V requirements, including TPM support.

To configure the security settings for the migrated VM, follow these steps:

1. In Hyper-V Manager, right-click the VM, and then select **Settings**.
1. Select **Security**. On the **Security** page, make sure that the following settings are selected:

   - **Secure Boot**
   - **Trusted Platform Module (TPM)**

1. Under **Secure Boot**, make sure that **Template** is set to **Microsoft UEFI Certificate Authority**.

1. Select **OK** to save the settings.
1. Restart the VM.

## Additional support

If the VM still doesn't start after you complete these steps, contact Microsoft Support for further assistance. As part of your support request, specify that you have a Hyper-V or SCVMM issue.
