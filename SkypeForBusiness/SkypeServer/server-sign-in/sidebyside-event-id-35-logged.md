---
title: SideBySide event ID 35 is logged
description: Describes an issue in which event ID 35 appears in the Application log when you start Skype for Business. This event can be ignored safely.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Skype for Business
  - Microsoft Lync 2013
  - Windows 7 Enterprise
  - Windows 7 Professional
  - Windows 7 Home Premium
  - Windows 7 Ultimate
  - Windows 7 Home Basic
  - Windows 7 Starter
  - Windows 8
  - Windows 8.1
  - Windows 10
search.appverid: MET150
ms.date: 03/31/2022
---
# SideBySide event ID 35 is logged in the Application log when you start Skype for Business

_Original KB number:_ &nbsp; 3077028

## Symptoms

When you start Skype for Business (previously Microsoft Lync 2013) on a 64-bit Windows operating system, the following error is logged in the Application log:

> Log Name: Application  
> Source: SideBySide  
> Event ID: 35  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Description:  
> Activation context generation failed for "c:\program files (x86)\microsoft office\Office15\lync.exe.Manifest".Error in manifest or policy file "c:\program files (x86)\microsoft office\Office15\UccApi.DLL" on line 1. Component identity found in manifest does not match the identity of the component requested. Reference is UccApi,processorArchitecture="AMD64",type="win32",version="15.0.0.0". Definition is UccApi,processorArchitecture="x86",type="win32",version="15.0.0.0". Please use sxstrace.exe for detailed diagnosis.  
> \<**Event**>

## Cause

On 64-bit Windows operating systems, an entry in the Lync.exe application manifest incorrectly causes a request for a 64-bit version of Wlmfds.dll to be loaded into the process space. However, only a 32-bit version of Wlmfds.dll exists. Therefore, the error that is mentioned in the "Symptoms" section is reported.

## Resolution

You can safely ignore this error log. This error log does not cause Skype for Business to crash. The side-by-side (SxS) DLL loader will load the 32-bit version of Wlmfds.dll correctly. The event that is logged causes no functionality or stability problems with Skype for Business.

## More information

To troubleshoot the Skype for Business crash issue, you can [perform a clean boot in Windows](https://support.microsoft.com/help/929135). This helps eliminate whether the crash issue is caused by software conflicts.
