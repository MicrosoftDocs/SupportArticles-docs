---
title: Error 0x19 when NTFS creates name in 8.3 format
description: Fixes a problem in which you may receive a Stop error 00000019 (Error 0x19) when NTFS generates a 8.3-formatted name for a file that has a long file name.
ms.date: 09/18/2020
author: Delead-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, bharathm, stevenxu
ms.prod-support-area-path: Blue Screen/Bugcheck
ms.technology: Performance
---
# Error message on a Windows Server 2003-based computer: "Stop error code 0x00000019"

This article provides workarounds for an issue where you receive a Stop error 00000019 when NTFS generates a 8.3-formatted name for a file that has a long file name.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 948289

## Symptoms

You may receive a Stop error message that resembles the following on a Windows Server 2003-based computer:

STOP: 0x00000019 (**parameter1**, **parameter2**, **parameter3**, **parameter4**)
BAD_POOL_HEADER

Notes
- The parameters in this Stop error message vary, depending on the configuration of the computer and on the type of the issue.
- Not all "0x00000019" Stop errors are caused by this problem.

## Cause

This problem occurs because the pool memory is unexpectedly corrupted. This problem occurs when the NTFS file system creates a name in the 8.3 name format for a file that has a long file name.

## Workaround

To work around this problem, disable 8.3 name creation. To do this, use one of the following methods.

### Method 1

1. Run the following command at a command prompt: fsutil behavior set disable8dot3 1 

2. Restart the computer.

### Method 2

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Click **Start**, click **Run**, type regedit, and then click **OK**.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`
3. Right-click **NtfsDisable8dot3NameCreation**, and then click **Modify**.
4. In the **Value data** box, type 1, and then click **OK**.

    > [!NOTE]
    > The default value is 0.
5. Exit Registry Editor.
6. To make this registry change effective, restart the computer.

## Status

Microsoft has confirmed that this is a problem. 

## More information

It is not recommended that this registry key is placed on servers unless the customer has submitted the Memory dump file to Microsoft for analysis and the root cause has been determined.

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[946226](https://support.microsoft.com/help/946226) FIX: You receive a "Stop 0x00000019" error message or a "Stop 0x000000c4" error message when you access NFS resources by using User Name Mapping  

[934326](https://support.microsoft.com/help/934326) FIX: Stop error message when you run the Client for NFS service in Microsoft Windows Services for UNIX 3.5: "Stop 0x00000019"

[935920](https://support.microsoft.com/help/935920) When the Emulex Elxsli2.sys driver is installed, you may receive a Stop error message after you upgrade your computer to Windows Server 2003 Service Pack 1  

[931479](https://support.microsoft.com/help/931479) The print server experiences a Stop error when you use the Point and Print feature to print to a shared printer in Windows Vista  

[925259](https://support.microsoft.com/help/925259) Error message when a Delayed Write Failure event is reported in Windows Server 2003: "Stop 0x00000019 - BAD_POOL_HEADER" or "Stop 0xCD PAGE_FAULT_BEYOND_END_OF_ALLOCATION"

[905795](https://support.microsoft.com/help/905795) When you try to control a Systems Management Server 2003 client from a remote location, you experience a Stop error on the Systems Management Server 2003 client  

[892260](https://support.microsoft.com/help/892260) You may receive a "STOP: 0x00000019" error message on a Windows Server 2003-based computer  

[295624](https://support.microsoft.com/help/295624)"Stop 0x00000050" or "Stop 0x00000019" While Printing Extended Characters to a PostScript Printer
