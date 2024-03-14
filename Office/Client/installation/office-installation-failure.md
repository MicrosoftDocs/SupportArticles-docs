---
title: Office 2010 Installation failure
description: Describes an issue in which Microsoft Office 2010 encountered an error during setup. Provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# Office 2010 Installation failure: "...encountered an error during setup" CAQuietExec wevtutil.exe BCSEvents.man

## Symptoms

User is attempting to install Office 2010 Professional Plus on a Dell machine with Windows 7 OS. Setup halts during installation with in the following error, and Office is not installed:

"Microsoft Office Professional Plus 2010 encountered an error during setup." 

If verbose logging is enabled, the user will see in the following error: 

```adoc
Error: Failed to install product: C:\MSOCache\All Users\{91140000-0011-0000-0000-0000000FF1CE}-C\ProPlusrWW.msi ErrorCode: 1603(0x643). 
```

## Cause

This error may occur on computers with versions of the Dell OpenManage Client Instrumentation utility installed that are older than version 7.8.0.914. 

The root cause of the issue is that the permissions on the following folders have been changed:

C:\Windows\System32\winevt

C:\Windows\System32\winevt\Logs

## Resolution

To resolve this issue, the NT Authority\Local Service account must be granted Full Control permissions on the %windir%\System32\winevt\Logs directory. Installing the 7.8.0.914 version of the Dell OpenManage Client utility does not resolve the issue if an earlier version had been previously installed.

Permissions can be set using command lines similar to the following:

```powershell
%windir%\system32\icacls.exe %windir%\system32\winevt\ /grant "nt service\trustedinstaller":F /grant "nt service\local service":F /grant administrators:F /grant system:F /T >%temp%\icacls.log
```

```powershell
%windir%\system32\icacls.exe %windir%\system32\winevt\logs /grant "Authenticated Users":M /T >%temp%\icacls.log
```

Dell has published a new version of Dell Client Manager which resolves this issue. The version of Dell Client Manager that resolves this issue is available for download from Dell at:  
[https://support.us.dell.com/support/downloads/download.aspx?c=us&l=en&s=gen&releaseid=R264538&formatcnt=0&libid=0&typeid=-1&dateid=-1&formatid=-1&source=-1&fileid=388850](https://support.us.dell.com/support/downloads/download.aspx?c=us&l=en&s=gen&releaseid=R264538&formatcnt=0&libid=0&typeid=-1&dateid=-1&formatid=-1&source=-1&fileid=388850)

The user should download this fix, restart their system and relaunch the install of Office 2010.  

## More Information

Installation log files may contain lines similar to the following: 

```adoc
----------------------------------------- 
CAQuietExec: "wevtutil.exe" im "C:\Program Files\Microsoft 
Office\Office14\BCSEvents.man" 
MSI (s) (84!D8) [10:46:27:870]: Closing MSIHANDLE (7325) of type 790531 for thread
1752 
MSI (s) (84!D8) [10:46:27:886]: Creating MSIHANDLE (7326) of type 790531 for thread
1752 
CAQuietExec: The publishers and channels are installed successfully. However, we 
can't enable one or more publishers and channels. Access is denied. 
MSI (s) (84!D8) [10:46:27:886]: Closing MSIHANDLE (7326) of type 790531 for thread
1752 
MSI (s) (84!D8) [10:46:27:886]: Creating MSIHANDLE (7327) of type 790531 for thread
1752 
CAQuietExec: Error 0x80070005: Command line returned an error. 
MSI (s) (84!D8) [10:46:27:886]: Closing MSIHANDLE (7327) of type 790531 for thread
1752
CAQuietExec: Error 0x80070005: CAQuietExec Failed 
-----------------------------------------
```