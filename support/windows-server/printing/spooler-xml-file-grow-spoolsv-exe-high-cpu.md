---
title: Spooler.xml file growth and high CPU in spoolsv.exe process on print server
description: Resolves an issue where you experience higher CPU utilization in the spoolsv.exe process and the spooler.xml file grows in size.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Spooler.xml file growth and high CPU in spoolsv.exe process on print server

This article helps resolve an issue where you experience higher CPU utilization in the spoolsv.exe process and the spooler.xml file grows in size.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 960919

## Symptoms

Windows Server print server may experience higher than normal CPU utilization in the spoolsv.exe process. The spooler.xml file located in %systemroot%\\system32\\spool\\ folder will also grow in size and may exhaust all available disk space.

## Cause

If the print spooler (spoolsv.exe) is under stress or the print server is busy and the spooler enters an error condition, the errors are written to the spooler.xml file. The CPU utilization is caused by the spooler process rapidly writing the errors to the log file and the file will continue to grow until the error condition ceases or the operating system is restarted.

## Resolution

You can work around this problem by disabling Windows Error Reporting for the print spooler. To disable WER, perform the following steps:

1. Open the Registry Editor by running regedit.exe.

2. Browse to the following registry key:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print\`.

3. Add a REG_DWORD value named DisableWERLogging and set this value to 0x1 (hexadecimal).

4. Restart the Print Spooler service.

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied, or statutory, including but not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
