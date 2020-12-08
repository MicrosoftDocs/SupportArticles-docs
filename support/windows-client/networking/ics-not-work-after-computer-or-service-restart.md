---
title: ICS doesn't work after computer or service restart on Windows 10
description: Address an issue in which ICS looses settings after computer or service restarts on Windows 10.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# ICS doesn't work after computer or service restart on Windows 10

_Original product version:_ &nbsp; Windows 10, version 1709, all editions, Windows 10, version 1703, all editions, Windows 10, version 1607, all editions  
_Original KB number:_ &nbsp; 4055559

## Summary

Consider the following scenario:
- You have a Windows 10 Version 1607, Windows 10 Version 1703, or Windows 10 Version 1709-based computer that has two network interfaces that connect to two different networks.
- You change the **Internet Connection Sharing (ICS)** service **Startup type** to **Automatic**.
- You enable ICS on one of the network interfaces and then confirm that ICS connection works.
- You restart the ICS service or the computer.
In this scenario, the ICS settings are lost, and the ICS connection doesn't work.
 **Note** Generally, if there is no traffic on ICS for 4 minutes, the service shuts down and does not restart automatically.

## Resolution

**Note**  This solution is currently available only in Windows 10 Version 1709 with [update KB 4054517]() installed.
To fix this issue, set the following registry subkey:Path: HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\SharedAccess Type: DWORD Setting: EnableRebootPersistConnection Value: 1
Then, change the ICS Service Startup mode to **Automatic**.
