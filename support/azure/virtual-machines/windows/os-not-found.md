---
title: Windows can't boot with (An operating system wasn't found) error 
description: Provides a solution to an issue where Windows VM doesn't start with (An operating system wasn't found) error.
ms.date: 07/12/2024
ms.reviewer: 
ms.service: virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---
# Windows boot error in an Azure VM: An operating system wasn't found

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010142

This article provides a solution to an issue where Windows VM doesn't start with error "An operating system wasn't found".

## Symptoms

Windows doesn't start, and it returns the following error message:

> An operating system wasn't found. Try disconnecting any drivers that don't contain an operating system. Press Ctrl+Alt+Del to restart

## Cause

This issue occurs for one of the following reasons:

- The startup process can't locate an active system partition.
- The disk is corrupted.
- The disk isn't presented to the Hyper-V host.
- The host can't access the storage in which the disk is hosted.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix this issue, stop (de-allocate) and restart the VM. Then, check whether the issue persists. If the issue persists, follow these steps.

### Step 1: Verify whether the Windows partition is marked as active

[!INCLUDE [Verify that Windows partition is active](../../../includes/azure/windows-vm-verify-set-active-partition.md)]

### Step 2: Repair the Boot Configuration data

1. Run the following command line as an administrator to verify the file system integrity and fix logical file system errors.

    ```console
    chkdsk <Windows partition>: /f
    ```

2. Run the following command line as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code that resembles "xxxxxxxx-xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx." You will use this identifier in the next step.

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /enum /v
    ```

3. Repair the Boot Configuration data by running the following commands. Replace the placeholders by using the actual values.

    > [!NOTE]
    > This step is applied to most corruption issues that affect startup configuration data. You must perform this step even if the **Device** and **OSDevice** values are pointing to the correct partition.

    - \<Windows partition> is the partition that contains a folder that is named "Windows."
    - \<Boot partition> is the partition that contains a hidden system folder that is named "Boot."
    - \<Identifier> is the identifier of Windows Boot Loader that you found in the previous step.

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} device partition=<boot partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} integrityservices enable

    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} device partition=<Windows partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} integrityservices enable

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} recoveryenabled Off

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} osdevice partition=<Windows partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} bootstatuspolicy IgnoreAllFailures
    ```

4. Detach the repaired OS disk from the troubleshooting VM. Then, create a VM from the OS disk.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
