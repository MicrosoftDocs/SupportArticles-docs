---
title: Troubleshoot Windows VM OS boot failure
description: Explains why a Windows VM cannot boot and how to solve the problem.
ms.date: 12/07/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---

# Troubleshoot Windows VM OS boot failure

This article explains why a Windows VM cannot boot and how to solve the problem.

## Symptoms

When you pull the screenshot of the virtual machine (VM), the screenshot shows the message that the boot partition could not be found:

`Boot failure. Reboot and Select proper Boot device or Insert Boot Media in selected Boot device`

:::image type="content" source="media/os-bucket-boot-failure/boot-failure.png" alt-text="Screenshot of the Boot Failure message.":::

## Causes

There are several causes for this error:

- The operating system (OS) is unable to boot due to the partition holding the Boot Configuration Data (BCD) Store is inactive.
- The OS is unable to boot due to BCD Corruption.
- The OS is unable to boot due to the boot sector not being found.

## Solution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

### Process overview

1. Create and access a Repair VM.
1. Verify that the OS partition is active.
1. Fix the missing reference on the BCD store.
1. Rebuild the VM.

> [!NOTE]
> When encountering this error, the Guest OS is not operational. Troubleshoot this issue in offline mode to resolve this issue.

### Create and access a repair VM

1. Use steps 1-3 of the [VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands) to prepare a Repair VM.
1. Using Remote Desktop Connection, connect to the Repair VM.

### Verify that the OS partition is active

> [!NOTE]
> This mitigation applies only for Generation 1 VMs. Generation 2 VMs (using UEFI) does not use an active partition.

Verify the OS partition that holds the BCD store for the disk is marked as active.

   1. Open an elevated command prompt and open the DISKPART tool.

      `diskpart`

   2. List the disks on the system and look for added disks and proceed to select the new disk. In this example, the new disk is Disk 1.

      ```ps
      list disk
      sel disk 1
      ```

      :::image type="content" source="media/os-bucket-boot-failure/list-disk.png" alt-text="The diskpart window shows outputs of list disk and sel disk 1 commands. Disk 0 and Disk 1 are displayed in the table. Disk 1 is the selected disk.":::

   3. List all of the partitions on the disk and then proceed to select the partition you want to check. Usually System Managed partitions are smaller and around 350 Mb in size. In the image below, this partition is Partition 1.

      ```ps
      list partition
      sel partition 1
      ```

      :::image type="content" source="media/os-bucket-boot-failure/list-partition.png" alt-text="The diskpart window shows outputs of list partition and sel partition 1 commands. Partition 1 is the selected disk.":::

   4. Check the status of the partition. In our example, Partition 1 is not active.

      `detail partition`

      :::image type="content" source="media/os-bucket-boot-failure/detail-partition-not-active.png" alt-text="The diskpart window with output of the detail partition command where Partition 1 is not active.":::

      If the partition isn't active, set the Active flag and then recheck that the change was done properly.

      ```ps
      active
      detail partition
      ```

      :::image type="content" source="media/os-bucket-boot-failure/detail-partition-active.png" alt-text="The diskpart window with output of the detail partition command where Partition 1 is active.":::

   5. Now exit the DISKPART tool.

      `exit`

### Fix the missing reference in the BCD store

1. Open up an elevated CMD and run CHKDSK on the disk.

   `chkdsk <DRIVE LETTER>: /f`

2. Gather the current boot setup info and document it, take note of the identifier on the active partition.

   1. For Generation 1 VM:

      `bcdedit /store <drive letter>:\boot\bcd /enum`

      1. If this command errors out due to `\boot\bcd` not being found, then go to the following mitigation.

      2. Write down the identifier of the Windows Boot loader. This identifier is the one with the path `\windows\system32\winload.efi`.

         :::image type="content" source="media/os-bucket-boot-failure/windows-identifier-generation-1.png" alt-text="Screenshot shows the output of Generation 1 VM, which lists the identifier number under Windows Boot Loader.":::

   2. For Generation 2 VM:

      `bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /enum`

      1. If this errors out due to `\boot\bcd` not being found, then go to the following mitigation.

      2. Write down the identifier of the Windows Boot loader. This is the one with the path `\windows\system32\winload.efi`.

         :::image type="content" source="media/os-bucket-boot-failure/windows-identifier-generation-2.png" alt-text="Screenshot shows the output of Generation 2 VM, which lists the identifier number under Windows Boot Loader.":::

3. Run the following commands:

   1. For **Generation 1** VM:

      ```ps
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {bootmgr} device partition=<BCD FOLDER - DRIVE LETTER>:
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {bootmgr} integrityservices enable
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} device partition=<WINDOWS FOLDER - DRIVE LETTER>:
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} integrityservices enable
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} recoveryenabled Off
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} osdevice partition=<WINDOWS FOLDER - DRIVE LETTER>:
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} bootstatuspolicy IgnoreAllFailures
      ```

      >[!NOTE]
      >In case the VHD has a single partition and both the BCD Folder and Windows Folder are in the same volume, and if the above setup didn't work, then try replacing the partition values with ***boot***.

      ```ps
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {bootmgr} device boot
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {bootmgr} integrityservices enable
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} device boot
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} integrityservices enable
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} recoveryenabled Off
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} osdevice boot
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} bootstatuspolicy IgnoreAllFailures
      ```

   2. For **Generation 2** VM:

      ```ps
      bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {bootmgr} device partition=<Volume Letter of EFI System Partition>:
      bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {bootmgr} integrityservices enable
      bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} device partition=<WINDOWS FOLDER - DRIVE LETTER>:
      bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} integrityservices enable
      bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} recoveryenabled Off
      bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} osdevice partition=<WINDOWS FOLDER - DRIVE LETTER>:
      bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} bootstatuspolicy IgnoreAllFailures
      ```

### Rebuild the VM

Use [step 5 of the VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands#repair-process-example) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
