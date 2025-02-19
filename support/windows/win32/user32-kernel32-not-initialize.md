---
title: User32.dll or Kernel32.dll does not initialize
description: This article describes an issue in which an application that is executed by CreateProcess or CreateProcessAsUser may fail.
ms.date: 12/19/2023
ms.custom: sap:System Services Development\Process, thread, and DLL APIs
ms.reviewer: franki
ms.topic: troubleshooting
---

# User32.dll or Kernel32.dll does not initialize

This article describes an issue where an application that is executed by `CreateProcess` or `CreateProcessAsUser` may fail.

_Applies to:_ &nbsp; Microsoft Windows  
_Original KB number:_ &nbsp; 184802

## Symptoms

An application that is executed by `CreateProcess` or `CreateProcessAsUser` may fail, and you receive one of the following error messages:

> Initialization of the dynamic library \<system>\system32\user32.dll failed. The process is terminating abnormally.
Initialization of the dynamic library \<system>\system32\kernel32.dll failed. The process is terminating abnormally.

Additionally, the failed process returns exit code 128 or the following:

> error:ERROR_WAIT_NO_CHILDREN

## Cause

This failure occurs for one of the following reasons:

- The executed process does not have correct security access to the window station and desktop that are associated with the process.

- The system ran out of desktop heap.

## More information

- Cause 1

  The executed process does not have correct security access to the window station and desktop that are associated with the process.

  The lpDesktop member of the STARTUPINFO structure that is passed to `CreateProcess` or `CreateProcessAsUser` specifies the window station and desktop that are associated with the executed process. The executed process must have correct security access to the specified window station and desktop.

- Cause 2

  The system ran out of desktop heap.

  Every desktop object on the system has a desktop heap that is associated with it. The desktop object uses the heap to store menus, hooks, strings, and windows. In Windows Server 2003 and Windows XP 32-bit, the system allocates desktop heap from a system-wide 48 megabytes (MB) buffer. In addition to desktop heaps, printer drivers and font drivers also use this buffer.

  Desktops are associated with window stations. A window station can contain zero or more desktops. You can change the size of the desktop heap that is allocated for a desktop that is associated with a window station by changing the following registry value.

  > [!NOTE]
  > We do not recommend that you use the /3GB switch. The /3GB switch is specified in the Boot.ini file. The /3GB switch is supported only for 32-bit operating systems.
 `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\SubSystems\Windows`

In Windows Server 2003 and Windows XP 32-bit, the default data for this registry value will resemble the following (all on one line):

```console
%SystemRoot%\system32\csrss.exe ObjectDirectory=\Windows
SharedSection=1024,3072,512 Windows=On SubSystemType=Windows
ServerDll=basesrv,1 ServerDll=winsrv:UserServerDllInitialization,3
ServerDll=winsrv:ConServerDllInitialization,2 ProfileControl=Off
MaxRequestThreads=16
```

In different versions of Windows, the default data for this registry value will resemble the following:

- For Windows Vista RTM (32-bit)

    ```console
    SharedSection=1024,3072,512
    ```

- For Windows Vista SP1, Windows 7, Windows 8, Windows 8.1 (32-bit), and Windows Server 2008 (32-bit)

    ```console
    SharedSection=1024,12288,512
    ```

- For Windows Vista, Windows 7, Windows 8, Windows 8.1 (64-bit), Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2 (64-bit)

    ```console
    SharedSection=1024,20480,768
    ```

The numeric values that following `SharedSection=` control how the desktop heap is allocated. These `SharedSection` values are specified in kilobytes. There are separate settings for desktops that are associated with interactive and noninteractive window stations.

> [!NOTE]
> If you change the `SharedSection` values in the registry, you must restart the system for the changes to take effect.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

The first `SharedSection` value (1024) is the shared heap size common to all desktops. This includes the global handle table. This table holds handles to windows, menus, icons, cursors, and so on, and shared system settings. It is unlikely that you would ever have to change this value.

The second `SharedSection` value is the size of the desktop heap for each desktop that is associated with the **interactive** window station WinSta0. User objects such as hooks, menus, strings, and windows consume memory in this desktop heap. It is unlikely that you would ever have to change this value.

Each desktop that is created in the interactive window station uses the default desktop heap of 3,072 KB. By default, the system creates the following three desktops in Winsta0:

