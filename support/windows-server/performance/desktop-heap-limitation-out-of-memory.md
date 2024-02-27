---
title: Desktop heap limitation causes out of memory error
description: This article describes the desktop heap limitation, and provides a method to modify the desktop heap size.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:system-hang, csstroubleshoot
---
# You may receive an error "Out of Memory" because of the desktop heap limitation

This article helps fix an "Out of Memory" error that occurs when you open many application windows in Windows.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 947246

## Symptoms

After you open many application windows in Windows, you may be unable to open any additional windows. A window may open sometimes, but it won't contain the expected components. Additionally, you receive an error message that resembles:

> Out of Memory

## Cause

This problem occurs because of the desktop heap limitation. When you close some windows, and then try to open other windows, these windows may open. However, this method doesn't affect the desktop heap limitation.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this problem, modify the desktop heap size by following these steps:

1. Click **Start**, type *regedit* in the **Start Search** box, and then select regedit.exe in the **Programs** list.

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, type your password, or click **Continue**.

2. Locate and then select the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\SubSystems` registry subkey.

3. Right-click the **Windows** entry, and then select **Modify**.

4. In the **Value data** section of the **Edit String** dialog box, locate the `SharedSection` entry, and then increase the second value and the third value for this entry.

    > [!NOTE]
    >
    > - The second value of the `SharedSection` registry entry is the size of the desktop heap for each desktop that is associated with an interactive window station. The heap is required for each desktop that is created in the interactive window station (WinSta0). The value is in kilobytes (KB).
    > - The third `SharedSection` value is the size of the desktop heap for each desktop that is associated with a *non-interactive* window station. The value is in kilobytes (KB).
    > - We don't recommend that you set a value that is over 20480 KB for the second `SharedSection` value.

By default, the Windows registry entry contains the following data in an x86-based version of Windows 7 Service Pack 1.

> %SystemRoot%\system32\csrss.exe  
ObjectDirectory=\Windows  
SharedSection=1024, 12288,512  
Windows=On  
SubSystemType=Windows  
ServerDll=basesrv,1  
ServerDll=winsrv:UserServerDllInitialization,3  
ServerDll=winsrv:ConServerDllInitialization,2  
ProfileControl=Off  
MaxRequestThreads=16

Windows 7 Service Pack 1 (64 bit) / Windows Server 2008 R2, 2012 R2 (64 bit)

> SharedSection=1024, 20480,768

Memory allocations are dynamic in later operating systems. There's no limitation for memory allocation. However, if you allocate too much memory to the desktop heap, negative performance may occur. It's why we don't recommend that you set a value that is over **20480**.

> [!NOTE]
> The desktop heap size isn't affected by the physical RAM on the computer. You can't improve the performance by adding physical RAM.

### Did this fix the problem

Check if the problem is fixed. If the problem isn't fixed, [contact support](https://support.microsoft.com/contactus/).

## References

[Desktop Heap Overview](/archive/blogs/kocoreinternals/desktop-heap-overview)
