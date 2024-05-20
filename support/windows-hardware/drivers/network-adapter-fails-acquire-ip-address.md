---
title: Network adapter fails to acquire an IP address
description: This article provides resolutions for the problem that prevents network cards from acquiring an IP address via DHCP at startup in a Windows Embedded 2009 environment. This problem occurs intermittently.
ms.date: 09/01/2020
ms.custom: sap:Windows Embedded POSReady 2009
ms.subservice: general
---
# Network adapter fails to acquire an IP address through DHCP at startup

This article helps you resolve the problem that prevents network cards from acquiring an IP address via DHCP at startup in a Windows Embedded 2009 environment.

_Original product version:_ &nbsp; Windows Embedded POSReady 2009, Windows Embedded Standard 2009  
_Original KB number:_ &nbsp; 3139296

## Symptoms

In Windows Embedded POSReady 2009 and Windows Embedded Standard 2009, network adapters may intermittently fail to acquire an IP address using DHCP at startup and shortly afterward. After the system has fully started, DHCP and other affected networking services work as expected.

## Cause

The default value for the `HKLM\SYSTEM\CurrentControlSet\Services\AFD` registry key with the REG_DWORD value that's named Start is **0x2**. This setting causes the `AFD.SYS` service to load late in the startup process. In turn, delays the startup of the DHCP service and other networking services because they require `AFD.SYS` to load earlier in the startup process.

## Resolution

In the `HKLM\SYSTEM\CurrentControlSet\Services\AFD` registry key, change the value of Start to **0x1**. This value allows the startup sequence to function correctly.
