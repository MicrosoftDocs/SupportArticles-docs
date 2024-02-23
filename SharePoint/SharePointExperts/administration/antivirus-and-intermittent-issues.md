---
title: Antivirus and intermittent issues when you view Office documents by using Microsoft Offices Online or Office Online Server
description: Fixes antivirus and intermittent issues that occurs when you view Office documents by using Microsoft Microsoft Offices Online or Office Online Server.
author: helenclu
ms.author: luche
ms.reviewer: jhaak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: sap:spsexperts, CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 12/17/2023
---

# Antivirus and intermittent issues when you view Office documents by using Office Online Server

This article was written by [Jason Haak](https://social.technet.microsoft.com/profile/Jason+Ha+-+MSFT), Senior Support Escalation Engineer.

## Symptoms

When you view Office documents by using Microsoft Microsoft Offices Online or Office Online Server, you see intermittent errors. All Office file types are affected, most frequently PowerPoint and Word files. Frequently, the same document displays at one time, and then throws an error at another document.

In the Unified Logging Service (ULS) log on the Office Online Server, you will see such a "ConversionError" or "Conversion failed" error. In the Windows Event Application log, the AppServerHost.exe process that is ended unexpectedly may appear repeatedly.

## Cause

Antivirus network monitoring processes that monitor the "*\Program Files\Microsoft Office Web Apps\" folder and all executables (.exe) in each subfolder can potentially interfere with the file conversion functionality. To display documents, each document is converted into image files that are cached on the Office Online Servers. The process that's responsible for this conversion is called **AppServerHost.exe**.  Numerous instances of this subprocess are opened and closed by Microsoft Offices Online repeatedly, and the Antivirus network monitoring software can detect this activity as a threat or make these processes end unexpectedly.  In turn, this leads to a corrupted cached file and the error.

## Resolution

Although clearing the Microsoft Offices Online cache manually or programmatically has had limited success, to fix this issue completely, you need reconfigure the Antivirus network monitoring programs to enable Microsoft Offices Online to freely create and sustain the AppServerHost.exe process and all relating subprocesses. Here are some configuration guidelines:

1. Exclude any monitoring within the following directories:
   - C:\Program Files\Microsoft Office Web Apps\
   - C:\ProgramData\Microsoft\OfficeWebApps\Working\d
   - C:\ProgramData\Microsoft\OfficeWebApps\Working\waccache
   - C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files
1. Exclude monitoring or reduce the risk for the AppServerHost.exe process and the wacsm Microsoft service.

If the previous two guidelines don't help, contact your Antivirus software support for more help.

A basic list of the Microsoft Office Online processes that you should be excluding is here. You may have other processes, depending on what is installed.

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
- ULSControllerService.exew3wp.exe
- WordViewerAppManagerWatchdog.exe
- WordViewerWfeWatchdog.exe
