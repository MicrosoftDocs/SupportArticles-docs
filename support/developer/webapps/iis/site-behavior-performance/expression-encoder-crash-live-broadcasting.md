---
title: Expression Encoder crashes
description: This article provides resolutions for the problem where Expression Encoder might crash.
ms.date: 03/20/2020
ms.custom: sap:Site behavior and performance
ms.reviewer: dbristol, marashid
ms.technology: iis-site-behavior-performance
---
# Expression Encoder may crash when live broadcasting

This article helps you resolve the problem where Expression Encoder crashes when it's configured to push a stream to Windows Media Services via Hypertext Transfer Protocol (HTTP).

_Original product version:_ &nbsp; Microsoft Expression Encoder 4  
_Original KB number:_ &nbsp; 2883279

## Symptoms

Expression Encoder 4 is configured to push a stream to Windows Media Services via HTTP. Expression Encoder may crash without reporting any error.

## Cause

This problem may occur if there are problems with the Windows Media Format SDK namespace file, *Wmsdkns.xml*.

## Resolution

Delete the *Wmsdkns.xml* file. After you delete it, Expression Encoder will re-create the *Wmsdkns.xml* file.

See the **Resolution** section of the following KB article for the steps:

[Error message when you try to use Windows Media Player to stream audio or video from Windows Media Services: "The specified protocol is not supported"](https://support.microsoft.com/help/940029)
