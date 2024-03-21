---
title: A volume shows up as raw in disk management
description: Provides solutions to an issue where a volume shows as raw in disk management but chkdsk shows the file system as NTFS after you extend the partition.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, robtm
ms.custom: sap:Backup, Recovery, Disk, and Storage\Partition and volume management , csstroubleshoot
---
# A volume may show up as raw in disk management after you extend the partition, but chkdsk shows the file system as NTFS

This article provides solutions to an issue where a volume shows as **raw** in disk management but chkdsk shows the file system as NTFS after you extend the partition.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2261358

## Symptoms

When you extend a volume by using FSExtend, the volume may show as **raw** in disk management. However, when you run chkdsk, the file system is shown as NTFS.

Additionally, you see the following error message in the System log:

> Log Name: System  
Source: Ntfs  
Event ID: 55  
Level: Error  
Description:  
The file system structure on the disk is corrupt and unusable. Please run the chkdsk utility on the volume \<driveletter>:

## Cause

The issue occurs because of one of the following reasons:

- The file system structure on the disk is corrupted.
- There is not enough disk space for the file system extend.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1

If there is too little disk space to mount the volume, shrink the NTFS transaction log to 4 MB. Then, the disk will have enough space to mount the volume. To do this, follow these steps.

1. To shrink the NTFS transaction log to 4 MB, run the following command:

    ```console
    chkdsk d: /l:4096 /f
    ```

2. Determine whether you can access the disk. If you can access the disk, you should free up some free space and then return the NTFS transaction log to the default value of about 65 MB. To do this, run the following command:

    ```console
    chkdsk d: /l: 65536 /f
    ```

### Method 2

Run the following command on the disk to fix any errors on the disk:

```console
chkdsk /f <drive>
```

After chkdsk is completed successfully, restart the server. Then, run FSExtend on the drive to extend the file system. To do this, run the following command:

```console
FSExtend <drive>
```

This should extend the file system on the drive, and the disk should be accessible.
