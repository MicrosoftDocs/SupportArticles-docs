---
title: Error the RPC server is unavailable
description: Provides a resolution for the issue that the system cannot log you on, due to error the RPC server is unavailable.
ms.date: 09/27/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User Logon fails
ms.technology: UserProfilesAndLogon
---
# The system can't log you on with the following error: The RPC server is unavailable 

This article provides a resolution for the issue that the system cannot log you on, due to the following error: The RPC server is unavailable.

_Original product version:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 555839

This article was written by [Yuval Sinay](https://mvp.microsoft.com/en-US/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP

## Community solutions content disclaimer  

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if microsoft or any of its suppliers has been advised of the possibility of damages.

## Summary

The following article will help you to resolve the error "The system cannot log you on with the following error: The RPC server is unavailable".  

## Symptoms

During logon to the domain the following error may appear:

"**The system cannot log you on due to the following error: The RPC server is unavailable**"

## Cause

There can be a few reasons for this problem:

1. Incorrect DNS settings.

2. Incorrect Time and Time zone settings.

3. The "TCP/IP NetBIOS Helper" service isn't running.

4. The "Remote Registry" service isn't running.

## Resolution

1. Verity correct DNS settings.

    Troubleshooting "RPC Server is Unavailable" in Windows

2. Verity correct Time and Time Zone settings.

3. Verity that "**TCP/IP NetBIOS Helper**" is running and set to auto start after restart.

4. Verity that "**Remote Registry**" is running and set to auto start after restart.

    Reboot the computer after changing the required settings.  

## More information

Using Windows Server 2003 in a Managed Environment  
Windows Time Service

You receive a "The RPC server is unavailable" error message when you open Disk Management in Windows XP

Troubleshooting "RPC Server is Unavailable" in Windows
