---
title: Event ID 46 when you start a computer
description: This article describes an issue with Windows operating system, wherein System Event logs report Event ID 46 after a computer restart.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, cachen
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
ms.technology: windows-server-performance
---
# Event ID 46 is logged when you start a computer

This article provides a solution to an issue where Event ID 46 is logged when you start a computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2756313

## Symptoms

The following event is logged in the System log during the boot:

> Log Name: System  
Source: volmgr  
Date: \<Date> \<Time>  
Event ID: 46  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: \<Computer Name>  
Description:  
Crash dump initialization failed!

## Cause

This issue may occur if the computer boots without a configured dump file. The default dump file is the pagefile. During a clean Windows OS installation, the very first boot will hit this condition as the pagefile has not been set up yet.

## Resolution

To resolve this issue, you may want to complete the paging file configuration.

For more information, see [Generate a kernel or complete crash dump](/windows/client-management/generate-kernel-or-complete-crash-dump).

> [!NOTE]
> This event can be ignored if it is logged during a clean install or if no dump file is desired.
