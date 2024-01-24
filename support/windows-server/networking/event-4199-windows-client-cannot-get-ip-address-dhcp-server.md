---
title: Event ID 4199 and Windows client can't get an IP address from the DHCP server
description: Helps resolve Event ID 4199 and the issue in which the Windows client can't get an IP address from the DHCP server.
ms.date: 01/20/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, rnitsch, markusr, v-lianna
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
ms.subservice: networking
---
# Event ID 4199 and Windows client can't get an IP address from the DHCP server

Windows client can't get an IP address from the Dynamic Host Configuration Protocol (DHCP) server, and Event ID 4199 is logged as follows:

```output
Log Name: System  
Source: Tcpip  
Date: <Date>  
Event ID: 4199  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: <Computer Name>  

Description:  
The system detected an address conflict for IP address 0.0.0.0. with the system having network hardware address <Network Hardware Address>. Network operations on this system may be disrupted as a result.  
```

When you check the DHCP server audit logs (*%windir%\\System32\\dhcp\\DHCP*.log*), you find many `BAD_ADDRESS` entries. Here's an example (*%windir%\\System32\\dhcp\\DhcpSrvLog-Fri.log*):

```output
11,11/22/19,09:30:39,Renew,10.2.29.108,<Computer Name>.contoso.com,<MAC Address>,,230319146,0,,,,0x4D53465420352E30,MSFT 5.0,,,0x010C766C616E2D323032382D6871,0   
13,11/22/19,09:30:43,Conflict,10.2.29.108,BAD_ADDRESS,,,0,6,,,,,,,,,0  
```

## ARP probe is detected as a duplicate IP address

The cause might be related to a Layer 3 switch or router security feature called "IP Device Tracking." If the switch or router sends out an address resolution protocol (ARP) probe for the client while the Windows client is in the duplicate address detection (DAD) phase, the client detects the probe as a duplicate IP address and declines the IP address offered by the DHCP server.

> [!NOTE]
> Windows DHCP clients that obtain an IP address use a gratuitous ARP request to perform a client-based conflict detection before completing configuration and using the server-offered IP address.  

## Deactivate the IP Device Tracking feature or delay sending ARP probe requests

To resolve this issue, deactivate the IP Device Tracking feature on the Layer 3 switch or router, or delay sending ARP probe requests.  

You might also disable the duplicate address detection functionality on the Windows client network interface by using the following cmdlet:

```powershell
Set-NetIPInterface -InterfaceAlias "Ethernet" -AddressFamily IPv4 -DadTransmits 0 
```

> [!IMPORTANT]
> This action should only be done in well-managed environments, as you risk having duplicate IP addresses on the network without any notifications or warnings from Windows.

Cisco also recognizes this issue and provides the solution in [Troubleshoot Duplicate IP Address 0.0.0.0 Error Messages](https://www.cisco.com/c/en/us/support/docs/ios-nx-os-software/8021x/116529-problemsolution-product-00.html).

[!INCLUDE [Third-party information and solution disclaimer](../../includes/third-party-information-solution-disclaimer.md)]
