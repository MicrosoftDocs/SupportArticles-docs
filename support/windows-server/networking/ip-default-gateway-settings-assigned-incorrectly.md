---
title: IP and default gateway settings are assigned incorrectly
description: Works around an issue where IP address and default gateway settings are assigned incorrectly.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.subservice: networking
---
# IP address and default gateway settings are assigned incorrectly in Windows

This article provides a workaround for an issue where IP address and default gateway settings are assigned incorrectly.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2473489

## Symptoms

On a Windows computer, you may experience one of the following issues:

- IP address and default gateway settings are assigned incorrectly.
- After you configure additional IP addresses, the IP addresses are displayed incorrectly when you run the `ipconfig` command.
- After you restart the computer, IP address settings revert to previous settings.  

## Cause

These issues occur because of conflicts between TCP/IP registry settings and data that is managed by Network Input Output (NetIO). In Windows Vista or in later versions of Windows, IP address and default gateway settings are managed by both TCP/IP registry settings and NetIO components. TCP/IP registry settings are under the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip`  

## Workaround

To work around this issue, run the following command to resolve the conflict:  

 ```console
netsh interface ip reset  
  ```

 After you run the command, previous IP address and default gateway settings are reset, and you can reconfigure to the correct settings.  

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
