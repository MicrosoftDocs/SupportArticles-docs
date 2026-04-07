---
title: Repair a Linux VM automatically with ALAR
description: Learn how to use Azure Linux Auto Repair (ALAR) scripts to automatically fix a nonbootable Linux VM in Azure and restore access quickly.
services: virtual-machines-linux
documentationcenter: ''
author: pagienge
editor: v-jsitser
tags: virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.devlang: azurecli
ms.date: 02/11/2026
ms.author: pagienge
---

# Use Azure Linux Auto Repair (ALAR) to fix a Linux VM

**Applies to:** :heavy_check_mark: Linux VMs

## Summary

The next time you need to repair your Azure Linux virtual machine (VM), automate the job by using the Azure Linux Auto Repair (ALAR) scripts. You no longer need to run the job manually. These scripts simplify the recovery process and enable even inexperienced users to recover their Linux VM easily.

ALAR uses the VM repair extension that's described in [Repair a Linux VM by using the Azure Virtual Machine repair commands](repair-linux-vm-using-azure-virtual-machine-repair-commands.md).

ALAR covers the following repair scenarios:

- No-boot scenarios
  - Malformed `/etc/fstab`
      - syntax error
      - missing disk
  - Damaged initrd or missing initrd line in the `/boot/grub/grub.cfg`
  - Last installed kernel isn't bootable
  - GRUB/EFI installation or configuration damaged
  - Disk space/auditd forced shutdowns
  - Light disk corruption on OS volumes
- Configuration issues
  - Serial console and GRUB serial are incorrectly configured or are missing
  - Sudo misconfiguration

## How to use ALAR

The ALAR scripts use the [az vm repair](/cli/azure/vm/repair) extension, `run` command, and its `--run-id` option. The value of the `--run-id` option for the automated recovery is `linux-alar2`. To fix a Linux VM by using an ALAR script, follow these steps:

> [!NOTE]
> The VM Contributor role doesn't provide enough permissions to run these scripted operations, as they require permissions to read, write, and delete resources in the resource group that includes the target VM. Therefore, you need roles such as Contributor or Owner at the resource group level.

1. Create a rescue VM:

    ```azurecli-interactive
    az vm repair create --verbose --resource-group <RG-NAME> --name <VM-NAME>
    ```

    - The process currently requires three parameters. If you don't provide these parameters on the command line, the process prompts you to enter values for them. Add these parameters and values to the command for a non-interactive execution 
      - `--repair-username <RESCUE-USERNAME>`
      - `--repair-password <RESCUE-PASS>`
      - `--associate-public-ip`
    - See the [az vm repair](/cli/azure/vm/repair) documentation for more options that you can use to control the creation of the repair VM.
 
1. Run the `linux-alar2` script, along with parameters for one or more of the ALAR actions on the rescue VM:

    ```azurecli-interactive
    az vm repair run --verbose --resource-group <RG-NAME> --name <VM-NAME> --run-id linux-alar2 --parameters <action> --run-on-repair
    ```
    
    The valid action names are listed in this document.

1. Swap the copy of the OS disk back to the original VM and delete the temporary resources:

    ```azurecli-interactive
    az vm repair restore --verbose --resource-group <RG-NAME> --name <VM-NAME> 
    ```
    
    > [!NOTE]
    > The original and new disks aren't deleted during the `restore` phase.

In all of the example commands, replace the following parameters with your values:

- `<RG-NAME>`: The name of the resource group containing the broken VM.
- `<VM-NAME>`: The name of the broken VM.
- `<RESCUE-USERNAME>`: The user created on the repair VM for authentication. It's the equivalent of the user created on a new VM in the Azure portal.
- `<RESCUE-PASS>`: The password for `RESCUE-USERNAME`, enclosed in single quotes. For example: `'password!234'`.
- `<action>`: One or more of the defined actions available to apply to the broken VM. See the following list for all available actions, as well as the [ALAR GitHub ReadMe](https://github.com/Azure/ALAR). You can pass one or more actions that run consecutively. For multiple operations, delineate them using commas without spaces, like `fstab,sudo`.

## The ALAR actions

### `fstab`

This action removes any lines in the `etc/fstab` file that aren't needed to boot a system. It first makes a copy of the original file for reference. When the OS starts, the administrator can edit the fstab to correct any errors that prevented a reboot of the system.

For more information about problems with a malformed `/etc/fstab` file, see [Troubleshoot Linux VM starting issues because `fstab` errors](linux-virtual-machine-cannot-start-fstab-errors.md).

### `efifix`

Use this action to reinstall the required software to boot from a GEN2 VM. It also regenerates the `grub.cfg` file.

### `grubfix`

Use this action to reinstall GRUB and regenerate the `grub.cfg` file.

### `initrd`

Use this action to fix an initrd or initramfs that's corrupted or incorrectly created.

To create the initrd or initramfs correctly, add the `hv_vmbus`, `hv_netvsc`, and `hv_storvsc` modules to the image.

Initrd-related startup problems can appear as the following logged symptoms.

![Not syncing VFS](media/repair-linux-vm-using-alar/not-syncing-VFS.png)

![No working init found](media/repair-linux-vm-using-alar/no-working-init-found.png)

In both cases, the following information is logged before the error entries.

![Unpacking failed](media/repair-linux-vm-using-alar/unpacking-failed.png)

### `kernel`

This action changes the default kernel by replacing the default or broken kernel with a previously installed version.

For more information about messages that the serial console might log for kernel-related startup events, see [How to recover an Azure Linux virtual machine from kernel-related boot issues](kernel-related-boot-issues.md).

### `serialconsole`

This action corrects an incorrect or malformed serial console configuration for the Linux kernel or GRUB. Run this action in the following cases:

- No GRUB menu is displayed at VM startup.
- No operating system related information is written to the serial console.

### `sudo`

The `sudo` action resets the permissions on the `/etc/sudoers` file and all files in `/etc/sudoers.d` to the required 0440 modes. It also checks other best practices. A basic check runs to detect and report on duplicate user entries. The action moves only the `/etc/sudoers.d/waagent` file if it conflicts with other files.

### `corrupt`

This action attempts basic, nondestructive fixes to filesystem corruption in the volumes residing on the OS disk. When the run is successful, the output is a listing of filesystem data for verification. Remember the potential for data loss caused by filesystem corruption. If this action is needed, perform more intensive data validation once access to the virtual machine is restored.

### `auditd`

If your VM shuts down immediately upon startup due to the audit daemon configuration, use this action. The `auditd` action modifies the audit daemon configuration (in the `/etc/audit/auditd.conf` file) by changing the `HALT` value configured for any `action` parameters to `SYSLOG`, which doesn't force the system to shut down. In a Logical Volume Manager (LVM) environment, if the logical volume that contains the audit logs is full and there's available space in the volume group, the logical volume is extended by 10% of the current filesystem size. However, if you're not using an LVM environment or there's no available space, only the `auditd` configuration file is altered.

> [!IMPORTANT]
> This action changes the VM's security posture by altering the audit daemon configuration so that the VM shutdown issue can be resolved. Once the VM is running and accessible, evaluate the configuration and potentially revert it to the original state. For this purpose, ALAR creates a backup of the `auditd.conf` file in `/etc/audit` with the execution timestamp.


## Limitation

Classic VMs aren't supported.

## Next steps

If you experience a bug or want to request an enhancement to the ALAR tool, post a comment on [GitHub](https://github.com/Azure/ALAR/issues).

You can also find the latest information about the ALAR tool on [GitHub](https://github.com/Azure/ALAR).

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
