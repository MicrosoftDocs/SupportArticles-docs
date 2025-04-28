---
title: w32tm /resync command fails with "The computer didn't resync because no time data was available."
description: Describes a resync failure that can be due to multiple different causes.
ms.date: 03/20/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, karanr
ms.custom:
- sap:active directory\windows time service configuration,accuracy,and synchronization
- pcy:WinComm Directory Services
---
# "w32tm /resync" fails with "The computer didn't resync because no time data was available."

This article provides several possible solutions to an error that you may get when you run the `w32tm /resync` command to synchronize time with a time source.

_Applies to:_ &nbsp; Windows Server (All supported versions)  
_Original KB number:_ &nbsp; 929276

## Symptoms

The machine is having time synchronization issues. If you run a manual resync by running `w32tm /resync`, the following error is returned: **The computer did not resync because no time data was available.**

```console
C:\Windows\system32>w32tm /resync /rediscover
Sending resync command to local computer
The computer did not resync because no time data was available
```

You may also see the following events:

> Log Name: System  
> Source: Microsoft-Windows-Time-Service  
> Date: 24-04-2019 22:35:55  
> Event ID: 129  
> Task Category: None  
> Level: Warning  
> Keywords:  
> User: LOCAL SERVICE  
> Computer: MEM1.fabrikam.com  
> Description: NtpClient was unable to set a domain peer to use as a time source because of discovery error. NtpClient will try again in 15 minutes and double the reattempt interval thereafter. The error was: The entry is not found. (0x800706E1)

> Log Name: System  
> Source: Microsoft-Windows-Time-Service  
> Date: 24-04-2019 23:45:32  
> Event ID: 134  
> Task Category: None  
> Level: Warning  
> Keywords:  
> User: LOCAL SERVICE  
> Computer: MEM1.fabrikam.com  
> Description: NtpClient was unable to set a manual peer to use as a time source because of DNS resolution error on 'time.windows.com,0x9'. NtpClient will try again in 15 minutes and double the reattempt interval thereafter. The error was: No such host is known. (0x80072AF9)

## Cause

This error generally occurs when the client sends an NTP request but doesn't get a proper NTP response in return. There are multiple scenarios that can cause this.

### Scenario 1

The NTP client can't find the NTP server. This could be due to name resolution (DNS) failing or due to a misspelling of the name/IP address defined in the NTPServer registry key.

### Scenario 2

UDP port 123 is blocked. This might be at the local Windows Firewall or on a non-Microsoft firewall.

### Scenario 3

The target NTP server the client is trying to sync time with isn't advertising as an NTP Server.

## Resolution

### Resolution for scenario 1

1. Check the spelling and accuracy of the value defined in the NTPServer registry key. Have the customer verify it’s a valid server, with the correct name or IP address.
2. Check DNS. Ensure the proper DNS servers are defined which can resolve the target NTP server.
3. Use network traces for a better idea of what’s happening with name resolution.

Ultimately, this scenario could end up being Scenario 2 or Scenario 3.

### Resolution for scenario 2

Collect Network Traces to review UDP port 123 traffic. Do this by starting a capture, then running a `w32tm /resync /rediscover`.

1. If you don’t see any UDP 123 (NTP Request) packets being sent, it’s likely that UDP port 123 is blocked on the local Windows Firewall.
2. If you do see UDP port 123 (NTP Request) packets being sent but no response back, it’s likely that UDP port 123 is blocked on a non-Microsoft firewall.

If this is validated and UDP port 123 isn't blocked, consider Scenario 3.

### Resolution for scenario 3

1. If your customer is attempting to sync with a Domain Controller (whether via NT5DS, NTP or AllSync), review the Windows Time hierarchy. Starting with the PDC, check the Domain Controllers to ensure they are all receiving time from their respective source. You can use w32tm /monitor for a quick status check on all the Domain Controllers.
2. If the Domain Controllers are properly syncing time from their source, verify and ensure the Domain Controllers are advertising as Domain Controllers by running a `dcdiag /test:Advertising`.
3. Finally, on the Domain Controllers, verify the following w32time Registry Keys are configured as follows (at `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time`):

   - On all DCs: \TimeProviders\NtpServer – Enabled=1
   - On the PDC: \Config – AnnounceFlags = 5
   - On member DCs: \Config – AnnounceFlags = 10
