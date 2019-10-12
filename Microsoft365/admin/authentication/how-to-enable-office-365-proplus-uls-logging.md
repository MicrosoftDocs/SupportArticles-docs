---
title: How to enable Office 365 ProPlus ULS logging
description: There are times during troubleshooting an Office issue when the traditional log settings are not gathering enough information. This article describes how to collect more verbose logging details. 
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.author: ericspli
appliesto:
- Office 365 ProPlus
---

# How to enable Office 365 ProPlus ULS logging

This article was written by [Eric Splichal](https://social.technet.microsoft.com/profile/Splic-MSFT), Support Escalation Engineer.

When you troubleshoot Microsoft Office issues, traditional log settings sometimes don't collect enough information. This might be for sign-in issues, installation and patching issues, and even app issues.

To collect more verbose logging details, set the following registry keys:

For sign-in or activation issues, add the following registry key:

**[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Logging]**

**"EnableLogging"=dword:00000001**

For installation or patching issues, run the following commands to add the registry keys:

```powershell
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel /t REG_DWORD /d 3
```

```powershell
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging /t REG_DWORD /d 1
```

You have to restart Microsoft Office Click-to-Run Service inside Services.msc for the logging to take effect.

Reproduce the issue and collect the logs for review. The logs are stored under %temp% for sign-in or activation issues. For installation or patching issues, you also have to collect the logs from %windir%\temp. Note the time stamp you do the repro so that you collect the correct logs.

After you collect the logs, turn off the Office ULS verbose logging setting. Otherwise, this continues to collect verbose data and use more dive space.

To enable and disable ULS logging automatically, download and run the following .reg files:

- [Enable-Local-Logging2016](https://msdnshared.blob.core.windows.net/media/2018/06/Enable-Local-Logging2016.zip)
- [Disable-Local-Logging2016](https://msdnshared.blob.core.windows.net/media/2018/06/Disable-Local-Logging2016.zip)