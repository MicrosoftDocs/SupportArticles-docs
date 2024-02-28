---
title: Retrieve data from Windows XP Mode VM
description: When you upgrade from Windows 7 to Windows 8, Windows XP Mode is installed on your machine, however Windows Virtual PC isn't present anymore. This issue occurs because Windows Virtual PC isn't supported on Windows 8. To retrieve data from the Windows XP Mode virtual machine, perform the steps listed in this article.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:nested-virtualization, csstroubleshoot
---
# How to retrieve data from a Windows XP Mode virtual machine on Windows 8 or Windows 10

This article provides methods to retrieve data from a Windows XP Mode virtual machine in Windows 10.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2724115

## Summary

With the end of extended support for Windows XP in April 2014, Microsoft has decided not to develop Windows XP Mode for Windows 8 and above. If you're a Windows 7 customer who uses Windows XP Mode and are planning a move to Windows 10, this article may be helpful to you.  

When you upgrade from Windows 7 to Windows 10, Windows XP Mode is installed on your machine, however Windows Virtual PC isn't present anymore. This issue occurs because Windows Virtual PC isn't supported on Windows 8 and above. To retrieve data from the Windows XP Mode virtual machine, use one of the following methods.

## Method 1

Mount the virtual hard disk that was attached to the Windows XP Mode virtual machine, and then extract the data from the mounted drive.

1. On the Windows 10 machine, locate your Windows XP Mode virtual hard disk. The default location is: %LocalAppData%/Microsoft/Windows Virtual PC/Virtual Machines/Windows XP Mode.vhd.
2. Right-click the virtual hard disk, and then select **Mount**.
3. The contents of the virtual hard disk will appear as a local drive on the Windows PC (for example, G:\\).  
4. Locate data that needs to be extracted, and copy the data to another location.  
5. To unmount the virtual hard disk, right-click the new local drive (for example, G:\\), and then select **Eject**.
6. Uninstall Windows XP Mode when all data has been retrieved.

## Method 2

Copy the Windows XP Mode virtual hard disks to another Windows 7 machine, and use Windows Virtual PC to run the virtual machine. Then extract the data from the virtual machine.

1. Copy your Windows XP Mode virtual hard disk (Default location: %LocalAppData%/Microsoft/Windows Virtual PC/Virtual Machines/Windows XP Mode.vhd), and the base virtual hard disk (default location: %ProgramFiles%\Windows XP Mode\Windows XP Mode base.vhd) from the Windows 10 PC to another Windows 7 PC.  
2. Ensure the base disk is copied to the exact same location as it existed on the previous Windows 7 PC (for example, C:\Program Files\Windows XP Mode\Windows XP Mode base.vhd).  
3. [Create a new virtual machine with Windows Virtual PC](/previous-versions/windows/it-pro/windows-7/ee449426(v=ws.10)). Then point to your Windows XP Mode virtual hard disk as the disk for the new virtual machine.  
4. Start the virtual machine, login, and copy any required data from the virtual machine to another location.  
5. Delete the virtual machine, and uninstall Windows XP Mode when all data is retrieved.  

    > [!Note]
    > The Windows XP Mode virtual hard disk will not work on Windows 8 and above as they does not provide the Windows XP Mode license. The Windows XP Mode license is a benefit provided on Windows 7 only.
