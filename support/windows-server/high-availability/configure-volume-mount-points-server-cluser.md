---
title: Configure volume mount points on a server cluster
description: Describes how to configure volume mount points on a server cluster.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.technology: windows-server-high-availability
---
# Configure volume mount points on a server cluster in Windows Server

This article describes how to create volume mount points on a server cluster by using the NTFS volume mount points functionality.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 947021

## Summary

By using volume mount points, you can graft or mount a target partition onto a folder on another physical disk. You can also exceed the 26-letter limitation for drive letter references.

You can use the following methods to add mount points in Windows Server.

> [!NOTE]
> These methods are the same for clustered or nonclustered computers.  
>
> - Use Logical Disk Manager (Diskmgmt.msc).
> - Use Mountvol.exe at a command prompt.
> - Write your own .exe file by using the Win32 SetVolumeMountPoint and DeleteVolumeMountPoint functions.

## More information

When you create a volume mount point on a Windows Server failover cluster, you must consider the following key items:  

- A volume mount point cannot be created between clustered and nonclustered disks.
- You cannot create a volume mount point on the witness disk or on the disk that is used for the "No Majority: Disk only" quorum type.
- Volume mount points are transparent to programs.

### How to set up volume mount points on the disks that are not a resource in the cluster

1. Log on to the local computer by using administrative rights to the cluster node that hosts both the mount point and the volume for the mount point.
2. On each node of the cluster, use the Disk Management console to make sure that only one node has each disk in the "online" state. The disks should be online on the same node and on only that node.
3. On the disk that will host the volume for the mount point, follow these steps:  

      1. In the middle pane of the Disk Management console, right-click the disk item where the disk number is shown, and then click **Online** if the disk is not already online.
      2. Right-click the disk item again, and then click **Initialize Disk** if the disk is not already initialized.
      3. If the disk does not have a volume, complete steps 3d-3g. If the disk has a volume, go to step 3h.
      4. Right-click some unallocated space, and then click **New Simple Volume**.
      5. When the New Simple Volume Wizard starts, click **Next**, enter the volume size, and then click **Next**.
      6. On the **Assign Drive Letter or Path** screen, assign a drive letter, and then click **Next**.
      7. Format the partition by using the NTFS file system, click **Next**, and then click **Finish**.
      8. If the volume does not have a drive letter, complete steps 3i-3j. If the volume has a drive letter, go to step 4.
      9. Right-click the disk, and then click **Change Drive Letter and Paths**.
      10. Click **Add**, assign a drive letter, and then click **OK**.
4. On the disk that will host the mount point, follow these steps:  

      1. In the middle pane of the Disk Management console, right-click the disk item where the disk number is shown, and then click **Online** if the disk is not already online.
      2. Right-click the disk item again, and then click **Initialize Disk** if the disk is not already initialized.
      3. If the disk does not have a volume, complete steps 4d-4i. If the disk has a volume, go to step 4j.
      4. Right-click some unallocated space, and then click **New Simple Volume**.
      5. When the New Simple Volume Wizard starts, click **Next**.
      6. Enter the volume size, and then click **Next**.
      7. On the **Assign Drive Letter or Path** screen, click **Mount in the following empty NTFS folder**, and then click **Browse**.
      8. Expand **X:**, where X represents the root drive that hosts the mount point. Select an empty folder or create a new folder, click **OK**, and then click **Next**.
      9. Format the partition by using the NTFS file system, click **Next**, and then click **Finish**.
      10. Make sure that the volume does not have a drive letter assigned to it.
      11. Right-click the disk, click **Change Drive Letter and Paths**, and then click **Add**.
      12. Click **Mount in the following empty NTFS folder**, and then click **Browse**.
      13. Expand the root drive that hosts the volume for the mount point. Select an empty folder, or create a new folder, and then click **OK** two times.  

