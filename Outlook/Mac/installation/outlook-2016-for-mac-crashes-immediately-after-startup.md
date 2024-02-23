---
title: Outlook 2016 for Mac crashes after startup
description: Describes a scenario in which Outlook 2016 for Mac for crashes immediately after startup and the crash reporter displays an error.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook 2016 for Mac crashes immediately after startup

_Original KB number:_ &nbsp; 3014451

## Symptoms

Microsoft Outlook 2016 for Mac crashes immediately after startup. The crash reporter displays the following error information.

> Exception Type: EXC_BREAKPOINT (SIGTRAP)  
> Exception Codes: 0x0000000000000002, 0x0000000000000000Application Specific Information:
>
> dyld: launch, loading dependent librariesDyld Error Message:  
> Library not loaded: @rpath/osfcore.framework/Versions/A/osfcore
>
> Referenced from: /Applications/Microsoft Outlook.app/Contents/MacOS/Microsoft Outlook  
> Reason:image not found

## Cause

This problem occurs if the underlying file system is formatted as case-sensitive. In this scenario, the file is named **OsfCore.framework**. However, Outlook 2016 for Mac looks for a file that is named **osfcore.framework** and cannot find the file inside the app bundle.

## Workaround

To work around this problem, rename the **OsfCore.framework** file as **osfcore.framework**. To do this, follow these steps:

1. In Finder, open the Application folder.
2. Right-click **Microsoft Outlook,** and then select **Show Package Contents**.
3. Open the Frameworks folder, and then find the OsfCore.framework file.
4. Select **OsfCore.framework**, press Return, and then change the file name to **osfcore.framework**.

## More information

You can use Disk Utility to determine whether the file system is formatted as case-sensitive. To do this, run Disk Utility, select the hard disk drive partition, and then select the **Erase** tab to view the **Format** option that's selected. If either of the case-sensitive options are selected, you may experience this problem.
