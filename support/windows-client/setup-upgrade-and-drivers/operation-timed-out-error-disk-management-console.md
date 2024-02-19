---
title: The operation timed out error
description: Helps to fix the error The operation timed out when creating a partition using Disk Management console or DiskPart.exe.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jburrage
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# "The operation timed out" error when creating a partition using Disk Management console or DiskPart.exe

This article helps to fix the error "The operation timed out" when creating a partition using Disk Management console or DiskPart.exe.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2826890

## Symptoms

- When you try to create a new volume in Disk Management (diskmgmt.msc), you may receive the following error message:

    >The operation failed to complete because the Disk Management console view is not up-to-date. Refresh the view by using the refresh task. If the problem persists, close the Disk Management console, then restart Disk Management or restart the computer.

- If you try to create a new partition using Diskpart.exe, you may receive an error message that is similar to the following ones:

    >Virtual Disk Service error:  
    The operation timed out.
    >
    >Diskpart has referenced an object which is not up-to-date.  
    Refresh the object by using the RESCAN command.  
    If the problem persists exit DiskPart, then restart DiskPart or restart the computer.

- Additionally, you may see a pop-up window with the following information:

    >Found New Hardware  
    Windows needs to install driver software for your Unknown Device  

## Cause

These problems occur if the volume.inf is missing from `%Systemroot%\inf` folder.

## Resolution

To resolve the problem, do the following steps:

1. Open an elevated Command Prompt. To do it, click Start, click All Programs, click Accessories, right-click Command Prompt, and then click Run as administrator.
2. At the command prompt, type the following command and then press Enter:
`sfc /verifyonly`  

3. If the above command returns stating problems were found, then type the following command and then press Enter. Let the command operation complete:  
`sfc /scannow`  

4. Open Windows Explorer and then navigate to `%Systemroot%\inf` folder
5. Verify if *volume.inf* file has been replaced. If the file is not replaced, then you need to copy volume.inf from another computer running the same version of Windows, same version of Service Pack, and same CPU architecture.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
