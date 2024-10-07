---
title: Error message when you run the w32tm /resync command
description: Describes a problem that occurs if a Group Policy object for a Windows Time Service object is configured incorrectly.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, karanr
ms.custom: sap:Active Directory\Windows Time Service configuration, accuracy, and synchronization, csstroubleshoot
---
# Error message when you run the "w32tm /resync" command to synchronize Windows Server 2003 or Windows SBS to an external time source: "The computer did not resync because no time data was available"

This article provides a solution to an error that occurs when you run the `w32tm /resync` command to synchronize Windows Server 2003 or Windows SBS to an external time source.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016
_Original KB number:_ &nbsp; 929276

## Symptoms

The machine is having time synchronization issues. If you run a manual resync with w32tm /resync, the following error is returned: “The computer did not resync because no time data was available.”

------------------------------------------------------------------------------------------------------------
SCREENSHOT

C:\Windows\system32>w32tm /resync /rediscover Sending resync command to local computer The computer did not resync because no time data was available

------------------------------------------------------------------------------------------------------------

You may also see the following events:

------------------------------------------------------------------------------------------------------------
TABLE WITH EVENTS:

Log Name: System

Source: Microsoft-Windows-Time-Service

Date: 24-04-2019 22:35:55

Event ID: 129

Task Category: None

Level: Warning

Keywords:

User: LOCAL SERVICE

Computer: MEM1.fabrikam.com

Description:

NtpClient was unable to set a domain peer to use as a time source because of discovery error. NtpClient will try again in 15 minutes and double the reattempt interval thereafter. The error was: The entry is not found. (0x800706E1)

Log Name: System

Source: Microsoft-Windows-Time-Service

Date: 24-04-2019 23:45:32

Event ID: 134

Task Category: None

Level: Warning

Keywords:

User: LOCAL SERVICE

Computer: MEM1.fabrikam.com

Description:

NtpClient was unable to set a manual peer to use as a time source because of DNS resolution error on 'time.windows.com,0x9'. NtpClient will try again in 15 minutes and double the reattempt interval thereafter. The error was: No such host is known. (0x80072AF9)

------------------------------------------------------------------------------------------------------------

## Cause

This problem occurs if a Group Policy object for a Windows Time Service object is configured incorrectly.

This error generally occurs when the client sends an NTP request but does not get a proper NTP response in return. There are multiple scenarios that can cause this.

**Scenario 1:**

The NTP client is unable to find the NTP server. This could be due to name resolution (DNS) failing or due to a misspelling of the name/IP address defined in the NTPServer registry key.

**Scenario 2:**

UDP port 123 is blocked. This could be at the local Windows Firewall or on a 3rd party firewall.

**Scenario 3:**

The target NTP server the client is trying to sync time with is not advertising as an NTP Server.

## Resolution

**Scenario 1:**

1. Check the spelling and accuracy of the value defined in the NTPServer registry key. Have the customer verify it’s a valid server, with the correct name or IP address.
2. Check DNS. Ensure the proper DNS servers are defined which can resolve the target NTP server.
3. Leverage network traces for a better idea of what’s happening with name resolution.

Ultimately, this scenario could end up being Scenario 2 or Scenario 3.

**Scenario 2:**

1. Collect Network Traces to review UDP port 123 traffic. Do this by starting a capture, then running a w32tm /resync /rediscover.
   a. If you don’t see any UDP 123 (NTP Request) packets being sent, it’s likely that UDP port 123 is blocked on the local Windows Firewall.
   b. If you do see UDP port 123 (NTP Request) packets being sent but no response back, it’s likely that UDP port 123 is blocked on a 3rd party firewall.

If this is validated and UDP port 123 is not blocked, consider Scenario 3.

**Scenario 3:**
1. If your customer is attempting to sync with a Domain Controller (whether via NT5DS, NTP or AllSync), review the Windows Time hierarchy. Starting with the PDC, check the Domain Controllers to ensure they are all receiving time from their respective source. You can use w32tm /monitor for a quick status check on all the Domain Controllers.

2. If the Domain Controllers are properly syncing time from their source, verify and ensure the Domain Controllers are advertising as Domain Controllers by running a dcdiag /test:Advertising.

3. Finally, on the Domain Controllers, verify the following w32time Registry Keys are configured as follows (at HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time):
- On all DCs: \TimeProviders\NtpServer – Enabled=1
- On the PDC: \Config – AnnounceFlags = 5
- On member DCs: \Config – AnnounceFlags = 10

## More Information

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:  
[816042](configure-authoritative-time-server.md) How to configure an authoritative time server in Windows Server 2003
