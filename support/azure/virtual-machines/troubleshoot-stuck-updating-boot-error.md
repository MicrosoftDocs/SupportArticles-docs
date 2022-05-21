---
title: Azure VM startup is stuck at Windows Update| Microsoft Docs
description: Learn how to troubleshoot the issue when an Azure VM startup is stuck at Windows update.
services: virtual-machines
documentationCenter: ''
author: genlin
manager: dcscontentpm
editor: v-jesits
ms.service: virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 10/09/2018
ms.author: genli
---

# Azure VM startup is stuck at Windows update

This article helps resolve the issue when your Virtual Machine (VM) is stuck at the Windows Update stage during startup.

## Symptom

 A Windows VM doesn't start. When you check the screenshots in the [Boot diagnostics](/azure/virtual-machines/troubleshooting/boot-diagnostics) window, you see that the startup is stuck in the update process. The following are examples of messages that you may receive:

- Installing Windows ##% Don't turn off your PC. This will take a while Your PC will restart several times
- Keep your PC on until this is done. Installing update # of #...
- We couldn't complete the updates Undoing changes Don't turn off your computer
- Failure configuring Windows updates Reverting changes Do not turn off your computer
- Error < error code > applying update operations ##### of ##### (\Regist...)
- Fatal Error < error code >  applying update operations ##### of ##### ($$...)

## Solution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

Depending on the number of updates that are getting installed or rolled backing, the update process can take a while. Leave the VM in this state for 8 hours. If the VM is still in this state after that period, restart the VM from the Azure portal, and see if it can start normally. If this step doesn't work, try the following solution.

### Remove the update that causes the problem

1. Take a snapshot of the OS disk of the affected VM as a backup. For more information, see [Snapshot a disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk).
2. [Attach the OS disk to a recovery VM](troubleshoot-recovery-disks-portal-windows.md).
3. Once the OS disk is attached on the recovery VM, run **diskmgmt.msc** to open Disk Management, and ensure the attached disk is **ONLINE**. Take note of the drive letter that is assigned to the attached OS disk holding the \windows folder. If the disk is encrypted, decrypt the disk before proceeding with next steps in this document.

4. Open an elevated command prompt instance (Run as administrator). Run the following command to get the list of the update packages that are on the attached OS disk:

    ```console
    dism /image:<Attached OS disk>:\ /get-packages > c:\temp\Patch_level.txt
    ```

    For example, if the attached OS disk is drive F, run the following command:

    ```console
    dism /image:F:\ /get-packages > c:\temp\Patch_level.txt
    ```

5. Open the C:\temp\Patch_level.txt file, and then read it from the bottom up. Locate the update that's in **Install Pending** or **Uninstall Pending** state.  The following is a sample of the update status:

    ```
    Package Identity : Package_for_RollupFix~31bf3856ad364e35~amd64~~17134.345.1.5
    State : Install Pending
    Release Type : Security Update
    Install Time :
    ```

6. Remove the update that caused the problem:

    ```
    dism /Image:<Attached OS disk>:\ /Remove-Package /PackageName:<PACKAGE NAME TO DELETE>
    ```

    Example:

    ```
    dism /Image:F:\ /Remove-Package /PackageName:Package_for_RollupFix~31bf3856ad364e35~amd64~~17134.345.1.5
    ```

    > [!NOTE]
    > Depending on the size of the package, the DISM tool will take a while to process the un-installation. Normally the process will be completed within 16 minutes.

7. [Detach the OS disk and recreate the VM](troubleshoot-recovery-disks-portal-windows.md#swap-the-failed-vms-os-disk-with-the-repaired-disk). Then check whether the issue is resolved.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
