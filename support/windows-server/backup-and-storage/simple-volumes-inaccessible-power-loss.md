---
title: Simple volumes become inaccessible
description: Provides a resolution for the issue that simple volumes may become inaccessible if a power loss occurs shortly after creation.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# Simple volumes may become inaccessible if a power loss occurs shortly after creation

This article provides a resolution for the issue that simple volumes may become inaccessible if a power loss occurs shortly after creation.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2001877

## Symptoms

Consider the following scenario. In Windows 7, you create a new simple volume in Disk Management or DiskPart.exe on a non-removable disk.  If your Windows 7 system experiences a sudden power loss within a few minutes of volume creation, you may notice the volume you created before the power loss is inaccessible and is not assigned a drive letter when you power the system back on.  

Additionally, in Disk Management the volume may not have a status (for example, "Healthy") or a file system type listed.  If you try to modify the volume in Disk Management, you may receive the following error message:  
>The operation failed to complete because the Disk Management console view is not up-to-date.  Refresh the view by using the refresh task.  If the problem persists close the Disk Management Console, then restart Disk Management or restart the computer.

## Cause

This issue occurs because the configuration information for the new volume was not written to disk by the time the power loss occurred.

## Resolution

If you are experiencing the issue described in the "Symptoms" section, reinstalling the volume will resolve the issue.  Follow these steps to reinstall the volume.  

1. Open Device Manager.  You can access Device Manager by typing "Device Manager" or "devmgmt.msc" in the Start Search box.
2. Once Device Manager is open, click on "Storage Volumes" to expand the Storage Volumes portion of the device tree.
3. Under Storage Volumes, you should notice a volume listed as "Unknown device."  Right click on this device and choose "Uninstall."  When asked to confirm, choose OK.
4. Restart the system if you are prompted to do so.  The volume should be accessible once the system finishes restarting.  If you are not prompted to restart the system, right click in Device Manager and choose "Scan for hardware changes."  Once the scan is complete and installation of the volume completes, you will be able to access the volume.

    > [!Note]
    > If the power loss occurs within a few seconds of volume creation, in rare circumstances you may be prompted to format the volume after you follow the above steps.  If this occurs, the file system configuration was not written by the time the power loss occurred.  You may need to reformat or recreate the volume.

If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).
