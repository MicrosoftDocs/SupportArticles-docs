---
title: Cannot restart a Windows Server that has 20 TB of RAM (or more), Credential Guard enabled, and Hyper-V role enabled
description: This article summarizes an issue that prevents a Windows Server computer from restarting correctly when the server has 20 TB or more of RAM, Credential Guard enabled, and the Hyper-V role enabled.
ms.date: 11/20/2020
author: Teresa-Motiv
ms.author: v-tea
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, winciccore
ms.prod-support-area-path: System Hang
ms.technology: Performance
---

# Cannot restart a Windows Server that has 20 TB of RAM (or more), Credential Guard enabled, and Hyper-V role enabled

This article summarizes an issue that prevents a Windows Server computer from restarting correctly when the server has 20 TB or more RAM (or more), Credential Guard enabled, and the Hyper-V role enabled.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016
_Original KB number:_ &nbsp; 4575723

## Symptoms

You have a computer that has 20 terabytes or more of RAM, and runs Windows Server 2019 or Windows Server 2016. On this computer, you enable the Hyper-V role and/or Credential Guard. Depending on the settings, you see the behavior that is described in the following table:

|   |Credential Guard enabled |Credential Guard disabled |
|---|---|---|
|**Hyper-V role enabled** |Computer restarts repeatedly |Computer restarts three times, and then hangs at the Windows startup screen |
|**Hyper-V role disabled** |Computer restarts, and then hangs at the Windows startup screen |Computer restarts correctly |

This issue was originally observed in Lenovo SR950 servers that use 20 TB or more of type 3DS 2933-MHz RAM. It is presumed to occur in servers from other manufacturers that use 20 TB or more of RAM (including servers that use non-3DS RAM).

## Resolution

This is a known issue. Microsoft is in the process of developing a fix to be included in a future Windows release.
