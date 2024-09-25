---
author: genlin
ms.author: genli
ms.service: azure-virtual-machines
ms.topic: include
ms.date: 07/12/2024
ms.reviewer: jarrettr
---
1. Delete the VM.

   > [!IMPORTANT]
   > When you're prompted to confirm the VM deletion, make sure that you clear the **Delete with VM** option that's associated with the OS disk resource type.

1. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [Attach a managed data disk to a Windows VM by using the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).

1. Connect to the troubleshooting VM.

1. Select **Start**, and then search for and select **Computer management**. In the console tree of the Computer Management app, select **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.

1. Identify the Boot partition and the Windows partition. If there's only one partition on the OS disk, this partition is both the Boot partition and the Windows partition.

   If the OS disk contains more than one partition, you can identify them by viewing the folders in the partitions:

   - The Windows partition contains a folder that's named *Windows*. This partition is larger than the others.

   - The Boot partition contains a folder that's named *boot*. This folder is hidden by default. To see the folder in File Explorer, open the **Folder Options** dialog box, select to display hidden files and folders, and then clear the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB to 500 MB.

1. Run the following [BCDEdit /enum](/windows-hardware/drivers/devtest/bcdedit--enum) command as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code in GUID format (*xxxxxxxx*-*xxxx*-*xxxx*-*xxxx*-*xxxxxxxxxxxx*). You have to use this identifier in the next step.

   ```cmd
   bcdedit /store <boot-partition>:\boot\bcd /enum /v
   ```

   > [!NOTE]
   > If there isn't a *bcd* store file in the *boot* folder of the Boot partition, restore the file by following the steps in [Repair or replace the binary file](../../azure/virtual-machines/windows/virtual-machines-windows-repair-replace-system-binary-file.md), except that you're replacing the *\\boot\\bcd* file instead of a system binary (*.sys*) file.

1. Repair the Boot Configuration data by running the following [BCDEdit /set](/windows-hardware/drivers/devtest/bcdedit--set) commands. Change the placeholders to the actual values, as described in the following table.

   | Placeholder              | Value                                                                     |
   |--------------------------|---------------------------------------------------------------------------|
   | **\<windows-partition>** | The partition that contains a folder that's named *Windows*               |
   | **\<boot-partition>**    | The partition that contains a hidden system folder that's named *boot*    |
   | **\<identifier>**        | The identifier of Windows Boot Loader that you found in the previous step |

   ```cmd
   bcdedit /store <boot-partition>:\boot\bcd /set {<identifier>} OSDEVICE BOOT
   ```

   ```cmd
   bcdedit /store <boot-partition>:\boot\bcd /set {<identifier>} OSDEVICE partition=<windows-partition>:
   ```

1. Detach the repaired OS disk from the troubleshooting VM. Then, create a VM from the OS disk.
