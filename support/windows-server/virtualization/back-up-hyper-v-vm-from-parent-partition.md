---
title: Back up virtual machines from parent partition
description: Describes how to back up Hyper-V virtual machines by using Windows Server Backup on a Windows Server computer. Step-by-step instructions are provided.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jeffpatt
ms.custom: sap:backup-and-restore-of-virtual-machines, csstroubleshoot
---
# How to back up Hyper-V virtual machines from the parent partition on a Windows Server computer by using Windows Server Backup

This article describes how to back up Hyper-V virtual machines from the parent partition on a Windows Server computer by using Windows Server Backup.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 958662

## Problem description

To back up Hyper-V virtual machines from the parent partition on Windows Server by using Windows Server Backup, you must register the Microsoft Hyper-V VSS writer with Windows Server Backup.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To register the Hyper-V VSS writer with Windows Server Backup, follow these steps:  

1. Click **Start**, click **Run**, type **regedit**, and then click **OK**.

2. Locate the following registry key:
 `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion`  

3. Right-click **CurrentVersion**, point to **New**, and then click **Key**.

4. Type WindowsServerBackup, and then press ENTER.

5. Right-click **WindowsServerBackup**, point to **New**, and then click **Key**.

6. Type Application Support, and then press ENTER.

7. Right-click **Application Support**, point to **New**, and then click **Key**.

8. Type **{66841CD4-6DED-4F4B-8F17-FD23F8DDC3DE}**, and then press ENTER.

9. Right-click **{66841CD4-6DED-4F4B-8F17-FD23F8DDC3DE}**, point to **New**, and then click **String Value**.

10. Type Application Identifier, and then press ENTER.

11. Right-click **Application Identifier**, and then click **Modify**.

12. In the **Value data** box, type Hyper-V, and then click **OK**.

13. On the **File** menu, click **Exit**.

## More information about Hyper-V virtual machine backups

### Back up the virtual machines by using Windows Server Backup

- When you perform a backup of the virtual machines, you must back up all volumes that host files for the virtual machine, including the InitialStore.xml file (in C:\ProgramData\Microsoft\Windows\Hyper-V, by default) and the volume(s) containing the VHD(s) and configuration XML files. For example, if the virtual machine configuration files are stored on the D: volume, and the virtual machine virtual hard disk (VHD) files are stored on the E: volume, and InitialStore.xml file is stored on the C: volume, you must back up the C:, D: and E: volumes.
- Virtual machines that do not have Integration Services installed will be put in a saved state while the VSS snapshot is created.

- Virtual machines that are running operating systems that do not support VSS, such as Microsoft Windows 2000 or Windows XP, will be put in a saved state while the VSS snapshot is created.

- Virtual machines that contain dynamic disks (not dynamically expanding) must be backed up offline.

> [!NOTE]
> Windows Server Backup does not support backing up Hyper-V virtual machines on Cluster Shared Volumes (CSV volumes).

### Restore virtual machines by using Windows Server Backup

To restore the virtual machines, follow these steps:  

1. Start Windows Server Backup in Administrative Tools.
2. On the **Actions** menu, click **Recover**.
3. Select the server that you want to recover data from, and then click **Next**.
4. Select the date and time that you want to restore from, and then click **Next**.
5. Select the **Applications** recovery type, and then click **Next**.
6. Select **Hyper-V**, and then click **Next**.
7. Select the restore location, and then click **Next**.
8. Click **Recover** to start the restore process.
    > [!NOTE]
    > All volumes that host files for the virtual machine will be restored. Individual virtual machines cannot be restored by using Windows Server Backup.

Virtual machines that contain two or more snapshots will not be restored. To work around this issue, follow these steps:  

1. Start Hyper-V Manager in Administrative Tools.
2. Delete the virtual machine that was not restored.
3. Start Windows Server Backup in Administrative Tools.
4. On the **Actions** menu, click **Recover**.
5. Select the server that you want to recover data from, and then click **Next**.
6. Select the date and time that you want to restore from, and then click **Next**.
7. Select the **Files and folders** recovery type, and then click **Next**.
8. Select the directory where the snapshots are stored, and then click **Next**.

    > [!NOTE]
    > By default, the snapshots are located in the following directory:C:\ProgramData\Microsoft\Windows\Hyper-V\Snapshots

9. Select the location where the snapshots should be restored, and then click **Next**.
10. Click **Recover** to start the restore process.
11. After the restore has finished, perform another restore. However, use the **Applications** recovery type, and select **Hyper-V** to correctly restore the virtual machines.
