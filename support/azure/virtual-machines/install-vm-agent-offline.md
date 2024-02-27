---
title: Install the Azure VM Agent in offline mode
description: Learn how to install the Azure VM Agent in offline mode.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-windows
ms.topic: article
ms.date: 01/30/2024
ms.author: genli

---
# Install the Azure Virtual Machine Agent in offline mode

The Azure Virtual Machine Agent (VM Agent) provides useful features, such as local administrator password reset and script pushing. This article shows you how to install the VM Agent for an offline Windows virtual machine (VM).

## When to use the VM Agent in offline mode

Install the VM Agent in offline mode if the VM Agent isn't installed and you can't RDP to the VM.

If you can RDP to the VM, you only have to [download and install the VM Agent manually](/azure/virtual-machines/extensions/agent-windows#manual-installation).

## How to install the VM Agent in offline mode

Use the following steps to install the VM Agent in offline mode.

### Step 1: Attach the OS disk of the VM to another VM as a data disk

1. Take a snapshot for the OS disk of the affected VM, create a disk from the snapshot, and then attach the disk to a troubleshoot VM. For more information, see [Troubleshoot a Windows VM by attaching the OS disk to a recovery VM using the Azure portal](troubleshoot-recovery-disks-portal-windows.md). For the classic VM, delete the VM and keep the OS disk, and then attach the OS disk to the troubleshoot VM.

2. Connect to the troubleshooter VM. Open **Computer management** > **Disk management**. Verify that the OS disk is online and that drive letters are assigned to the disk partitions.

### Step 2: Modify the OS disk to install the Azure VM Agent

1. Make a remote desktop connection to the troubleshooter VM.

2. In the troubleshooter VM, browse to the OS disk that you attached, and then open the *\windows\system32\config* folder. Copy all of the files in this folder as a backup, in case a rollback is required.

3. Start the **Registry Editor** (*regedit.exe*).

4. Select the **HKEY_LOCAL_MACHINE** key. On the menu, select **File** > **Load Hive**:

    :::image type="content" source="media/install-vm-agent-offline/load-hive.png" alt-text="Screenshot of the HKEY_LOCAL_MACHINE key and the Load Hive option in the File menu in Registry Editor." border="false":::

5. Browse to the *\windows\system32\config\SYSTEM* folder on the OS disk that you attached. For the name of the hive, enter **BROKENSYSTEM**. The new registry hive is displayed under the **HKEY_LOCAL_MACHINE** key.

6. If the attached OS disk has the VM agent installed, perform a backup of the current configuration. If it doesn't have VM agent installed, move to the next step.

    1. Rename the *\windowsazure* folder to *\windowsazure.old*.

    2. Export the following registries:
        - **HKEY_LOCAL_MACHINE\BROKENSYSTEM\ControlSet001\Services\WindowsAzureGuestAgent**
        - **HKEY_LOCAL_MACHINE\BROKENSYSTEM\ControlSet001\Services\RdAgent**

7. Use the existing files on the troubleshooter VM as a repository for the VM Agent installation. Complete the following steps:

    1. From the troubleshooter VM, export the following subkeys in registry format (*.reg*):
        - **HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WindowsAzureGuestAgent**
        - **HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\RdAgent**

          :::image type="content" source="media/install-vm-agent-offline/backup-reg.png" alt-text="Screenshot of the rdagent and winazureguestagent reg files in Windows Explorer." border="false":::

    2. Edit the registry files. In each file, change the entry value **SYSTEM** to **BROKENSYSTEM** (as shown in the following images) and save the file. Remember the **ImagePath** of the current VM agent. We will need to copy the corresponding folder to the attached OS disk.

        :::image type="content" source="media/install-vm-agent-offline/change-reg.png" alt-text="Screenshot of the original entry value and the changed entry value of the rdagent reg file." border="false":::

    3. Import the registry files into the repository by double-clicking each registry file.

    4. Verify that the following subkeys are successfully imported into the **BROKENSYSTEM** hive:
        - **WindowsAzureGuestAgent**
        - **RdAgent**

    5. Copy the installation folder of the current VM Agent to the attached OS disk:

        1. On the OS disk that you attached, create a folder that's named *WindowsAzure* in the root path.

        2. Go to *C:\WindowsAzure* on the troubleshooter VM, and look for any folder that is named *C:\WindowsAzure\GuestAgent_X.X.XXXX.XXX*. Copy the *GuestAgent* folder that has latest version number from *C:\WindowsAzure* to the *WindowsAzure* folder in the attached OS disk. If you aren't sure which folder should be copied, copy all *GuestAgent* folders. The following image shows an example of the *GuestAgent* folder that is copied to the attached OS disk. If you can't find the *GuestAgent* folder, check for the imagePath of **WindowsAzureGuestAgent** registry subkey for the accurate path.

             :::image type="content" source="media/install-vm-agent-offline/copy-files.png" alt-text="Screenshot of an example GuestAgent folder in the attached OS disk." border="false":::

8. Select **BROKENSYSTEM**. From the menu, select **File** > **Unload Hive**​.

9. Detach the OS disk, and then [change the OS disk for the affected VM](troubleshoot-recovery-disks-portal-windows.md#swap-the-failed-vms-os-disk-with-the-repaired-disk). For the classic VM, create a new VM by using the repaired OS disk.

10. Access the VM. Notice that the RdAgent is running and the logs are being generated.

If you created the VM by using the Resource Manager deployment model, you're done.

### Use the ProvisionGuestAgent property for classic VMs

[!INCLUDE [classic-vm-deprecation](../../includes/azure/classic-vm-deprecation.md)]

If you created the VM by using the classic model, use the Azure PowerShell module to update the **ProvisionGuestAgent** property. The property informs Azure that the VM has the VM Agent installed.

To set the **ProvisionGuestAgent** property, run the following commands in Azure PowerShell:

   ```powershell
   $vm = Get-AzureVM –ServiceName <cloud service name> –Name <VM name>
   $vm.VM.ProvisionGuestAgent = $true
   Update-AzureVM –Name <VM name> –VM $vm.VM –ServiceName <cloud service name>
   ```

Then run the `Get-AzureVM` command. Notice that the **GuestAgentStatus** property is now populated with data:

   ```powershell
   Get-AzureVM –ServiceName <cloud service name> –Name <VM name>
   GuestAgentStatus:Microsoft.WindowsAzure.Commands.ServiceManagement.Model.PersistentVMModel.GuestAgentStatus
   ```

## Next steps

- [Azure Virtual Machine Agent overview](/azure/virtual-machines/extensions/agent-windows)
- [Virtual machine extensions and features for Windows](/azure/virtual-machines/extensions/features-windows)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
