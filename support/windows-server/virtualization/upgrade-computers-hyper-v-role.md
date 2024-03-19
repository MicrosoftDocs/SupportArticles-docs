---
title: Upgrade computers with Hyper-V role
description: Describes the options available for upgrading or migrating from a Windows Server 2008 installation that has the Hyper-V role enabled to Windows Server 2008 R2.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jeffpatt
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
---
# How to upgrade computers running Windows Server 2008 with the Hyper-V role installed to Windows Server 2008 R2

This article describes the options that are available for upgrading or migrating from a Windows Server 2008 installation with the Hyper-V role enabled to Windows Server 2008 R2.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 957256

## Introduction

For Windows Server 2008 Failover Clusters that are running virtual machines, see the [Upgrade guidance for virtual machines on failover clusters](#upgrade-guidance-for-virtual-machines-on-failover-clusters) section of this article.

## More information

### Method 1: Perform an upgrade of the parent partition from Windows Server 2008 to Windows Server 2008 R2.

> [!NOTE]
> During the upgrade, the compatibility report will inform you that you must remove the Hyper-V role by using Server Manager before you continue with the upgrade. This is not necessary. However, before continuing with the upgrade we suggest that you back up your virtual machines or export them using Hyper-V Manager. Additionally, consider the following before you upgrade:

- Hyper-V must be at RTM (KB 950050) or later. If this requirement is not met, you will be blocked from continuing with the upgrade.

- All virtual machines must be shut down prior to the upgrade. Saved states are not compatible between Windows Server 2008 and Windows Server 2008 R2. If the parent partition is upgraded with any virtual machines in a saved state, you must right-click the virtual machine, and then select **Discard saved state** to turn on the virtual machine.

- Because Online Snapshot functionality uses saved states, Online Snapshots are not fully compatible between Windows Server 2008 and Windows Server 2008 R2. Online Snapshots are snapshots taken when a virtual machine was turned on. Offline Snapshots are snapshots that are taken when a virtual machine was turned off. Offline Snapshots are fully compatible with Windows Server 2008 R2. Virtual machines will start successfully to the online snapshot that was applied when the virtual machine was shut down before the upgrade. This is shown in Hyper-V Manager by the green arrow under the snapshot that points to **Now**.

    To turn on the virtual machine with any other snapshot, follow these steps.

    > [!NOTE]
    > The following steps assume that you have to continue using all snapshots that are configured for the virtual machine. If you no longer require snapshots, you can delete your snapshots by using Hyper-V Manager, and then shut down the virtual machine for the data to merge with the parent virtual hard disk.

    For more information, see [Hyper-V Virtual Machine Snapshots: FAQ](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd560637(v=ws.10)).

    1. Using Hyper-V Manager, right-click the snapshot that you want to apply, and then click **Take Snapshot and Apply**. This action will take a new snapshot from the currently applied snapshot. This new snapshot will now be compatible with Windows Server 2008 R2. We recommend that you rename the snapshot to reflect this. If you select this option, any changes that you may have made to the state of the virtual machine since the last start will be saved.

    2. After the new R2 snapshot is taken, the snapshot that you selected in step 1 will be applied, and the virtual machine will go into a saved state. Right-click the virtual machine, and then click **Delete saved state**.

    3. Turn on the virtual machine.

    4. Take a new snapshot to capture the current state of the virtual machine to have a Windows Server 2008 R2-compatible snapshot.

    5. Repeat these steps for each snapshot from Windows Server 2008. Once you have completed these steps on all required snapshots, delete the snapshots that were created on Windows Server 2008, and then shut down the virtual machine to allow the merge process to begin.

- After the upgrade, update the Integration Services. To do this, open the **Virtual Machine Connection** window, and then click **Insert Integration Services Setup Disk** on the
 **Action** menu.

    > [!NOTE]
    > On a Windows Server 2008 R2-based computer, the Integration Services for Windows Vista and Windows Server 2008 will be listed in **Programs and Features** as KB955484.

### Method 2

Export a virtual machine from a Windows Server 2008-based computer that has Hyper-V enabled, and then import it to a server that has Windows Server 2008 R2 with Hyper-V enabled.

> [!NOTE]
> The virtual machine must be shut down before you export it. If you exported the virtual machine with a saved state, you cannot restore the virtual machine on Windows Server 2008 R2. To start the virtual machine after you import it to Windows Server 2008 R2, you must discard the saved state before you can turn on the virtual machine. If the virtual machine has snapshots, these snapshots must be merged before the export, or you must use the steps from Method 1 to recover and re-create the snapshots.

After you import the virtual machine, update the Integration Services. To do this, open the **Virtual Machine Connection** window, and then click **Insert Integration Services Setup Disk** on the **Action** menu.

> [!NOTE]
> On a Windows Server 2008 R2-based computer, the Integration Services for Windows Vista and Windows Server 2008 will be listed in **Programs and Features** as "KB955484."

### Method 3

Using backup software that leverages the Hyper-V VSS Writer, back up a virtual machine that is running on Windows Server 2008, and restore it to Windows Server 2008 R2.

After you restore the virtual machine, update the Integration Services. To do this, open the **Virtual Machine Connection** window, and then click **Insert Integration Services Setup Disk** on the **Action** menu.

> [!NOTE]
> On a Windows Server 2008 R2-based computer, the Integration Services for Windows Vista and Windows Server 2008 will be listed in **Programs and Features** as KB955484.

### Upgrade guidance for virtual machines on failover clusters

When you have highly available virtual machines that are configured as clustered resources in a Windows Server 2008 cluster, you must follow these steps to upgrade your virtual machines and clusters to Windows Server 2008 R2.

> [!NOTE]
> If you are running any other clustered services or applications in the parent partition, visit the following Microsoft Web site for information about how to move these resources to Windows Server 2008 R2:  
[Migrating to a Failover Cluster Running Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730990(v=ws.11))

We do not recommend running any additional services or applications in the parent partition for Hyper-V servers.

1. Using the Failover Cluster Manager snap-in (CluAdmin.msc), perform a Quick Migration to move all virtual machines to a subset of nodes. Evict the other subset of the nodes, which are not hosting any virtual machines. To do this, right-click the nodes in Failover Cluster Manager, click **Move Actions**, and then click **Evict**. The size of the subset should be such that the virtual machines hosted by the subset can be stored on the remaining nodes, which are still running Windows Server 2008. For example, in a four-node cluster, evict two nodes so that the remaining nodes can hold the virtual machines that were being hosted by the first group of nodes. Make sure that the evicted nodes are masked out from the shared storage of the original cluster.

2. Perform a clean installation of Windows Server 2008 R2 on the evicted subset of nodes, and then enable the Hyper-V role and the Failover Clustering feature.

    > [!IMPORTANT]
    > An upgrade is not supported on a failover cluster so a clean installation is required.

3. Create a new cluster with the evicted nodes, and then run all of the Validate a Configuration Wizard tests. If applicable, enable Cluster Shared Volumes (CSV) on the Windows Server 2008 R2 cluster, and create some CSV disks.

4. Prepare the virtual machines in the original cluster for an upgrade. Take the following actions, depending on the state of the virtual machine:
    - If the virtual machine is in a **Running** state, use Hyper-V Manager to shut down the virtual machine.

    - If the virtual machine is in a **Saved** state, use Hyper-V Manager to start from the saved state and then shut down the virtual machine. Saved states are not supported when you upgrade your host to Windows Server 2008 R2.

    - If the virtual machine has an online snapshot that you need, apply the relevant snapshot, and then shut down the virtual machines.

5. Follow one of these steps to prepare your virtual machine for upgrading:

    > [!IMPORTANT]
    > If you are moving virtual machines to a CSV disk, follow the specific steps in the "Migrate a virtual machine from a non-CSV disk to a CSV disk" section later in this article.

    1. Export the virtual machines. If you are going to use the same SAN storage for the Windows Server 2008 R2 cluster, you can use a configuration-only export. Export the virtual machine from Windows Server 2008 Hyper-V Manager by selecting **Export** on the **Action** menu. Make sure to select the **Export only the virtual machine configuration** check box.

    2. Back up the virtual machines by using a backup application of your choice.

6. Open Failover Cluster Manager on the original cluster, and then take the virtual machine configuration resources Offline.

7. If you are going to reuse the same storage for the new cluster, mask it from the original cluster, and then make it available to the new (Windows Server 2008 R2) cluster.

8. Depending on what you did in step 5, follow one of these steps to move the virtual machines into the new Windows Server 2008 R2 Cluster.

    > [!IMPORTANT]
    > If you are moving your virtual machines to a CSV disk, follow the steps in the [Migrate a virtual machine from a non-CSV disk to a CSV disk](#migrate-a-virtual-machine-from-a-non-csv-disk-to-a-csv-disk) section.
    1. If you used step 5a to export the virtual machines above, import the virtual machines back to the cluster nodes.
    2. If you use step 5b to back up the virtual machines, use a backup application to restore the virtual machine to the clustered disk.

9. For each of the virtual machines that are now in this Windows Server 2008 R2 cluster, update the Integration Services. To do this, turn on the virtual machine, open the Virtual Machine Connection window, and then click **Insert Integration Services Setup Disk** on the **Action** menu.

    > [!NOTE]
    > On Windows Server 2008 R2, the Integration Services for Windows Vista and Windows Server 2008 will be listed in Programs and Features as KB955484.

10. When all virtual machines are running on the Windows Server 2008 R2 cluster and everything has been tested and verified as fully functional, use Failover Cluster Manager to remove the old cluster. To do this, **right-click** the cluster in Failover Cluster Manager, click **More Actions**, and then click **Destroy Cluster**.

11. For the remaining nodes that were in the old cluster, perform a clean installation of Windows Server 2008 R2, and then enable the Hyper-V role and the Failover Clustering feature as required. Join these nodes to the new cluster.

### Migrate a virtual machine from a non-CSV disk to a CSV disk

1. Export the virtual machines. Use one of the following options, depending on how much control you want over where your virtual hard disks are stored:

    1. If you want Hyper-V Manager to move the virtual hard disks along with the virtual machine configuration, select **Export** on the **Action** menu in Hyper-V Manager, and then specify the folder that you want to export the virtual machine to. If you are running Windows Server 2008 Hyper-V, make sure that the **Export only the virtual machine configuration** check box is not selected.

    2. If you want complete control over where the virtual hard disks are placed during the migration, export the virtual machine to the CSV Folder by selecting **Export** on the **Action** menu in Hyper-V Manager. Select **Export only the virtual machine configuration**.

2. From Virtual Machine Manager, delete the virtual machine.

3. To add the storage to the cluster's "Available Storage" group, select the **Storage** node in the left navigation pane, and then click **Add Storage**. To make a disk a Cluster Shared Volume, enable the Cluster Shared Volumes feature from the Failover Cluster's **Overview** page, select the **Cluster Shared Volumes** node in the left navigation pane, select **Add Storage**, and then specify a disk. This disk will be added to the Cluster Shared Volumes group and a directory, such as C:\ClusterStorage\Volume4, will be created for this group.

4. If you used step 1b to export your virtual machine, follow steps in the "Exporting and importing virtual machines in clustered environments" section. Otherwise, import the virtual machine by using the Import user interface in Hyper-V Manager.

5. From Failover Cluster Manager, make the virtual machine highly available.
