---
title: Add-ins are registered under \Wow6432Node
description: Discusses a behavior that add-ins for Office programs may be registered under the \Wow6432Node.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2013
  - Word 2013
  - Excel 2013
  - Microsoft Outlook 2010
  - Microsoft Word 2010
  - Excel 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Excel 2007
  - Microsoft Office Outlook 2003
  - Microsoft Office Word 2003
  - Microsoft Office Excel 2003
search.appverid: MET150
ms.date: 01/30/2024
---
# Add-ins for Office programs may be registered under the \Wow6432Node

_Original KB number:_ &nbsp; 2778964

## Summary

If you have a 32-bit version of Office installed on a 64-bit version of Windows, add-ins that are registered under `HKEY_LOCAL_MACHINE` will be registered under the `\Wow6432Node` subkey. For example:

`HKEY_LOCAL_MACHINE\software\Wow6432Node\microsoft\office\Outlook\Addins`

This is important to remember if you are troubleshooting problems in your Office programs and you need to disable add-ins. If you are not modifying the correct registry data (because you do not realize you are running 32-bit Office on a 64-bit version of Windows), then your changes will not change the add-in behavior.

## More information

COM add-ins register themselves in the Windows Registry under either the `HKEY_CURRENT_USER` or `HKEY_LOCAL_MACHINE` hives. But, if you are using a 64-bit version of Windows, the subkey under `HKEY_LOCAL_MACHINE` will vary depending on the bitness of your Office installation. See the following table for the correct registry location for the different combinations of 32-bit/64-bit versions of Office and Windows.

|Window bitness|Office bitness|COM add-in registry location under HKEY_LOCAL_MACHINE|
|---|---|---|
|32-bit|32-bit|HKEY_LOCAL_MACHINE\Software\Microsoft\Office\\<*application*>\Addins|
|64-bit|64-bit|HKEY_LOCAL_MACHINE\Software\Microsoft\Office\\<*application*>\Addins|
|64-bit|32-bit|HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\\<*application*>\Addins|
|32-bit|64-bit|It is not possible to install a 64-bit version of Office on a 32-bit version of Windows|

> [!NOTE]
> If you have a 64-bit version of Windows, add-ins that register themselves under `HKEY_CURRENT_USER` are not affected by this nuance.

Use the following steps to determine the bitness of Windows you are using.

- Windows 7
  1. Select **Start**, right-click **Computer** and then select **Properties**.
  2. Note the bitness of Windows next to System type under **System**.
- Windows 8
  1. Press Window+X.
  2. Select **System**.
  3. Note the bitness of Windows next to System type under **System**.

Use the following steps to determine the bitness of Office you are using.

- Office 2010
  1. Start an Office program.
  2. On the **File** tab, select **Help**.
  3. Note the bitness next to the version number in the right-side of the Help section.

- Office 2013
  1. Start an Office program.
  2. On the **File** tab, select **Account** (select **Office Account** in Outlook).
  3. In the right-pane, select About <*program*>.
  4. Note the bitness next to the version number in the About <*program*> dialog box.
