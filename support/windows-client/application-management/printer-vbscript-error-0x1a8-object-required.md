---
title: Printer VBScript error 0x1A8
description: Fixes a 0x1A8 error that occurs when you use the print-related Visual Basic script files on a 64-bit Windows operating system.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:com-and-com+-performance-and-stability, csstroubleshoot
---
# Printer VBScript error: 0x1A8. Object required

This article provides help to fix a 0x1A8 error that occurs when you use the print-related Visual Basic script files on a 64-bit Windows operating system.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 2466246

## Symptoms

You may receive a message similar to one of the following if you attempt to use the print-related Visual Basic script files on a 64-bit Windows operating system.

- Unable to enumerate printers, error: 0x1A8. Object required
- Unable to enumerate printers on server, error: 0x1A8. Object required
- Unable to enumerate forms, error: 0x1A8. Object required
- Unable to enumerate ports, error: 0x1A8. Object required
- Unable to enumerate drivers, error: 0x1A8. Object required
- Unable to add printer connection, error: 0x1A8. Object required
- Unable to delete printer connection, error: 0x1A8. Object required
- Unable to get the default printer, error: 0x1A8. Object required
- Unable to set the default printer, error: 0x1A8. Object required
- Unable to add driver, error: 0x1A8. Object required
- Unable to delete driver, error: 0x1A8. Object required
- Unable to delete drivers on server, error: 0x1A8. Object required
- Unable to list drivers, error: 0x1A8. Object required
- Unable to print the dependent files, error: 0x1A8. Object required
- Unable to add form, error: 0x1A8. Object required
- Unable to delete form, error: 0x1A8. Object required
- Unable to delete printer,  error: 0x1A8. Object required
- Unable to save the configuration of the printer, error: 0x1A8. Object required
- Unable to restore the configuration of the printer, error: 0x1A8. Object required
- Unable to get the configuration for the port, error: 0x1A8. Object required
- Unable to convert the port, error: 0x1A8. Object required
- Unable to add the TCP port, error: 0x1A8. Object required
- Unable to list ports, error: 0x1A8. Object required
- Unable to get port configuration, error: 0x1A8. Object required
- Unable to update port settings, error: 0x1A8. Object required
- Unable to get the printer config, error: 0x1A8. Object required
- Unable to configure printer, error: 0x1A8. Object required
- Unable to pause printer, error: 0x1A8. Object required
- Unable to resume printer, error: 0x1A8. Object required
- Unable to purge printer, error: 0x1A8. Object required
- Unable to send test page to printer, error: 0x1A8. Object required
- Unable to list printers, error: 0x1A8. Object required

## Cause

You must register PRNADMIN.DLL with the 32-bit version of REGSVR32.EXE, and also run the script using the 32-bit version of CSCRIPT.EXE.

## Resolution

- Use REGSVR32.EXE located in the %windir%\syswow64 folder to register PRNADMIN.DLL.

    ```console
    %windir%\syswow64\regsvr32.exe PRNADMIN.DLL
    ```

- Use CSCRIPT.EXE located in the %windir%\syswow64 folder to run the script:

    ```console
    %windir%\syswow64\cscript.exe <vbscript>
    ```

## More information

The following visual basic scripts for manipulating printers are included with the Windows Server 2003 Resource Kit.

- clean.vbs - delete all printing components from the specified machine, as if the machine were clean installed.
- clone.vbs - printer server cloning script for Windows .NET Server 2003
- conall.vbs - connects to all printers on a print server
- defprn.vbs - default printer script for Windows .NET Server 2003
- drvmgr.vbs - driver script for Windows .NET Server 2003
- forms.vbs - form script for Windows .NET Server 2003
- persist.vbs - script for saving and restoring printer configuration
- portconv.vbs - Script for converting lpr ports to tcp ports
- PortMgr.vbs - Port operation script for Windows .NET Server 2003
- prncfg.vbs - printer configuration script for Windows .NET Server 2003
- prnctrl.vbs - printer control script for Windows .NET Server 2003
- prndata.vbs - printer data configuration script for Windows .NET Server 2003
- prnmgr.vbs - printer script for Windows .NET Server 2003

## Resource Kit support policy

The software supplied in the Windows Resource Kit Tools is not supported under any Microsoft standard support program or service. The software (including instructions for its use and all printed and online documentation) is provided as is without warranty of any kind. Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the SOFTWARE and documentation remains with you.
