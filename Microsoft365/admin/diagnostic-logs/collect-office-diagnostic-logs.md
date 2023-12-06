---
title: Increase the size of diagnostic logs for Microsoft 365 Apps for enterprise
description: Provides instructions to increase the size of Office diagnostic logs.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 12/06/2023
---

# Increase the size of diagnostic logs for Microsoft 365 Apps for enterprise

Diagnostic logging is always on in all supported versions of Office applications to store about 120MB of log data per application. If more log data needs to be collected to troubleshoot an issue, you can increase the default size of the log data that is stored.

Use the following steps to increase the size of Office diagnostic logs:

1. Download [OfficeDiagnosticLogging.zip](https://download.microsoft.com/download/2/8/9/ccb152a7-a11e-45da-8764-b5f52045e1d1/OfficeDiagnosticLogging.zip), save the file to a location that will be easy to access by using a command prompt, and then expand the compressed file.
1. Open a Command Prompt window, and locate the folder in which the expanded OfficeDiagnosticLogging.bat script is located.
1. Close all instances of the Office application that you're troubleshooting  (for example, Word, Excel, or PowerPoint).
1. Run the following command:

   ```bat
   OfficeDiagnosticLogging.bat start -MaxSizeIn100MB 4
   ```

   > [!NOTE]
   > The numeral 4 in the command limits Office to collect no more than 400 MB of log data per application.
1. Open the Office application and use it as usual. When the random issue is reproduced, continue to the next step.
1. Close all the Office application windows that experienced the issue (this behavior forces all log data to be flushed to disk).
1. Go to the %temp%\diagnostics folder, and open the appropriate folder for the Office application (for example, WINWORD, EXCEL, or POWERPNT).
1. There may be more than one .log file to gather. Sort the .log files by the modified date and gather all .log files with a "Date modified" time from one hour before the issue's occurrence up to (and including) the most recent .log file. Bundle all gathered .log files into a .zip archive file to send to Microsoft Support.
