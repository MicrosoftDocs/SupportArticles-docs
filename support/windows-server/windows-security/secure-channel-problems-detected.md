---
title: Secure Channel Problems Detected
description: Provides a solution to detected secure channel problems.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:secure-channel-issues, csstroubleshoot
---
# Secure channel problems detected

This article provides a solution to detected secure channel problems.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2753702

## Symptoms

Several symptoms may be seen:

- You've ran the CSS Authentication Diagnostic and it has notified you of secure channel problems.

- When attempting to log onto a computer, you receive the message "no logon servers available to service the logon request." The attempted logon will not be successful.

- When attempting to access a resource, such as a file or folder, across the network you receive a message "access denied" or "no logon servers available to service the logon request."

- Netlogon source events in the System event log of IDs 5719, 5722 or 5723.

These symptoms may be intermittent or consistent. They may also be tied to a specific network location or locations. This condition is known as a "broken secure channel".

The secure channel for the computer is either interrupted by network difficulties or the computer's local copy of its password no longer matches the copy of it on the Active Directory domain controller, or both conditions exist.

## Resolution

To resolve this issue if the cause is only network difficulties:

Verify that the network connectivity between the local computer and the domain controller(s) has the required ports open on both client (local computer) and server (domain controller).

Many methods may be used to verify that connectivity is sufficient since there are many causes of network problems. A common cause is network ports being inadvertently restricted. To resolve that common concern, review the ports required for Active Directory in [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md) and then to use the Port Query tool (PortQry.exe) to examine the ports that are in user or available for use on local computer and domain controller.

PortQry.exe is a free download from Microsoft.

[PortQry Command Line Port Scanner Version 2.0](https://www.microsoft.com/download/details.aspx?id=17148)

Once the network concern is identified look to local network interface, firewall software, or network infrastructure to resolve the issue.

To resolve this issue if the cause is a dissimilar computer password:

To resolve this issue if the cause is network difficulties or a mismatched computer password, first resolve the network difficulties as above and then follow the steps to resolve the dissimilar password.

On the computer that is seeing the issue, log on local and use the command below. NLTest.exe is available in the Remote Server Administration Tools and in the Support Tools downloads from Microsoft.com.

From an elevated command prompt on the domain member computer, see the problem run the command below (where DomainName is the domain the computer is a member of):

```console
Nltest.exe /sc_change_pwd:[<DomainName>]
```

After doing the command above, restart the computer and attempt to logon to the domain.
