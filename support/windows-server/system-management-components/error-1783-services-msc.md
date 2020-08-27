---
title: Error 1783 when you open Services.msc
description: Provides a solution to an issue where you get the error 1783 when you open Services.msc. 
ms.date: 08/25/2020
author: delhan
ms.author: Delead-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Microsoft Management Console (MMC)
ms.technology: SysManagementComponents
---
# Error 1783: The stub received bad data

This article helps fix the error 1783 that occurs when you open Services.msc.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2028588

## Symptoms

When you open Services.msc, you may get the following error: 

*The system encountered the following error while reading the list of services on:*  
** *Error 1783: The stub received bad data*  

Accessing Services remotely may yield the same error. You may be able to Start and Stop the services using sc start and sc stop commands.

## Cause

The number of services installed has exceeded the size limit of the Services.msc buffer. This buffer is limited to 256 kb of data.

## Resolution

Reduce the Number of Services. You can do this by:

1. Uninstall unneeded software that includes services (recommended)

2. Uninstall unneeded services manually:

a. Go to Registry Editor 
 b. Browse to HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services Key.
 c. Back up the Services registry key and remove unwanted keys to reduce the number of items.

NOTE: It is not recommended to remove services manually as unintended side-effects could occur.
