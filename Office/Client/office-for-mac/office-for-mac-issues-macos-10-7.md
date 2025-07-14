---
title: Known issues with Office for Mac on macOS 10.7 (Lion) and Higher
description: Lists Office for Mac issues under macOS 10.7 (Lion).
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Office for Mac 2004
  - Office for Mac 2008
  - Office for Mac 2011
ms.date: 06/06/2024
---

# Known issues with Office for Mac on macOS 10.7 (Lion) and Higher

## Summary

This article discusses known issues that may occur with Office for Mac applications on macOS 10.7 (Lion).

> [!NOTE]
> - Microsoft has been working with Apple from the early days of MacOS 10.7 (Lion). Through this partnership, many issues were addressed leading up to the Lion release. Microsoft will continue to work closely with Apple to address problems that may occur with Office for Mac 2008 and 2011 and Lion OS.
> - Sync services are not available with OSX versions 10.8 (Mountain Lion) or higher.

## More information

There are two major Office for Mac issues Microsoft is aware of running on Lion: 

1. Communicator for Mac crashes when you send an IM or start an audio/visual call.
    > [!NOTE]
    > Microsoft will resolve this issue in an upcoming update to Communicator for Mac.

2. Office for Mac 2004 won't run on Lion.
    > [!NOTE]
    > Previous MacOS versions supported Rosetta, an Apple Mac OSX bridge technology that enabled applications such as Office for Mac 2004 to run on the latest chip architecture for Mac. Because Lion no longer supports Rosetta, applications that relied on it will no longer function under the new MacOS.

Here's a list of other known issues that Microsoft is currently investigating. These issues will likely only be encountered in specific situations or configurations:

Excel 2008 or 2011

- Excel may crash when you move a sheet from one workbook to another workbook.   
- Excel 2011: MSQuery for English works on Lion. However, it will not work on other language versions of Excel 2011 on Lion.   
- Excel 2008: MSQuery won't work on any version of Excel 2008 on Lion.   
- The date format may display the year as two digits instead of four digits.   

Word 2008 or 2011

- The date format may display the year as two digits instead of four digits.   

PowerPoint 2008 or 2011

- Pressing the Command and Tab keys to open another application while in Presenter View may crash PowerPoint.   
- Switching out of or quitting Slide Show in full-screen mode may result in inconsistent window behavior.   
- You may be prompted to save your presentations when switching windows.   

Entourage 2008 or Outlook 2011

- You may be unable to import messages from Lion Mail.   

Office 2008 or 2011

- Reference tools may have redraw problems and links may not work.   
- Chart data labels may not be visible.   
- Equation editor may not function correctly.   

Web Applications

- May not correctly open the file in the rich client application. The following workaround works with Safari or Firefox:
  1. Quit Safari or Firefox.   
  2. On the **Go** menu, click **Applications**.   
  3. Select Safari or Firefox.   
  4. On the **File** menu, click **Get Info**.   
  5. Select the check box for **Open in 32-bit mode**.   
  6. Quit and open Safari or Firefox.
