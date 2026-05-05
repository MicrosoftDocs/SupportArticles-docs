---
title: Fix Desktop Heap Limitation and Out of Memory Errors
description: Learn how to fix desktop heap limitations and resolve out of memory errors by modifying the desktop heap size.
ms.date: 05/05/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:system performance\system performance (slow,unresponsive,high cpu,resource leak)
- pcy:WinComm Performance
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Fix desktop heap allocation failures causing out of memory errors

This article discusses the limitations of a resource known as the desktop heap. When this resource is depleted, it can cause graphical glitches, out of memory errors, and unexpected behaviors.

_Original KB number:_ &nbsp; 947246

## Identify symptoms of desktop heap exhaustion

When the desktop heap is exhausted, you might see events in the event log such as:

```
  Log name: System
  Event ID: 243
  Level: Warning
  Source: Win32k
  Description: A desktop heap allocation failed.
```

In more recent versions of Windows, the event includes additional details:

```
  Log name: System
  Event ID: 243
  Level: Warning
  Source: Win32k
  Description: A desktop heap allocation failed. Process ID: 14012. Process name: conhost.exe. Thread ID: 14260. Session ID: 0
```

This event is logged only once per session, so it's possible for the event to be logged several minutes or even hours before the user first notices symptoms.

Each session on the computer has its own desktop heap. Each user who signs in to the system has their own desktop heap. Session 0, the isolated session where background services run, has its own desktop heap.

When a user's desktop heap is depleted, that user might experience graphical glitches such as windows not appearing as expected. Or the window might appear but it might be missing some elements such as buttons, scroll bars, and so on. 

The default size of the desktop heap is usually enough for most users, but desktop heap exhaustion can still occur when opening many application windows simultaneously.

When session 0's desktop heap is depleted, it can have negative effects across the entire system that adversely affect all signed in users. Since session 0 isn't supposed to have any graphical elements in it, because it's invisible to the user, session 0 purposely has a very small desktop heap compared to a standard user.

Never ignore this warning, especially if the desktop heap exhaustion occurs in Session 0. Session 0 desktop heap exhaustion can be the root cause of many seemingly unrelated behaviors and it can be very hard to diagnose.

Users might also see other generic "out of memory" error messages when this happens, as applications attempt to create new windows but fail to do so.

## Causes of desktop heap exhaustion

This problem occurs because of the desktop heap limitation. When you close some windows, and then try to open other windows, these windows might open. However, this method doesn't affect the desktop heap limitation. Session 0 is a special session. When desktop heap exhaustion occurs in session 0, it can lead to undesired and unexpected behaviors across the entire system.

## How to modify desktop heap size to fix errors

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).
> Under normal circumstances, don't increase the size of the desktop heap. Only increase it when necessary. Also, you can't modify the session 0 desktop heap. The following information applies only to user desktop heaps.

To resolve this problem, modify the desktop heap size by following these steps:

1. Select **Start**, type *regedit* in the **Start Search** box, and then select regedit.exe in the **Programs** list.

    > [!NOTE]
    > If you're prompted for an administrator password or for confirmation, type your password, or select **Continue**.

1. Locate and then select the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\SubSystems` registry subkey.

1. Right-click the **Windows** entry, and then select **Modify**.

1. In the **Value data** section of the **Edit String** dialog box, locate the `SharedSection` entry, and then increase the second value and the third value for this entry.

    > [!NOTE]
    >
    > - The second value of the `SharedSection` registry entry is the size of the desktop heap for each desktop that is associated with an interactive window station. The heap is required for each desktop that is created in the interactive window station (WinSta0). The value is in kilobytes (KB).
    > - The third `SharedSection` value is the size of the desktop heap for each desktop that is associated with a *non-interactive* window station. The value is in kilobytes (KB).
    > - Don't set a value that is over 20480 KB for the second `SharedSection` value.

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

Memory allocations are dynamic in later operating systems. There's no limitation for memory allocation. However, if you allocate too much memory to the desktop heap, negative performance might occur. It's why you shouldn't set a value that is over **20480**.

> [!NOTE]
> The physical RAM on the computer doesn't affect the desktop heap size. You can't improve the performance by adding physical RAM.