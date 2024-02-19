---
title: Error opening installation log file error when uninstalling an application
description: Provides a workaround for the issue where an error occurs when you uninstall an application.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:msi, csstroubleshoot
---
# Error when trying to uninstall an application: Error opening installation log file. Verify that the specified location exists and is writable

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2564571

## Summary

When you attempt to uninstall any product in "Programs and Features", a new "Windows Installer" window appears and gives the following error:

> Error opening installation log file. Verify that the specified location exists and is writable.

## More information

This issue occurs if the following conditions are true:

- Windows Installer Logging is enabled.
- The Windows Installer engine can't properly write the uninstallation log file.

These conditions occur if the Windows Installer's application heap becomes freed and loses the information on where to store the log file. In this situation, Windows Installer attempts to write to the location *C:\Windows\System32* and addresses it as a file. Proper behavior would be to write to the following location and file name:

*C:\Users\\\<username>\AppData\Local\Temp\MSIxxxxxx.log*.

Microsoft has confirmed it to be a problem in the operating systems listed in the Applies To section of this article.

To work around this issue, stop and restart the Explorer.exe process using Task Manager.
