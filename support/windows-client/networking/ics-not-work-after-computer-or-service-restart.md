---
title: ICS doesn't work after computer or service restarts in Windows 10
description: Address an issue in which ICS looses settings after computer or service restarts on Windows 10.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# ICS doesn't work after computer or service restarts in Windows 10

This article provides a solution to issues where the Internet Connection Sharing (ICS) settings are lost and the ICS connection doesn't work after you restart the ICS service or the computer that runs Windows 10, version 1709.

_Applies to:_ &nbsp; Windows 10, version 1709  
_Original KB number:_ &nbsp; 4055559

## Symptoms

Consider the following scenario:

- You have a Windows 10, version 1709-based computer that has two network interfaces that connect to two different networks.
- You change the ICS service Startup type to **Automatic**.
- You enable ICS on one of the network interfaces and then confirm that ICS connection works.
- You restart the ICS service or the computer.

In this scenario, the ICS settings are lost, and the ICS connection doesn't work.

> [!NOTE]
> Generally, if there is no traffic on ICS for 4 minutes, the service shuts down and does not restart automatically.

## Resolution

> [!NOTE]
>
> - Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.
> - This solution is currently available only in Windows 10 Version 1709 with update KB 4054517 installed.

To fix this issue, set the following registry subkey, and then change the ICS Service Startup mode to **Automatic**:

- Path: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\SharedAccess`
- Type: DWORD
- Setting: EnableRebootPersistConnection
- Value: 1
