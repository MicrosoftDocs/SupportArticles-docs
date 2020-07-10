---
title: 0xC0000094 exception in Silverlight 5 app
description: This article introduces that in the VMWare environment, Silverlight application that uses client network stack may crash due to an unhandled divide by zero exception.
ms.date: 04/30/2020
ms.prod-support-area-path:
ms.reviewer: enamulkh, tref, ppratap, huanchix
---
# Integer divide by zero exception (0xC0000094) may occur in a Silverlight 5 application that's running in VMWare

This article helps you resolve the problem that a Silverlight application that runs in a VMWare environment crashes with a divide by zero exception (0xC0000094) when you enable client HTTP handling in it.

_Original product version:_ &nbsp; Silverlight 5  
_Original KB number:_ &nbsp; 2756614

## Symptoms

With Silverlight, you can specify whether the browser or the client provides HTTP handling for your applications. By default, HTTP handling is performed by the browser and you must opt-in to client HTTP handling. When you enable client HTTP handling in your Silverlight application that is running in a VMWare environment, your application may crash with an unhandled divide by zero exception (0xC0000094). You may see an Application Event log like the following:

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

When downloading a network resource using a client HTTP Stack, Silverlight tries to calculate the download speeds to adjust the buffer size. When running under VMWare, the time difference between start time and end time for a network operation is zero, causing a divide by zero exception.

## Resolution

A patch has been released to fix the issue. You can download it from
 [here](https://www.microsoft.com/getsilverlight/get-started/install/default.aspx). The corresponding Security Update for Microsoft Silverlight can be found [here](https://www.microsoft.com/download/details.aspx?id=36946).

## More information

This problem applies to Silverlight 5 versions less than 5.1.20125.0. The issue is more prevalent in Out Of Browser (OOB) Silverlight Apps, which don't have access to the Browser Network stack.
