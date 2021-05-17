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
ms.technology: windows-server-user-profiles
---
# The system can't log you on with the following error: The RPC server is unavailable 

This article provides a resolution for the issue that the system cannot log you on, due to the following error: The RPC server is unavailable.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 555839

This article was written by [Yuval Sinay](https://mvp.microsoft.com/en-US/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP

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

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]