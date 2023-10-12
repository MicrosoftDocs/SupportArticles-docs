---
title: Troubleshoot a faulty Azure VM by using nested virtualization in Azure
description: How to troubleshoot a faulty Azure VM by using nested virtualization in Azure.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-backup-restore
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-windows
ms.topic: article
ms.date: 10/12/2023
ms.author: glimoli
ms.reviewer: v-weizhu
---
# Troubleshoot a faulty Azure VM by using nested virtualization in Azure

This article shows how to create a nested virtualization environment in Microsoft Azure, so you can mount the disk of the faulty VM on the Hyper-V host (Rescue VM) for troubleshooting purposes.

## Prerequisites

In order to mount the faulty VM, the Rescue VM must use the same type of Storage Account (Standard or Premium) as the faulty VM.

## Step 1: Create a Rescue VM and install Hyper-V role

1. Create a new Rescue VM:

    - Operating system: Windows Server 2016 Datacenter or newer versions of Windows Server Datacenter.

    - Size: Select a series that supports nested virtualization. For example: [Dv3](/azure/virtual-machines/dv3-dsv3-series) or [Dv4](/azure/virtual-machines/dv4-dsv4-series).

    - Same location, Storage Account, and Resource Group as the faulty VM.

    - Select the same storage type as the faulty VM (Standard or Premium).

    - Image: Choose either a Generation 2 image or a Generation 1 image.

    - Security type: Change the security type to **Standard**. By default, the security type is **Trusted launch virtual machines** that doesn't support nested virtualization. If you set the security type to **Trusted launch virtual machines**, and attempt to add server roles on the Rescue VM, you'll encounter the following error message:

        > Hyper-V cannot be installed because virtualization support is not enabled in the BIOS.

        :::image type="content" source="media/troubleshoot-vm-by-use-nested-virtualization/hyper-v-cannot-be-installed-error.png" alt-text="Screenshot that shows the 'Hyper-V cannot be installed' error message. "lightbox="media/troubleshoot-vm-by-use-nested-virtualization/hyper-v-cannot-be-installed-error.png":::
      
2. After the Rescue VM is created, remote desktop to the Rescue VM.

3. In Server Manager, select **Manage** > **Add Roles and Features**.

4. In the **Installation Type** section, select **Role-based or feature-based installation**.

5. In the **Select destination server** section, make sure that the Rescue VM is selected.

6. Select the **Hyper-V role** > **Add Features**.

7. Select **Next** on the **Features** section.

8. If a virtual switch is available, select it. Otherwise select **Next**.

9. On the **Migration** section, select **Next**

10. On the **Default Stores** section, select **Next**.

11. Check the box to restart the server automatically if required.

12. Select **Install**.

13. Allow the server to install the Hyper-V role. This takes a few minutes and the server will reboot automatically.

## Step 2: Create the faulty VM on the Rescue VM's Hyper-V server

1. [Create a snapshot disk](troubleshoot-recovery-disks-portal-windows.md#take-a-snapshot-of-the-os-disk) for the OS disk of the VM that has problem, and then attach the snapshot disk to the Rescue VM.

2. Remote desktop to the Rescue VM.

3. Open Disk Management (diskmgmt.msc). Make sure that the disk of the faulty VM is set to **Offline**.

4. Open Hyper-V Manager: In **Server Manager**, select the **Hyper-V role**. Right-click the server, and then select the **Hyper-V Manager**.

5. In the Hyper-V Manager, right-click the Rescue VM, and then select **New** > **Virtual Machine** > **Next**.

6. Type a name for the VM, and then select **Next**.

7. Select **Generation 1** or **Generation 2** according to the faulty VM generation.

8. Set the startup memory at 1024 MB or more.

9. If applicable select the Hyper-V Network Switch that was created. Else move to the next page.

10. Select **Attach a virtual hard disk later**.

    :::image type="content" source="media/troubleshoot-vm-by-use-nested-virtualization/attach-virtual-hard-disk-later.png" alt-text="Screenshot shows the Attach a Virtual Hard Disk Later option under the Connect Virtual Hard Disk entry." border="false":::

11. Select **Finish** when the VM is created.

12. Right-click the VM that you created, and then select **Settings**.

13. Select **IDE Controller 0** for generation 1 VMs or **SCSI Controller** for generation 2 VMs, select **Hard Drive**, and then click **Add**.

    :::image type="content" source="media/troubleshoot-vm-by-use-nested-virtualization/create-new-drive.png" alt-text="Screenshot shows steps to add a new hard drive." border="false":::

14. In **Physical Hard Disk**, select the disk of the faulty VM that you attached to the Azure VM. If you do not see any disks listed, check if the disk is set to offline by using Disk management.

    :::image type="content" source="media/troubleshoot-vm-by-use-nested-virtualization/physical-hard-disk.png" alt-text="Screenshot shows the Physical hard disk area." border="false":::

15. Select **Apply**, and then select **OK**.

16. Double-click on the VM, and then start it.

17. Now you can work on the VM as the on-premises VM. You could follow any troubleshooting steps you need.

## Step 3: Replace the OS disk used by the faulty VM

1. After you get the VM back online, shut down the VM in the Hyper-V manager.

2. Detach the repaired OS disk.
3. [Replace the OS disk used by the VM with the repaired OS disk](troubleshoot-recovery-disks-portal-windows.md#swap-the-failed-vms-os-disk-with-the-repaired-disk).

## Next steps

If you are having issues connecting to your VM, see [Troubleshoot RDP connections to an Azure VM](troubleshoot-rdp-connection.md). For issues with accessing applications running on your VM, see [Troubleshoot application connectivity issues on a Windows VM](troubleshoot-app-connection.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
