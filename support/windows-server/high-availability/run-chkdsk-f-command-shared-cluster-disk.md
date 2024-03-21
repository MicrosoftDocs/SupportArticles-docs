---
title: Run chkdsk /f command on shared cluster disk
description: Describes how to run the chkdsk /f command on a shared cluster disk.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, stevemat, CTIMON
ms.custom: sap:Clustering and High Availability\Root cause of an unexpected failover, csstroubleshoot
---
# Run the chkdsk /f command on a shared cluster disk

This article describes how to run the `chkdsk /f` command on a shared cluster disk.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 176970

## Summary

When you try to run the `chkdsk /f` or `chkdsk /f /r` command on a shared cluster drive, Chkdsk may not run and may state that the drive could not be locked for exclusive use. If you schedule Chkdsk to run after the computer restarts, Chkdsk may generate the following error message during the startup process:

> Cannot determine file system on drive \??\ **drive letter**.

## More information

Under most circumstances, running Chkdsk with the `/F` or `/R` switch requires the computer to be restarted because of open handles on the shared disk. Typically, there are no services or drivers running that prevent autochk (a derivative of Chkdsk) from checking the disk when the computer restarts. However, if you are using Windows Clustering, the file system does not mount the shared disk until the Cluster service starts because the owner of the shared disk is unknown. This causes Chkdsk to report that it cannot determine the file system on a shared cluster disk. Running Chkdsk in Read-Only mode may seem to work, but Chkdsk does not fix any problems.

If you suspect that there is file corruption on the shared disk, use the following steps to close all open handles to the shared disk and run Chkdsk on the drive:

1. Quit all programs and stop all non-cluster-aware services.
2. Start the Cluster Administrator tool, right-click the cluster name, and then click **Properties**.
3. On the Quorum tab, note which hard disk is the quorum hard disk. If the hard disk on which you want to run Chkdsk contains the quorum log, temporarily move the quorum to another shared disk.
4. Use the Cluster Administrator tool to find the group that contains the shared hard disk on which you want to run Chkdsk.
5. After you find the physical disk resource on which you want to run Chkdsk, take the entire group offline, including the shared disk. This closes all of the handles to the physical disk. To take the group offline, right-click the group name, and then click **Take off-line**.
6. In the Cluster Administrator tool, click the shared disk on which you want to run Chkdsk, and then bring it online. To do this, right-click the disk resource, and then click **Bring on-line**.

    > [!NOTE]
    > If the dirty bit was previously set, Chkdsk may automatically run and the Physical Disk resource may take a while to come online. In Windows NT 4.0, you will see a Command Prompt window with Chkdsk running. In Windows 2000, if you open Task Manager you will see Chkdsk running as a process.

7. At a command prompt, change to a drive other than the drive on which you are attempting to run Chkdsk, and then type the `chkdsk **x**: /f /r` command, where **X** is the shared disk.

If you receive a **Disk cannot be locked** error message when you try to run Chkdsk, verify that all services and tools that have access to the drive are stopped, and then try to run Chkdsk again. Any running service or program that has an open handle to the drive can prevent Chkdsk from running. Windows 2000 and later versions of Windows can attempt to close open handles to the shared disk. If you are prompted to close open handles, press the Y key.

### If handles remain open or the cluster contains a single shared disk

If programs or drivers maintain an open handle to the shared disk, or if there is only a single shared disk (on which the quorum log is stored), you must take down the entire cluster. Doing this requires that you disable the clustering components temporarily so that the file system can mount the shared disk when you restart the node. You must also shut down the other nodes in the cluster so that they do not take ownership of the shared disk when the node restarts.

To do this, use the steps in the appropriate section.

#### Windows Server 2003

You must put the physical disk resource in maintenance mode before you run a "chkdsk /F" command against a volume on a Microsoft Windows Server 2003-based computer. You must do this to prevent the physical disk resource from going into a failed state.

#### Windows 2000

1. Quit all programs, stop all programs that are not cluster-aware, and then log on to the server with an account that has Administrative credentials.
2. Start Cluster Administrator, right-click **cluster name**, and then click **Properties**.
3. Click the **Quorum** tab, and then note which drive is the quorum disk. If the drive on which you want to run Chkdsk contains the quorum log, temporarily move the quorum disk to another shared drive.
4. Copy FSUtil.exe from the `%SystemRoot%\System32` folder on a Windows XP-or-later-based computer to the local drive on the Windows 2000-based computer.
5. On the Windows 2000-based computer, at a command prompt, change to the folder that contains FSUtil.exe, and then type the `fsutil dirty set drive:` command, where **drive** is the shared drive.
6. Use Cluster Administrator to find the group that contains the shared drive on which you want to run Chkdsk.
7. Right-click the group name, and then click **Take offline**. This takes the whole group offline, including the shared drive, and closes all the handles to the physical drive.
8. Right-click the Physical Disk resource, and then click **Bring Online**. This brings the drive online. Chkdsk runs on the volume, and it may be in an online pending state for a while.
9. After Chkdsk runs on the volume, bring all other resources in the group online.

#### Windows NT 4.0

1. Turn off node B.
2. Log on to node A as an administrator.
3. Run the `chkdsk /f` command on the shared disk. When you are prompted to schedule Chkdsk to run when the computer next restarts, press Y.
4. In the Devices tool in Control Panel, click **Cluster Disk**, and then click **Startup**.
5. Change the Startup type to **Disabled**.
6. In the Services tool in Control Panel, click the Cluster Server service, and then click **Startup**.
7. Change the Startup type to **Disabled**.
8. Quit Control Panel, and then restart node A. Chkdsk runs without interference from the Cluster Disk driver or any other service.
9. After Chkdsk is finished, change the Startup type back to its original setting, and then restart the computer to activate the cluster.
10. Turn on node B.
