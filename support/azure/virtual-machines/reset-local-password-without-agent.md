---
title: Reset a local Windows password without Azure agent | Microsoft Docs
description: How to reset the password of a local Windows user account when the Azure guest agent is not installed or functioning on a VM
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
ms.service: virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure-services
ms.date: 04/25/2019
ms.author: genli

---
# Reset local Windows password for Azure VM offline

You can reset the local Windows password of a VM in Azure using the [Azure portal or Azure PowerShell](reset-rdp.md) provided the Azure guest agent is installed. This method is the primary way to reset a password for an Azure VM. If you encounter issues with the Azure guest agent not responding, or failing to install after uploading a custom image, you can manually reset a Windows password. This article details how to reset a local account password by attaching the source OS virtual disk to another VM. The steps described in this article do not apply to Windows domain controllers.

> [!WARNING]
> Only use this process as a last resort. Always try to reset a password using the [Azure portal or Azure PowerShell](reset-rdp.md) first.

## Overview of the process

The core steps for performing a local password reset for a Windows VM in Azure when there is no access to the Azure guest agent is as follows:

1. Stop the affected VM.
1. Create a snapshot for the OS disk of the VM.
1. Create a copy of the OS disk from the snapshot.
1. Attach and mount the copied OS disk to another Windows VM, then create some config files on the disk. The files will help you to reset the password.
1. Unmount and detach the copied OS disk from the troubleshooting VM.
1. Swap the OS disk for the affected VM.

## Detailed steps for the VM with Resource Manager deployment

> [!NOTE]
> The steps do not apply to Windows domain controllers. It only works on standalone server or a server that is a member of a domain.

Always try to reset a password using the [Azure portal or Azure PowerShell](reset-rdp.md) before trying the following steps. Make sure you have a backup of your VM before you start.

1. Take a snapshot for the OS disk of the affected VM,  create a disk from the snapshot, and then attach the disk to a troubleshoot VM. For more information, see [Troubleshoot a Windows VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-windows.md).
2. Connect to the troubleshooting VM using Remote Desktop.
3. Create `gpt.ini` in `\Windows\System32\GroupPolicy` on the source VM's drive (if gpt.ini exists, rename to gpt.ini.bak):

   > [!WARNING]
   > Make sure that you do not accidentally create the following files in C:\Windows, the OS drive for the troubleshooting VM. Create the following files in the OS drive for your source VM that is attached as a data disk.

   Add the following lines into the `gpt.ini` file you created:

     ```ini
     [General]
     gPCFunctionalityVersion=2
     gPCMachineExtensionNames=[{42B5FAAE-6536-11D2-AE5A-0000F87571E3}{40B6664F-4972-11D1-A7CA-0000F87571E3}]
     Version=1
     ```

     :::image type="content" source="media/reset-local-password-without-agent/create-gpt-ini.png" alt-text="Screenshot shows the updates made to the gpt.ini file.":::

