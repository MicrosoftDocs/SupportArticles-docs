---
title: A computer can't identify the network
description: Provides a solution to an issue that a computer can't identify the network when this computer is a member of a child domain.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, clandis, ioanc
ms.custom: sap:secure-channel-issues, csstroubleshoot
---
# A computer can't identify the network when the computer is running Windows Vista, Windows Server 2008, Windows 7, or Windows Server 2008 R2, and is a member of a child domain

This article provides a solution to an issue that a computer can't identify the network when this computer is a member of a child domain.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 980873

## Symptoms

You have a computer that is running Windows Vista, Windows Server 2008, Windows 7, or Windows Server 2008 R2. When this computer is a member of a child domain, the computer can't identify the network. It may cause the firewall on the computer to be set to the public profile.

Additionally, events that resemble the following example are logged in the Applications event logs:

> [!NOTE]
> Error 0x54B indicates that the specified domain either doesn't exist or couldn't be contacted.

## Cause

This issue occurs because the computer can't connect to the primary domain controller (PDC) in the forest domain after the computer is joined to the child domain. The Network Location Awareness (NLA) service expects to be able to enumerate the domain's forest name to choose the right network profile for the connection. The service does this by calling `DsGetDcName` on the forest root name and issuing an LDAP (Lightweight Directory Access Protocol) query on UDP (User Datagram Protocol) port 389 to a root Domain Controller. The service expects to be able to connect to the PDC in the forest domain to populate the following registry subkey:  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\NetworkList\Nla\Cache\IntranetForests`

If something hinders the DNS name resolution or the connection attempt to the DC, NLA isn't able to set the appropriate network profile on the connection.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1

Configure the firewall devices not to block communications on UDP/TCP port 389. For more information about how to do it, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).  

### Method 2

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

1. Configure one computer in the child domain to connect to the PDC from the root domain.
2. Restart the computer. The computer should now be able to identify the network. Also, the profile on the firewall will be set to the domain profile.
3. Export the following registry subkey as a file to a shared location in the domain:  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\NetworkList\Nla\Cache\IntranetForests`

4. Import the registry subkey that you exported in step 3 to the other computers that can't connect to the PDC from the domain forest.
5. Restart the computer. The computer should now be able to identify the network and the profile on the firewall will be set to the domain profile.

### Method 3

If it's sufficient to identify the network profile based on the child domain name, then mitigating the time taken by NLA during its aggressive retries might be the right approach.

To deploy a registry setting that changes the retry count used by NLA, follow these steps:

1. Create a new registry key that matches the forest root domain under the path:  
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Nla\Cache\Intranet\`

2. In the newly created registry key for the name of the forest root domain, add the two registry values below:

    - **Failures** REG_DWORD with a value of 1

    - **Successes** REG_DWORD with a value of 0

    It will cause NLA to go to its lowest retry count and should result in identification lasting for just a couple of minutes.
