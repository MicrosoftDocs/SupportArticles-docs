---
title: The system registry is no longer backed up to the RegBack folder starting in Windows 10 version 1803
description: Starting in Windows 10, version 1803, Windows no longer automatically backs up the system registry to the RegBack folder. System restore points include registry information.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# The system registry is no longer backed up to the RegBack folder starting in Windows 10 version 1803

_Original product version:_ &nbsp; Windows 10, version 2004, all editions, Windows 10, version 1909, all editions, Windows 10 Enterprise 2019 LTSC, Windows 10 Enterprise, version 1903, Windows 10 Enterprise, version 1809, Windows 10 Enterprise, version 1803, Windows 10 IoT Enterprise, version 1903, Windows 10 IoT Enterprise v1809, Windows 10 IoT Enterprise v1803, Windows 10 Pro, version 1903, Windows 10 Pro, version 1809, Windows 10 Professional, version 1803, Windows 10 Pro for Workstations, version 1903, Windows 10 Pro for Workstations, version 1809, Windows 10 Pro for Workstations, version 1803, Windows 10 Pro Education, version 1903, Windows 10 Pro Education, version 1809, Windows 10 Pro Education, version 1803, Windows 10 Education, version 1903, Windows 10 Education, version 1809, Windows 10 Education, version 1803, Windows 10 Home, version 1903, Windows 10 Home, version 1809, Windows 10 Home, version 1803, Windows 10, version 1903, all editions, Windows 10, version 1809, all editions, Windows 10, version 1803, all editions  
_Original KB number:_ &nbsp; 4509719

## Summary

Starting in Windows 10, version 1803, Windows no longer automatically backs up the system registry to the RegBack folder. If you browse to to the \Windows\System32\config\RegBack folder in Windows Explorer, you will still see each registry hive, but each file is 0kb in size.
![The Windows\System32\config\Regbak folder](./media/system-registry-no-backed-up-regback-folder/4510102_en_1.png)

## More information

This change is by design, and is intended to help reduce the overall disk footprint size of Windows. To recover a system with a corrupt registry hive, Microsoft recommends that you use a system restore point.
If you have to use the legacy backup behavior, you can re-enable it by configuring the following registry entry, and then restarting the computer: `HKLM\System\CurrentControlSet\Control\Session Manager\Configuration Manager\EnablePeriodicBackup` 
 **Type:** REG_DWORD
 **Value:** 1

Windows backs up the registry to the RegBack folder when the computer restarts, and creates a RegIdleBackup task to manage subsequent backups. Windows stores the task information in the Scheduled Task Library, in the Microsoft\Windows\Registry folder. The task has the following properties:![Properties for the RegIdleBackup task](./media/system-registry-no-backed-up-regback-folder/4510104_en_2.png)
