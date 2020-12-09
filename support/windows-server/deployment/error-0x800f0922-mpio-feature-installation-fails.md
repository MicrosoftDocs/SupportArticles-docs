---
title: Error 0x800f0922 when the Multipath I/O (MPIO) feature installation fails
description: Resolves an issue in which the Multipath I/O (MPIO) feature installation fails.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, sugan, vineetm
ms.prod-support-area-path: Servicing
ms.technology: Deployment
---
# Error 0x800f0922 when the MPIO feature installation fails

This article helps to fix the error 0x800f0922 that occurs when the Microsoft Multipath I/O (MPIO) feature installation fails.

_Original product version:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 3008079

## Symptoms

When you try to install the MPIO feature by using the graphical user interface (GUI) or Windows PowerShell, you receive the following error message:
  
> The request to add or remove features on the specified server failed.  
Installation of one or more roles, role services, or features failed. Error: 0x800f0922.

Additionally, information that resembles the following is logged in the Component Based Servicing log (CBS.log):
  
> 2014-10-01 22:11:50, Info CSI 00000029 Begin executing advanced installer phase 32 (0x00000020) index 11 (0x000000000000000b) (sequence 41)  
Old component: [l:0]""  
New component: [ml:344{172},l:342{171}]"Microsoft-Windows-MultipathDeviceSpecificModule, Culture=neutral, Version=6.2.9200.16384,  
PublicKeyToken=31bf3856ad364e35, ProcessorArchitecture=amd64, versionScope=NonSxS"  
Install mode: install  
Installer ID: {3d07d150-2f3d-4184-9793-d0fd59b0c885}  
Installer name: [12]"Root Devices"  
2014-10-01 22:11:50, Error CSI 00000001@2014/10/2:02:11:50.019 (F) CMIADAPTER: Inner Error Message from AI HRESULT = 800f0207 [Error,Facility=(000f),Code=519 (0x0207)]  
[66]"The device instance cannot be created because it already exists."  
]  
[gle=0x80004005]  
2014-10-01 22:11:50, Error CSI 00000002@2014/10/2:02:11:50.019 (F) CMIADAPTER: AI failed. HRESULT = 800f0207 [Error,Facility=(000f),Code=519 (0x0207)]  
Element:  
[308]"\<rootDevices xmlns="urn:schemas-microsoft-com:asm.v3">  
\<rootDevice classGUID="{4D36E97D-E325-11CE-BFC1-08002BE10318}" deviceName="ROOT\MPIO\0001" generateId="false">  
\<properties>  
\<property name="HardwareIds" value="&quot;ROOT\MSDSM&quot;" />  
\</properties>  
\</rootDevice></rootDevices>"[gle=0x80004005]  
2014-10-01 22:11:50, Error CSI 00000003@2014/10/2:02:11:50.019 (F) CMIADAPTER: Exiting with HRESULT code = 800f0207 [Error,Facility=(000f),Code=519 (0x0207)].  
[gle=0x80004005]  
2014-10-01 22:11:50, Info CSI 0000002a Performing 1 operations; 1 are not lock/unlock and follow:  
(0) LockComponentPath (10): flags: 0 comp: {l:16 b:0079df39e6ddcf01300000001413a815} pathid: {l:16 b:0079df39e6ddcf01310000001413a815} path:  
[l:234{117}]"\SystemRoot\WinSxS\x86_microsoft.windows.s..ation.badcomponents_31bf3856ad364e35_6.2.9200.16384_none_353ccb4c94858655" pid: 1314  starttime: 130566894897453336 (0x01cfdde62dc9d918)  
2014-10-01 22:11:50, Error [0x018005] CSI 0000002b (F) Failed execution of queue item Installer: Root Devices ({3d07d150-2f3d-4184-9793-d0fd59b0c885}) with HRESULT 800f0207 [Error,Facility=(000f),Code=519 (0x0207)]. Failure will not be ignored: A rollback will be initiated after all the operations in the installer queue are completed; installer is reliable (2)[gle=0x80004005]  
2014-10-01 22:11:50, Info CBS Added C:\Windows\Logs\CBS\CBS.log to WER report.  
2014-10-01 22:11:50, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_20141002021129.log to WER report.  
2014-10-01 22:11:50, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_20141002015645.log to WER report.  
2014-10-01 22:11:50, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_20141002014932.log to WER report.  
2014-10-01 22:11:50, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_20141002014131.log to WER report.  
2014-10-01 22:11:50, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_20141001211447.log to WER report.  
2014-10-01 22:11:50, Info CBS Not able to add pending.xml.bad to Windows Error Report. [HRESULT = 0x80070002 - ERROR_FILE_NOT_FOUND]  
2014-10-01 22:11:50, Info CBS Not able to add SCM.EVM to Windows Error Report. [HRESULT = 0x80070002 - ERROR_FILE_NOT_FOUND]  
2014-10-01 22:11:50, Info CSI 0000002c Creating NT transaction (seq 3), objectname [6]"(null)"  
2014-10-01 22:11:50, Info CSI 0000002d Created NT transaction (seq 3) result 0x00000000, handle @0x330  
2014-10-01 22:11:50, Info CSI 0000002e@2014/10/2:02:11:50.185 Beginning NT transaction commit...  
2014-10-01 22:11:50, Info CSI 0000002f@2014/10/2:02:11:50.200 CSI perf trace:  
CSIPERF:TXCOMMIT; 15663
2014-10-01 22:11:50, Info CSI 00000030@2014/10/2:02:11:50.200 CSI Advanced installer perf trace:  
CSIPERF:AIDONE;{3d07d150-2f3d-4184-9793-d0fd59b0c885};Microsoft-Windows-MultipathDeviceSpecificModule, Version = 6.2.9200.16384, pA = PROCESSOR_ARCHITECTURE_AMD64 (9), Culture neutral, VersionScope = 1 nonSxS, PublicKeyToken = {l:8 b:31bf3856ad364e35}, Type neutral, TypeName neutral, PublicKey neutral;199927us  
2014-10-01 22:11:50, Info CSI 00000031 End executing advanced installer (sequence 41)
Completion status: HRESULT_FROM_WIN32(ERROR_ADVANCED_INSTALLER_FAILED)  

Also, the following information is logged in the device installation text log (SetupAPI.dev.log):

>\>>> [Setup Root Device - Install]  
\>>> Section start 2014/10/01 21:57:01.843  
set: {Install Root Device: ROOT\MPIO\0001} 21:57:01.843  
!!! set: Could not create a device information element for device ROOT\MPIO\0001. HRESULT = 0x800f0207  
set: {Install Root Device - exit(0x800f0207)} 21:57:01.843  
\<<< Section end 2014/10/01 21:57:01.843  
\<<< [Exit status: FAILURE(0x00000207)]

## Cause

This issue occurs because of some stale entries in the registry key for the MPIO feature.

## Resolution

To resolve this issue, remove the following key from the registry:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\MPIO\0001`

## Status

Microsoft has confirmed that this is a problem in the Microsoft products listed at the beginning of this article.

## Explanation of the error codes

|Error Code|Symbol|File|Description|
|---|---|---|---|
|0x800f0922|CBS_E_INSTALLERS_FAILED|cbsapi.h|Processing advanced installers and generic commands failed.|
|0x800f0207|SPAPI_E_DEVINST_ALREADY_EXISTS|winerror.h|The device instance cannot be created because it already exists.|
|0x80070002|ERROR_FILE_NOT_FOUND|winerror.h|The system cannot find the file specified.|
|0x00000207|SE_AUDITID_LPC_INVALID_USE|msaudite.h|Invalid use of LPC port.|
|||||
