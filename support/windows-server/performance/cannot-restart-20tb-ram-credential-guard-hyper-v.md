---
title: Cannot restart a Windows Server computer that uses Credential Guard, Hyper-V, and at least 20 TB RAM
description: Discusses an issue that prevents a Windows Server-based computer from restarting correctly if it has 20 TB or more of RAM, and Credential Guard and the Hyper-V role enabled.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, winciccore, v-tappelgate
ms.custom: sap:system-hang, csstroubleshoot
---

# Cannot restart a Windows Server computer that uses Credential Guard, Hyper-V, and at least 20 TB RAM

This article discusses an issue that prevents a Windows Server-based computer from restarting correctly if the server has 20 TB or more of RAM, and has Credential Guard and the Hyper-V role enabled.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016

## Symptoms

You have a computer that has 20 terabytes or more of RAM, and runs Windows Server 2019 or Windows Server 2016. On this computer, you enable Credential Guard and the Hyper-V role. Depending on the settings, you see the behavior that is described in the following table.

|   |Credential Guard enabled |Credential Guard disabled |
|---|---|---|
|**Hyper-V role&nbsp;enabled** |Computer restarts repeatedly |Computer restarts three times, and stops responding at the Windows startup screen |
|**Hyper-V role&nbsp;disabled** |Computer restarts, and stops responding at the Windows startup screen |Computer restarts correctly |

This issue was originally observed in Lenovo SR950 servers that use 20 TB or more of type 3DS 2933-MHz RAM. It is presumed to also occur in other brands of servers that use 20 TB or more of RAM (including servers that use non-3DS RAM).

## Status

This is a known issue. Microsoft is developing a fix to be included in a future Windows release.
