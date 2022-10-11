---
title: 0xC0000094 exception in Silverlight 5 app
description: This article introduces that in the VMware environment, Silverlight application that uses client network stack may crash due to an unhandled divide by zero exception.
ms.date: 04/30/2020
ms.custom: sap:Silverlight
ms.reviewer: enamulkh, tref, ppratap, huanchix
---
# Integer divide by zero exception (0xC0000094) may occur in a Silverlight 5 application that's running in VMware

This article helps you resolve the problem where a Silverlight application that runs in a VMware environment crashes with a divide by zero exception (0xC0000094) when you enable client HTTP handling in it.

_Original product version:_ &nbsp; Silverlight 5  
_Original KB number:_ &nbsp; 2756614

## Symptoms

With Silverlight, you can specify whether the browser or the client provides HTTP handling for your applications. HTTP handling is performed by the browser by default, and you must opt in to client HTTP handling. When you enable client HTTP handling in your Silverlight application that is running in a VMware environment, your application may crash with an unhandled divide by zero exception (0xC0000094). You may see an Application Event log like the following one:

> Log Name: Application  
> Source: Application Error  
> Description: 
> Faulting application name: IEXPLORE.EXE, version: 8.0.7600.16930, time stamp: 0x4eeae23b  
> Faulting module name: npctrl.dll, version: 5.1.10411.0, time stamp: 0x4f851e71  
> Exception code: 0xc0000094  
> Fault offset: 0x0001d700  
> Faulting process id: 0x5f0  
> Faulting application path: C:\Program Files\Internet Explorer\IEXPLORE.EXE  
> Faulting module path: c:\Program Files\Microsoft Silverlight\5.1.10411.0\npctrl.dll

## Cause

When downloading a network resource using a client HTTP Stack, Silverlight tries to calculate the download speeds to adjust the buffer size. When running under VMware, the time difference between start time and end time for a network operation is zero, causing a divide by zero exception.

## Resolution

This issue has been fixed in later versions of Silverlight.

> [!NOTE]
> Microsoft Silverlight reached the end of support in October 2021 and the installer is no longer available for download. [Learn more](https://support.microsoft.com/windows/silverlight-end-of-support-0a3be3c7-bead-e203-2dfd-74f0a64f1788).

## More information

This problem applies to Silverlight 5 versions less than 5.1.20125.0. The issue is more prevalent in Out Of Browser (OOB) Silverlight Apps, which don't have access to the Browser Network stack.
