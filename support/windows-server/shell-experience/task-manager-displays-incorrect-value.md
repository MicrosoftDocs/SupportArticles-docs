---
title: Task manager displays incorrect value for L2/L3 cache
description: Provides a solution to an issue where task manager may display incorrect value for L2/L3 cache.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jaysenb
ms.custom:
- sap:windows desktop and shell experience\desktop (shell,explorer.exe init,themes,colors,icons,recycle bin)
- pcy:WinComm User Experience
---
# Windows Server task manager may display incorrect value for L2/L3 cache

This article provides a solution to an issue where task manager may display incorrect value for L2/L3 cache.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2022  
_Original KB number:_ &nbsp; 4557856

## Symptoms

Windows Server 2019 and Windows Server 2022 task manager may display an incorrect value for L2/L3 cache.

## Cause

This can occur if the hardware supports a value larger than 64 MB for L2/L3 cache.

## Workaround

You can work around this behavior with the PowerShell command `GWMI -Class Win32_CacheMemory | FT`.
