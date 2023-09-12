---
title: Errors when you back up VMs that belong to a guest cluster
description: Address errors that occur when you try to back up VMs that belong to a guest cluster.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:backup-and-restore-of-virtual-machines, csstroubleshoot
ms.technology: hyper-v
---
# Errors when backing up VMs that belong to a guest cluster in Windows

This article helps fix errors that occur when you try to back up Virtual Machines (VMs) that belong to a guest cluster by using shared virtual disk (VHDS).

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4230569

## Symptoms

When you use a third-party backup application to back up your VM that is in a guest cluster by using shared VHDS, you may receive one or more of the following error messages:

- Error 1

    > Error code: '32768'. Failed to create checkpoint on collection 'Hyper-V Collection'

- Error 2

    > Error code: '32770'. Active-active access is not supported for the shared VHDX in VM group

- Error 3

    > Error code: '32775'. More than one VM claimed to be the owner of shared VHDX in VM group 'Hyper-V Collection'

- Error 4

    > Error   Event 19100   Hyper-V-VMMS 19100    'BackupVM' background disk merge failed to complete: General access denied error (0x80070005)

## Cause and resolution

- For error 1

    This issue occurs because Windows can't query the cluster service inside the guest VM. To fix this issue, make sure that the cluster feature is installed on all guest VMs and is running.

- For error 2

    This issue occurs because the VHDS disk is used as a Cluster Shared Volume (CSV), which cannot be used for creating checkpoints. To fix this issue, you need to use each disk as a shared disk instead of as a Cluster Shared Volume. This can be done by using the **Remove from Cluster Shared Volume** option.

- For error 3

    This issue occurs because the shared drive was offline in the guest cluster. To fix this issue, make sure that all shared drives in the cluster that are part of the backup are online.

    If you're using Windows Server 2012 R2 or an earlier version of Windows Server, it isn't supported to use it with VHD Set disks as shared storage.

- For error 4

    This issue occurs because of a permission issue. To fix this issue, the folder that holds the VHDS files and their snapshot files must be modified to give the VMMS process additional permissions. To do this, follow these steps.

    1. Determine the GUIDS of all VMs that use the folder. To do this, start PowerShell as administrator, and then run the following command:

        ```powershell
        get-vm | fl name, id
        ```

        Output example:

        > Name : BackupVM  
        Id : d3599536-222a-4d6e-bb10-a6019c3f2b9b

        > Name : BackupVM2  
        Id : a0af7903-94b4-4a2c-b3b3-16050d5f80f

    2. For each VM GUID, assign the VMMS process full control by running the following command:

        ```console
        icacls <Folder with VHDS> /grant "NT VIRTUAL MACHINE\<VM GUID>":(OI)F
        ```

        Example:

        ```console
        icacls "c:\ClusterStorage\Volume1\SharedClusterDisk" /grant "NT VIRTUAL MACHINE\a0af7903-94b4-4a2c-b3b3-16050d5f80f2":(OI)F icacls "c:\ClusterStorage\Volume1\SharedClusterDisk" /grant "NT VIRTUAL MACHINE\d3599536-222a-4d6e-bb10-a6019c3f2b9b":(OI)F
        ```
