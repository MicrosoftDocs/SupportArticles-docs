---
title: Print Spooler errors
description: Provides a solution to fix Print Spooler errors that occurs after you install or upgrade a Third-Party print driver.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, jdickson
ms.custom: sap:management-and-configuration-installing-print-drivers, csstroubleshoot
ms.subservice: printing
---
# You experience Print Spooler error messages after you install or upgrade a Third-Party print driver

This article provides a solution to fix Print Spooler errors that occurs after you install or upgrade a Third-Party print driver.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2793718

## Symptoms

You may experience any of the following symptoms on your Windows-based client computer:

- During the install or upgrade of a third-party print driver, you may receive the following error messages:

  - Operation failed with error 0x00000057
  - Printer driver was not installed.  Operation could not be completed (error 0x00000057)
  - Operation failed with error 0x000005b3
  - Operation could not be completed (error 0x00000bc4). No printers were found.
  - Windows cannot connect to the printer. Operation could not be completed (error 0x00000002)

- When you try to start or stop the Print Spooler service, you may receive the following error message:

    > Spooler subsystem app has encountered a problem and needs to close

- When you click **Start**, and then click **Printers and Faxes** in Windows XP, or **Devices and Printers** in Windows Vista or later, you may receive the following error message:

    > Spooler subsystem app has encountered an error and needs to close

- When you click **Start**, and then click **Printers and Faxes** in Windows XP, or **Devices and Printers** in Windows Vista or later to try to view your printers, no printers appear.  This issue may occur even if you have printers installed.

## Cause

These issues may occur if a third-party printer driver or service affects the functionality of an existing or newly installed printer.

## Resolution

To clear and reset the print spooler, follow these steps:

1. In the search box on the taskbar, type *services*, and then select **Services** in the list of results.
2. Select the **Standards** tab, and then double-click **Print Spooler** in the list of services.
3. Select **Stop**, and then select **OK**.
4. In the search box on the taskbar, enter *%WINDIR%\system32\spool\printers*, select %WINDIR%\system32\spool\PRINTERS in the list of results, and then delete all files in the folder.
5. In the search box on the taskbar, search for services, and then select **Services** in the list of results.
6. Select the **Standards** tab, and the double-click **Print Spooler** in the list of services.
7. Select **Start**, select **Automatic** in the **Startup Type** box, and then select **OK**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
