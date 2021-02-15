---
title: Time synchronization may not succeed 
description: Describes a problem that may occur when you try to use a non-Windows NTP time server as a time source. Provides steps to let you synchronize to the non-Windows NTP server.
ms.date: 09/27/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Windows Time Service
ms.technology: windows-server-active-directory
---
# Time synchronization may not succeed when you try to synchronize with a non-Windows NTP server  

This article provides a resolution for the issue that time synchronization may not succeed when you try to synchronize with a non-Windows NTP server.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 875424

## Symptoms

When you try to synchronize your Microsoft Windows Server 2003-based computer to a Network Time Protocol (NTP) server that isn't running Microsoft Windows, the synchronization may not succeed. As this problem occurs, the following events may be recorded in the System log.

## Cause

This problem may occur when your computer sends synchronization requests by using symmetric active mode. By default, Windows Server 2003 domain controllers are configured as time servers and use symmetric active mode to send synchronization requests. Some NTP servers that don't run Windows respond only to requests that use client mode.

## Resolution

To resolve this problem, configure Windows Time to use client mode when it synchronizes with the time server. You can follow these steps:  

1. Click **Start**, click **Run**, type cmd, and then press ENTER.
2. At the command prompt, type the following commands in the given order. After you type each command, press ENTER.

   - w32tm /config /manualpeerlist: **NTP_server_IP_Address**, 0x8 /syncfromflags: MANUAL  
   - net stop w32time  
   - net start w32time  
   - w32tm /resync  

## More information

The mode that Windows Time uses to send requests is set by the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer`  
If the value of the Enabled entry in this subkey is 1, Windows Time uses symmetric active mode. Otherwise, Windows Time uses client mode.

The 0x8 setting that is referenced in the command in the "Resolution" section sets Windows Time to use client mode.

The valid settings for the mode used with the /manualpeerlist switch include:  

- 0x01 - use special poll interval SpecialInterval
- 0x02 - UseAsFallbackOnly
- 0x04 - send request as SymmetricActive mode
- 0x08 - send request as Client mode
