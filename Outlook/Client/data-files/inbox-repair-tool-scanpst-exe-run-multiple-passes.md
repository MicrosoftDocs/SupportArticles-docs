---
title: Inbox Repair tool (Scanpst.exe) run multiple passes
description: Discusses that the Inbox Repair tool (Scanpst.exe) can run multiple scans automatically in the Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, vijayde
appliesto: 
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# The Inbox Repair tool (Scanpst.exe) can run multiple passes in Outlook 2016

_Original KB number:_ &nbsp; 4055729

## Summary  

In versions of Microsoft Outlook that are earlier than Microsoft Outlook 2016, version 1807, the Inbox Repair tool (Scanpst.exe) can run only a single pass to scan a damaged Outlook data file (.pst) or Offline Outlook data file (`.ost`). However, multiple passes are sometimes required to fix all errors.

Starting in Outlook 2016, version 1807 (build 16.0.10325.20082), the Inbox Repair tool can be run at a command line to automatically do multiple scans in a batch until a steady state is reached.

## More information

You can now choose to have the Inbox Repair tool run automatically until a steady state is reached.

### Steady state

The steady state is reached when one of the following is true:

- Zero (0) errors are returned
- No new errors are reported (two consecutive passes output the exact same result)
- A maximum number of passes is reached (to avoid a possible loop); currently, the limit is 20 (this value defaults to 10 if it's not specified)

> [!IMPORTANT]
> There is no support for networked .pst files.

### Enabling the new functionality  

Any of the following command line arguments enable the new functionality. Other command line arguments are covered in the **Command-line arguments** table.

- -force
- -silent
- -rescan
- -no repair

If these command line arguments are not used, the legacy code of the tool is used, and the tool behaves as it does in earlier versions. Therefore, you have to run Scanpst.exe at a command prompt to benefit from the new functionality to automatically rescan.

### Tracking the automatic progress

Earlier versions of the Scanpst tool run only eight phases. When you use the **-rescan** argument together with the updated Scanpst tool, the subsequent sets of phases are incrementally numbered. For example, if three rescans are required to reach a steady state, the progression of UI updates is as follows:

- Initial pass: Phases 1 to 8​
- Second pass: Phases 9 to 16​
- Third pass: Phases 17 to 24​

> [!NOTE]
> In addition to the minor UI update that is related to the phase numbering, when you create a log file, each pass is numbered in the log sequentially (Scan Number 1, Scan Number 2, and so on).

### Command line arguments

|Argument|Meaning|Notes|Default|
|---|---|---|---|
|-log| Create a log | Must be followed by one of the following:<br/><br/>append, replace, none | replace|
|-backupfile| A backup file will be created| Must be followed by the desired backup file name.||
|-rescan| Maximum number of scan or repair iterations before reaching steady state| 0-20; any integer greater than 20 defaults to 20.|10|
|-no repair| Run the scan without repairing ||Scan and repair|
|-force| Do not require the user to select any UI options before running or closing the scan or repair| UI is displayed without user interaction, also known as Immediate mode.| Normal mode|
|-silent|Do not show any UI| User must monitor the process to know when it ends. For example, by looking at the .log file (if any), the creation of the .bak file (if backup option is being used), or checking for Scanpst.exe in Task Manager.|Normal mode|
|-file|File to be scanned|Path to `.pst` or `.ost` file||
