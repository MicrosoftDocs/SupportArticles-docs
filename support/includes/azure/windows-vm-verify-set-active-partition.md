---
ms.service: virtual-machines
ms.topic: include
ms.date: 07/10/2024
---

> [!NOTE]
> This mitigation applies only for Generation 1 VMs. Generation 2 VMs (using UEFI) don't use an active partition.

1. Delete the VM. Make sure that you select the **Keep the disks** option when you do this.

2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).

3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.

4. Identify the Boot partition and Windows partition. If there's only one partition on the OS disk, this partition is both Boot partition and Windows partition.

    If the OS disk contains more than one partition, you can identify the partitions by viewing the folders in them:

    - The Windows partition contains a folder that is named *Windows*, and this partition is larger than the others.

    - The Boot partition contains a folder that is named *Boot*. This folder is hidden by default. To see the folder, you must display the hidden files and folders and disable the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB~500 MB.

5. Run the following command as an administrator to create a boot record:

    ```console
    bcdboot <Windows partition>:\Windows /S <windows partition>: 
    ```

6. Use the DISKPART tool to check whether the Windows partition is active:

   1. Open an elevated command prompt and open the DISKPART tool.

      `diskpart`

   2. List the disks on the system and look for added disks and proceed to select the new disk. In this example, the new disk is Disk 1.

      ```ps
      list disk
      sel disk 1
      ```

      :::image type="content" source="../../azure/virtual-machines/windows/media/windows-vm-verify-set-active-partition/list-disk.png" alt-text="The diskpart window shows outputs of list disk and sel disk 1 commands. Disk 0 and Disk 1 are displayed in the table. Disk 1 is the selected disk.":::

   3. List all the partitions on that disk and then proceed to select the partition you want to check. Usually System Managed partitions are smaller and around 350 MB in size. In the following image, this partition is Partition 1.

      ```ps
      list partition
      sel partition 1
      ```

      :::image type="content" source="../../azure/virtual-machines/windows/media/windows-vm-verify-set-active-partition/list-partition.png" alt-text="The diskpart window shows outputs of list partition and sel partition 1 commands. Partition 1 is the selected disk.":::

   4. Check the status of the partition. In our example, Partition 1 is not active.

      `detail partition`

      :::image type="content" source="../../azure/virtual-machines/windows/media/windows-vm-verify-set-active-partition/detail-partition-not-active.png" alt-text="The diskpart window with output of the detail partition command where Partition 1 is not active.":::

      If the partition isn't active, change the Active flag and then recheck the change was done properly.

      ```ps
      active
      detail partition
      ```

      :::image type="content" source="../../azure/virtual-machines/windows/media/windows-vm-verify-set-active-partition/detail-partition-active.png" alt-text="The diskpart window with output of the detail partition command where Partition 1 is active.":::

   5. Exit the DISKPART tool.

      `exit`
