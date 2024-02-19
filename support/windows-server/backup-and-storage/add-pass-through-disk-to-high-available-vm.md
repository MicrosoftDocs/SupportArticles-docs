---
title: Pass-through disk is read-only after added to highly available VM
description: Discusses the steps that add a pass-through disk to a highly available virtual machine (VM) in a Windows Server 2008 R2 SP1-based failover cluster. Resolves an issue of a read-only disk status in the VM.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ctimon
ms.custom: sap:storage-hardware, csstroubleshoot
---
# Read-only pass-through disk after you add the disk to a highly available VM in a Windows Server 2008 R2 SP1 failover cluster

This article provides the steps to add a pass-through disk to a highly available virtual machine (VM) in a Windows Server 2008 R2 Service Pack 1 (SP1)-based failover cluster, and helps solve the issue where the added pass-through disk status is displayed as read-only.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2501763

## Add a pass-through disk to a highly available VM

To add a pass-through disk to a highly available VM in a Windows Server 2008 R2 SP1 failover cluster, follow these steps:

1. Log on as a domain user who is a member of the Local Administrators group on each cluster node.
2. Configure the pass-through disk on the Storage Area Network (SAN), and map the disk to each cluster node.
3. Open the **Disk Management** snap-in, and then verify that each cluster node detects the disk and that the disk status is **Offline**.
4. Right-click the name of the disk, and then click **Online** to bring the disk online.
5. Right-click the name of the disk, and then click **Initialize Disk** to initialize the disk.
6. Right-click the name of the disk, and then click **Offline** to take the disk offline.

    > [!NOTE]
    > You must take the disk offline before you add the disk to the cluster.

7. Add the disk to the failover cluster. To do this, follow these steps:
    1. Open the **Failover Cluster Manager** snap-in, right-click **Storage** in the console tree, and then click **Add disk**.
    2. In the **Add Disks to a Cluster** dialog box, click to select the check box for the disk that you want to add, and then click **OK**.
    3. In the **Storage** pane, verify that the disk is listed in **Available Storage** and that the disk status is **Online**.

8. Add the disk to an existing highly available VM in the cluster. To do this, follow these steps:

    1. In the **Failover Cluster Manager** snap-in, right-click the VM listed under **Virtual Machine**, and then click **Settings**.
    2. In the **Settings** dialog box, select a disk controller, and then click **Add** to add the disk to the disk controller. For example, click **SCSI Controller**, and then click **Add** to add the disk to the SCSI controller.
    3. In the **Hard Drive** pane, select the disk from the **Physical hard disk** list, and then click **OK**.

        > [!NOTE]
        > If you cannot find the disk from the **Physical hard disk**  list, verify that the disk status is **Offline** in the **Disk Management** snap-in.

    4. Verify that the disk is displayed under **Disk Drivers** of the VM. Verify that the disk is displayed in the **Dependencies** tab of the properties dialog box for the VM.

9. In the **Failover Cluster Manager** snap-in, right-click the VM, and then click **Connect**.
10. In the **Disk Management** snap-in, verify that the disk is added and that the disk status is **Offline**.
11. Right-click the name of the disk, and then click **Online** to bring the disk online.

> [!NOTE]
> You may find that the disk status is **Read Only**.

## Resolve the issue of the read-only disk status

To resolve the issue of the **Read Only** disk status in the VM, follow these steps:

1. Open a command prompt on the VM, type the `net stop vds` command, and then press ENTER to stop the Virtual Disk Service (VDS).
2. At the command prompt on the VM, type the  `net start vds` command, and then press ENTER to restart the VDS.
3. Open the **Disk Management** snap-in, and verify the disk status. If the disk status is still **Read Only**, restart the VM.