- Winlogon
- Default  

  The Default application desktop will be used by all the processes for which `Winsta0\default` is specified in the STARTUPINFO.lpDesktop structure member. When the lpDesktop structure member is NULL, the window station and desktop are inherited from the parent process. All services that are executed under the LocalSystem account with the Allow Service to Interact with Desktop  startup option selected will use `Winsta0\Default`. All these processes will share the desktop heap that is associated with the Default application desktop.

- Screen saver  

  The screen saver desktop is created in the interactive window station (WinSta0) when a screen saver is displayed.

The third SharedSection value is the size of the desktop heap for each desktop that is associated with a noninteractive window station. If this value is not present, the size of the desktop heap for noninteractive window stations will be same as the size that is specified for interactive window stations (that is, the second SharedSection value).

If only two SharedSection values are present, you can add a third value to specify the size of the desktop heap for desktops that are created in noninteractive window stations.

Every service process that is executed under a user account will receive a new desktop in a noninteractive window station that is created by the Service Control Manager (SCM). Therefore, each service that is executed under a user account will consume the number of kilobytes of desktop heap that is specified in the third SharedSection value. All services that are executed under the LocalSystem account when Allow Service to Interact with the Desktop is not selected share the desktop heap of the Default desktop in the noninteractive service windows station (Service-0x0-3e7$).

The total desktop heap that is being used in the interactive and noninteractive window stations must fit in the buffer.

Decreasing the second or third SharedSection value will increase the number of desktops that can be created in the corresponding window stations. Smaller values will limit the number of hooks, menus, strings, and windows that can be created in a desktop. On the other hand, increasing the second or third SharedSection  value will decrease the number of desktops that can be created. However, this will also increase the number of hooks, menus, strings, and windows that can be created in a desktop.

Because the SCM creates a new desktop in the noninteractive window station for every service process that is running under a user account, a larger third SharedSection  value will reduce the number of user account services that can run successfully on the system. The minimum that can be specified for the second or third SharedSection  value is 128. Any attempt to use a smaller value will instead use 128.

Desktop heap is allocated by User32.dll when a process needs user objects. If an application is not dependent on User32.dll, it will not consume desktop heap.

> [!NOTE]
> In Windows Server 2003, the specific event is logged in the System log when one of the following conditions is true:

- If the desktop heap becomes full, the following event is logged:

  ```output
  Event Type: Warning
  Event Source: Win32k
  Event Category: None
  Event ID: 243
  Date: Date
  Time: Time
  User: N/A
  Computer: ServerName
  Description: A desktop heap allocation failed.
  ```

  In this case, increase the desktop heap size.
- If the total desktop heap becomes the system-wide buffer size, the following event is logged:

  ```output
  Event Type: Warning
  Event Source: Win32k
  Event Category: None
  Event ID: 244
  Date: Date
  Time: Time
  User: N/A
  Computer: ServerName
  Description: Failed to create a desktop due to desktop heap exhaustion.
  ```

  In this case, decrease the desktop heap size.

In Windows Server 2003, a system-wide buffer is 20 MB when one of the following conditions is true:

- You are in a Terminal Services environment.
- The /3GB switch is specified in the Boot.ini file.

## Applies to

- Microsoft Windows XP Professional
- Microsoft Windows XP Home Edition
- Windows Vista Ultimate
- Windows Vista Enterprise
- Windows Vista Business
- Windows Vista Home Premium
- Windows 7 Ultimate
- Windows 7 Enterprise
- Windows 7 Professional
- Windows 7 Home Premium
- Windows 8 Enterprise
- Windows 8 Pro, Windows 8
- Windows 8.1 Enterprise
- Windows 8.1 Pro
- Windows 8.1
- Microsoft Windows Server 2003 Datacenter Edition (32-bit x86)
- Microsoft Windows Server 2003 Datacenter x64 Edition
- Microsoft Windows Server 2003 Enterprise Edition (32-bit x86)
- Microsoft Windows Server 2003 Enterprise x64 Edition
- Microsoft Windows Server 2003 Standard Edition (32-bit x86)
- Microsoft Windows Server 2003 Standard x64 Edition
- Windows Server 2008 Datacenter
- Windows Server 2008 Enterprise
- Windows Server 2008 R2 Datacenter
- Windows Server 2008 R2 Enterprise
- Windows Server 2008 Standard
- Windows Server 2012 Datacenter
- Windows Server 2012 Standard
- Windows Server 2012 R2 Datacenter
- Windows Server 2012 R2 Standard