4. Create `scripts.ini` in `\Windows\System32\GroupPolicy\Machine\Scripts\`. Make sure hidden folders and file name extensions are shown. If needed, create the `Machine` or `Scripts` folders.

   Add the following lines the `scripts.ini` file you created:

     ```ini
     [Startup]
     0CmdLine=FixAzureVM.cmd
     0Parameters=
     ```

     :::image type="content" source="media/reset-local-password-without-agent/create-scripts-ini.png" alt-text="Screenshot shows the updates made to the script.ini file.":::

5. Create `FixAzureVM.cmd` in `\Windows\System32\GroupPolicy\Machine\Scripts\Startup\` with the following contents, replacing `<username>` and `<newpassword>` with your own values:

    ```ini
    net user <username> <newpassword> /add /Y
    net localgroup administrators <username> /add
    net localgroup "remote desktop users" <username> /add
    ```

    :::image type="content" source="media/reset-local-password-without-agent/create-fixazure-cmd.png" alt-text="Screenshot shows the newly created FixAzureVM.cmd file where you update the username and password.":::

    You must meet the configured password complexity requirements for your VM when defining the new password.

6. In Azure portal, detach the disk from the troubleshooting VM.

7. [Change the OS disk for the affected VM](troubleshoot-recovery-disks-portal-windows.md#swap-the-failed-vms-os-disk-with-the-repaired-disk).

8. After the new VM is running, connect to the VM using Remote Desktop with the new password you specified in the `FixAzureVM.cmd` script.

9. From your remote session to the new VM, remove the following files to clean up the environment:

    * From %windir%\System32\GroupPolicy\Machine\Scripts\Startup
      * remove FixAzureVM.cmd
    * From %windir%\System32\GroupPolicy\Machine\Scripts
      * remove scripts.ini
    * From %windir%\System32\GroupPolicy
      * remove gpt.ini (if gpt.ini existed before, and you renamed it to gpt.ini.bak, rename the .bak file back to gpt.ini)

## Detailed steps for Classic VM

[!INCLUDE [classic-vm-deprecation](../../includes/classic-vm-deprecation.md)]

> [!NOTE]
> The steps do not apply to Windows domain controllers. It only works on standalone server or a server that is a member of a domain.

Always try to reset a password using the [Azure portal or Azure PowerShell](/previous-versions/azure/virtual-machines/windows/classic/reset-rdp) before trying the following steps. Make sure you have a backup of your VM before you start.

1. Delete the affected VM in Azure portal. Deleting the VM only deletes the metadata, the reference of the VM within Azure. The virtual disks are retained when the VM is deleted:

   * Select the VM in the Azure portal, then click *Delete*:

     :::image type="content" source="media/reset-local-password-without-agent/delete-vm.png" alt-text="Screenshot shows the Delete button in an existing Classic VM page.":::

2. Attach the source VM's OS disk to the troubleshooting VM. The troubleshooting VM must be in the same region as the source VM's OS disk (such as `West US`):

   1. Select the troubleshooting VM in the Azure portal. Click *Disks* | *Attach existing*:

      :::image type="content" source="media/reset-local-password-without-agent/attach-existing.png" alt-text="Screenshot shows the Attach existing button of the troubleshooting VM.":::

   2. Select *VHD File* and then select the storage account that contains your source VM:

      :::image type="content" source="media/reset-local-password-without-agent/select-storage-account.png" alt-text="Screenshot shows the location to select storage account.":::

   3. Check the box marked *Show classic storage accounts*, then select the source container. The source container is typically *vhds*:

      :::image type="content" source="media/reset-local-password-without-agent/show-classic-storage-accounts.png" alt-text="Screenshot shows the Show classic storage accounts option is cleared.":::

      :::image type="content" source="media/reset-local-password-without-agent/select-container-vhds.png" alt-text="Screenshot shows the vhds is selected as storage container.":::

   4. Select the OS vhd to attach. Click *Select* to complete the process:

      :::image type="content" source="media/reset-local-password-without-agent/select-source-vhd.png" alt-text="Screenshot shows the selected source virtual disk.":::

   5. Click Ok to attach the disk

      :::image type="content" source="./media/reset-local-password-without-agent/attach-okay.png" alt-text="Screenshot shows the Attach existing disk page, at the bottom of which, there's an OK button.":::

3. Connect to the troubleshooting VM using Remote Desktop and ensure the source VM's OS disk is visible:

   1. Select the troubleshooting VM in the Azure portal and click *Connect*.

   2. Open the RDP file that downloads. Enter the username and password of the troubleshooting VM.

   3. In File Explorer, look for the data disk you attached. If the source VM's VHD is the only data disk attached to the troubleshooting VM, it should be the F: drive:

      :::image type="content" source="media/reset-local-password-without-agent/file-explorer-data-disk.png" alt-text="Screenshot shows the F local disk in File Explorer." border="false":::

4. Create `gpt.ini` in `\Windows\System32\GroupPolicy` on the source VM's drive (if `gpt.ini` exists, rename to `gpt.ini.bak`):

   > [!WARNING]
   > Make sure that you do not accidentally create the following files in `C:\Windows`, the OS drive for the troubleshooting VM. Create the following files in the OS drive for your source VM that is attached as a data disk.

   Add the following lines into the `gpt.ini` file you created:

     ```ini
     [General]
     gPCFunctionalityVersion=2
     gPCMachineExtensionNames=[{42B5FAAE-6536-11D2-AE5A-0000F87571E3}{40B6664F-4972-11D1-A7CA-0000F87571E3}]
     Version=1
     ```

     :::image type="content" source="media/reset-local-password-without-agent/create-gpt-ini-classic.png" alt-text="Screenshot shows the updates made to the gpt.ini file for Classic VM.":::

5. Create `scripts.ini` in `\Windows\System32\GroupPolicy\Machine\Scripts\`. Make sure hidden folders and file name extensions are shown. If needed, create the `Machine` or `Scripts` folders.

   Add the following lines the `scripts.ini` file you created:

     ```ini
     [Startup]
     0CmdLine=FixAzureVM.cmd
     0Parameters=
     ```

     :::image type="content" source="media/reset-local-password-without-agent/create-scripts-ini.png" alt-text="Screenshot shows the updates made to the scripts.ini file for Classic VM.":::

6. Create `FixAzureVM.cmd` in `\Windows\System32\GroupPolicy\Machine\Scripts\Startup\` with the following contents, replacing `<username>` and `<newpassword>` with your own values:

    ```ini
    net user <username> <newpassword> /add /Y
    net localgroup administrators <username> /add
    net localgroup "remote desktop users" <username> /add
    ```

    :::image type="content" source="media/reset-local-password-without-agent/create-fixazure-cmd.png" alt-text="Screenshot shows the newly created FixAzureVM.cmd file where you update the username and password for Classic VM.":::

    You must meet the configured password complexity requirements for your VM when defining the new password.

7. In Azure portal, detach the disk from the troubleshooting VM:

   1. Select the troubleshooting VM in the Azure portal, click *Disks*.

   2. Select the data disk attached in step 2, click **Detach**, then click **OK**.

     :::image type="content" source="media/reset-local-password-without-agent/data-disks.png" alt-text="Screenshot shows the detached disk in step 2.":::

     :::image type="content" source="media/reset-local-password-without-agent/detach-disk.png" alt-text="Screenshot shows the Detach button.":::

8. Create a VM from the source VM's OS disk:

     :::image type="content" source="media/reset-local-password-without-agent/create-new-vm-from-template.png" alt-text="Screenshot shows the Disk (classic) item.":::

     :::image type="content" source="media/reset-local-password-without-agent/choose-subscription.png" alt-text="Screenshot shows the subscriptions.":::

     :::image type="content" source="media/reset-local-password-without-agent/create-vm.png" alt-text="Screenshot highlights the Create VM button.":::

## Complete the Create virtual machine experience

1. After the new VM is running, connect to the VM using Remote Desktop with the new password you specified in the `FixAzureVM.cmd` script.

2. From your remote session to the new VM, remove the following files to clean up the environment:

    * From `%windir%\System32\GroupPolicy\Machine\Scripts\Startup\`
      * remove `FixAzureVM.cmd`
    * From `%windir%\System32\GroupPolicy\Machine\Scripts`
      * remove `scripts.ini`
    * From `%windir%\System32\GroupPolicy`
      * remove `gpt.ini` (if `gpt.ini` existed before, and you renamed it to `gpt.ini.bak`, rename the `.bak` file back to `gpt.ini`)

## Next steps

If you still cannot connect using Remote Desktop, see the [RDP troubleshooting guide](troubleshoot-rdp-connection.md). The [detailed RDP troubleshooting guide](detailed-troubleshoot-rdp.md) looks at troubleshooting methods rather than specific steps. You can also [open an Azure support request](https://azure.microsoft.com/support/options/) for hands-on assistance.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
