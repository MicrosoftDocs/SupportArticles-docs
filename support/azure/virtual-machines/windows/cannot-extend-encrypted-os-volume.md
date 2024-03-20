---
author: genlin
description: This article helps you troubleshoot a problem in which you are unable to extend the OS volume on an Azure VM that has been encrypted with Azure Disk Encryption.
ms.author: genli
ms.date: 05/07/2021
ms.service: virtual-machines
ms.subservice: vm-disk
ms.collection: windows
ms.topic: troubleshooting
title: Cannot extend an encrypted OS volume in Windows
---

# Cannot extend an encrypted OS volume in Windows

This article describes a problem that prevents you from easily extending the OS volume on some Azure VMs that have been encrypted with Azure Disk Encryption (ADE). It also describes a workaround that allows you extend the OS volume as needed.

## Symptom

You see the **Extend Volume…** option grayed for the **Windows (C:)** partition in an Azure VM. A System Reserved partition also appears immediately to the right of the Windows partition. The placement of the System Reserved partition appears to block the C drive from being extended into any unallocated space on the disk.

:::image type="content" source="media/cannot-extend-encrypted-os-volume/extend-volume-grayed.png" alt-text="Screenshot shows Disk Management with the Extend Volume option grayed out on the shortcut menu for the Windows volume.":::

## Cause

During a default Windows installation, a System Reserved partition is created on Disk 0. This partition holds the Boot Manager code and the Boot Configuration Database, and it reserves space for the startup files required for BitLocker. Normally, the System Reserved partition is assigned to partition 1, and the Windows volume is assigned to partition 2. This default arrangement, shown below, allows the C: drive to be extended into adjacent unallocated space as needed.

:::image type="content" source="media/cannot-extend-encrypted-os-volume/normal-partition.png" alt-text="Screenshot of Disk 0 in Disk Management with the Windows partition in the middle, next to unallocated space on the right.":::

Customers, however, may create VMs based on custom images that assign the Windows (C:) volume to partition 1 and that do not define a System Reserved partition. If Azure Disk Encryption is later applied to the OS disk, a new System Reserved partition must then be added to the disk to support BitLocker. The newly created System Reserved partition in this case is assigned to partition 2, whose placement will appear to block partition 1, the OS volume, from being extended into unallocated disk space.

## Resolution

To fix this problem, you need to perform the following steps:

