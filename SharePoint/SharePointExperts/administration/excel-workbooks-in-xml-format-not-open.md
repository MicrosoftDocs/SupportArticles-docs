---
title: Excel workbooks in XML format don't open from SharePoint
description: Describes an issue that occurs when you try to open Microsoft Excel workbooks in an XML format (XML Spreadsheet 2003) from a SharePoint document library.
author: helenclu
ms.author: luche
ms.reviewer: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:spsexperts
  - CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# Excel workbooks in XML format don't open from SharePoint

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

When you try to open Microsoft Excel workbooks in an XML format (XML Spreadsheet 2003) from a SharePoint document library, you receive the following error:

> This action couldn't be performed because Office doesn't recognize the command it was given.

## Workaround

To resolve this issue, use the following registry keys according to the version and build of your Office:
> [!WARNING]
> Editing the registry can have harmful side effects if it is not done property, so use this workaround at your own risk.

**32-bit of Office 2013 (Microsoft Installer)**

[HKEY_CLASSES_ROOT\.xml\OpenWithList\excel.exe]

@=""

[HKEY_CLASSES_ROOT\Applications\excel.exe\shell\edit\command]

@="\"C:\\Program Files (x86)\\Microsoft Office\\Office15\\EXCEL.EXE\" /n \"%1\""

[HKEY_CLASSES_ROOT\Applications\excel.exe\SupportedTypes]

".xml"=""

**32-bit of Office 2016 (Microsoft Installer)**

[HKEY_CLASSES_ROOT\.xml\OpenWithList\excel.exe]

@=""

[HKEY_CLASSES_ROOT\Applications\excel.exe\shell\edit\command]

@="\"C:\\Program Files\\Microsoft Office\\Office16\\EXCEL.EXE\" /n \"%1\""

[HKEY_CLASSES_ROOT\Applications\excel.exe\SupportedTypes]

".xml"=""

**64-bit of Office 2016 (Microsoft Installer)**

[HKEY_CLASSES_ROOT\.xml\OpenWithList\excel.exe]

@=""

[HKEY_CLASSES_ROOT\Applications\excel.exe\shell\edit\command]

@="\"C:\\Program Files\\Microsoft Office\\Office16\\EXCEL.EXE\" /n \"%1\""

[HKEY_CLASSES_ROOT\Applications\excel.exe\SupportedTypes]

".xml"=""

**32-bit of Office 2016 (Click-To-Run)**

[HKEY_CLASSES_ROOT\Applications\Excel.exe]

"FriendlyAppName"="@C:\\Program Files\\Microsoft Office\\root\\VFS\\ProgramFilesCommonX86\\Microsoft Shared\\Office16\\oregres.dll,-206"

[HKEY_CLASSES_ROOT\Applications\Excel.exe\shell]

[HKEY_CLASSES_ROOT\Applications\Excel.exe\shell\edit]

@="@C:\\Program Files\\Microsoft Office\\root\\VFS\\ProgramFilesCommonX86\\Microsoft Shared\\Office16\\oregres.dll,-1"

[HKEY_CLASSES_ROOT\Applications\Excel.exe\shell\edit\command]

@="\"C:\\Program Files\\Microsoft Office\\root\\Office16\\EXCEL.EXE\" /n \"%1\""

[HKEY_CLASSES_ROOT\Applications\Excel.exe\SupportedTypes]

".xml"=""

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\Applications\excel.exe\shell\edit\command]

@="\"C:\\Program Files\\Microsoft Office\\Root\\Office16\\EXCEL.EXE\" /n \"%1\""

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\Applications\excel.exe\SupportedTypes]

".xml"=""

[HKEY_CLASSES_ROOT\.xml\OpenWithList\Excel.exe]

@=""

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\.xml\OpenWithList\excel.exe]

@=""

**64-bit of Office 2016 (Click-To-Run)**

[HKEY_CLASSES_ROOT\.xml\OpenWithList\Excel.exe]

@=""

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\.xml\OpenWithList\excel.exe]

@=""

[HKEY_CLASSES_ROOT\Applications\Excel.exe]

"FriendlyAppName"="@C:\\Program Files\\Microsoft Office\\root\\VFS\\ProgramFilesCommonX64\\Microsoft Shared\\Office16\\oregres.dll,-206"

[HKEY_CLASSES_ROOT\Applications\Excel.exe\shell]

[HKEY_CLASSES_ROOT\Applications\Excel.exe\shell\edit]

@="@C:\\Program Files\\Microsoft Office\\root\\VFS\\ProgramFilesCommonX64\\Microsoft Shared\\Office16\\oregres.dll,-1"

[HKEY_CLASSES_ROOT\Applications\Excel.exe\shell\edit\command]

@="\"C:\\Program Files\\Microsoft Office\\root\\Office16\\EXCEL.EXE\" /n \"%1\""

[HKEY_CLASSES_ROOT\Applications\Excel.exe\SupportedTypes]

".xml"=""

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\Applications\excel.exe\shell\edit\command]

@="\"C:\\Program Files\\Microsoft Office\\Root\\Office16\\EXCEL.EXE\" /n \"%1\""

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\Applications\excel.exe\SupportedTypes]

".xml"=""
