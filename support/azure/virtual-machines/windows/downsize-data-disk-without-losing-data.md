---
title: Decrease the size of an Azure data disk without losing data
description: Learn how to decrease the size of a disk in Azure without losing any data even though downsizing a disk directly isn't supported.
ms.date: 06/01/2023
ms.reviewer: scotro, uarshadkhan, v-leedennis
ms.topic: how-to
ms.service: virtual-machines
ms.subservice: vm-disk
---
# Decrease the size of an Azure data disk without losing data

This article shows you how to decrease the size of a disk in Azure without losing any data. Downsizing a disk directly isn't supported because of the risk of data loss. Instead, you can create a smaller disk, copy the data from the original disk, and then delete the old disk.

> [!NOTE]  
> This article doesn't address the scenario of downsizing the operating system (OS) disk. The article is also intended as general guidance. It isn't specific to the instructions that you may need.

## 1 - Create a new data disk

To create a new data disk within the Azure portal, follow these steps:

1. In the [Azure portal][ap], search for and select **Virtual machines**.
1. In the list of virtual machines (VMs), select the **Name** value of the VM to which you want to attach a new data disk.
1. In the VM navigation pane, locate the **Settings** heading, and then select **Disks**.
1. On the VM disks page, locate the **Data disks** heading, and then select **Create and attach a new disk**.
1. Enter or select values in the new data disk row for the following column fields, as applicable:

   - **LUN**
   - **Disk name**
   - **Storage type**
   - **Size (GB)**
   - **Max IOPS**
   - **Max throughput (MBps)**
   - **Encryption**
   - **Host caching**

1. In the menu of the VM disks page, select **Save**. After the new disk is created, it's automatically attached to the VM.

## 2 - Configure the data disk within the VM

Use the VM to configure the new data disk, as described in the following steps.

### [Windows](#tab/windows)

1. Connect to your VM by using Remote Desktop Protocol (RDP). For instructions, see [How to connect using Remote Desktop and sign on to an Azure VM running Windows](/azure/virtual-machines/windows/connect-rdp).

1. Configure the data disk that you created. On a Windows VM, you can use the [Disk Management app](/windows-server/storage/disk-management/overview-of-disk-management) to do the following configuration tasks:

   - [Initialize the new data disk](/windows-server/storage/disk-management/initialize-new-disks).

   - [Designate a drive letter for the new disk volume](/windows-server/storage/disk-management/change-a-drive-letter).

   - If it's necessary, assign a disk volume size by either [extending the disk volume](/windows-server/storage/disk-management/extend-a-basic-volume) or [shrinking the disk volume](/windows-server/storage/disk-management/shrink-a-basic-volume).

### [Linux](#tab/linux)

1. Connect to your VM by using Secure Shell (SSH). For instructions, see [Quick steps: Create and use an SSH public-private key pair for Linux VMs in Azure](/azure/virtual-machines/linux/mac-create-ssh-keys).

1. Configure the data disk that you created. For instructions, follow the guidance in the [Find the disk](/azure/virtual-machines/linux/attach-disk-portal#find-the-disk) section of the [Use the portal to attach a data disk to a Linux VM](/azure/virtual-machines/linux/attach-disk-portal) article.

---

## 3 - Move the files from the old data disk to the new data disk

Copy the data from the old, larger disk to the new, smaller disk. This process might take a long time, depending on the amount of data that you have to transfer.

1. Run a command that copies files from one location to another.

   ### [Windows](#tab/windows)

   Run the [robocopy](/windows-server/administration/windows-commands/robocopy) command or an equivalent tool:

   ```cmd
   robocopy x:\ y:\ /mir /z /w:5 /r:2 /mt
   ```

   Replace `x` and `y` with the appropriate drive letters for the source and destination disks, respectively.

   ### [Linux](#tab/linux)

   Run the [rsync](https://rsync.samba.org/) command or an equivalent tool:

   ```bash
   rsync -avz /<source>/<directory>/ /<destination>/<directory>/
   ```

   ---

2. Verify that the data transfer worked. Double-check to make sure that you successfully copied all data from the old disk to the new disk.

## 4 - Detach and delete the old data disk

Deleting a data disk is a two-part process. You have to detach a disk from its VM before the disk can actually be deleted. After the disk is detached, you can delete the disk.

#### Part 1: Detach the old disk

To detach the old disk, follow these steps:

1. In the [Azure portal][ap], search for and select **Virtual machines**.

1. In the list of VMs, select the **Name** value of the VM on which your old data disk is stored.

1. In the VM navigation pane, locate the **Settings** heading, and then select **Disks**.

1. In the VM disks page, locate the **Data disks** heading, and then select the **Detach** icon (an "X" symbol) at the end of the row that displays the old disk.

1. In the menu of the VM disks page, select **Save**. The old data disk is now detached from the VM.

#### Part 2: Delete the old disk

To delete the old disk, review the instructions in [Find and delete unattached Azure managed and unmanaged disks](/azure/virtual-machines/disks-find-unattached-portal).

## Conclusion

By following these steps, you can successfully downsize a disk in Azure without losing any data. To avoid any loss of critical information, always make sure that you verify the data transfer before you delete the old disk.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[ap]: https://portal.azure.com
