---
title: Task Manager may display incorrect memory information
description: Works around an issue in which Task Manager may show the memory speed to be higher or lower than the speed that is reported in the BIOS.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:system performance\performance tools (task manager,perfmon,wsrm,and wpa)
- pcy:WinComm Performance
---
# Task Manager may display incorrect memory information

This article provides a workaround for an issue in which Task Manager shows the memory speed to be higher or lower than the speed that is reported in the BIOS.

_Original KB number:_ &nbsp; 3070928

## Symptoms

When you view memory information in Windows Task Manager, the values that are displayed for reserved hardware and for speed may differ from what is reported in other sources. For example, Task Manager may show the memory speed to be higher or lower than the speed that is reported in the BIOS.

## Cause

This issue occurs because Task Manager parses the SMBIOS memory data incorrectly.

## Workaround

To work around this issue, use an alternative source to view memory information. For example, Resource Monitor displays the correct value of the hardware reserved memory and is included in Windows 7 and later versions.
