---
title: Error messages or Access crashes after you install security update MS16-004
description: Discusses a problem in which you receive error messages or Access crashes after you install security update MS16-004. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
ms.date: 03/31/2022
---

# Error messages or Access crashes after you install security update MS16-004

## Symptoms

After you apply security update 2881067, 2881029, 3039794, or 2920727 that are described in security bulletin MS16-004, you have problems that affect your Access database if you use certain Windows common controls. Specifically, these problems occur if you use the controls that are associated with the MSCOMCTL.OCX file that's updated in the security update. These problems may include the following:

- The program crashes when you try to open an object that includes one of the controls.    
- You receive error messages that indicate that events were canceled. Example error messages include (but aren't limited to) the following:

    ```adoc
    Error 459: Object or class does not support the set of events. 
    
    2501: <EventName> action cancelled.
    
    The expression <EventName> you entered as the event property setting produced the following error: Object of class does not support the set of events.   
    ```

## Cause

This problem occurs because security update MS16-004 may prevent certain ActiveX controls from loading correctly within pre-existing Access databases or in Design view.

## Resolution

To fix this problem, reregister the MSCOMCTL.OCX file. If Method 1 does not fix the problem, you may have to use Method 2 to first manually delete a registry key that's associated with MSCOMCTL.OCX.

### Method 1: Reregister MSCOMCTL.OCX from an elevated command prompt

To reregister MSCOMCTL.OCX, follow these steps:

1. Open an administrative command prompt.   
2. On a 64-bit system, run the following commands:
   ```powershell
    Regsvr32 /u "C:\Windows\SysWOW64\MSCOMCTL.OCX" Regsvr32 "C:\Windows\SysWOW64\MSCOMCTL.OCX"
   ```    
3. On a 32-bit system, run the following commands:

   ```powershell
    Regsvr32 /u "C:\Windows\System32\MSCOMCTL.OCX" Regsvr32 "C:\Windows\System32\MSCOMCTL.OCX"
   ```    

### Method 2: Manually update the registry

> [!NOTE]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit all Office programs.   
2. Click **Start**, type regedit in the **Start search** box, and then click **OK**.   
3. In Registry Editor, locate and delete the following 2.0 subkey:

    **HKEY_CLASSES_ROOT\TypeLib\{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}\2.0**   
4. Run steps 1-3 in Method.   

### Method 3 (for administrators): Run a batch file to update systems automatically

> [!NOTE]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

After you successfully determine the fix for this problem in your environment by using Methods 1 and 2, you can automate the process. To do this, follow these steps:

1. Create a text file, and then paste the following text in it:

    ```adoc
    reg delete hkcr\typelib\{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}\2.0 /f
    
    if exist %systemroot%\SysWOW64\cscript.exe goto 64 
    %systemroot%\system32\regsvr32 /u mscomctl.ocx
    %systemroot%\system32\regsvr32 mscomctl.ocx
    exit
    
    :64
    %systemroot%\sysWOW64\regsvr32 /u mscomctl.ocx
    %systemroot%\sysWOW64\regsvr32 mscomctl.ocx 
    Exit
    ```
2. Save the file.   
3. Change the file name extension from .txt to .bat.   
4. Run the .bat file. To do this, right-click it, and then click **Run as Administrator**. (In Windows XP, double-click the file.)

> [!NOTE]
> If you have determined in Method 1 that you don't have to delete the registry key that's mentioned in Method 2 in order to make your application work, you can remove the "reg delete" line from the batch file.

## More Information

The controls that are associated with MSCOMCTL.OCX are listed in the **Insert ActiveX Control** dialog box as follows:

Microsoft ImageComboBox Control 6.0 (SP6)

Microsoft ImageList Control 6.0 (SP6)

Microsoft ListView Control 6.0 (SP6)

Microsoft ProgressBar Control 6.0 (SP6)

Microsoft Slider Control 6.0 (SP6)

Microsoft StatusBar Control 6.0 (SP6)

Microsoft TabStrip Control 6.0 (SP6)

Microsoft Toolbar Control 6.0 (SP6)

Microsoft TreeView Control 6.0 (SP6)

> [!NOTE]
> The version number and service pack level may be something other than "6.0 (SP6)".

Problems are also reported to have occurred in other Office products after this update is installed, although the symptoms may vary from those that occur in Access. In other programs, you may not have to make any changes in the registry.

## References

For more information about this security update, see the following Microsoft Knowledge Base articles: 

- [Microsoft Security Bulletin MS16-004 - Critical](https://technet.microsoft.com/library/security/ms16-004)

- [MS16-004: Description of the security update for Office 2010: January 12, 2016](https://support.microsoft.com/help/2881029)

- [MS16-004: Description of the security update for Office 2013: January 12, 2016](https://support.microsoft.com/help/3039794)

- [MS16-004: Description of the security update for Office 2016: January 12, 2016](https://support.microsoft.com/help/2920727)
