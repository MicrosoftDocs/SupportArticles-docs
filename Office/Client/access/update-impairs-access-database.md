---
title: An update impairs functionality of Access Database
description: Describes an issue in which you may experience problems with your Access database after applying security update MS12-060.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Access 2010
  - Access 2007
  - Access 2003
ms.date: 03/31/2022
---

# Security Update MS12-060 Impairs Functionality of Access Database

## Symptoms

After applying security update MS12-060 you may experience problems with your Access database if you are using any of the Windows Common Controls associated with the MSCOMCTL.OCX file updated in the patch. Problems may include hanging on opening an object that includes one of the controls, or error messages indicating that events have been cancelled. Example error messages may include (but aren't limited to) the following:

```adoc
Error 459: Object or class does not support the set of events. 

2501: <EventName> action cancelled.

The expression<EventName> you entered as the event property setting produced the following error: Object of class does not support the set of events.
```

## Cause

Security update MS12--060 may cause certain ActiveX controls to fail to load properly within pre-existing Access databases and when inserting controls in design view.

## Resolution

Method 1: Apply the fix from the appropriate link below:

Office 2010: [https://support.microsoft.com/kb/2597986](https://support.microsoft.com/help/2597986)

Office 2003:  [https://support.microsoft.com/kb/2687323](https://support.microsoft.com/help/2687323)

Method 2: Re-register MSCOMCTL.OCX from an elevated command prompt

1. Open a Command Prompt with elevated privileges.
2. If working on a 64-bit system, execute the following two commands:

    Regsvr32 /u "C:\Windows\SysWOW64\MSCOMCTL.OCX"

    Regsvr32 "C:\Windows\SysWOW64\MSCOMCTL.OCX"
3. If working on a 32-bit system, execute these commands instead:

    Regsvr32 /u "C:\Windows\System32\MSCOMCTL.OCX"

    Regsvr32 "C:\Windows\System32\MSCOMCTL.OCX"

Method 3: Manually update the registry

In some cases, registering and unregistering MSCOMCTL.OCX with elevated permissions won't be enough to fix the problem in a database. In those situations, manual deletion of a registry key associated with MSCOMCTL.OCX may be necessary.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756)。

1. Quit all Office programs.
2. Click Start, then Run.
3. In the Open box, type "regedit" (without quotes) and click OK. 
4. Browse to and remove the following 2.0 key from the registry:

    HKEY_CLASSES_ROOT\TypeLib\\{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}\2.0
5. Run steps 1-3 from Method 1 above.

Method 4: Execute a batch file to update your system automatically

**NOTE**: Backing up the registry is recommended prior to executing these steps.

1. Create a new text file and copy and paste the following to it:

    reg delete hkcr\typelib\\{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}\2.0 /f

    if exist %systemroot%\SysWOW64\cscript.exe goto 64 

    %systemroot%\system32\regsvr32 /u mscomctl.ocx

    %systemroot%\system32\regsvr32 mscomctl.ocx

    exit

    :64

    %systemroot%\sysWOW64\regsvr32 /u mscomctl.ocx

    %systemroot%\sysWOW64\regsvr32 mscomctl.ocx

    Exit
2. Save the file.
3. Change the file extension from .TXT to .BAT.
4. Run the .BAT file by right-clicking on it and choosing 'Run as Administrator' (XP users can simply double-click to run the file).

**NOTE**: You can remove the reg delete line from the batch file if you have found that you don't need to remove the registry key listed above to get your application to work. 

## More Information

Controls associated with MSCOMCTL.OCX are listed in the Insert ActiveX Control dialog box as:

Microsoft ImageComboBox Control 6.0 (SP6)

Microsoft ImageList Control 6.0 (SP6)

Microsoft ListView Control 6.0 (SP6)

Microsoft ProgressBar Control 6.0 (SP6)

Microsoft Slider Control 6.0 (SP6)

Microsoft StatusBar Control 6.0 (SP6)

Microsoft TabStrip Control 6.0 (SP6)

Microsoft Toolbar Control 6.0 (SP6)

Microsoft TreeView Control 6.0 (SP6)

**Note**: The version number and service pack level may be something other than "6.0 (SP6)".

Problems have also surfaced in other Office products after adding the patch, though symptoms may be different than those seen in Access. Removal of the registry key as noted above may not be necessary to address issues in those cases. 

See these KB articles for more information on the security update: 

- [MS12-060: Description of the security update for Office 2010: August 14, 2012](https://support.microsoft.com/help/2597986)

- [MS12-060: Description of the security update for Office 2003 and Office 2003 Web Components: August 14, 2012](https://support.microsoft.com/help/2687323)
