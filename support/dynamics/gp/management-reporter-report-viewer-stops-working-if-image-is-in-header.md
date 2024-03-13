---
title: Report Viewer stops working if image is in header
description: Describes an error that you may receive when you view a report that contains an image in the header. Provides a workaround.
ms.reviewer: kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Microsoft Management Reporter Report Viewer may stop working when there is an image in header

This article provides a workaround for the error that may occur in Microsoft Management Reporter Report Viewer when you view a report that contains an image in the header.

_Applies to:_ &nbsp; Microsoft Dynamics AX 2009, Microsoft Dynamics GP, Microsoft Dynamics SL 2011, Microsoft Management Reporter 2012  
_Original KB number:_ &nbsp; 2629083

## Symptoms

Management Reporter Report Viewer may stop working and display the following message when you view a report that includes an image in the header:

> Management Reporter for Microsoft Dynamics ERP has stopped working

A similar message will also be in Windows Event Viewer:

> Faulting application name: ReportViewer.exe, version: 2.0.1700.31, time stamp: 0x4e026425  
Faulting module name: KERNELBASE.dll, version: 6.1.7600.16850, time stamp: 0x4e211da1  
Exception code: 0xc000041d  
Fault offset: 0x000000000000a88d  
Faulting process id: 0xd6c  
Faulting application start time: 0x01cc876770db078d  
Faulting application path: C:\Program Files\Microsoft Dynamics ERP\Management Reporter\2.0\Client\ReportViewer.exe  
Faulting module path: C:\Windows\system32\KERNELBASE.dll
>
> Application: ReportViewer.exe Framework Version: v4.0.30319 Description: The process was terminated due to an unhandled exception.
Exception Info: System.InvalidOperationException Stack: at System.Drawing.Image.get_Width() at Microsoft.Dynamics.Performance.Reporting.Viewer.Pipelines.Native.Layout
>
> Object is in use elsewhere

## Cause

The issue occurs more frequently when you move between detail levels or units of the tree quickly. This is a known issue and will be addressed in a future release.

## Workaround

To work around this issue, remove the image from the header.
