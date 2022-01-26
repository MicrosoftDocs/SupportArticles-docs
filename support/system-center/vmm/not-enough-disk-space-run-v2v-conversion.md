---
title: No enough disk space to run a V2V conversion 
description: Discusses that a virtual-to-virtual conversion to a cluster shared volume fails in System Center 2012 Virtual Machine Manager because of insufficient disk space. Provides resolutions and workarounds.
ms.date: 07/17/2020
ms.reviewer: dewitth, ctimon, joouten
---
# Not enough disk space error when you run a V2V conversion to a CSV in Virtual Machine Manager

This article helps you fix an issue where a virtual-to-virtual conversion to a cluster shared volume fails in System Center 2012 Virtual Machine Manager because of insufficient disk space.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2960125

## Symptoms

When you try to perform a virtual-to-virtual (V2V) conversion to a cluster shared volume in Microsoft System Center 2012 Virtual Machine Manager, the cluster that you select may have a placement rating of zero (0) stars (unacceptable). In this situation, the Rating Explanation details window displays the following error message:

> There is not enough disk space on the available volumes due to disk reserves. Maximum disk space on the most appropriate volume, account for the host resource utilization and reserves (in megabytes): \<value1>  
> The virtual machine requires (in megabytes): \<value2>  
> The maximum space at the time of evaluation, after considering the virtual machine requirements (in megabytes): \<value1>

## Cause

This problem occurs because of a known issue in System Center 2012 Virtual Machine Manager and System Center 2012 R2 Virtual Machine Manager. In these programs, the host placement process considers only the space that is available on local volumes, not the space that is available on cluster shared volume (CSV) or cluster shared disk resources.

## Resolution

To resolve this problem, provide sufficient storage space for one node in the cluster. This space can be on any of the following devices:

- Virtual Machine Manager 2012: A virtual hard drive (VHD)
- Virtual Machine Manager 2012 R2: A file share, USB flash drive, or logical unit number (LUN)

## Workaround 1: For VMM 2012, VMM 2012 SP1, and VMM 2012 R2

To perform the V2V conversion, run the following Windows PowerShell script through the Virtual Machine Manager console window.

> [!NOTE]
>
> - Make sure that all volumes that you select for conversion are configured to use the dynamic VHD type. If any of the VHD types are Fixed, go to the [Create a dynamic VHD to expand local free space](#create-a-dynamic-vhd-to-expand-local-free-space) section under Workaround 3.
> - Make sure that the configuration file and VHD for the virtual machine are stored in the same location.

```powershell
$SourceVMHost = Get-SCVMHost -ComputerName "SourceVMHost"

$DestinationVMHost = Get-SCVMHost -ComputerName "Destination VM Host"

SourceVM = Get-SCVirtualMachine -VMHost $<SourceVMHost> -Name "SourceVM"

New-SCV2V -VM $SourceVM -VMHost $DestinationVMHost -Name "DestinationVM" -Path "C:\VMs" -MemoryMB 512 -RunAsynchronously
```

## Workaround 2: For VMM 2012, VMM 2012 SP1, and VMM 2012 R2

Add a new disk that has sufficient space as a local drive. This can be a new local disk, a USB flash drive, or an external disk such as a logical unit number (LUN) that was assigned from a storage area network (SAN). Alternatively create a file share on an existing disk and add this to Virtual Machine Manager, and provide this to the cluster as a storage option. This should be identified by the placement wizard as sufficient space. In the next wizard step, you can choose the CSV you intend to migrate to.

## Workaround 3: For VMM 2012 and VMM 2012 SP1 only

Add a new disk that has sufficient space as a local drive. This can be a new local disk or an external disk such as an LUN that was assigned from a storage area network (SAN). The following procedure creates a new local disk from a dynamically expanding VHD. If you will be using physical storage, go to the [Make the new storage available for placement in VMM](#make-the-new-storage-available-for-placement-in-vmm) section.

> [!NOTE]
> The dynamically expanding VHD will not be used for actual placement. Instead, it will let the free space check be completed successfully so that you can move to the next step in the wizard. In that next step, you can select another path, such as a CSV, for the virtualized server.

### Create a dynamic VHD to expand local free space

1. On the cluster to which you are adding space, select a node, and then start Server Manager.
2. Expand **Storage**, and then select **Disk Management**.
3. On the **Action** menu, select **Create VHD**.
4. For the **Location**, specify a local path and file name under which to store the VHD. For example, specify *D:\DynamicVHDforV2V.vhd*.
5. For **Virtual hard disk size**, select a size that is sufficiently large for your V2V requirements. For example, you might select **1TB** (1 terabyte).

    > [!NOTE]
    > To determine your free space requirements, see the **Volume Configuration** page of the V2V wizard. By selecting **Dynamic** as the **VHD Type**, you will require the smallest volume of space on the destination host. This will be about the size that is specified by the **Data Size** column. By selecting **Fixed**, you will require the most space, as represented by the **VHD Size (MB)** column.

6. For the **Virtual hard disk format**, select **Dynamic expanding**.

    > [!IMPORTANT]
    >
    > - The VHD is attached automatically and listed as a new disk in the bottom pane.
    > - Don't select **Fixed**. The **Fixed** option creates a VHD of the specified size and can fill the local hard disk. The **Dynamic expanding** option creates a minimally sized VHD (about 2 MB).

7. Right-click the **Disk #** option for the newly created disk, and then select **Initialize Disk**. Make sure that the new disk and MBR are selected, and then select **OK**.
8. After the disk is initialized, right-click the partition of the new disk that is shown as **Unallocated**, and then select **New Simple Volume**.
9. Continue through the remaining steps in the wizard and select the drive letter that you want. Then, select **Finish**.

### Make the new storage available for placement in VMM

1. Open the Virtual Machine Manager console, select the **Fabric** workspace, expand **Servers**, expand **All Hosts**, and then select the cluster node that was used in step 1 of the [Create a dynamic VHD to expand local free space](#create-a-dynamic-vhd-to-expand-local-free-space) section.
2. On the **Host** tab, select **Refresh**, and then verify that the **Refresh host cluster** job was completed successfully.
3. Open the **Properties** of the cluster node. On the **Hardware** tab, locate the new volume under **Storage**, and then select the **Available for placement** option. Verify that the **Change properties of a host volume** job was completed successfully.

### Start the V2V and redirect storage to the cluster shared volume

1. Start the V2V wizard, and then do the following steps:
   1. Reference the appropriate source virtual machine that is to be converted.
   2. Select the **Available for placement** option.
2. On the **Host** tab, select **Refresh**, and then verify that the **Refresh host cluster** job was completed successfully.
3. Open the **Properties** of the cluster node. On the **Hardware** tab, locate the new volume under **Storage**, and then select the **Available for placement** option. Verify that the **Change properties of a host volume** job was completed successfully.
4. Continue through the steps in the wizard. On the **Select Host** page, select the host that was used in step 1 of the [Create a dynamic VHD to expand local free space](#create-a-dynamic-vhd-to-expand-local-free-space) section.

    > [!NOTE]
    > This host should now have an acceptable rating.

5. Select **Next**.
6. In the list on the **Select Path** page, select the cluster storage resource that you want to use for final placement of the V2V virtual machine.
7. Continue through the remaining steps in the wizard, and select the appropriate options for your situation.
