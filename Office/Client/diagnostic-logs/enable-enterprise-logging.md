---
title: Enable enterprise logging for Microsoft 365 Apps
description: This article describes how to collect more logging details as compared to traditional logs.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
ms.date: 09/24/2026
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\InstallErrors\ErrorCodes
  - CSSTroubleshoot
  - CI 113644
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.reviewer: ericspli
---
# Enable enterprise logging for Microsoft 365 Apps

## Summary

When you troubleshoot issues with Microsoft Office, traditional log settings might not collect information for issues with sign-in, installation and patching, or for issues with the app. To collect verbose logging details, you need to add a registry key.

## Enable logging for sign-in and activation issues

To enable logging, run the following command:

```console
reg add HKCU\Software\Microsoft\Office\16.0\Common\Logging /v EnableLogging /t REG_DWORD /d 1
```

To disable logging, run the following command:

```console
reg delete HKCU\Software\Microsoft\Office\16.0\Common\Logging /v EnableLogging 
```

Reproduce the issue and collect the log for review. For sign-in and activation issues, the logs are stored in the %temp% folder. The names of the log files use the *MachineName-Date-time.log* format.

## Enable logging for installation or patching issues

To enable logging, run the following commands:

```console
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel /t REG_DWORD /d 3
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging /t REG_DWORD /d 1
```

To disable logging, run the following commands:

```console
reg delete HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging
reg delete HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel 
```

Restart the Microsoft Office Click-to-Run service inside Services.msc for the logging to take effect.

Reproduce the issue and collect the log for review. For installation or patching issues, the logs are stored in the %temp% folder. The names of the log files use the *MachineName-Date-time.log* format.

## Enable logging for issues with the Serviceability Manager

To enable logging, run the following command:

```console
reg add HKLM\SOFTWARE\Microsoft\Office\C2RSvcMgr /v EnableLocalLogging /t REG_DWORD /d 1
```

To disable logging, run the following command:

```console
reg delete HKLM\SOFTWARE\Microsoft\Office\C2RSvcMgr /v EnableLocalLogging
```

Serviceability Manager is part of [Office Inventory](/deployoffice/admincenter/inventory), which is used as part of [servicing profile](/deployoffice/admincenter/servicing-profile). This type of logging can be used if you experience an issue with inventory. For example, devices aren't displayed on the inventory page in the Microsoft 365 Apps admin center.

The Inventory feature is available in version 2008 (16.0.13127.21064) or later. For Serviceability Manager issues, the logs are stored in the %windir%\temp and %temp% folders. The names of the log files use the *MachineName-Date-time.log* format.

> [!NOTE]
> Note the time stamp when you reproduce the issue so that you collect the correct log file.

After you collect the log file, disable Office verbose logging. Otherwise, the log files will become very large.
