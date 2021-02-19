---
title: How to enable Microsoft 365 Apps for enterprise ULS logging
description: There are times during troubleshooting an Office issue when the traditional log settings are not gathering enough information. This article describes how to collect more verbose logging details. 
author: McCoyBot
manager: dcscontentpm
ms.date: 01/31/2020
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 113644
ms.author: ericspli
appliesto:
- Microsoft 365 Apps for enterprise
ms.reviewer: ericspli
---

# How to enable Microsoft 365 Apps for enterprise ULS logging

*This article was written by [Eric Splichal](https://social.technet.microsoft.com/profile/Splic-MSFT), Support Escalation Engineer.*

When you troubleshoot Microsoft Office issues, traditional log settings sometimes don't collect enough information. These might include sign-in issues, installation and patching issues, or even app issues.

To collect more verbose logging details, registry keys must be added:

**For sign-in or activation issues, add the following registry key:**

[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Logging]
"EnableLogging"=dword:00000001

To enable and disable the above key automatically, download and run the following .reg files:

- [Enable-Local-Logging2016](https://msdnshared.blob.core.windows.net/media/2018/06/Enable-Local-Logging2016.zip)
- [Disable-Local-Logging2016](https://msdnshared.blob.core.windows.net/media/2018/06/Disable-Local-Logging2016.zip)

Reproduce the issue and collect the logs for review. The logs (the MachineName-Date-time.log format) are stored under %temp% for sign-in or activation issues.

**For installation or patching issues, run the following commands to add the registry keys:**

```powershell
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel /t REG_DWORD /d 3
```

```powershell
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging /t REG_DWORD /d 1
```
Restart the Microsoft Office Click-to-Run Service inside Services.msc for the logging to take effect.

Reproduce the issue and collect the logs for review. The logs (the MachineName-Date-time.log format) are stored under %windir%\temp and %temp% for installation or patching issues.

> [!NOTE]
> Note the time stamp when you run the repro so that you can collect the correct logs.

After you collect the logs, turn off the Office ULS verbose logging settings. Otherwise, this continues to collect verbose data and use more drive space.
