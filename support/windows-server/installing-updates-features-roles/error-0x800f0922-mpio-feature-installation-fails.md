---
title: Error 0x800f0922 when the Multipath I/O (MPIO) feature installation fails
description: Resolves an issue in which the Multipath I/O (MPIO) feature installation fails.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, sugan, vineetm
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Error 0x800f0922 when the MPIO feature installation fails

This article helps to fix the error 0x800f0922 that occurs when the Microsoft Multipath I/O (MPIO) feature installation fails.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 3008079

## Symptoms

When you try to install the MPIO feature by using the graphical user interface (GUI) or Windows PowerShell, you receive the following error message:
  
> The request to add or remove features on the specified server failed.  
Installation of one or more roles, role services, or features failed. Error: 0x800f0922.

Additionally, information that resembles the following is logged in the Component Based Servicing log (CBS.log):
  
> *\<DateTime>*, Info CSI 00000029 Begin executing advanced installer phase 32 (0x00000020) index 11 (0x000000000000000b) (sequence 41)  
Old component: [l:0]""  
New component: [ml:344{172},l:342{171}]"Microsoft-Windows-MultipathDeviceSpecificModule, Culture=neutral, Version=6.2.9200.16384,  
PublicKeyToken=31bf3856ad364e35, ProcessorArchitecture=amd64, versionScope=NonSxS"  
Install mode: install  
Installer ID: {3d07d150-2f3d-4184-9793-d0fd59b0c885}  
Installer name: [12]"Root Devices"  
*\<DateTime>*, Error CSI 00000001@*\<DateTime>* (F) CMIADAPTER: Inner Error Message from AI HRESULT = 800f0207 [Error,Facility=(000f),Code=519 (0x0207)]  
[66]"The device instance cannot be created because it already exists."  
]  
[gle=0x80004005]  
*\<DateTime>*, Error CSI 00000002@*\<DateTime>* (F) CMIADAPTER: AI failed. HRESULT = 800f0207 [Error,Facility=(000f),Code=519 (0x0207)]  
Element:  
[308]"\<rootDevices xmlns="urn:schemas-microsoft-com:asm.v3">  
\<rootDevice classGUID="{4D36E97D-E325-11CE-BFC1-08002BE10318}" deviceName="ROOT\MPIO\0001" generateId="false">  
\<properties>  
\<property name="HardwareIds" value="&quot;ROOT\MSDSM&quot;" />  
\</properties>  
\</rootDevice></rootDevices>"[gle=0x80004005]  
*\<DateTime>*, Error CSI 00000003@*\<DateTime>* (F) CMIADAPTER: Exiting with HRESULT code = 800f0207 [Error,Facility=(000f),Code=519 (0x0207)].  
[gle=0x80004005]  
*\<DateTime>*, Info CSI 0000002a Performing 1 operations; 1 are not lock/unlock and follow:  
(0) LockComponentPath (10): flags: 0 comp: {l:16 b:0079df39e6ddcf01300000001413a815} pathid: {l:16 b:0079df39e6ddcf01310000001413a815} path:  
[l:234{117}]"\SystemRoot\WinSxS\x86_microsoft.windows.s..ation.badcomponents_31bf3856ad364e35_6.2.9200.16384_none_353ccb4c94858655" pid: 1314  starttime: 130566894897453336 (0x01cfdde62dc9d918)  
*\<DateTime>*, Error [0x018005] CSI 0000002b (F) Failed execution of queue item Installer: Root Devices ({3d07d150-2f3d-4184-9793-d0fd59b0c885}) with HRESULT 800f0207 [Error,Facility=(000f),Code=519 (0x0207)]. Failure will not be ignored: A rollback will be initiated after all the operations in the installer queue are completed; installer is reliable \[2](gle=0x80004005)  
*\<DateTime>*, Info CBS Added C:\Windows\Logs\CBS\CBS.log to WER report.  
*\<DateTime>*, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_*\<DateTime>*.log to WER report.  
*\<DateTime>*, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_*\<DateTime>*.log to WER report.  
*\<DateTime>*, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_*\<DateTime>*.log to WER report.  
*\<DateTime>*, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_*\<DateTime>*.log to WER report.  
*\<DateTime>*, Info CBS Added C:\Windows\Logs\CBS\CbsPersist_*\<DateTime>*.log to WER report.  
*\<DateTime>*, Info CBS Not able to add pending.xml.bad to Windows Error Report. [HRESULT = 0x80070002 - ERROR_FILE_NOT_FOUND]  
*\<DateTime>*, Info CBS Not able to add SCM.EVM to Windows Error Report. [HRESULT = 0x80070002 - ERROR_FILE_NOT_FOUND]  
*\<DateTime>*, Info CSI 0000002c Creating NT transaction (seq 3), objectname [6]"(null)"  
*\<DateTime>*, Info CSI 0000002d Created NT transaction (seq 3) result 0x00000000, handle @0x330  
*\<DateTime>*, Info CSI 0000002e@*\<DateTime>* Beginning NT transaction commit...  
*\<DateTime>*, Info CSI 0000002f@*\<DateTime>* CSI perf trace:  
CSIPERF:TXCOMMIT; 15663
*\<DateTime>*, Info CSI 00000030@*\<DateTime>* CSI Advanced installer perf trace:  
CSIPERF:AIDONE;{3d07d150-2f3d-4184-9793-d0fd59b0c885};Microsoft-Windows-MultipathDeviceSpecificModule, Version = 6.2.9200.16384, pA = PROCESSOR_ARCHITECTURE_AMD64 (9), Culture neutral, VersionScope = 1 nonSxS, PublicKeyToken = {l:8 b:31bf3856ad364e35}, Type neutral, TypeName neutral, PublicKey neutral;199927us  
*\<DateTime>*, Info CSI 00000031 End executing advanced installer (sequence 41)
Completion status: HRESULT_FROM_WIN32(ERROR_ADVANCED_INSTALLER_FAILED)  

Also, the following information is logged in the device installation text log (SetupAPI.dev.log):

>\>>> [Setup Root Device - Install]  
\>>> Section start *\<DateTime>*  
set: {Install Root Device: ROOT\MPIO\0001} *\<DateTime>*  
!!! set: Could not create a device information element for device ROOT\MPIO\0001. HRESULT = 0x800f0207  
set: {Install Root Device - exit(0x800f0207)} *\<DateTime>*  
\<<< Section end *\<DateTime>*  
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

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
