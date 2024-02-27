---
title: Error 1783 when you open Services.msc
description: Provides a solution to an issue where you get the error 1783 when you open Services.msc.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:microsoft-management-console-mmc, csstroubleshoot
---
# Error 1783: The stub received bad data

This article helps fix the error 1783 that occurs when you open Services.msc.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2028588

## Symptoms

When you open Services.msc, you may get the following error:  

>The system encountered the following error while reading the list of services on:  
Error 1783: The stub received bad data  

Accessing Services remotely may yield the same error. You may be able to Start and Stop the services using sc start and sc stop commands.

## Cause

The number of services installed has exceeded the size limit of the Services.msc buffer. This buffer is limited to 256 kb of data.

## Resolution

Reduce the Number of Services. You can do this by:

1. Uninstall unneeded software that includes services (recommended).

2. Uninstall unneeded services manually:

    1. Go to Registry Editor.
    2. Browse to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services` Key.
    3. Back up the Services registry key and remove unwanted keys to reduce the number of items.

> [!NOTE]
> It is not recommended to remove services manually as unintended side-effects could occur.
