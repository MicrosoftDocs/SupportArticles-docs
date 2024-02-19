---
title: UAC blocks elevation of executable apps
description: Describes new UAC behavior in Windows 10 that will disallow elevation of executable applications that are signed with revoked certificates.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, deverett, paulhut
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# UAC blocks the elevation of executable applications that are signed with revoked certificates

This article describes new UAC behavior in Windows 10 that will disallow elevation of executable applications that are signed with revoked certificates.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3082125

## Summary

New User Account Control (UAC) behavior in Windows 10 disallows elevation of running applications that use revoked certificates to sign binary files.

## More information

In Windows 10, UAC blocks executable binary files that are signed with revoked certificates.

This behavior prevents users from running certain applications. For example, users cannot run applications whose binary files are signed with stolen certificates.

To run an application, you must have the binaries files signed with valid certificates.
