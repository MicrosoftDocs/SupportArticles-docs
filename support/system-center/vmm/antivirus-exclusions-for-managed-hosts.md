---
title: Antivirus exclusions for VMM and managed hosts
description: Describes recommended antivirus exclusions for Virtual Machine Manager and managed hosts.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Recommended antivirus exclusions for System Center Virtual Machine Manager and managed hosts

If antivirus software is running on the Microsoft System Center Virtual Machine Manager (VMM) server or the managed hosts, including Scale-Out File Servers (SOF), antivirus exclusions should be set. This article describes the antivirus exclusions as they pertain to the VMM server itself and to the hosts that are managed by VMM.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3119208

## Set antivirus file type exclusions

We recommend that you set the following antivirus file type exclusions for the VMM server, the VMM libraries, and the managed hosts:

- All VHD, VHDX, AVHD, AVHDX, VSV, and ISO files that are stored in the VMM libraries and library shares.

- All VHD, VHDX, AVHD, AVHDX, VSV, and ISO files that are stored on the Hyper-V hosts and host clusters. These file types are typically found in the following locations:

  - Default virtual machine configuration directory and its subdirectories, if they're used
    - `C:\ProgramData\Microsoft\Windows\Hyper-V`

  - Default virtual machine virtual hard disk files directory and its subdirectories, if they're used
    - `C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks`

  - Default snapshot files directory and its subdirectories, if they're used
    - `C:\ProgramData\Microsoft\Windows\Hyper-V\Snapshots`

  - Default Cluster Shared Volumes (CSV) paths and any subdirectories if you use Cluster Shared Volumes.
    - `C:\ClusterStorage`

      The method for setting exceptions for cluster CSV volumes has changed. We no longer set the path `C:\ClusterStorage\volume(x)`. The new method is to set the exclusion using the Volume ID. The volume ID can be determined by opening an elevated command prompt and running the `mountvol` command. A sample output would look like this:
  
      > \\\\?\Volume{83843316-a7f8-4cf7-b8c3-003186740fbd}\  
      > C:\ClusterStorage\Volume1\  
  
      In this case, the antivirus exception would be for \\\\?\Volume{83843316-a7f8-4cf7-b8c3-003186740fbd}\

  - Any applicable custom virtual hard disk drive directories.

  - Any custom replication data directories if you use Hyper-V replica or protect virtual machine workloads in Azure (for example, Azure Site Recovery Services).

## More information

- If you're storing virtual machine files on Server Message Block (SMB) 3.0 file shares and have antivirus software that's running on your file servers, set the appropriate exclusions (as noted earlier) on the file server.

- The following two Hyper-V processes may have to be set as process exclusions in the antivirus software on all Hyper-V hosts:

  - Vmms.exe
  - Vmwp.exe

- If virtual machines are missing from the Hyper-V Management console, you must set the antivirus exclusions and then restart the Hyper-V Virtual Machine Management service.

- If you receive error code 0x800704C8, the virtual machine configuration file was likely corrupted. If you receive this error and can't fix the issue by restarting the Hyper-V Virtual Machine Management service, the virtual machine must be re-created or restored from a backup.

- The following System Center Virtual Machine Manager processes may have to be set as process exclusions in the Antivirus software on all System Center Virtual Machine Manager servers:

  - Vmmservice.exe
  - VmmAgent.exe
  - VmmAdminUI.exe
