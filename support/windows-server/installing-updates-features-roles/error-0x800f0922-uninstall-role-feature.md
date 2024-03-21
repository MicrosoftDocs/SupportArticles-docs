---
title: Error 0x800f0922 when you uninstall roles
description: Provides a solution to an issue where uninstalling Windows Server roles or features fails with error 0x800f0922.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# Error 0x800f0922 when trying to uninstall Windows Server roles or features

This article helps fix the error 0x800f0922 that occurs when you uninstall Microsoft Windows Server roles or features.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016  
_Original KB number:_ &nbsp; 4094128

## Symptoms

When you try to uninstall a Windows Server role or feature by using **Server Manager** or the PowerShell cmdlet `Uninstall-WindowsFeature`, the attempt fails, and you receive error code **0x800f0922** and the following error message: 

> CBS_E_INSTALLERS_FAILED  
Processing advanced installers and generic commands failed

For example, when uninstalling Windows Deployment Services (WDS), the following errors were logged in the **CBS.log** under `C:\Windows\Logs\CBS`:

> SQM: Reporting selectable update change for package: Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, update: Microsoft-Windows-Deployment-Services, start: Installed, applicable: Resolved, target: Resolved, client id: DISM Package Manager Provider, initiated offline: False, execution sequence: 1433, first merged sequence: 1433, download source: 0, download time (secs): 4294967295, download status: 0x0 (S_OK),reboot required: False, overall result:0x800f0922 (CBS_E_INSTALLERS_FAILED)  
SQM: Upload requested for report:  UpdateChange_Microsoft-Windows-Deployment-Services_Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, session id: 142860, sample type: Standard  
SQM: Ignoring upload request because the sample type is not enabled: Standard  
TI: CBS has queried the current reboot required state: 0  
SQM: Reporting selectable update change for package: Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, update: Microsoft-Windows-Deployment-Services-Deployment-Server, start: Staged, applicable: Resolved, target: Resolved, client id: DISM Package Manager Provider, initiated offline: False, execution sequence: 1433, first merged sequence: 1433, download source: 0, download time (secs): 4294967295, download status: 0x0 (S_OK),reboot required: False, overall result:0x800f0922 (CBS_E_INSTALLERS_FAILED)  
SQM: Upload requested for report:  UpdateChange_Microsoft-Windows-Deployment-Services-Deployment-Server_Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, session id: 142860, sample type: Standard  
SQM: Ignoring upload request because the sample type is not enabled: Standard  
TI: CBS has queried the current reboot required state: 0  
SQM: Reporting selectable update change for package: Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, update: Microsoft-Windows-Deployment-Services-Transport-Server, start: Installed, applicable: Resolved, target: Resolved, client id: DISM Package Manager Provider, initiated offline: False, execution sequence: 1433, first merged sequence: 1433, download source: 0, download time (secs): 4294967295, download status: 0x0 (S_OK),reboot required: False, overall result:0x800f0922 (CBS_E_INSTALLERS_FAILED)  
SQM: Upload requested for report:  UpdateChange_Microsoft-Windows-Deployment-Services-Transport-Server_Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, session id: 142860, sample type: Standard  
SQM: Ignoring upload request because the sample type is not enabled: Standard  
SQM: Reporting package change for package: Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, current: Installed, pending: Default, start: Installed, applicable: Installed, target: Installed, limit: Installed, hotpatch status: DisabledBecauseNoHotpatchPackagesInitiated, status: 0x0, failure source: Execute, reboot required: False, client id: DISM Package Manager Provider, initiated offline: False, execution sequence: 1433, first merged sequence: 1433 reboot reason: REBOOT_NOT_REQUIRED RM App session: -1 RM App name: N/A FileName in use: N/A  
SQM: Upload requested for report: PackageChangeBegin_Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, session id: 142859, sample type: Standard  
SQM: Ignoring upload request because the sample type is not enabled: Standard  
SQM: Reporting package change completion for package: Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, current: Installed, original: Installed, target: Installed, status: 0x800f0922, failure source: Execute, failure details: "(null)", client id: DISM Package Manager Provider, initiated offline: False, execution sequence: 1433, first merged sequence: 1433, pending decision: InteractiveInstallFailed, primitive execution context: Interactive  
SQM: execute time performance datapoint is invalid. [HRESULT = 0x80070490 - ERROR_NOT_FOUND]  
SQM: Failed to initialize Win SAT assessment. [HRESULT = 0x80040154 - Unknown Error]  
SQM: average disk throughput datapoint is invalid [HRESULT = 0x80040154 - Unknown Error]  
SQM: Upload requested for report: PackageChangeEnd_Microsoft-Windows-Deployment-Services-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, session id: 142862, sample type: Standard  
SQM: Ignoring upload request because the sample type is not enabled: Standard  
TI: CBS has queried the current reboot required state: 0  
SQM: Reporting selectable update change for package: Microsoft-Windows-Deployment-Services-UI-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, update: Microsoft-Windows-Deployment-Services-Admin-Pack, start: Staged, applicable: Resolved, target: Resolved, client id: DISM Package Manager Provider, initiated offline: False, execution sequence: 1433, first merged sequence: 1433, download source: 0, download time (secs): 4294967295, download status: 0x0 (S_OK),reboot required: False, overall result:0x800f0922 (CBS_E_INSTALLERS_FAILED)  
SQM: Upload requested for report:  UpdateChange_Microsoft-Windows-Deployment-Services-Admin-Pack_Microsoft-Windows-Deployment-Services-UI-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, session id: 142860, sample type: Standard  
SQM: Ignoring upload request because the sample type is not enabled: Standard  
SQM: Reporting package change for package: Microsoft-Windows-Deployment-Services-UI-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, current: Installed, pending: Default, start: Installed, applicable: Installed, target: Installed, limit: Installed, hotpatch status: DisabledBecauseNoHotpatchPackagesInitiated, status: 0x0, failure source: Execute, reboot required: False, client id: DISM Package Manager Provider, initiated offline: False, execution sequence: 1433, first merged sequence: 1433 reboot reason: REBOOT_NOT_REQUIRED RM App session: -1 RM App name: N/A FileName in use: N/A  
SQM: Upload requested for report: PackageChangeBegin_Microsoft-Windows-Deployment-Services-UI-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, session id: 142859, sample type: Standard  
SQM: Ignoring upload request because the sample type is not enabled: Standard
SQM: Reporting package change completion for package: Microsoft-Windows-Deployment-Services-UI-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, current: Installed, original: Installed, target: Installed, status: 0x800f0922, failure source: Execute, failure details: "(null)", client id: DISM Package Manager Provider, initiated offline: False, execution sequence: 1433, first merged sequence: 1433, pending decision: InteractiveInstallFailed, primitive execution context: Interactive  
SQM: execute time performance datapoint is invalid. [HRESULT = 0x80070490 - ERROR_NOT_FOUND]  
SQM: Failed to initialize Win SAT assessment. [HRESULT = 0x80040154 - Unknown Error]  
SQM: average disk throughput datapoint is invalid [HRESULT = 0x80040154 - Unknown Error]  
SQM: Upload requested for report: PackageChangeEnd_Microsoft-Windows-Deployment-Services-UI-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384, session id: 142862, sample type: Standard  
SQM: Ignoring upload request because the sample type is not enabled: Standard  
FinalCommitPackagesState: Completed persisting state of packages  
Enabling LKG boot option  
Exec: Processing complete.  Session: 30651968_3203616141, Package: Microsoft-Windows-ServerCore-Package~31bf3856ad364e35~amd64`~~`6.3.9600.16384 [HRESULT = 0x800f0922 - CBS_E_INSTALLERS_FAILED]  
Failed to perform operation.  [HRESULT = 0x800f0922 - CBS_E_INSTALLERS_FAILED]  
Session: 30651968_3203616141 finalized. Reboot required: no [HRESULT = 0x800f0922 - CBS_E_INSTALLERS_FAILED]  
Failed to FinalizeEx using worker session [HRESULT = 0x800f0922]

## Cause

This issue can occur if there are more than 65,000 files in the Windows Temp directory. The Windows Temp directory is located at `C:\Windows\Temp`. Check Windows environment variables to confirm the location of the Windows Temp directory.

## Resolution

To resolve the problem, delete the contents of the Windows Temp folder (normally `C:\Windows\Temp`), and then again try to remove the Windows Server role or feature.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
