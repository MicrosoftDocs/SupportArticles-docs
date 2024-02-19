---
title: Register OCX and DLL files as system globals
description: Describes how to register OCX and DLL files as system globals.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, willgloy
ms.custom: sap:1st-party-applications, csstroubleshoot
---
# Register OCX and DLL files as system globals

This article describes how to register OCX and DLL files as system globals.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 186597

## Summary

You may receive an error when installing or running an application stating that an OCX file or a DLL file needs to be registered as system global. Make a note of the file that needs to be registered.

## OCX files

1. Start your server in VGA mode.
2. You will need to use the Regsvr.exe, Regsvr16.exe (16-bit), or Regsvr32.exe (32-bit) command to register the OCX file as system global. These commands are included in the development kit when Visual Basic or Visual FoxPro is installed.

Depending on the application, you may have to register several OCX files this way.

## DLL files

To register a DLL as a system global, go to the SYSTEM32 directory and locate the DLL mentioned in the error message. The command to register a file called *Sample.dll* is:

```console
REGISTER /S SAMPLE.DLL
```

Registration data for a program is recognized only when the program is loaded. Therefore, if you issue a `REGISTER` command for a program that is already loaded, the changes will not take effect until the next time the program is loaded.

Also note that only administrators can run `REGISTER`.
