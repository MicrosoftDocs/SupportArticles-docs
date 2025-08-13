---
title: Windows 11 virtual machine doesn't start after you migrate it from VMware to Hyper-V
description: Describes how to configure a Windows 11 virtual machine after you migrate it from VMware to Hyper-V
ms.date: 08/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:virtualization and hyper-v\virtual machine state
- pcy:WinComm Storage High avail
---

# Windows 11 virtual machine doesn't start after you migrate it from VMware to Hyper-V

This article provides steps to make sure that a migrated Windows 11 virtual machine can start.

## Symptoms

After you migrate a virtual machine from VMware to Hyper-V, the virtual machine doesn't start. You don't see any specific error codes.

## Cause

Windows 11 requires a TPM for Secure Boot and security compliance. The following settings affect virtual machine startup:

- Secure Boot configuration
- Trusted Platform Module (TPM) configuration

## Solution

For best results when you migrate virtual machines, we recommend that you follow the procedures that are provided in [Convert a VMware VM to Hyper-V in the VMM fabric](/system-center/vmm/vm-convert-vmware?view=sc-vmm-2025). That article provides detailed steps for preparing to migrate and for the migration process itself.

The following procedure provides steps that are specific to virtual machines that run Windows 11 or a later version.

> [!IMPORTANT]  
>
> - Make sure that you have administrative access to both the VMware and Hyper-V environments.
> - Make sure that System Center Virtual Machine Manager (SCVMM) is installed and configured to manage and migrate the virtual machine. For more information, see  [Convert a VMware VM to Hyper-V in the VMM fabric: Start by bringing your vCenter server and the source ESXi hosts under SCVMM management](/system-center/vmm/vm-convert-vmware?view=sc-vmm-2025#start-by-bringing-your-vcenter-server-and-the-source-esxi-hosts-under-scvmm-management).
> - Verify that the edition of Windows 11 that you're using is compatible with Hyper-V requirements, including TPM support.

To configure the security settings for the migrated virtual machine, follow these steps:

1. In Hyper-V Manager, right-click the virtual machine, and then select **Settings**.
1. Select **Security**, and then on the **Security** page, make sure that the following settings are selected:

   - **Secure Boot**
   - **Trusted Platform Module (TPM)**

1. Under **Secure Boot**, make sure that **Template** is set to **Microsoft UEFI Certificate Authority**

1. Select **OK** to save the settings.
1. Restart the virtual machine.

## Additional support

If the virtual machine still doesn't start after you complete these steps, contact Microsoft Support for further assistance. As part of your support request, specify that you have a Hyper-V or SCVMM issue.