1. [Assign a larger disk SKU to the OS disk in the Azure portal](#assign-a-larger-disk-sku-to-the-os-disk-in-the-azure-portal)
2. [Extend the System Reserved volume into the unallocated space](#extend-the-system-reserved-volume-into-the-unallocated-space)
3. [Create a new boot volume in the remaining unallocated space](#create-a-new-boot-volume-in-the-remaining-unallocated-space)
4. [Delete the System Reserved volume and extend the Windows volume](#delete-the-system-reserved-volume-and-extend-the-windows-volume)

### Assign a larger disk SKU to the OS disk in the Azure portal

1. In the Azure portal, stop the VM whose OS disk you want to expand.
2. Navigate to the properties page for the OS disk. Take a snapshot to make a backup of the disk.
3. On the properties page of the OS disk, click **Size + performance** on the left menu.
4. In the **Size + performance** window, choose a larger disk SKU that gives you enough storage for  your needs, and then click **Resize**.
5. Start the VM again.

### Extend the System Reserved volume into the unallocated space

1. Sign in to the VM. In Disk Management, assign a drive letter to the System Reserved partition. For example, you can assign drive letter E to it.

   :::image type="content" source="media/cannot-extend-encrypted-os-volume/change-drive.png" alt-text="Screenshot of the shortcut menu for the System Reserved volume in Disk Management, with Change Drive Letter and Paths selected.":::

   :::image type="content" source="media/cannot-extend-encrypted-os-volume/add-drive.png" alt-text="Screenshot of the Add Drive Letter or Path dialog box, assigning the letter E to the System Reserved volume.":::

2. Right-click the **System Reserved** partition, and then select **Extend Volume…**. When selecting an amount of space to extend, *specify a value at least 200 MB less than the maximum allowed* (to leave room for a boot volume you will create later).

   :::image type="content" source="media/cannot-extend-encrypted-os-volume/extend-volume.png" alt-text="Screenshot of the Extend Volume option being extended for the System Reserved volume.":::

   :::image type="content" source="media/cannot-extend-encrypted-os-volume/extend-volume-wizard.png" alt-text="Screenshot of the Select Disks page in the Extend Volume Wizard.":::

   The disk partition layout will resemble the following example after this last step:

   :::image type="content" source="media/cannot-extend-encrypted-os-volume/unallocated-space.png" alt-text="Screenshot of Disk 0 in Disk Management with only 201 megabytes left unallocated.":::

### Create a new boot volume in the remaining unallocated space

1. Create a new volume in the remaining unallocated space and assign a drive letter to it. Make a note of this drive letter because you will be using it in the next step.

   :::image type="content" source="media/cannot-extend-encrypted-os-volume/new-simple-volume.png" alt-text="Screenshot of the new simple volume option selected from unallocated space.":::

2. Open an elevated command prompt and run the following command to create a new set of boot files in the last volume you have just created.

    ```console
    bcdboot C:\Windows /s [drive letter of newest volume]:
    ```

   For example, if the last volume you created (the rightmost volume in Disk Management, created from the remaining unallocated space) was assigned the F: drive, you would type the following at the command prompt:

    ```console
    bcdboot C:\Windows /s F:
    ```

3. Open Regedit, select **HKEY_LOCAL_MACHINE\BCD00000000**, and then select **Unload Hive** from the **File** menu.

   :::image type="content" source="media/cannot-extend-encrypted-os-volume/regedit.png" alt-text="Screenshot of a folder selected in the registry editor and of the Unload Hive option selected from the File menu.":::

4. Use the following command to replace the *\boot\bcd* file located in the last volume you have created (that is, the rightmost drive in Disk Management, created from last unallocated space) with the current BCD file found in the *\boot* folder of the System Reserved volume.

    ```console
    Copy [Drive letter of System Reserved volume]:\boot\bcd [Drive letter of newest volume]:\boot\bcd
    ```

    For example, if the drive letter of your System Reserved volume is E, and the newest (rightmost) volume you created is F, you would type the following command:

    ```console
    Copy E:\boot\bcd F:\boot\bcd
    ```

    You need to perform this step because the BCD file created in step 2 does not contain Azure-specific configuration settings. (Note that as an alternative to performing this copy operation, you can follow the "Set the Boot Configuration Data [BCD] settings" instructions found here: [Verify the VM](/azure/virtual-machines/windows/prepare-for-upload-vhd-image#verify-the-vm))

5. Run the following command to begin the process of changing Windows Boot Manager from the System Reserved partition to the newest (rightmost) partition:

    ```console
    bcdedit /store [Newest drive letter]:\boot\bcd /enum /v
    ```

    For example, if the newest (rightmost) partition drive letter is F, you would type the following command:

    ```console
    bcdedit /store F:\boot\bcd /enum /v
    ```

    You will see output that looks like the following example:

    ```output
    Windows Boot Manager
    --------------------
    identifier              {9dea862c-5cdd-4e70-acc1-f32b344d4795}  <<<<<
    device                  partition=E:
    description             Windows Boot Manager
    locale                  en-us
    inherit                 {7ea2e1ac-2e61-4728-aaa3-896d9d0a9f0e}
    displayorder            {05d0826e-19a2-4380-968f-4b45f971812d}
    toolsdisplayorder       {b2721d73-1db4-4c62-bf78-c548a880142d}
    timeout                 30
    …………..
    ```

6. Use the Identifier value from the last output to run the following command and complete the process of moving Windows Boot Manager to the newest partition:

    ```console
    bcdedit /store [Newest drive letter]:\boot\bcd /set [Identifier] device partition=[Newest drive letter]:
    ```

    For example, if the newest drive letter is F and the identifier is the same as in the output above, you would type the following:

    ```console
    bcdedit /store F:\boot\bcd /set {9dea862c-5cdd-4e70-acc1-f32b344d4795} device partition=F:
    ```

7. In Disk Management, right-click the rightmost volume (the last volume you created), and select **Mark Partition as Active**. Click Yes to confirm.
8. Restart the VM.

### Delete the System Reserved volume and extend the Windows volume

1. Log in to the VM again. In Disk Management, delete the old System Reserved partition, and click Yes to confirm.

    :::image type="content" source="media/cannot-extend-encrypted-os-volume/delete-volume.png" alt-text="Screenshot of the Delete Volume option being selected for the old System Reserved partition in Disk Management.":::

2. Finally, extend the C drive as needed with the unallocated space that is now adjacent.

   :::image type="content" source="media/cannot-extend-encrypted-os-volume/extend-volume-available.png" alt-text="Screenshot of the Extend Volume now available on the shortcut menu for the Windows volume in Disk Management.":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
