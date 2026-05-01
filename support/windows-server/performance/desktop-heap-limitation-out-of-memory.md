---
title: Desktop heap limitation causes out of memory error
description: This article describes desktop heap limitations, and provides a method to modify the desktop heap size.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:system performance\system performance (slow,unresponsive,high cpu,resource leak)
- pcy:WinComm Performance
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows</a>
---
# Desktop heap allocation failures may lead to graphical glitches, "out of memory" errors, and unexpected behaviors.

This article discusses the limitations of a resource known as the desktop heap. When this resource is depleted, it may lead to graphical glitches, out of memory errors, and unexpected behaviors.

_Original KB number:_ &nbsp; 947246

## Symptoms

When desktop heap is exhausted, you may see events in the event log such as:

```
  Log name: System
  Event ID: 243
  Level: Warning
  Source: Win32k
  Description: A desktop heap allocation failed.
```

In more recent versions of Windows, the event has been enriched to contain additional details:

```
  Log name: System
  Event ID: 243
  Level: Warning
  Source: Win32k
  Description: A desktop heap allocation failed. Process ID: 14012. Process name: conhost.exe. Thread ID: 14260. Session ID: 0
```

This event is logged only once per session, so it's possible for the event to have been logged several minutes or even hours before the user first began to notice symptoms.

Each session on the computer has its own desktop heap. Each user who logs on to the system has their own desktop heap. Session 0, the isolated session where background services run, has its own desktop heap.

When a user's desktop heap is depleted, that user may experience graphical glitches such as windows not appearing as expected. Or the window may appear but it may be missing some elements such as buttons, scroll bars, etc. 

The default size of the desktop heap is usually enough for most users, however desktop heap exhaustion can still occur when opening many application windows simultaneously.

When session 0's desktop heap is depeleted, it may have negative affects across the entire system that adversely affect all logged on users. Since session 0 is not supposed to have any graphical elements in it, because it is invisible to the user, session 0 purposely has a very small desktop heap compared to a standard user.

It is important to never ignore this warning, especially if the desktop heap exhuastion occurs in Session 0. Session 0 desktop heap exhaustion can be the root cause of many seemingly-unrelated behaviors and it can be very hard to diagnose.

Users may also see other generic "out of memory" error messages when this happens, as applications attempt to create new windows but fail to do so.

## Cause

This problem occurs because of the desktop heap limitation. When you close some windows, and then try to open other windows, these windows may open. However, this method doesn't affect the desktop heap limitation.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

> [!IMPORTANT]
> Under normal circumstances, it is not usually recommended to increase the size of the desktop heap. It should only be done when truly necessary. Also, session 0 desktop heap cannot be modified. The following applies only to user desktop heaps.


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
