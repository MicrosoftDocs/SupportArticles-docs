---
title: Task manager displays incorrect value for L2/L3 cache
description: Provides a solution to an issue where task manager may display incorrect value for L2/L3 cache.
ms.date: 09/25/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jaysenb
ms.prod-support-area-path: Desktop Shell
ms.technology: windows-server-shell-experience
---
# Windows Server 2019 task manager may display incorrect value for L2/L3 cache

This article provides a solution to an issue where task manager may display incorrect value for L2/L3 cache.

_Applies to:_ &nbsp; Windows Server 2019  
_Original KB number:_ &nbsp; 4557856

## Symptoms

Windows Server 2019 task manager may display an incorrect value for L2/L3 cache.

## Cause

This can occur if the hardware supports a value larger than 64 MB for L2/L3 cache.

## Workaround

You can work around this behavior with the PowerShell command `GWMI -Class Win32_CacheMemory | FT`.

This problem does not occur in either older or newer versions of Windows.
