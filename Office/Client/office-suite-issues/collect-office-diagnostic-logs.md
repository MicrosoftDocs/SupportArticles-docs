---
title: Increase the Size of Diagnostic Logs for Office
description: Provides instructions to increase the size of Office diagnostic logs.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - CSSTroubleshoot
ms.date: 06/06/2025
---

# Increase the size of diagnostic logs for Office

Diagnostic logging is always on in all supported versions of Office applications to store about 120 MB of log data per application. If you need to collect more log data to troubleshoot an issue, you can increase the default size of the log data that's stored.

To increase the size of Office diagnostic logs, follow these steps:

1. Download [OfficeDiagnosticLogging.zip](https://download.microsoft.com/download/2/8/9/ccb152a7-a11e-45da-8764-b5f52045e1d1/OfficeDiagnosticLogging.zip) and save the file to a location that's easy to access by using a command prompt.
1. Unzip the compressed file.
1. Open a Command Prompt window, and locate the folder where you extracted the OfficeDiagnosticLogging.bat script.
1. Close all instances of the Office application that you're troubleshooting.
1. Run the following command:

   ```console
   OfficeDiagnosticLogging.bat start -MaxSizeIn100MB 4
   ```

   > [!NOTE]
   > This command limits Office to collecting no more than 400 MB of log data per application. You can change the 4 in the command to another number that's appropriate for your available disk space and logging needs.
1. Open the Office application, and use it as usual. After the random issue is reproduced, go to the next step.
1. Close all the Office application windows that experienced the issue. This action forces all log data to be flushed to disk.
1. Go to the %temp%\diagnostics folder, and open the corresponding folder for the Office application, such as WINWORD, EXCEL, or POWERPNT.
1. There may be more than one .log file to collect. Sort the .log files by the modified date, and collect all .log files that have a **Date modified** time from one hour before the issue's occurrence up to (and including) the most recent .log file. Compress all collected .log files into a .zip archive file to send to Microsoft Support.
