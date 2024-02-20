---
title: Error code 0x800f0922 when installing Windows updates
description: Helps resolve the 0x800f0922 (CBS_E_INSTALLERS_FAILED) error when installing Windows updates.
author: Deland-Han
ms.author: delhan
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ismael, v-lianna
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot, ikb2lmc
---
# Error 0x800f0922 caused by corrupted scheduled task when installing Windows updates

This article helps resolve the 0x800f0922 (CBS_E_INSTALLERS_FAILED) error that occurs when installing Windows updates.

When you install Windows updates, you receive the 0x800f0922 (CBS_E_INSTALLERS_FAILED) error.

In the *CBS.log* file, you see the following entries:

```output
Info,	CSI    00000c61 Begin executing advanced installer phase 38 index 2480 (sequence 2519)
    Old component: [l:0]''
    New component: [l:168 ml:169]'Microsoft-OneCore-SecureBootEncodeUEFI-Task, Culture=neutral, Version=10.0.14393.6078, PublicKeyToken=31bf3856ad364e35, ProcessorArchitecture=amd64, versionScope=NonSxS'
    Install mode: install
    Smart installer: FALSE
    Installer ID: {<InstallerID>}
    Installer name: 'Task Scheduler'
…
Error	CSI    00000c63 (F) Logged @: [l:26 ml:27]'JobsHandler::Install enter'
Error	CSI    00000c64 (F) Logged @: [l:34 ml:35]'JobsHandler::Install type=4 pass=4'
Error	CSI    00000c65 (F) Logged @: [l:36 ml:37]'IsScheduleServiceRunning queries SCM'
Error	CSI    00000c66 (F) Logged @: [l:37 ml:38]'IsScheduleServiceRunning returns true'
Error	CSI    00000c67 (F) Logged @: [l:23 ml:24]'InstallTaskOnline enter'
Error	CSI    00000c68 (F) Logged @: [l:49 ml:50]'InstallTaskOnline: RegisterTask failed 0x80070002'
Error	CSI    00000c69 (F) Logged @: [l:70 ml:71]'WmiCmiPlugin jobshandler.cpp(237): RegisterTask failed. HR=0x80070002.'
Error	CSI    00000c6a (F) Logged @: [l:57 ml:58]'WmiCmiPlugin plgutil.cpp(217): fnc failed. HR=0x80070002.'
Error	CSI    00000c6b (F) Logged @: [l:74 ml:75]'WmiCmiPlugin jobshandler.cpp(364): ForEachElementIn failed. HR=0x80070002.'
Error	CSI    00000c6c (F) Logged @: [l:86 ml:87]'WmiCmiPlugin jobshandler.cpp(836): InstallManifestSectionOnline failed. HR=0x80070002.'
Error	CSI    00000c6d@2023/8/7:15:43:34.530 (F) CMIADAPTER: Inner Error Message from AI HRESULT = HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)
 ['The system cannot find the file specified.']
Error	CSI    00000c6e@ (F) CMIADAPTER: AI failed. HRESULT = HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)
…
Error	CSI    00000c6f@ (F) CMIADAPTER: Exiting with HRESULT code = HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND). 
 
Error      [0x018003] CSI    00000c71 (F) Failed execution of queue item Installer: Task Scheduler ({<InstallerID>}) with HRESULT HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND).  Failure will not be ignored: A rollback will be initiated after all the operations in the installer queue are completed; installer is reliable 
Error CBS    Startup: Failed to process advanced operation queue, startupPhase: 0.  A rollback transaction will be created. [HRESULT = 0x800f0922 - CBS_E_INSTALLERS_FAILED] 
Info  CBS    Progress: UI message updated. Operation type: Update. Stage: 1 out of 1. Rollback. 
Info  CBS    Setting original failure status: 0x800f0922, last forward execute state: CbsExecuteStateResolvePending
```

In the Task Scheduler event log, you see the following entries:

```output
Log Name:      Microsoft-Windows-TaskScheduler/Operational
Source:        Microsoft-Windows-TaskScheduler
Event ID:      146
Task Category: Task loading at service startup failed
Level:         Error
Keywords:      
User:          SYSTEM
Description:
Task Scheduler failed to load task "\Microsoft\Windows\PI\SecureBootEncodeUEFI" at service startup. Additional Data: Error Value: 2147942402.
```

This issue occurs because the scheduled `SecureBootEncodeUEFI` task is corrupted.

## Delete staged packages and clean up corrupted tasks

To fix this issue, follow these steps:

1. Find the staged update packages by running the `get-packages` cmdlet:

	```powershell
	Dism /english /online /get-packages /format:table | findstr /i "Staged"
	```

2. Delete the staged update packages by running the `remove-package` cmdlet. For example:

	```powershell
	Dism /online /remove-package /PackageName:Package_for_RollupFix~31bf3856ad364e35~amd64~~14393XXXX
	```

3. Identify the `SecureBootEncodeUEFI` GUID by running the following cmdlet:

	```powershell
	reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\PI\SecureBootEncodeUEFI" /v ID
	```

	The cmdlet output looks like the following:

	```output
	HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\PI\SecureBootEncodeUEFI
    ID    REG_SZ    {<GUID>}
	```
	
4. Running the following cmdlets to delete the `SecureBootEncodeUEFI` registry values:

	> [!NOTE]
 	> You need to replace the `{GUID}` value returned from Step 3.

	```powershell
	reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Maintenance\{GUID}" /f
	reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{GUID}" /f
	reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{GUID}" /f
	reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\PI\SecureBootEncodeUEFI" /f
	```

For more information about how to clean up corrupted tasks, see [MS10-092: Vulnerability in Task Scheduler could allow for elevation of privilege](https://support.microsoft.com/topic/ms10-092-vulnerability-in-task-scheduler-could-allow-for-elevation-of-privilege-06527121-3313-b13a-2179-d604e89e647c).
