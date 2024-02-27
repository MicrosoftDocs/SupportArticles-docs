---
title: Time synchronization may not succeed
description: Describes a problem that may occur when you try to use a non-Windows NTP time server as a time source. Provides steps to let you synchronize to the non-Windows NTP server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-time-service, csstroubleshoot
---
# Time synchronization may not succeed when you try to synchronize with a non-Windows NTP server  

When you try to synchronize a Windows-based computer to a Network Time Protocol (NTP) server that isn't running Windows, the synchronization may not succeed. This article provides a resolution to this issue.

_Applies to:_ &nbsp; Support versions of Windows Server  
_Original KB number:_ &nbsp; 875424

## Cause

This problem may occur when your computer sends synchronization requests by using symmetric active mode. By default, Windows Server 2003 domain controllers are configured as time servers and use symmetric active mode to send synchronization requests. Some NTP servers that don't run Windows respond only to requests that use client mode.

## Resolution

To resolve this problem, configure Windows Time to use client mode when it synchronizes with the time server. Follow these steps:  

1. Select **Start**, search for *cmd*, right-click **Command Prompt**, and then select **Run as administrator**.
2. In the Command Prompt window, run the following commands:

   ```console
   w32tm /config /manualpeerlist:<NTP_server_IP_Address>,0x8 /syncfromflags:MANUAL
   net stop w32time
   net start w32time
   w32tm /resync
   ```

## More information

The mode that Windows Time uses to send requests is set by the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer`  
If the value of the **Enabled** entry in this subkey is 1, Windows Time uses symmetric active mode. Otherwise, Windows Time uses client mode.

The 0x8 setting that is referenced in the command in the "Resolution" section sets Windows Time to use client mode.

The valid settings for the mode used with the /manualpeerlist switch include:  

- 0x01 - use special poll interval SpecialInterval
- 0x02 - UseAsFallbackOnly
- 0x04 - send request as SymmetricActive mode
- 0x08 - send request as Client mode
