---
title: Virtual machine LUNs disappear after you configure them as MPIO devices
description: When you use discrete device assignment to connect a LUN to a virtual machine, you cannot use that LUN as an MPIO device
ms.date: 03/04/2022
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.technology: hyper-v
keywords: DDA,passthrough,pass-through,LUN,MPIO
---

# Virtual machine LUNs disappear after you configure them as MPIO devices

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Microsoft Hyper-V Server 2016

## Symptoms

You're using a virtual machine (VM) host that runs Windows Server 2016 or a later version, and you use steps that resemble the following to configure a VM on the host:

1. You install the Multipath I/O (MPIO) feature and the Hyper-V role on the VM host.
1. You create a VM on the specified host, and install MPIO on the VM.
1. You use [Discrete Device Assignment (DDA)](/windows-server/virtualization/hyper-v/deploy/deploying-storage-devices-using-dda) to connect one or more physical LUNs (also known as pass-through disks) to the VM.  
   When you check the settings of the VM in Hyper-V Manager, the **Settings** page lists the DDA disks (the physical LUNs) as physical disks.  
  
   :::image type="content" source="./media/vm-dda-luns-disappear-after-mpio-config/hyper-v-vm-settings-show-dda-disks.png" alt-text="The VM Settings page in Hyper-V Manager lists DDA disks as physical disks.":::  
   When you connect to the VM and then open **Disk Management**, the tool lists the new LUNs as unallocated disks.  
  
   :::image type="content" source="./media/vm-dda-luns-disappear-after-mpio-config/hyper-v-vm-disk-mgr-before-mpio-config.png" alt-text="On the VM, Disk Management lists the DDA disks as unallocated physical disks.":::
1. On the VM, you open the MPIO Settings tool, and configure the LUNs as MPIO devices. Then, you restart the VM.
1. After the VM restarts, you connect to it, and then open **Disk Management** again. Now, the new LUNs no longer appear in the tool.  
  
   :::image type="content" source="./media/vm-dda-luns-disappear-after-mpio-config/hyper-v-vm-disk-mgr-after-mpio-config.png" alt-text="After you configure MPIO on the VM, Disk Management on the VM no longer shows the DDA disks.":::

## Status

This behavior is by design.

## More information

The DDA and MPIO features both rely on the Host Bus Adapter (HBA) that connects a LUN to the VM. The two features can't use the same HBA at the same time. Therefore, you can't configure DDA disks on a VM as MPIO devices.

> [!NOTE]  
> The VM host does not access the DDA disks. You can still configure MPIO on the VM host if a VM on that host uses DDA disks.
