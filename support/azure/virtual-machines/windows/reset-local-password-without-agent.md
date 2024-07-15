---
title: Reset a local Windows password without Azure agent
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
ms.date: 07/08/2024
ms.author: genli
ms.custom: sap:Cannot connect to my VM
---
# Reset local Windows password for Azure VM offline

**Applies to:** :heavy_check_mark: Windows VMs

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
 
## Alternative Method       
In certain situations, We are unable to RDP due to incorrect password and guest agent is not reporting in ready state. One effective solution to regain access involves attaching the problematic disk to a rescue VM, modifying the registry, and then booting the VM in Hyper-V to create a new user with administrative privileges.

1. Attach the Problematic Disk to a Rescue VM from azure portal.
  
2. Connect to the rescue VM via Remote Desktop Protocol (RDP).
    Open the Disk Management console and ensure the attached disk is online.

    Launch Command Prompt as Administrator:

3. **Load  SYSTEM Hive**:

   Identify the drive letter assigned to the attached disk (assume it is `G:` for this example).
   Execute the following commands.
     
    ```
    reg load HKLM\brokenSYSTEM G:\Windows\System32\config\SYSTEM
    reg add "HKLM\brokenSYSTEM\Setup" /v SetupType /t REG_DWORD /d 2 /f
    reg add "HKLM\brokenSYSTEM\Setup" /v CmdLine /t REG_SZ /d "cmd.exe" /f
    ```

    **Unload SYSTEM Hive**
    ```
    reg unload HKLM\brokenSYSTEM
    ```
    Open the Disk Management console and ensure the attached disk is offline.

    **Boot the VM in Hyper-V**

    VM should boot into a command prompt without requiring a password.

4. Create a New User and Add to Administrators Group
    In the command prompt, type `lusrmgr.msc` to open the Local Users and Groups management console.

    **Create New User**

    In the console, right-click on the "Users" folder and select "New User".
   
    **Add User to Administrators Group:**

    After creating the user, right-click on the new user account.
    Select "Properties", go to the "Member Of" tab, and add the user to the "Administrators" group.

5. After reboot of the machine, enter the new username and password to gain access.

## Next steps

If you still cannot connect using Remote Desktop, see the [RDP troubleshooting guide](troubleshoot-rdp-connection.md). The [detailed RDP troubleshooting guide](detailed-troubleshoot-rdp.md) looks at troubleshooting methods rather than specific steps. You can also [open an Azure support request](https://azure.microsoft.com/support/options/) for hands-on assistance.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
