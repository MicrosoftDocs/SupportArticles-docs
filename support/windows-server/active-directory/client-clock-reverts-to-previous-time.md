---
title: Computer clock resets to a previous date and time
description: Describes workarounds for an issue in which the computer clock resets to a past date and time.
ms.date: 02/21/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:windows-time-service, csstroubleshoot
keywords: Windows Time service, w32time, clock skew, NTP
---

# Windows computer clock resets to a previous date and time

This article provides workarounds for an issue in which the computer clock resets incorrectly if you restart the computer while it doesn't have an internet connection.

_Applies to:_ &nbsp; Windows 10 and later versions

_Original KB number:_ &nbsp;3160312

## Symptoms

The system date and time setting on a computer that's running Windows 10 or a later version incorrectly resets to a date and time that's at least one day in the past. This issue might occur in the following scenario:

- The computer is originally connected to the internet.
- The computer is turned off and then restarted while it's connected to a closed private network.
- The private network has no SSL servers (therefore, the computer has no outbound SSL traffic).

Other symptoms include, but aren't limited to, the following:

- Kernel-General event ID 1 in the system log indicates that the time setting has been reset to a past value.
- Events that are recorded in the event log have invalid time stamps that are in the past.
- Kerberos authentication fails.

This behavior overrides changes that were made by an administrator.

## Cause

This issue occurs because of a problem in the Secure Time Seeding feature that's part of Windows Time service. This feature uses metadata from the computer's outgoing SSL connections to determine the approximate current date and time values. It stores this data in the registry. Windows can use this data to set the date and time instead of using data from the Active Directory Domain Services (AD DS) domain hierarchy or from another Network Time Protocol (NTP) server.

When the computer restarts in an environment where it doesn't send any outgoing SSL traffic, the Secure Time Seeding feature doesn't clear or update the old registry data. Instead, the Windows Time service sets the date and time based on the stale Secure Time Seeding information from the registry.

## Workaround

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur.

To work around this issue, try either Method 1 or Method 2, depending on your network environment. If neither of these methods offer a practical solution, try Method 3.

### Method 1: Clear the W32time registry values and force the clock to resynchronize

You can clear the w32time registry state to force synchronize the time on the computer with the internal NTP/NT5DS server. To do this, open an administrative Command Prompt window, and then run the following commands, in sequence:

```console
Net stop w32time
W32tm.exe /unregister
W32tm.exe /register
net start w32time
W32tm.exe /resync /force
```

### Method 2: Reconnect to the internet

Reconnect the computer to the internet. This issue is corrected after the computer has access to the SSL servers on the internet and has outbound SSL traffic.

### Method 3: Disable Secure Time Seeding (optional)

> [!IMPORTANT]  
> We recommend that you try the Method 1 or Method 2 workaround before you disable the Secure Time Seeding feature. If you disable the feature, it remains disabled even after you upgrade to a newer version of Windows.

To disable the Secure Time Seeding feature, follow these steps:

1. In an administrative Command Prompt window, run the following command:
   
   ```console
   reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config /v UtilizeSslTimeData /t REG_DWORD /d 0 /f
   ```
   
   > [!NOTE]  
   > This command sets the value of `UtilizeSslTimeData` (DWORD) to **0**.
   
1. Restart the computer.
1. In an administrative Command Prompt window, run the following commands:
   
   ```console
   Net start w32time
   W32tm.exe /resync /force
   ```

   These commands force the system to resynchronize the date and time. Because Secure Time Seeding is disabled, Windows Time uses NTP to resynchronize.

> [!NOTE]  
> To re-enable the Secure Time Seeding feature, change the `UtilizeSslTimeData` value data to **1**. To do this, run the following command in an administrative Command Prompt window, and then restart the computer:
>  
> ```console
> reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config /v UtilizeSslTimeData /t REG_DWORD /d 1 /f
> ```

## More information

For more information about Secure Time Seeding, see [Time accuracy improvements for Windows Server 2016: Secure Time Seeding](/windows-server/networking/windows-time-service/windows-server-2016-improvements#secure-time-seeding).
