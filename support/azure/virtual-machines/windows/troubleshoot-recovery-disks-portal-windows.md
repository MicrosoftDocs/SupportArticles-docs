---
title: Troubleshoot a Windows VM in the Azure portal
author: genlin
description: This article describes how to attach a disk to a repair VM for offline servicing.
ms.author: genli
ms.date: 07/16/2021
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# Troubleshoot a Windows VM by attaching the OS disk to a repair VM through the Azure portal

**Applies to:** :heavy_check_mark: Windows VMs

If your Windows virtual machine (VM) in Azure encounters a startup or disk error, you might need to perform troubleshooting steps on its OS disk offline. Attaching the OS disk to a second VM for offline repair might be required, for example, if a failed application update prevents a VM from starting successfully. This article describes how to connect a failed OS disk to a repair VM to fix any errors and then re-create your original VM.

## Determine which method to use for offline repair

The steps you should use to attach a failed OS disk to a repair VM depend on whether the disk is encrypted with Azure Disk Encryption (ADE), whether it's managed or unmanaged, and some other factors.

- If the OS disk is unmanaged, see [Attach an unmanaged disk to a VM for offline repair](unmanaged-disk-offline-repair.md) for instructions on attaching the disk to a repair VM. If you're unsure, see [Determine if the OS disk is managed or unmanaged](unmanaged-disk-offline-repair.md#determine-if-the-os-disk-is-managed-or-unmanaged).

- If the OS disk is managed,
  - Not encrypted, see [Repair a Windows VM by using the Azure Virtual Machine repair commands](repair-windows-vm-using-azure-virtual-machine-repair-commands.md). This is the automated (preferred) method to attach a failed OS disk to a repair VM by using [az vm repair](/cli/azure/vm/repair). If you're unsure if the OS disk is encrypted, see [Confirm that ADE is enabled on the disk](unlock-encrypted-disk-offline.md#confirm-that-ade-is-enabled-on-the-disk).
  
  - Encrypted with ADE single-pass encryption (with or without KEK), see [Repair a Windows VM by using the Azure Virtual Machine repair commands](repair-windows-vm-using-azure-virtual-machine-repair-commands.md). This is the automated (preferred) method to attach a failed OS disk to a repair VM by using [az vm repair](/cli/azure/vm/repair).
  
  - Encrypted with ADE using a method other than single-pass encryption, see [Unlocking an encrypted disk for offline repair](unlock-encrypted-disk-offline.md) for instructions on attaching and unlocking the disk.

## Manually attach a failed OS disk to a repair VM

Use the following process to fix a failed VM with the help of a repair VM.

1. [Take a snapshot of the OS disk](#take-a-snapshot-of-the-os-disk).
2. [Create a disk from the snapshot](#create-a-disk-from-the-snapshot).
3. [Create a repair VM with the new disk attached as a data disk](#create-a-repair-vm-with-the-new-disk-attached-as-a-data-disk).
4. [Repair the failed VM's OS disk](#repair-the-failed-vms-os-disk).
5. [Swap the failed VM's OS disk with the repaired disk](#swap-the-failed-vms-os-disk-with-the-repaired-disk).

### Take a snapshot of the OS disk

A snapshot is a full, read-only copy of a virtual hard disk. We recommend that you cleanly shut down the VM before taking a snapshot, to clear out any processes that are in progress. To take a snapshot of an OS disk, follow these steps:

1. Go to the [Azure portal](https://portal.azure.com) and navigate to the VM that has the problem.
2. Select the **Disks** blade, and then select the OS disk to open its **Overview** blade.

    :::image type="content" source="media/troubleshoot-recovery-disks-portal-windows/os-disk.png" alt-text="Screenshot of the Disks blade of a V M in Azure portal, showing the O S disk highlighted.":::

3. On the **Overview** blade of the OS disk, select **Create snapshot**.

    :::image type="content" source="media/troubleshoot-recovery-disks-portal-windows/create-snapshot.png" alt-text="Screenshot of the overview blade of a disk with the create snapshot option highlighted.":::

4. Proceed to create a snapshot with the default settings.

### Create a disk from the snapshot

To create a disk from the snapshot, follow these steps:

1. After the deployment of the disk snapshot is complete, navigate to the new resource in the Azure portal.
2. On the **Overview** blade of the new disk snapshot, select **Create Disk.**

    :::image type="content" source="media/troubleshoot-recovery-disks-portal-windows/create-disk.png" alt-text="Screenshot of the overview blade of a snapshot, with the create disk option highlighted.":::

3. On the **Basics** page of the "Create a Managed Disk" wizard, assign a descriptive name to the disk, such as "MyVMOsDiskCopy."
4. On the **Basics** page, select a region and [Availability zone](/azure/availability-zones/az-overview#availability-zones), and record these choices. You will assign these same values to the repair VM.
5. Complete the "Create a Managed Disk" wizard with the default options.

### Create a repair VM with the new disk attached as a data disk

1. In the Azure portal, begin the process of creating a new VM based on Windows Server.
2. On the **Basics** page of the "Create a Virtual Machine" wizard, specify the same region and availability zone that you chose for the new disk you just created from the snapshot.
3. Complete the "Create a Virtual Machine" wizard with the default settings.
4. Start and connect to the repair VM. Ensure the repair VM is operating correctly.
5. Attach the disk to the repair VM as a data disk.

    1. On the **Virtual machine** pane, select **Disks**.
    2. On the **Disks** pane, select **Attach existing disks**.
    3. Under **Disk name**, select the expected disk from the drop-down menu.
    4. Select **Save**.

### Repair the failed VM's OS disk

With the copy of the OS disk mounted on the repair VM, you can now perform any maintenance and troubleshooting steps as needed. After you've fixed the errors on the disk that have prevented it from starting, continue with the following steps.

## Swap the failed VM's OS disk with the repaired disk

Azure portal supports changing the OS disk of the VM. To do this, follow these steps:

1. After you repair the disk, open the **Disks** blade for the repair VM in the Azure portal. Detach the copy of the source VM OS disk. To do this, locate the row for the associated disk name under **Data Disks**, select the "X" at the right side of that row, and then select **Save**.

    :::image type="content" source="media/troubleshoot-recovery-disks-portal-windows/detach-repaired-disk-copy.png" alt-text="Screenshot of a data disk selected on the Disks blade in Azure portal, with the X symbol highlighted next to it.":::

2. In the Azure portal, navigate to the source (failed) VM and open the **Disks** blade. Click **Swap OS disk** to replace the existing OS disk with the one you have just repaired.

    :::image type="content" source="media/unlock-encrypted-disk-offline/swap-os-disk.png" alt-text="Screenshot of the disks blade in Azure portal with the swap O S disk option highlighted.":::

3. Choose the new disk that you repaired, and then enter the name of the VM to confirm the change. If you don't see the disk in the list, wait 10 to 15 minutes after you detach the disk from the troubleshooting VM.

## Next Steps

If you're having problems connecting to your VM, see [Troubleshoot Remote Desktop connections to an Azure VM](troubleshoot-rdp-connection.md). For problems with accessing applications running on your VM, see [Troubleshoot application connectivity issues on a Windows VM](troubleshoot-app-connection.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
