---
title: Recommended antivirus exclusions for Hyper-V hosts
description: Describes the recommended antivirus exclusions for Hyper-V hosts. The purpose is for optimal operation of Hyper-V and the running virtual machines.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
---
# Recommended antivirus exclusions for Hyper-V hosts

This article describes the recommended antivirus exclusions for Hyper-V hosts for optimal operation.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 1909, Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3105657

## Summary

You may have antivirus software installed and running on a Hyper-V host. For optimal operation of Hyper-V and the running virtual machines, you should configure several exclusions and options. These configurations will help avoid issues, such as those that are described in the following article:

[Virtual machines are missing, or error 0x800704C8, 0x80070037, or 0x800703E3 occurs when you try to start or create a virtual machine](https://support.microsoft.com/help/961804).

Use the information that's provided in the [Configurations](#configurations) section to configure your antivirus software to coexist optimally with Hyper-V and your virtual machines.

> [!IMPORTANT]
> This article contains information that shows how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. These specific configuration changes should be made only on the following systems:
>
> - Physical systems that are configured to have the Hyper-V role enabled and that have virtual machines currently running
> - Physical systems that may be providing storage for the virtual machine files, such as a Windows Server File Server.

For specific guidance about how to configure your antivirus software, work with your antivirus vendor.

## Configurations

Configure the real-time scanning component within your antivirus software to exclude the following directories, files, and processes.

> [!NOTE]
> If you are using Windows Defender as an anti-malware solution on your server, you may not need to configure additional exclusions. For a list of Windows Defender automatic exclusions, see [List of automatic exclusions](/windows/security/threat-protection/windows-defender-antivirus/configure-server-exclusions-windows-defender-antivirus#list-of-automatic-exclusions).

### Files

All directories that contain the following files:

- Virtual Hard Disk file (`*.vhd`)

- Virtual Hard Disk v2 file (`*.vhdx`)

- Virtual Hard Disk snapshot file (`*.avhd`)

- Virtual Hard Disk v2 snapshot file (`*.avhdx`)

- VHD Set file (`*.vhds`)

- Virtual PMEM VHD file (`*.vhdpmem`)

- Virtual Optical Disk images (`*.iso`)

- Resilient Change Tracking file (`*.rct`)

- Modified Region Table file (`*.mrt`)

- Device state file (`*.vsv`)

    The processes that create, open, or update the file: vmms.exe, vmwp.exe, vmcompute.exe.

- Memory state file (`*.bin`)

    The processes that create, open, or update the file: vmwp.exe

- VM Configuration file (`*.xml`)

    The processes that create, open, or update the file: vmms.exe

- VM Configuration v2 file (`*.vmcx`)

    The processes that create, open, or update the file: vmms.exe

- VM Runtime State file (`*.vmrs`)

    The processes that create, open, or update the file: vmms.exe, vmwp.exe, vmcompute.exe.

- VM Guest State file (`*.vmgs`)

### Directory

- The default virtual machine configuration directory, if it's used, and any of its subdirectories:

    `%ProgramData%\Microsoft\Windows\Hyper-V`

- The default virtual machine virtual hard disk files directory, if it's used, and any of its subdirectories: 

    `%Public%\Documents\Hyper-V\Virtual Hard Disks`

- The default snapshot files directory, if it's used, and any of its subdirectories:

    `%SystemDrive%\ProgramData\Microsoft\Windows\Hyper-V\Snapshots`

- The default Cluster Shared Volumes path, if you're using Cluster Shared Volumes, and any of its subdirectories:

    `C:\ClusterStorage`

- Any custom virtual machine configuration directories, if applicable

- Any custom virtual hard disk drive directories, if applicable

- Any custom replication data directories, if you're using Hyper-V Replica

- If antivirus software is running on your file servers, any Server Message Block protocol 3.0 (SMB 3.0) file shares on which you store virtual machine files.

### Process

- Vmms.exe (`%systemroot%\System32\Vmms.exe`)

    This file may have to be configured as a process exclusion within the antivirus software.

- Vmwp.exe (`%systemroot%\System32\Vmwp.exe`)

    This file may have to be configured as a process exclusion within the antivirus software.

- Vmsp.exe (`%systemroot%\System32\Vmsp.exe`)

    Starting with Windows Server 2016, this file may have to be configured as a process exclusion within the antivirus software.

- Vmcompute.exe (`%systemroot%\System32\Vmcompute.exe`)

    > [!NOTE]
    > Starting with Windows Server 2019
