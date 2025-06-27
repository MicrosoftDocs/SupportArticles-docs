---
title: Antivirus and intermittent issues when you view Office documents by using Office Online Server
description: Fixes antivirus and intermittent issues that occur when you view Office documents by using Office Online Server.
author: helenclu
ms.author: luche
ms.reviewer: jhaak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Other
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 07/24/2024
---

# Antivirus and intermittent issues when you view Office documents by using Office Online Server

## Symptoms

When you view Office documents by using Office Online Server, you see intermittent errors. All Office file types are affected, most frequently PowerPoint and Word files. Frequently, the same document displays at one time, and then throws an error at another document.

In the Unified Logging Service (ULS) log on the Office Online Server, you see a "ConversionError" or "Conversion failed" error. In the Windows Event Application log, the AppServerHost.exe process that's ended unexpectedly appears repeatedly.

## Cause

Antivirus network monitoring processes that monitor the "*\Program Files\Microsoft Office Web Apps\" folder and all executables (.exe) in each subfolder can potentially interfere with the file conversion functionality. To display documents, each document is converted into image files that are cached on the Office Online Servers. The process that's responsible for the conversion is called **AppServerHost.exe**.  Microsoft Offices Online actively opens and closes numerous instances of this subprocess, and the Antivirus network monitoring software might detect this activity as a threat or cause these processes to end unexpectedly.  In turn, this leads to a corrupted cached file and the error.

## Resolution

Although clearing the Microsoft Offices Online cache manually or programmatically has limited success, to fix the issue completely, you need to reconfigure the Antivirus network monitoring programs to enable Microsoft Offices Online to freely create and sustain the AppServerHost.exe process and all related subprocesses. Here are some configuration guidelines:

1. Exclude any monitoring within the following directories:
   - C:\Program Files\Microsoft Office Web Apps\
   - C:\ProgramData\Microsoft\OfficeWebApps\Working\d
   - C:\ProgramData\Microsoft\OfficeWebApps\Working\waccache
   - C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files
1. Exclude monitoring or reduce the risk for the AppServerHost.exe process and the wacsm Microsoft service.

If the previous two guidelines don't help, contact your Antivirus software support for more help.

Here is a basic list of Microsoft Office Online processes that you should exclude. Depending on the software that's installed, other processes may need to be excluded.

- AgentManagerWatchdog.exe
- AppServerHost.exe
- broadcastwatchdog_app.exe
- broadcastwatchdog_wfe.exe
- DiskCacheWatchdog.exe
- EditAppServerHost.exe
- EditAppServerHostSlim.exe
- excelcnv.exe
- FarmStateManagerWatchdog.exe
- FarmStateReplicator.exe
- HostingServiceWatchdog.exe
- ImagingService.exe
- ImagingWatchdog.exe
- MetricsProvider.exe
- Microsoft.Office.Excel.Server.EcsWatchdog.exe
- Microsoft.Office.Excel.Server.WfeWatchdog.exe
- Microsoft.Office.Web.AgentManager.exe
- Microsoft.Office.Web.WebOneNoteWatchdog.exe
- OneNoteMerge.exe
- ppteditingbackendwatchdog.exe
- pptviewerbackendwatchdog.exe
- pptviewerfrontendwatchdog.exe
- ProofingWatchdog.exe
- SandboxHost.exe
- SpellingWcfProvider.exe
- ULSControllerService.exe
- W3wp.exe
- WordViewerAppManagerWatchdog.exe
- WordViewerWfeWatchdog.exe
