---
title: Troubleshoot Windows VM OS boot failure
description: Explains why a Windows VM cannot boot and how to solve the problem.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.reviewer: 
---

# Troubleshoot Windows VM OS boot failure

This article explains why a Windows VM cannot boot and how to solve the problem.

## Symptoms

When you pull the screenshot of the virtual machine (VM), the screenshot shows the message that the boot partition could not be found:

`Boot failure. Reboot and Select proper Boot device or Insert Boot Media in selected Boot device`

![Boot Failure screen](./media/os-bucket-boot-failure/1-boot-failure.png)

## Causes

There are several causes for this error:

- The operating system (OS) is unable to boot due to the partition holding the Boot Configuration Data (BCD) Store is inactive.
- The OS is unable to boot due to BCD Corruption.
- The OS is unable to boot due to the boot sector not being found.

## Solution

### Process overview

1. Create and access a Repair VM.
1. Verify that the OS partition is active.
1. Fix the missing reference on the BCD store.
1. Rebuild the VM.

> [!NOTE]
> When encountering this error, the Guest OS is not operational. Troubleshoot this issue in offline mode to resolve this issue.

### Create and access a repair VM

1. Use steps 1-3 of the [VM Repair Commands](https://docs.microsoft.com/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands) to prepare a Repair VM.
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

      ![Disk 1](media/os-bucket-boot-failure/11-Gen2-1.png)

   3. List all of the partitions on the disk and then proceed to select the partition you want to check. Usually System Managed partitions are smaller and around 350 Mb in size. In the image below, this partition is Partition 1.

      ```ps
      list partition
      sel partition 1
      ```

      ![Partition 1](media/os-bucket-boot-failure/12-Gen2-2.png)

   4. Check the status of the partition. In our example, Partition 1 is not active.

      `detail partition`

      ![Detail Partition](media/os-bucket-boot-failure/13-Gen2-3.png)

      1. If the partition isn't active:

         1. Set the Active flag and then recheck that the change was done properly.

            ```ps
            active
            detail partition
            ```

            ![Active Flag](media/os-bucket-boot-failure/14-Gen2-4.png)

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

         ![Mitigation 2 - Windows Identifier 1](media/os-bucket-boot-failure/6-boot-configuration-data-windows-identifier.png)

   2. For Generation 2 VM:

      `bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /enum`

      1. If this errors out due to `\boot\bcd` not being found, then go to the following mitigation.

      2. Write down the identifier of the Windows Boot loader. This is the one with the path `\windows\system32\winload.efi`.

         ![Mitigation 2 - Windows Identifier 2](media/os-bucket-boot-failure/15-default-identifier.png)

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

Use [step 5 of the VM Repair Commands](https://docs.microsoft.com/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands#repair-process-example) to rebuild the VM.

## Next steps

If you still cannot determine the cause of the issue and need more help, you can open a support ticket with Microsoft Customer Support.

If you need more help at any point in this article, you can contact the Azure experts on the [MSDN Azure and Stack Overflow forums](https://azure.microsoft.com/support/forums/). Alternatively, you can file an Azure support incident. Go to the [Azure support site](https://azure.microsoft.com/support/options/), and select **Get support**. For information about using Azure support, read the [Microsoft Azure support FAQ](https://azure.microsoft.com/support/faq/).
