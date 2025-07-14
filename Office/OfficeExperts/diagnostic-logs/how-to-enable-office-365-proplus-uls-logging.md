---
title: How to enable Microsoft 365 Apps for enterprise logging
description: There are times during troubleshooting an Office issue when the traditional log settings are not gathering enough information. This article describes how to collect more verbose logging details.
author: helenclu
ms.author: luche
manager: dcscontentpm
ms.date: 06/06/2024
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\InstallErrors\ErrorCodes
  - sap:office-experts
  - CSSTroubleshoot
  - CI 113644
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.reviewer: ericspli
---

# How to enable Microsoft 365 Apps for enterprise logging

*This article was written by [Eric Splichal](https://social.technet.microsoft.com/profile/Splic-MSFT), Support Escalation Engineer.*

When you troubleshoot Microsoft Office issues, traditional log settings sometimes don't collect enough information. These might include sign-in issues, installation and patching issues, or even app issues.

To collect more verbose logging details, registry keys must be added.

**For sign-in or activation issues, run the following commands to add or delete the registry key:**

To enable logging:

```console
reg add HKCU\Software\Microsoft\Office\16.0\Common\Logging /v EnableLogging /t REG_DWORD /d 1
```

To disable logging:

```console
reg delete HKCU\Software\Microsoft\Office\16.0\Common\Logging /v EnableLogging 
```

Reproduce the issue and collect the logs for review. The logs are stored under %temp% for sign-in or activation issues, in the format of *MachineName-Date-time.log*.

**For installation or patching issues, run the following commands to add or delete the registry keys:**

To enable logging:

```console
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel /t REG_DWORD /d 3
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging /t REG_DWORD /d 1
```

To disable logging:

```console
reg delete HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging
reg delete HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel 
```

Restart the Microsoft Office Click-to-Run Service inside Services.msc for the logging to take effect.

Reproduce the issue and collect the logs for review. The logs are stored under %windir%\temp and %temp% for installation or patching issues, in the format of *MachineName-Date-time.log*.

**For issues with the Serviceability Manager, run the following commands to add or delete the registry key:**

To enable logging:

```console
reg add HKLM\SOFTWARE\Microsoft\Office\C2RSvcMgr /v EnableLocalLogging /t REG_DWORD /d 1
```

To disable logging:

```console
reg delete HKLM\SOFTWARE\Microsoft\Office\C2RSvcMgr /v EnableLocalLogging
```

Serviceability Manager is part of [Office Inventory](/deployoffice/admincenter/inventory), which is used as part of [servicing profile](/deployoffice/admincenter/servicing-profile). This type of logging can be used if you experience an issue with Inventory. For example, devices aren't displayed on the inventory page in the Microsoft 365 Apps admin center. 

The Inventory feature is available in version 2008 (16.0.13127.21064) or later. The logs are stored under %windir%\temp and %temp% for Serviceability Manager issues, in the format of MachineName-Date-time.log.

> [!NOTE]
> Note the time stamp when you run the repro so that you can collect the correct logs.

After you collect the logs, **disable Office verbose logging**. Otherwise, the logs will become very large.