5. Follow these steps to add the following disks to the cluster:
   - The disk that contains the mount point
   - The disk that hosts the volume for the mount point  

      1. Open the Failover Cluster Management snap-in. To do this, click **Start**, click **Administrative Tools**, and then click **Failover Cluster Management**. If the **User Account Control** dialog box appears, confirm that the action that it displays is what you want, and then click **Continue**.
      2. In the navigation pane, click **Storage**.
      3. In the **Actions** pane, click **Add a Disk**.
      4. Select the disk that hosts both the mount point and the volume for the mount point, and then click **OK**. Both disks now appear in the **Available Storage** area of the storage pane.
      5. Right-click the disk resource that hosts the mount point, and then click **Properties**.

      6. In the **Dependencies** tab, click the **Resource** column.
      7. Click the root disk, click **Apply**, and then click **OK**. This dependency will cause the resource to come online after the disk resource that hosts the mount point is successfully brought online.

6. Right-click the newly added disk resources, and then click **More actions**.
7. Click **Move this resource to Another Service or application** to move the resource to the appropriate application or service group.

### How to set up volume mount points on the clustered disks

> [!NOTE]  
>
> - Follow these steps on the node on which the "Services and Applications" group is hosted.
> - In these steps, volume N and volume Y already exist in the same "Cluster Service and Application" group.
> - Volume N represents the volume that will host the mount point folder. Volume Y represents the volume that is being mounted by the mount point. Volume Y does not require an assigned drive letter before you follow these steps.
> - If you receive a "parameter is incorrect" error message when you access Disk Management on one of the nodes in your server cluster, exit Disk Management, start Failover Cluster Manager, navigate to **Storage**, and then put volume N into **Maintenance Mode**.  

1. In the middle pane of the Disk Management console of the cluster node that owns both volumes N and Y, right-click volume Y, and then click **Change Drive Letter and Paths**.
2. Click **Add**, click **Mount in the following empty NTFS folder**, and then click **Browse**.
3. Click volume N, click **New Folder**, type a name for the new folder, and then click **OK** two times to return to the Server Manager console.
4. Open the Failover Cluster Management console.
5. Test the mount point on each node by moving the "Service and Application" group that holds both of the disk resources to each node. Make sure that the disks come online on each node and that the information in the volume that was mounted can be accessed through Windows Explorer or by using the command line and the "N:\\\<mount point folder name>" path.

### Best practices when you use volume mount points

- Create a dependency in the mounted volume disk resource that specifies the disk that is hosting the mount point folder. This makes the mounted volume dependent on the host volume, and it makes sure that the host volume comes online first.

    > [!NOTE]
    > This practice is no longer necessary in Windows Server 2008 and later versions of Windows.  

- If you move a mount point from one shared disk to another shared disk, make sure that the shared disks are located in the same group.
- Try to use the root (host) volume exclusively for mount points. The root volume is the volume that hosts the mount points. This practice greatly reduces the time that is required to restore access to the mounted volumes if you have to run the Chkdsk.exe tool. This also reduces the time that is required to restore from backup on the host volume.
- If you use the root (host) volume exclusively for mount points, the size of the host volume must be at least 5 megabytes (MB). This reduces the probability that the volume will be used for anything other than the mount points.
- In a cluster where high availability is important, you can make redundant mount points on separate host volumes. This helps guarantee that if one root (host) volume is inaccessible, you can still access the data that is located on the mounted volume through the other mount point. For example, if HOST_VOL1 (D :) is located on Mountpoint1, user data is located on LUN3. Then, if HOST_VOL2 (E:) is located on Mountpoint1, user data is located on LUN3. Therefore, customers can access LUN3 by using either D:\\mountpoint1 or E:\\mountpount1.

    > [!NOTE]
    > Because the user data that is located on LUN3 depends on both the D and E volumes, you must temporarily remove the dependency of any failed host volume until the volume is back in service. Otherwise, the user data that is located on LUN3 remains in a failed state.
