---
title: Report Viewer stops working when viewing report
description: Describes an issue when viewing a report that contains an image. Provides a resolution.
ms.reviewer: theley, kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Management Reporter
---
# Microsoft Management Reporter Report Viewer stops working when you view a report

This article provides a resolution for the issue that Microsoft Management Reporter Report Viewer stops working when you view a report that contains an image.

_Applies to:_ &nbsp; Microsoft Dynamics AX 2009, Microsoft Dynamics GP, Microsoft Dynamics SL 2011, Microsoft Management Reporter 2012  
_Original KB number:_ &nbsp; 2643511

## Symptoms

When you view a report in Report Viewer that contains an image, the program may stop responding and display the following message:

> Management reporter for Microsoft Dynamics ERP has stopped working

There will also be a message in Windows Event Viewer similar to the following:

> Exception type: System.InvalidOperationException  
Message: Object is currently in use elsewhere.
>
> Application: ReportViewer.exe Framework Version: v4.0.30319 Description: The process was terminated due to an unhandled exception. Exception Info: System.InvalidOperationException Stack: at System.Drawing.Image.get_Width() at Microsoft.Dynamics.Performance.Reporting.Viewer.Pipelines.Native.Layout+Header.Measure(System.Drawing.Graphics, System.Drawing.Size)

## Cause

This is a known issue with Management Reporter Service Pack 2 and reports that contain an image. This issue has been reported as Bug 475009.

## Resolution

Remove the image from the report to work around this issue.
