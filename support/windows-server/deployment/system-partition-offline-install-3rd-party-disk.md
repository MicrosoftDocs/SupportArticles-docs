---
title: System Partition goes offline after installing third-party disk or Storage Management Software
description: Provides a resolution to an issue where System Partition goes offline after installing some third-Party Disk or Storage Management Software.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, adityah
ms.custom: sap:servicing, csstroubleshoot
---
# System Partition goes offline after installing some third-party disk or Storage Management Software

This article provides a resolution to an issue where System Partition goes offline after installing some third-party disk or Storage Management Software.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2419286

## Symptoms

- Issue 1

  When installing Hyper-V Role, you may get the following error:

  > Failure configuring windows features  
  Reverting changes  
  Do not turn off your computer

    Under CBS.log, look for the following log:

    > Process output: [l:100 [100]"The boot configuration data store could not be opened. The system cannot find the file specified."][gle=0x80004005]

- Issue 2

    When you run Cluster validation, Storage validation fails, under Cluster Validation Reports we can see the following error:

     > List all disks visible to one or more nodes (including non-cluster disks).  
     Prepare storage for testing  
     Preparing storage for testing on node Node1.contoso.com  
     Preparing storage for testing on node Node1  
     Failed to prepare storage for testing on node Node1 status 87  
     Failed to prepare storage for testing on node Node1 status 87  

- Issue 3

    When you run `Bcdedit /enum all`, you get the following error:

    > The boot configuration data store could not be opened. The system cannot find the file specified."  

    Look for the registry key HKEY_LOCAL_MACHINE\BCD00000000. If we check under HKLM, you will not find the key BCD00000000.

## Cause  

If some third-party storage disk or Storage Management software is installed, it may bring all the volume without drive letter offline.

Generally, 100-MB partition is system partition that contains Boot configuration Database and does not have a drive letter assigned.  

## Resolution

To solve this issue, use one of the following methods:

- From command prompt, run the following commands:

    ```console
    C:\\>Diskpart
    C:\Diskpart> List volume
    C:\Diskpart> Select volume 1 (Considering this is 100-MB system partition)
    c:\Diskpart> Online volume
    C:\Diskpart> exit
    ```

- From the Disk Management console, assign the drive letter to the 100-MB partition it should bring the disk online.

    To access Disk Management, open command prompt, run the following command:

    > C:\>Diskmgmt.msc

    Select the 100-MB volume; Right click on the volume Change drive letter & Path, assign a drive letter.

    Assigning the drive letter will ensure the volume not offline again after a reboot.

    The volumes may go offline if AUTOMOUNT is disabled either while using a third party storage software or if the user manually disabled the AUTOMOUNT for the volume. To check this, type the `DISKPART> automount` command after running diskpart in the administrator command prompt.

    Automatic mounting of new volumes is disabled.

    To enable AUTOMOUNT, run the following command

    ```console
    DISKPART> automount enable
    ```

    Reboot the server and the volume will not go offline.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
