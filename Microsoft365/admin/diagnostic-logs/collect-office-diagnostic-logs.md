---
title: Enable Microsoft 365 Apps for enterprise ULS logging for random issues
description: Describes how to collect Office diagnostic logs for Office support professionals to troubleshoot Office issues.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: v-maqiu
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 3/31/2022
---

# How to enable ULS logging for Microsoft 365 Apps for enterprise

To troubleshoot Office issues, Microsoft Office support professionals may have to review advanced log data that's created by Office applications.

To collect Office diagnostic logs, follow these steps:

1. Download [OfficeDiagnosticLogging.zip](https://download.microsoft.com/download/2/8/9/ccb152a7-a11e-45da-8764-b5f52045e1d1/OfficeDiagnosticLogging.zip), save the file to a location that will be easy to access by using a command prompt, and then expand the compressed file.
1. Open a Command Prompt window, and then locate the folder in which the expanded OfficeDiagnosticLogging.bat script is located.
1. Close all instances of the Office application that you're troubleshooting  (for example, Word, Excel, or PowerPoint).
1. Run the following command:

   ```bat
   OfficeDiagnosticLogging.bat start -MaxSizeIn100MB 4
   ```

   > [!NOTE]
   > The numeral 4 here limits Office to collect no more than 400 MB of log data per application.
1. Use the Office application as usual. When the random issue is reproduced, continue to the next step.
1. Close all the Office application windows that experienced the issue (this behavior forces all log data to be flushed to disk).
1. Go to the %temp%\diagnostics folder, and then open the application folder that's being used (for example, WINWORD, EXCEL, or POWERPNT).
1. There may be more than one .log file to gather. Sort the .log files by the modified date and gather all .log files with a "Date modified" time from one hour before the issue occurrence up to (and including) the most recent .log file. Bundle all gathered .log files into a .zip archive file.
1. Send the compressed (.zip) file to Microsoft Support.
1. Turn logging off to prevent decreased performance and excessive disk consumption. To do this, run the following command at a command prompt:

   ```bat
   OfficeDiagnosticLogging.bat stop
   ```