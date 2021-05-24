---
title: How to enable Microsoft 365 Apps for enterprise logging
description: There are times during troubleshooting an Office issue when the traditional log settings are not gathering enough information. This article describes how to collect more verbose logging details. 
author: helenclu
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

Reproduce the issue and collect the logs for review. The logs are stored under %temp% for sign-in or activation issues in the format MachineName-Date-time.log.

**For installation or patching issues, run the following commands to add the registry keys:**

```powershell
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel /t REG_DWORD /d 3
```

```powershell
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging /t REG_DWORD /d 1
```
Restart the Microsoft Office Click-to-Run Service inside Services.msc for the logging to take effect.

Reproduce the issue and collect the logs for review. The logs are stored under %windir%\temp and %temp% for installation or patching issues in the format MachineName-Date-time.log.

**For issues with Serviceability Manager:**

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\C2RSvcMgr]
"EnableLocalLogging"=dword:00000001

Serviceability Manager is part of [Office Inventory](https://docs.microsoft.com/en-us/deployoffice/admincenter/inventory) which is used as part of [Serviceing Profiles](https://docs.microsoft.com/en-us/deployoffice/admincenter/servicing-profile). This type of logging would be used if you are having an issue with Inventory (ie Devices are not showing up in Inventory from the Office 365 Admin center). 

The Inventory feature is only available from **Version 2008 (16.0.13127.21064) or higher**. The logs are stored under %windir%\temp and %temp% for installation or patching issues in the format MachineName-Date-time.log.

> [!NOTE]
> Note the time stamp when you run the repro so that you can collect the correct logs.

After you collect the logs, turn off the Office verbose logging settings. Otherwise, this continues to collect verbose data and use more drive space.
