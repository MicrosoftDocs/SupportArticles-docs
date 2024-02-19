---
title: Fail to register a DLL by using Regsvr32.exe
description: Provides a solution to a 0x80070005 error that occurs when you register a DLL by using Regsvr32.exe.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, aanders
ms.custom: sap:desktop-shell, csstroubleshoot
---
# You receive 0x80070005 error when you try to register a DLL by using Regsvr32.exe

This article provides a solution to a 0x80070005 error that occurs when you register a DLL by using Regsvr32.exe.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 827659

## Symptoms

When you try to register a dynamic-link library (or DLL, or .dll file) by using the Regsrv32.exe command-line tool, the DLL is not registered, and you may receive the following error message:

> DllRegisterServer in **file_name**.dll failed.
>
> Return code was: 0x80070005

> [!NOTE]
> This behavior does not occur in Windows NT 4.0 or Windows 2000.

## Cause

This behavior may occur if you try to register a DLL by using Regsrv32 while you are logged on using an account that does not have administrative credentials, such as an account that is a member of the standard users group. An account that does not have administrative credentials cannot write to the registry or change files in the System32 folder.

The behavior occurs because Windows XP and Windows Server 2003 use a more restrictive security scheme than earlier versions of Windows use. This scheme prevents standard users from registering DLLs.

> [!NOTE]
> Because of this behavior, standard users may not be able to run programs that self-register DLLs by using standard user's ID.

## Resolution

To resolve this behavior, log on by using an administrator account, and then register the DLL.

## More information

You can register a DLL by using an account that does not have administrative credentials as long as the DLL does not write to the registry or change files in the System32 folder.
