---
title: A disk partition that was created immediately before power failure or system crash can't be formatted or used
description: Describes a problem in which you're unable to properly format or use a disk partition that was created immediately before a system crash or power failure.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# A disk partition that was created immediately before power failure or system crash can't be formatted or used

This article describes a problem in which you can't properly format or use a disk partition that was created immediately before a system crash or power failure.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2539626

## Symptoms

Consider the following scenario:

- Using Disk Management or DiskPart, you create a new partition on a disk.
- Shortly after creating the partition, the computer loses power or crashes and you're forced to reboot.

In this scenario, you may end up with a disk partition that doesn't have a drive letter assigned to it. The partition is unusable and you may receive errors when attempting to format the partition. You can successfully delete the partition, but you receive errors when trying to recreate a new partition in its place.

For example:

- In Disk Management, if you try to format the partition, you may receive the error message: "An unexpected error has occurred. Check the System Event Log for more information on the error. Close the Disk Management console, then restart Disk Management or restart the computer."
- In Disk Management, you can successfully choose "Delete Volume." However, if you then try to recreate it, by choosing "New Simple Volume," Disk Management hangs for a long time. After several minutes, you receive the error message: "The operation failed to complete because the Disk Management console view isn't up to date. Refresh the view by using the refresh task. If the problem persists close the Disk Management console, then restart Disk Management or restart the computer."

    The disk partition gets successfully recreated, but the volume never gets formatted, or associated with a drive letter.

- In DiskPart, you can use the `select partition` command to select the problematic partition, and the `delete partition` command to successfully delete it. However, if you then use a command such as "create partition primary" to recreate the partition, DiskPart hangs for a long time. After several minutes, you receive the following error message:

    > Virtual Disk Service error:  
    The operation timed out.
    >
    > DiskPart has referenced an object which is not up-to-date.  
    Refresh the object by using the RESCAN command.  
    If the problem persists exit DiskPart, then restart DiskPart or restart the computer.  

## Cause

This problem occurs because the computer created a new volume, but unexpectedly crashed or lost power before all the appropriate registry entries for the newly created volume device were successfully written to disk. As a result, the volume has been only partially installed. When you attempt to delete and recreate the volume, the creation fails because the old, improperly installed volume interferes with the creation of the new one.

## Resolution

1. Start Device Manager. (From the Start menu, right-click on Computer and select Properties. Then click on "Device Manager.")
2. Expand the Storage Volumes category.
3. In the Storage Volumes category, right-click on any devices labeled "Unknown device" and select Uninstall.
4. Close Device Manager.
5. Using Disk Management or DiskPart, delete the problematic partition.

You should now be able to successfully create and format the volume using Disk Management or DiskPart.
